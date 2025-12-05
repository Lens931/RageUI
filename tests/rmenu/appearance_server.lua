local QBCore = nil

pcall(function()
    QBCore = exports['qb-core']:GetCoreObject()
end)

local dbProvider = nil

local function tryGetDbProvider()
    if dbProvider then return dbProvider end

    if MySQL and (MySQL.query or (MySQL.Sync and (MySQL.Sync.execute or MySQL.Sync.fetchAll))) then
        dbProvider = MySQL
        return dbProvider
    end

    local ok, provider = pcall(function()
        return exports.oxmysql
    end)

    if ok and provider then
        dbProvider = provider
        return dbProvider
    end

    ok, provider = pcall(function()
        return exports['ghmattimysql']
    end)

    if ok and provider then
        dbProvider = provider
        return dbProvider
    end

    return nil
end

local function dbFetchAll(query, params)
    local provider = tryGetDbProvider()
    if not provider then return nil end

    if provider.query and provider.query.await then
        return provider.query.await(query, params)
    end

    if provider.Sync and provider.Sync.fetchAll then
        return provider.Sync.fetchAll(query, params)
    end

    local ok, result = pcall(function()
        return provider:executeSync(query, params)
    end)

    if ok then return result end

    return nil
end

local function dbExecute(query, params)
    local provider = tryGetDbProvider()
    if not provider then return nil end

    if provider.query and provider.query.await then
        return provider.query.await(query, params)
    end

    if provider.Sync and provider.Sync.execute then
        return provider.Sync.execute(query, params)
    end

    local ok, result = pcall(function()
        return provider:executeSync(query, params)
    end)

    if ok then return result end

    return nil
end

local function ensureOutfitTable()
    if not tryGetDbProvider() then return end

    dbExecute([[CREATE TABLE IF NOT EXISTS rageui_outfits (
        id INT NOT NULL AUTO_INCREMENT,
        identifier VARCHAR(64) NOT NULL,
        slot INT NOT NULL,
        payload LONGTEXT NOT NULL,
        saved_at INT UNSIGNED NOT NULL DEFAULT (UNIX_TIMESTAMP()),
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE KEY identifier_slot (identifier, slot),
        KEY idx_identifier (identifier)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4]], {})
end

local function fetchOutfitsFromDatabase(identifier)
    if not tryGetDbProvider() then return nil end

    local results = dbFetchAll('SELECT slot, payload FROM rageui_outfits WHERE identifier = ?', { identifier })
    if type(results) ~= 'table' then return nil end

    local outfits = {}

    for _, row in ipairs(results) do
        local decoded = json.decode(row.payload or '{}')
        if decoded then
            outfits[tonumber(row.slot)] = decoded
        end
    end

    return outfits
end

local function saveOutfitToDatabase(identifier, payload)
    if not tryGetDbProvider() then return end

    dbExecute([[INSERT INTO rageui_outfits (identifier, slot, payload, saved_at)
        VALUES (?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE payload = VALUES(payload), saved_at = VALUES(saved_at)]], {
        identifier,
        payload.slot,
        json.encode(payload),
        payload.savedAt or os.time(),
    })
end

ensureOutfitTable()

local fallbackStorage = {}

local function getIdentifier(src)
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local identifier = GetPlayerIdentifier(src, i)
        if identifier then return identifier end
    end

    return tostring(src)
end

local function loadOutfits(Player, identifier)
    local outfits = fetchOutfitsFromDatabase(identifier)
    if outfits then return outfits end

    if Player then
        return Player.PlayerData.metadata.appearance_outfits or {}
    end

    fallbackStorage[identifier] = fallbackStorage[identifier] or {}
    return fallbackStorage[identifier]
end

local function persistOutfits(Player, identifier, outfits, changedPayload)
    if tryGetDbProvider() and changedPayload then
        saveOutfitToDatabase(identifier, changedPayload)
        return
    end

    if Player then
        Player.Functions.SetMetaData('appearance_outfits', outfits)
    else
        fallbackStorage[identifier] = outfits
    end
end

RegisterNetEvent('rageui:appearance:requestOutfits', function()
    local src = source
    local identifier = getIdentifier(src)
    local Player = QBCore and QBCore.Functions.GetPlayer(src) or nil

    local outfits = loadOutfits(Player, identifier)
    TriggerClientEvent('rageui:appearance:outfitsResponse', src, outfits)
end)

RegisterNetEvent('rageui:appearance:saveOutfit', function(slot, payload)
    if type(slot) ~= 'number' or slot < 1 then return end

    local src = source
    local identifier = getIdentifier(src)
    local Player = QBCore and QBCore.Functions.GetPlayer(src) or nil
    local outfits = loadOutfits(Player, identifier)

    payload = payload or {}
    payload.slot = slot
    payload.savedAt = os.time()

    outfits[slot] = payload
    persistOutfits(Player, identifier, outfits, payload)

    TriggerClientEvent('rageui:appearance:outfitSaved', src, slot, payload)
end)

RegisterNetEvent('rageui:appearance:loadOutfit', function(slot)
    if type(slot) ~= 'number' or slot < 1 then return end

    local src = source
    local identifier = getIdentifier(src)
    local Player = QBCore and QBCore.Functions.GetPlayer(src) or nil
    local outfits = loadOutfits(Player, identifier)
    local payload = outfits[slot]

    if payload then
        TriggerClientEvent('rageui:appearance:applyOutfitClient', src, payload, slot)
    end
end)
