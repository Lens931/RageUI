local QBCore = nil

pcall(function()
    QBCore = exports['qb-core']:GetCoreObject()
end)

local fallbackStorage = {}

local function getIdentifier(src)
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local identifier = GetPlayerIdentifier(src, i)
        if identifier then return identifier end
    end

    return tostring(src)
end

local function loadOutfits(Player, identifier)
    if Player then
        return Player.PlayerData.metadata.appearance_outfits or {}
    end

    fallbackStorage[identifier] = fallbackStorage[identifier] or {}
    return fallbackStorage[identifier]
end

local function persistOutfits(Player, identifier, outfits)
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
    persistOutfits(Player, identifier, outfits)

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
