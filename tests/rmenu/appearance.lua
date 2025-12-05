---
--- Apparence inspirée du créateur de personnage de GTA Online
---

local menuName = 'appearance'
local toggleCommand = 'appearance-menu'

RMenu.Add(menuName, 'main', RageUI.CreateMenu("APPARENCE PERSONNAGE", "Création de personnage"))
RMenu:Get(menuName, 'main'):SetSubtitle("~b~Créateur style GTA Online")
RMenu:Get(menuName, 'main').EnableMouse = true

RMenu.Add(menuName, 'heritage', RageUI.CreateSubMenu(RMenu:Get(menuName, 'main'), "HÉRITAGE", "Parents et carnation"))
RMenu.Add(menuName, 'features', RageUI.CreateSubMenu(RMenu:Get(menuName, 'main'), "TRAITS", "Détails du visage"))
RMenu.Add(menuName, 'appearance', RageUI.CreateSubMenu(RMenu:Get(menuName, 'main'), "APPARENCE", "Cheveux et maquillage"))
RMenu.Add(menuName, 'wardrobe', RageUI.CreateSubMenu(RMenu:Get(menuName, 'main'), "VÊTEMENTS", "Tenues de base"))
RMenu.Add(menuName, 'props', RageUI.CreateSubMenu(RMenu:Get(menuName, 'main'), "ACCESSOIRES", "Chapeaux et lunettes"))
RMenu.Add(menuName, 'model', RageUI.CreateSubMenu(RMenu:Get(menuName, 'main'), "MODÈLE", "Modèles Freemode"))
RMenu.Add(menuName, 'outfits', RageUI.CreateSubMenu(RMenu:Get(menuName, 'main'), "TENUES", "Emplacements sauvegardés"))
RMenu.Add(menuName, 'persistence', RageUI.CreateSubMenu(RMenu:Get(menuName, 'main'), "SAUVEGARDE", "Profils de personnage"))

---@param menu table
local function toggleMenu(menu)
    if not menu then return end
    RageUI.Visible(menu, not RageUI.Visible(menu))
end

RegisterCommand(toggleCommand, function()
    toggleMenu(RMenu:Get(menuName, 'main'))
end, false)

RegisterKeyMapping(toggleCommand, 'Ouvrir le menu d\'apparence', 'keyboard', 'F3')

---@type table
local parents = {
    fathers = {
        "Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan",
        "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel",
        "Anthony", "Claude", "Niko", "John"
    },
    mothers = {
        "Hannah", "Audrey", "Jasmine", "Giselle", "Amelia", "Isabella", "Zoe", "Ava", "Camilla", "Violet",
        "Sophia", "Evelyn", "Nicole", "Ashley", "Grace", "Brianna", "Natalie", "Olivia", "Elizabeth", "Charlotte",
        "Emma", "Misty", "Molly", "Mary-Ann"
    }
}

local heritage = {
    father = 1,
    mother = 1,
    resemblance = 5,
    skinTone = 5,
}

---@type table
local features = {
    nose = 5,
    noseProfile = 5,
    noseTip = 5,
    cheeks = 5,
    lips = 5,
    jaw = 5,
    chin = 5,
    eyes = 5,
}

---@type table
local appearance = {
    hairStyle = 1,
    hairColor = 1,
    hairHighlight = 1,
    eyebrows = 1,
    eyebrowsOpacity = 5,
    makeupStyle = 1,
    makeupColor = 1,
    makeupOpacity = 5,
    lipstickStyle = 1,
    lipstickColor = 1,
    lipstickOpacity = 5,
    blemishes = 0,
    ageing = 0,
}

local appearanceOptions = {
    hairStyles = { labels = {}, values = {} },
    hairColors = { labels = {}, values = {} },
    eyebrows = { labels = {}, values = {} },
    makeups = { labels = {}, values = {} },
    makeupColors = { labels = {}, values = {} },
    lipsticks = { labels = {}, values = {} },
    lipstickColors = { labels = {}, values = {} },
    blemishes = { labels = {}, values = {} },
    ageing = { labels = {}, values = {} },
}

---@type table
local wardrobe = {
    tshirt = 1,
    torso = 1,
    pants = 1,
    shoes = 1,
    jacket = 1,
    mask = 1,
    bag = 1,
    accessory = 1,
    decals = 1,
    armor = 1,
}

local wardrobeOptions = {
    tshirts = { labels = {}, values = {} },
    torsos = { labels = {}, values = {} },
    jackets = { labels = {}, values = {} },
    pants = { labels = {}, values = {} },
    shoes = { labels = {}, values = {} },
    masks = { labels = {}, values = {} },
    bags = { labels = {}, values = {} },
    accessories = { labels = {}, values = {} },
    decals = { labels = {}, values = {} },
    armors = { labels = {}, values = {} },
}

local wardrobeTextures = {
    tshirt = 1,
    torso = 1,
    pants = 1,
    shoes = 1,
    jacket = 1,
    mask = 1,
    bag = 1,
    accessory = 1,
    decals = 1,
    armor = 1,
}

local wardrobeTextureOptions = {
    tshirts = { labels = {}, values = {} },
    torsos = { labels = {}, values = {} },
    jackets = { labels = {}, values = {} },
    pants = { labels = {}, values = {} },
    shoes = { labels = {}, values = {} },
    masks = { labels = {}, values = {} },
    bags = { labels = {}, values = {} },
    accessories = { labels = {}, values = {} },
    decals = { labels = {}, values = {} },
    armors = { labels = {}, values = {} },
}

---@type table
local props = {
    hats = 1,
    glasses = 1,
    ears = 1,
    watches = 1,
    bracelets = 1,
}

local propOptions = {
    hats = { labels = {}, values = {} },
    glasses = { labels = {}, values = {} },
    ears = { labels = {}, values = {} },
    watches = { labels = {}, values = {} },
    bracelets = { labels = {}, values = {} },
}

local propTextures = {
    hats = 1,
    glasses = 1,
    ears = 1,
    watches = 1,
    bracelets = 1,
}

local propTextureOptions = {
    hats = { labels = {}, values = {} },
    glasses = { labels = {}, values = {} },
    ears = { labels = {}, values = {} },
    watches = { labels = {}, values = {} },
    bracelets = { labels = {}, values = {} },
}

---@type table
local pedModel = {
    index = 1,
    models = {
        { label = "Homme (mp_m_freemode_01)", model = "mp_m_freemode_01" },
        { label = "Femme (mp_f_freemode_01)", model = "mp_f_freemode_01" },
    }
}

---@type table
local outfits = {}
for i = 1, 10 do
    outfits[i] = {
        saved = false,
        label = string.format("Tenue %02d", i),
        note = "Vide",
    }
end

---@type table
local persistence = {
    autosave = true,
    slot = 1,
    slots = { "Profil A", "Profil B", "Profil C", "Profil D" },
}

local function getPlayerPed()
    return PlayerPedId()
end

local function clampSelection(selection, max)
    if max < 1 then return 1 end
    if selection < 1 then return 1 end
    if selection > max then return max end
    return selection
end

local function buildComponentOptions(componentId, includeNone)
    local ped = getPlayerPed()
    local labels = {}
    local values = {}

    if includeNone then
        table.insert(labels, "Aucun")
        table.insert(values, 0)
    end

    local total = GetNumberOfPedDrawableVariations(ped, componentId)
    for drawable = 0, total - 1 do
        table.insert(labels, string.format("Variation %02d", drawable))
        table.insert(values, drawable)
    end

    if #labels == 0 then
        table.insert(labels, "Variation 00")
        table.insert(values, 0)
    end

    return labels, values
end

local function buildComponentTextureOptions(componentId, drawable)
    local ped = getPlayerPed()
    local labels = {}
    local values = {}

    local total = GetNumberOfPedTextureVariations(ped, componentId, drawable)
    for texture = 0, math.max(total, 1) - 1 do
        table.insert(labels, string.format("Texture %02d", texture))
        table.insert(values, texture)
    end

    if #labels == 0 then
        table.insert(labels, "Texture 00")
        table.insert(values, 0)
    end

    return labels, values
end

-- Options couleurs de cheveux
local function buildHairColorOptions()
    local labels = {}
    local values = {}

    local total = GetNumHairColors()
    for colorIndex = 0, total - 1 do
        table.insert(labels, string.format("Couleur %02d", colorIndex))
        table.insert(values, colorIndex)
    end

    if #labels == 0 then
        table.insert(labels, "Couleur 00")
        table.insert(values, 0)
    end

    return labels, values
end

-- Options overlays (sourcils, maquillage, etc.)
local function buildOverlayOptions(overlayId, includeNone)
    local labels = {}
    local values = {}

    if includeNone then
        table.insert(labels, "Aucun")
        table.insert(values, -1)
    end

    local total = GetPedHeadOverlayNum(overlayId)
    for overlayIndex = 0, total - 1 do
        table.insert(labels, string.format("Variation %02d", overlayIndex))
        table.insert(values, overlayIndex)
    end

    if #labels == 0 then
        table.insert(labels, "Variation 00")
        table.insert(values, 0)
    end

    return labels, values
end

-- Options couleurs de maquillage
local function buildMakeupColorOptions()
    local labels = {}
    local values = {}

    local total = GetNumMakeupColors()
    for colorIndex = 0, total - 1 do
        table.insert(labels, string.format("Couleur %02d", colorIndex))
        table.insert(values, colorIndex)
    end

    if #labels == 0 then
        table.insert(labels, "Couleur 00")
        table.insert(values, 0)
    end

    return labels, values
end

local function buildPropOptions(propId)
    local ped = getPlayerPed()
    local labels = { "Sans" }
    local values = { -1 }

    local total = GetNumberOfPedPropDrawableVariations(ped, propId)
    for drawable = 0, total - 1 do
        table.insert(labels, string.format("Variation %02d", drawable))
        table.insert(values, drawable)
    end

    return labels, values
end

local function buildPropTextureOptions(propId, drawable)
    local ped = getPlayerPed()
    local labels = {}
    local values = {}

    local total = GetNumberOfPedPropTextureVariations(ped, propId, drawable)
    for texture = 0, math.max(total, 1) - 1 do
        table.insert(labels, string.format("Texture %02d", texture))
        table.insert(values, texture)
    end

    if #labels == 0 then
        table.insert(labels, "Texture 00")
        table.insert(values, 0)
    end

    return labels, values
end

local function refreshWardrobeOptions()
    wardrobeOptions.masks.labels, wardrobeOptions.masks.values = buildComponentOptions(1, true)
    wardrobeOptions.tshirts.labels, wardrobeOptions.tshirts.values = buildComponentOptions(8, false)
    wardrobeOptions.torsos.labels, wardrobeOptions.torsos.values = buildComponentOptions(11, false)
    wardrobeOptions.jackets.labels, wardrobeOptions.jackets.values = buildComponentOptions(3, false)
    wardrobeOptions.pants.labels, wardrobeOptions.pants.values = buildComponentOptions(4, false)
    wardrobeOptions.shoes.labels, wardrobeOptions.shoes.values = buildComponentOptions(6, false)
    wardrobeOptions.bags.labels, wardrobeOptions.bags.values = buildComponentOptions(5, true)
    wardrobeOptions.accessories.labels, wardrobeOptions.accessories.values = buildComponentOptions(7, true)
    wardrobeOptions.decals.labels, wardrobeOptions.decals.values = buildComponentOptions(10, true)
    wardrobeOptions.armors.labels, wardrobeOptions.armors.values = buildComponentOptions(9, true)

    wardrobe.mask = clampSelection(wardrobe.mask, #wardrobeOptions.masks.labels)
    wardrobe.tshirt = clampSelection(wardrobe.tshirt, #wardrobeOptions.tshirts.labels)
    wardrobe.torso = clampSelection(wardrobe.torso, #wardrobeOptions.torsos.labels)
    wardrobe.jacket = clampSelection(wardrobe.jacket, #wardrobeOptions.jackets.labels)
    wardrobe.pants = clampSelection(wardrobe.pants, #wardrobeOptions.pants.labels)
    wardrobe.shoes = clampSelection(wardrobe.shoes, #wardrobeOptions.shoes.labels)
    wardrobe.bag = clampSelection(wardrobe.bag, #wardrobeOptions.bags.labels)
    wardrobe.accessory = clampSelection(wardrobe.accessory, #wardrobeOptions.accessories.labels)
    wardrobe.decals = clampSelection(wardrobe.decals, #wardrobeOptions.decals.labels)
    wardrobe.armor = clampSelection(wardrobe.armor, #wardrobeOptions.armors.labels)

    local mappings = {
        { key = 'tshirt', option = 'tshirts', componentId = 8 },
        { key = 'torso', option = 'torsos', componentId = 11 },
        { key = 'jacket', option = 'jackets', componentId = 3 },
        { key = 'pants', option = 'pants', componentId = 4 },
        { key = 'shoes', option = 'shoes', componentId = 6 },
        { key = 'mask', option = 'masks', componentId = 1 },
        { key = 'bag', option = 'bags', componentId = 5 },
        { key = 'accessory', option = 'accessories', componentId = 7 },
        { key = 'decals', option = 'decals', componentId = 10 },
        { key = 'armor', option = 'armors', componentId = 9 },
    }

    for _, entry in ipairs(mappings) do
        local drawable = wardrobeOptions[entry.option].values[wardrobe[entry.key]] or 0
        wardrobeTextureOptions[entry.option].labels, wardrobeTextureOptions[entry.option].values = buildComponentTextureOptions(entry.componentId, drawable)
        wardrobeTextures[entry.key] = clampSelection(wardrobeTextures[entry.key], #wardrobeTextureOptions[entry.option].labels)
    end
end

local function refreshPropOptions()
    propOptions.hats.labels, propOptions.hats.values = buildPropOptions(0)
    propOptions.glasses.labels, propOptions.glasses.values = buildPropOptions(1)
    propOptions.ears.labels, propOptions.ears.values = buildPropOptions(2)
    propOptions.watches.labels, propOptions.watches.values = buildPropOptions(6)
    propOptions.bracelets.labels, propOptions.bracelets.values = buildPropOptions(7)

    props.hats = clampSelection(props.hats, #propOptions.hats.labels)
    props.glasses = clampSelection(props.glasses, #propOptions.glasses.labels)
    props.ears = clampSelection(props.ears, #propOptions.ears.labels)
    props.watches = clampSelection(props.watches, #propOptions.watches.labels)
    props.bracelets = clampSelection(props.bracelets, #propOptions.bracelets.labels)

    local mappings = {
        { key = 'hats', propId = 0 },
        { key = 'glasses', propId = 1 },
        { key = 'ears', propId = 2 },
        { key = 'watches', propId = 6 },
        { key = 'bracelets', propId = 7 },
    }

    for _, entry in ipairs(mappings) do
        local drawable = propOptions[entry.key].values[props[entry.key]] or -1
        propTextureOptions[entry.key].labels, propTextureOptions[entry.key].values = buildPropTextureOptions(entry.propId, math.max(drawable, 0))
        propTextures[entry.key] = clampSelection(propTextures[entry.key], #propTextureOptions[entry.key].labels)
    end
end

local function refreshAppearanceOptions()
    appearanceOptions.hairStyles.labels, appearanceOptions.hairStyles.values = buildComponentOptions(2, false)
    appearanceOptions.hairColors.labels, appearanceOptions.hairColors.values = buildHairColorOptions()
    appearanceOptions.eyebrows.labels, appearanceOptions.eyebrows.values = buildOverlayOptions(2, false)
    appearanceOptions.makeups.labels, appearanceOptions.makeups.values = buildOverlayOptions(4, true)
    appearanceOptions.makeupColors.labels, appearanceOptions.makeupColors.values = buildMakeupColorOptions()
    appearanceOptions.lipsticks.labels, appearanceOptions.lipsticks.values = buildOverlayOptions(8, true)
    appearanceOptions.lipstickColors.labels, appearanceOptions.lipstickColors.values = buildMakeupColorOptions()
    appearanceOptions.blemishes.labels, appearanceOptions.blemishes.values = buildOverlayOptions(0, true)
    appearanceOptions.ageing.labels, appearanceOptions.ageing.values = buildOverlayOptions(3, true)

    appearance.hairStyle = clampSelection(appearance.hairStyle, #appearanceOptions.hairStyles.labels)
    appearance.hairColor = clampSelection(appearance.hairColor, #appearanceOptions.hairColors.labels)
    appearance.hairHighlight = clampSelection(appearance.hairHighlight, #appearanceOptions.hairColors.labels)
    appearance.eyebrows = clampSelection(appearance.eyebrows, #appearanceOptions.eyebrows.labels)
    appearance.makeupStyle = clampSelection(appearance.makeupStyle, #appearanceOptions.makeups.labels)
    appearance.makeupColor = clampSelection(appearance.makeupColor, #appearanceOptions.makeupColors.labels)
    appearance.lipstickStyle = clampSelection(appearance.lipstickStyle, #appearanceOptions.lipsticks.labels)
    appearance.lipstickColor = clampSelection(appearance.lipstickColor, #appearanceOptions.lipstickColors.labels)
    appearance.blemishes = clampSelection(appearance.blemishes, #appearanceOptions.blemishes.labels)
    appearance.ageing = clampSelection(appearance.ageing, #appearanceOptions.ageing.labels)
end

-- Chargement des options au démarrage
refreshWardrobeOptions()
refreshPropOptions()
refreshAppearanceOptions()

local function applyHeritage()
    local ped = getPlayerPed()
    local father = heritage.father - 1
    local mother = heritage.mother - 1
    local shapeMix = (heritage.resemblance - 1) / 10
    local skinMix = (heritage.skinTone - 1) / 10

    SetPedHeadBlendData(ped, mother, father, 0, mother, father, 0, shapeMix, skinMix, 0.0, true)
end

local function applyFaceFeatures()
    local ped = getPlayerPed()
    local featureValues = {
        features.nose,
        features.noseProfile,
        features.noseTip,
        features.cheeks,
        features.lips,
        features.jaw,
        features.chin,
        features.eyes,
    }

    for i, value in ipairs(featureValues) do
        SetPedFaceFeature(ped, i - 1, (value - 5) / 5)
    end
end

local function applyPedAppearance()
    local ped = getPlayerPed()
    local hairDrawable = appearanceOptions.hairStyles.values[appearance.hairStyle] or 0
    local hairColor = appearanceOptions.hairColors.values[appearance.hairColor] or 0
    local hairHighlight = appearanceOptions.hairColors.values[appearance.hairHighlight] or 0
    SetPedComponentVariation(ped, 2, hairDrawable, 0, 0)
    SetPedHairColor(ped, hairColor, hairHighlight)

    local eyebrowIndex = appearanceOptions.eyebrows.values[appearance.eyebrows] or -1
    SetPedHeadOverlay(ped, 2, eyebrowIndex, appearance.eyebrowsOpacity / 10.0)
    SetPedHeadOverlayColor(ped, 2, 1, hairColor, hairHighlight)

    local makeupIndex = appearanceOptions.makeups.values[appearance.makeupStyle] or -1
    local makeupColor = appearanceOptions.makeupColors.values[appearance.makeupColor] or 0
    SetPedHeadOverlay(ped, 4, makeupIndex, appearance.makeupOpacity / 10.0)
    SetPedHeadOverlayColor(ped, 4, 2, makeupColor, 0)

    local lipstickIndex = appearanceOptions.lipsticks.values[appearance.lipstickStyle] or -1
    local lipstickColor = appearanceOptions.lipstickColors.values[appearance.lipstickColor] or 0
    SetPedHeadOverlay(ped, 8, lipstickIndex, appearance.lipstickOpacity / 10.0)
    SetPedHeadOverlayColor(ped, 8, 2, lipstickColor, 0)

    local blemishIndex = appearanceOptions.blemishes.values[appearance.blemishes] or -1
    SetPedHeadOverlay(ped, 0, blemishIndex, 1.0)

    local ageingIndex = appearanceOptions.ageing.values[appearance.ageing] or -1
    SetPedHeadOverlay(ped, 3, ageingIndex, 1.0)
end

local function applyWardrobe()
    local ped = getPlayerPed()

    local function setComponent(componentId, index, textureIndex, options, textureOptions)
        local drawable = options.values[index] or 0
        local texture = textureOptions.values[textureIndex] or 0
        SetPedComponentVariation(ped, componentId, drawable, texture, 0)
    end

    setComponent(1, wardrobe.mask, wardrobeTextures.mask, wardrobeOptions.masks, wardrobeTextureOptions.masks)
    setComponent(8, wardrobe.tshirt, wardrobeTextures.tshirt, wardrobeOptions.tshirts, wardrobeTextureOptions.tshirts)
    setComponent(11, wardrobe.torso, wardrobeTextures.torso, wardrobeOptions.torsos, wardrobeTextureOptions.torsos)
    setComponent(3, wardrobe.jacket, wardrobeTextures.jacket, wardrobeOptions.jackets, wardrobeTextureOptions.jackets)
    setComponent(4, wardrobe.pants, wardrobeTextures.pants, wardrobeOptions.pants, wardrobeTextureOptions.pants)
    setComponent(6, wardrobe.shoes, wardrobeTextures.shoes, wardrobeOptions.shoes, wardrobeTextureOptions.shoes)
    setComponent(5, wardrobe.bag, wardrobeTextures.bag, wardrobeOptions.bags, wardrobeTextureOptions.bags)
    setComponent(7, wardrobe.accessory, wardrobeTextures.accessory, wardrobeOptions.accessories, wardrobeTextureOptions.accessories)
    setComponent(10, wardrobe.decals, wardrobeTextures.decals, wardrobeOptions.decals, wardrobeTextureOptions.decals)
    setComponent(9, wardrobe.armor, wardrobeTextures.armor, wardrobeOptions.armors, wardrobeTextureOptions.armors)
end

local function applyProps()
    local ped = getPlayerPed()

    local function setProp(propId, index, textureIndex, options, textureOptions)
        local drawable = options.values[index] or -1
        if drawable == -1 then
            ClearPedProp(ped, propId)
        else
            local texture = textureOptions.values[textureIndex] or 0
            SetPedPropIndex(ped, propId, drawable, texture, true)
        end
    end

    setProp(0, props.hats, propTextures.hats, propOptions.hats, propTextureOptions.hats)
    setProp(1, props.glasses, propTextures.glasses, propOptions.glasses, propTextureOptions.glasses)
    setProp(2, props.ears, propTextures.ears, propOptions.ears, propTextureOptions.ears)
    setProp(6, props.watches, propTextures.watches, propOptions.watches, propTextureOptions.watches)
    setProp(7, props.bracelets, propTextures.bracelets, propOptions.bracelets, propTextureOptions.bracelets)
end

local function applyModel(model)
    if not model then return end
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), hash)
    SetModelAsNoLongerNeeded(hash)

    -- Rafraîchir les options après changement de ped
    refreshWardrobeOptions()
    refreshPropOptions()
    refreshAppearanceOptions()

    -- Re-appliquer la customisation
    applyHeritage()
    applyFaceFeatures()
    applyPedAppearance()
    applyWardrobe()
    applyProps()
end

RageUI.CreateWhile(1.0, function()
    if RageUI.Visible(RMenu:Get(menuName, 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Inspiré du créateur GTA Online")
            RageUI.Button("Héritage", "Choisissez vos parents et mixez la ressemblance.", { RightLabel = "→→" }, true, nil, RMenu:Get(menuName, 'heritage'))
            RageUI.Button("Traits du visage", "Ajustez nez, joues, mâchoire et yeux.", { RightLabel = "→→" }, true, nil, RMenu:Get(menuName, 'features'))
            RageUI.Button("Apparence", "Coiffure, couleur, sourcils et maquillage.", { RightLabel = "→→" }, true, nil, RMenu:Get(menuName, 'appearance'))
            RageUI.Button("Vêtements", "Sélectionnez une tenue de départ.", { RightLabel = "→→" }, true, nil, RMenu:Get(menuName, 'wardrobe'))
            RageUI.Button("Accessoires", "Appliquez chapeau, lunettes et bijoux.", { RightLabel = "→→" }, true, nil, RMenu:Get(menuName, 'props'))
            RageUI.Button("Modèle du personnage", "Basculez entre les modèles Freemode.", { RightLabel = "→→" }, true, nil, RMenu:Get(menuName, 'model'))
            RageUI.Button("Tenues sauvegardées", "Gérez vos emplacements de tenues.", { RightLabel = "→→" }, true, nil, RMenu:Get(menuName, 'outfits'))
            RageUI.Button("Sauvegarder / Charger", "Choisissez le profil à utiliser.", { RightLabel = "→→" }, true, nil, RMenu:Get(menuName, 'persistence'))
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'heritage')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.List("Père", parents.fathers, heritage.father, "Sélectionnez le parent masculin.", {}, true, function(_, _, _, Index)
                heritage.father = Index
                applyHeritage()
            end)
            RageUI.List("Mère", parents.mothers, heritage.mother, "Sélectionnez le parent féminin.", {}, true, function(_, _, _, Index)
                heritage.mother = Index
                applyHeritage()
            end)
            RageUI.SliderProgress("Ressemblance", heritage.resemblance, 10, "0 = mère, 10 = père.", {}, true, function(_, _, _, Index)
                heritage.resemblance = Index
                applyHeritage()
            end)
            RageUI.SliderProgress("Couleur de peau", heritage.skinTone, 10, "Mélange des carnations.", {}, true, function(_, _, _, Index)
                heritage.skinTone = Index
                applyHeritage()
            end)
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'features')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Détails du visage")
            RageUI.SliderProgress("Nez", features.nose, 10, "Largeur et hauteur.", {}, true, function(_, _, _, Index)
                features.nose = Index
                applyFaceFeatures()
            end)
            RageUI.SliderProgress("Profil du nez", features.noseProfile, 10, "Pont et cambrure.", {}, true, function(_, _, _, Index)
                features.noseProfile = Index
                applyFaceFeatures()
            end)
            RageUI.SliderProgress("Pointe du nez", features.noseTip, 10, "Affinement de la pointe.", {}, true, function(_, _, _, Index)
                features.noseTip = Index
                applyFaceFeatures()
            end)
            RageUI.SliderProgress("Joues", features.cheeks, 10, "Creux ou volume.", {}, true, function(_, _, _, Index)
                features.cheeks = Index
                applyFaceFeatures()
            end)
            RageUI.SliderProgress("Lèvres", features.lips, 10, "Épaisseur et forme.", {}, true, function(_, _, _, Index)
                features.lips = Index
                applyFaceFeatures()
            end)
            RageUI.SliderProgress("Mâchoire", features.jaw, 10, "Largeur de la mâchoire.", {}, true, function(_, _, _, Index)
                features.jaw = Index
                applyFaceFeatures()
            end)
            RageUI.SliderProgress("Menton", features.chin, 10, "Longueur et creux.", {}, true, function(_, _, _, Index)
                features.chin = Index
                applyFaceFeatures()
            end)
            RageUI.SliderProgress("Yeux", features.eyes, 10, "Ouverture et rotation.", {}, true, function(_, _, _, Index)
                features.eyes = Index
                applyFaceFeatures()
            end)
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'appearance')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Cheveux")
            RageUI.List("Style", appearanceOptions.hairStyles.labels, appearance.hairStyle, "Choisissez une coupe.", {}, true, function(_, _, _, Index)
                appearance.hairStyle = Index
                applyPedAppearance()
            end)
            RageUI.List("Couleur", appearanceOptions.hairColors.labels, appearance.hairColor, "Teinte principale.", {}, true, function(_, _, _, Index)
                appearance.hairColor = Index
                applyPedAppearance()
            end)
            RageUI.List("Mèches", appearanceOptions.hairColors.labels, appearance.hairHighlight, "Couleur secondaire.", {}, true, function(_, _, _, Index)
                appearance.hairHighlight = Index
                applyPedAppearance()
            end)

            RageUI.Separator("~b~Sourcils")
            RageUI.List("Forme", appearanceOptions.eyebrows.labels, appearance.eyebrows, "Style de sourcil.", {}, true, function(_, _, _, Index)
                appearance.eyebrows = Index
                applyPedAppearance()
            end)
            RageUI.Slider("Opacité", appearance.eyebrowsOpacity, 10, "Intensité des sourcils.", false, {}, true, function(_, _, _, Index)
                appearance.eyebrowsOpacity = Index
                applyPedAppearance()
            end)

            RageUI.Separator("~b~Maquillage")
            RageUI.List("Maquillage", appearanceOptions.makeups.labels, appearance.makeupStyle, "Sélection du style.", {}, true, function(_, _, _, Index)
                appearance.makeupStyle = Index
                applyPedAppearance()
            end)
            RageUI.Slider("Opacité maquillage", appearance.makeupOpacity, 10, "Appliquer ou atténuer.", false, {}, true, function(_, _, _, Index)
                appearance.makeupOpacity = Index
                applyPedAppearance()
            end)
            RageUI.List("Couleur maquillage", appearanceOptions.makeupColors.labels, appearance.makeupColor, "Choisissez la couleur.", {}, true, function(_, _, _, Index)
                appearance.makeupColor = Index
                applyPedAppearance()
            end)
            RageUI.List("Rouge à lèvres", appearanceOptions.lipsticks.labels, appearance.lipstickStyle, "Couleur des lèvres.", {}, true, function(_, _, _, Index)
                appearance.lipstickStyle = Index
                applyPedAppearance()
            end)
            RageUI.List("Couleur lèvres", appearanceOptions.lipstickColors.labels, appearance.lipstickColor, "Teinte du rouge à lèvres.", {}, true, function(_, _, _, Index)
                appearance.lipstickColor = Index
                applyPedAppearance()
            end)
            RageUI.Slider("Opacité lèvres", appearance.lipstickOpacity, 10, "Intensité du rouge à lèvres.", false, {}, true, function(_, _, _, Index)
                appearance.lipstickOpacity = Index
                applyPedAppearance()
            end)

            RageUI.Separator("~b~Imperfections")
            RageUI.Slider("Imperfections", appearance.blemishes, 10, "Tâches ou grain de peau.", false, {}, true, function(_, _, _, Index)
                appearance.blemishes = Index
                applyPedAppearance()
            end)
            RageUI.Slider("Rides / Ageing", appearance.ageing, 10, "Signes de l'âge.", false, {}, true, function(_, _, _, Index)
                appearance.ageing = Index
                applyPedAppearance()
            end)
        end)
    end


    if RageUI.Visible(RMenu:Get(menuName, 'wardrobe')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Tenue de base")
            RageUI.List("T-shirt", wardrobeOptions.tshirts.labels, wardrobe.tshirt, "Couche intérieure.", {}, true, function(_, _, _, Index)
                wardrobe.tshirt = Index
                local drawable = wardrobeOptions.tshirts.values[wardrobe.tshirt] or 0
                wardrobeTextureOptions.tshirts.labels, wardrobeTextureOptions.tshirts.values = buildComponentTextureOptions(8, drawable)
                wardrobeTextures.tshirt = clampSelection(wardrobeTextures.tshirt, #wardrobeTextureOptions.tshirts.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur T-shirt", wardrobeTextureOptions.tshirts.labels, wardrobeTextures.tshirt, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.tshirt = Index
                applyWardrobe()
            end)
            RageUI.List("Torse", wardrobeOptions.torsos.labels, wardrobe.torso, "Couche principale.", {}, true, function(_, _, _, Index)
                wardrobe.torso = Index
                local drawable = wardrobeOptions.torsos.values[wardrobe.torso] or 0
                wardrobeTextureOptions.torsos.labels, wardrobeTextureOptions.torsos.values = buildComponentTextureOptions(11, drawable)
                wardrobeTextures.torso = clampSelection(wardrobeTextures.torso, #wardrobeTextureOptions.torsos.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur Torse", wardrobeTextureOptions.torsos.labels, wardrobeTextures.torso, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.torso = Index
                applyWardrobe()
            end)
            RageUI.List("Veste", wardrobeOptions.jackets.labels, wardrobe.jacket, "Couche extérieure.", {}, true, function(_, _, _, Index)
                wardrobe.jacket = Index
                local drawable = wardrobeOptions.jackets.values[wardrobe.jacket] or 0
                wardrobeTextureOptions.jackets.labels, wardrobeTextureOptions.jackets.values = buildComponentTextureOptions(3, drawable)
                wardrobeTextures.jacket = clampSelection(wardrobeTextures.jacket, #wardrobeTextureOptions.jackets.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur Veste", wardrobeTextureOptions.jackets.labels, wardrobeTextures.jacket, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.jacket = Index
                applyWardrobe()
            end)
            RageUI.List("Pantalon", wardrobeOptions.pants.labels, wardrobe.pants, "Bas du corps.", {}, true, function(_, _, _, Index)
                wardrobe.pants = Index
                local drawable = wardrobeOptions.pants.values[wardrobe.pants] or 0
                wardrobeTextureOptions.pants.labels, wardrobeTextureOptions.pants.values = buildComponentTextureOptions(4, drawable)
                wardrobeTextures.pants = clampSelection(wardrobeTextures.pants, #wardrobeTextureOptions.pants.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur Pantalon", wardrobeTextureOptions.pants.labels, wardrobeTextures.pants, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.pants = Index
                applyWardrobe()
            end)
            RageUI.List("Chaussures", wardrobeOptions.shoes.labels, wardrobe.shoes, "Choix de chaussures.", {}, true, function(_, _, _, Index)
                wardrobe.shoes = Index
                local drawable = wardrobeOptions.shoes.values[wardrobe.shoes] or 0
                wardrobeTextureOptions.shoes.labels, wardrobeTextureOptions.shoes.values = buildComponentTextureOptions(6, drawable)
                wardrobeTextures.shoes = clampSelection(wardrobeTextures.shoes, #wardrobeTextureOptions.shoes.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur Chaussures", wardrobeTextureOptions.shoes.labels, wardrobeTextures.shoes, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.shoes = Index
                applyWardrobe()
            end)
            RageUI.Separator("~b~Add-ons")
            RageUI.List("Masque", wardrobeOptions.masks.labels, wardrobe.mask, "Tous les masques disponibles.", {}, true, function(_, _, _, Index)
                wardrobe.mask = Index
                local drawable = wardrobeOptions.masks.values[wardrobe.mask] or 0
                wardrobeTextureOptions.masks.labels, wardrobeTextureOptions.masks.values = buildComponentTextureOptions(1, drawable)
                wardrobeTextures.mask = clampSelection(wardrobeTextures.mask, #wardrobeTextureOptions.masks.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur Masque", wardrobeTextureOptions.masks.labels, wardrobeTextures.mask, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.mask = Index
                applyWardrobe()
            end)
            RageUI.List("Sac / Parachute", wardrobeOptions.bags.labels, wardrobe.bag, "Sacs, sacoches ou parachute.", {}, true,function(_, _, _, Index)
                wardrobe.bag = Index
                local drawable = wardrobeOptions.bags.values[wardrobe.bag] or 0
                wardrobeTextureOptions.bags.labels, wardrobeTextureOptions.bags.values = buildComponentTextureOptions(5, drawable)
                wardrobeTextures.bag = clampSelection(wardrobeTextures.bag, #wardrobeTextureOptions.bags.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur Sac / Parachute", wardrobeTextureOptions.bags.labels, wardrobeTextures.bag, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.bag = Index
                applyWardrobe()
            end)
            RageUI.List("Accessoire cou", wardrobeOptions.accessories.labels, wardrobe.accessory, "Cravates, colliers et foulards.", {}, true, function(_, _, _, Index)
                wardrobe.accessory = Index
                local drawable = wardrobeOptions.accessories.values[wardrobe.accessory] or 0
                wardrobeTextureOptions.accessories.labels, wardrobeTextureOptions.accessories.values = buildComponentTextureOptions(7, drawable)
                wardrobeTextures.accessory = clampSelection(wardrobeTextures.accessory, #wardrobeTextureOptions.accessories.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur Accessoire", wardrobeTextureOptions.accessories.labels, wardrobeTextures.accessory, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.accessory = Index
                applyWardrobe()
            end)
            RageUI.List("Patchs / Décals", wardrobeOptions.decals.labels, wardrobe.decals, "Badges et patchs visibles.", {}, true, function(_, _, _, Index)
                wardrobe.decals = Index
                local drawable = wardrobeOptions.decals.values[wardrobe.decals] or 0
                wardrobeTextureOptions.decals.labels, wardrobeTextureOptions.decals.values = buildComponentTextureOptions(10, drawable)
                wardrobeTextures.decals = clampSelection(wardrobeTextures.decals, #wardrobeTextureOptions.decals.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur Patchs / Décals", wardrobeTextureOptions.decals.labels, wardrobeTextures.decals, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.decals = Index
                applyWardrobe()
            end)
            RageUI.List("Gilet pare-balles", wardrobeOptions.armors.labels, wardrobe.armor, "Niveaux de protection.", {}, true,function(_, _, _, Index)
                wardrobe.armor = Index
                local drawable = wardrobeOptions.armors.values[wardrobe.armor] or 0
                wardrobeTextureOptions.armors.labels, wardrobeTextureOptions.armors.values = buildComponentTextureOptions(9, drawable)
                wardrobeTextures.armor = clampSelection(wardrobeTextures.armor, #wardrobeTextureOptions.armors.labels)
                applyWardrobe()
            end)
            RageUI.List("Couleur Gilet", wardrobeTextureOptions.armors.labels, wardrobeTextures.armor, "Variations de texture.", {}, true, function(_, _, _, Index)
                wardrobeTextures.armor = Index
                applyWardrobe()
            end)
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'props')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Accessoires")
            RageUI.List("Chapeaux", propOptions.hats.labels, props.hats, "Ajoutez un couvre-chef.", {}, true, function(_, _, _,Index)
                props.hats = Index
                local drawable = propOptions.hats.values[props.hats] or -1
                propTextureOptions.hats.labels, propTextureOptions.hats.values = buildPropTextureOptions(0, math.max(drawable, 0))
                propTextures.hats = clampSelection(propTextures.hats, #propTextureOptions.hats.labels)
                applyProps()
            end)
            RageUI.List("Couleur Chapeaux", propTextureOptions.hats.labels, propTextures.hats, "Variations de texture.", {}, true, function(_, _, _, Index)
                propTextures.hats = Index
                applyProps()
            end)
            RageUI.List("Lunettes", propOptions.glasses.labels, props.glasses, "Lunettes et montures.", {}, true, function(_, _, _, Index)
                props.glasses = Index
                local drawable = propOptions.glasses.values[props.glasses] or -1
                propTextureOptions.glasses.labels, propTextureOptions.glasses.values = buildPropTextureOptions(1, math.max(drawable, 0))
                propTextures.glasses = clampSelection(propTextures.glasses, #propTextureOptions.glasses.labels)
                applyProps()
            end)
            RageUI.List("Couleur Lunettes", propTextureOptions.glasses.labels, propTextures.glasses, "Variations de texture.", {}, true, function(_, _, _, Index)
                propTextures.glasses = Index
                applyProps()
            end)
            RageUI.List("Oreilles", propOptions.ears.labels, props.ears, "Boucles ou studs.", {}, true, function(_, _, _, Index)
                props.ears = Index
                local drawable = propOptions.ears.values[props.ears] or -1
                propTextureOptions.ears.labels, propTextureOptions.ears.values = buildPropTextureOptions(2, math.max(drawable, 0))
                propTextures.ears = clampSelection(propTextures.ears, #propTextureOptions.ears.labels)
                applyProps()
            end)
            RageUI.List("Couleur Oreilles", propTextureOptions.ears.labels, propTextures.ears, "Variations de texture.", {}, true, function(_, _, _, Index)
                propTextures.ears = Index
                applyProps()
            end)
            RageUI.List("Montres", propOptions.watches.labels, props.watches, "Choisissez un poignet.", {}, true, function(_, _, _, Index)
                props.watches = Index
                local drawable = propOptions.watches.values[props.watches] or -1
                propTextureOptions.watches.labels, propTextureOptions.watches.values = buildPropTextureOptions(6, math.max(drawable, 0))
                propTextures.watches = clampSelection(propTextures.watches, #propTextureOptions.watches.labels)
                applyProps()
            end)
            RageUI.List("Couleur Montres", propTextureOptions.watches.labels, propTextures.watches, "Variations de texture.", {}, true, function(_, _, _, Index)
                propTextures.watches = Index
                applyProps()
            end)
            RageUI.List("Bracelets", propOptions.bracelets.labels, props.bracelets, "Accessoire de poignet.", {}, true, function(_, _, _, Index)
                props.bracelets = Index
                local drawable = propOptions.bracelets.values[props.bracelets] or -1
                propTextureOptions.bracelets.labels, propTextureOptions.bracelets.values = buildPropTextureOptions(7, math.max(drawable, 0))
                propTextures.bracelets = clampSelection(propTextures.bracelets, #propTextureOptions.bracelets.labels)
                applyProps()
            end)
            RageUI.List("Couleur Bracelets", propTextureOptions.bracelets.labels, propTextures.bracelets, "Variations de texture.", {}, true, function(_, _, _, Index)
                propTextures.bracelets = Index
                applyProps()
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get(menuName, 'model')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            for i, entry in ipairs(pedModel.models) do
                RageUI.Button(entry.label, "Sélectionnez un modèle de base.", { RightBadge = (pedModel.index == i and RageUI.BadgeStyle.Tick or nil) }, true, function(_, _, Selected)
                    if Selected then
                        pedModel.index = i
                        applyModel(entry.model)
                    end
                end)
            end
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'outfits')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Emplacements")
            for slot, data in ipairs(outfits) do
                local badge = data.saved and RageUI.BadgeStyle.Star or RageUI.BadgeStyle.None
                local subtitle = data.saved and data.note or "Vide"
                RageUI.Button(data.label, subtitle, { RightBadge = badge, RightLabel = "→" }, true, function(_, _, Selected)
                    if Selected then
                        data.saved = not data.saved
                        data.note = data.saved and "Sauvegardé" or "Vide"
                        -- Ici tu pourras plus tard lier à un système de sauvegarde réel
                    end
                end)
            end
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'persistence')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Checkbox("Autosave", "Sauvegarde automatique à la fermeture.", persistence.autosave, { Style = RageUI.CheckboxStyle.Tick }, function(_, _, _, Checked)
                persistence.autosave = Checked
            end)
            RageUI.List("Profil actif", persistence.slots, persistence.slot, "Choisissez le profil.", {}, true, function(_, _, _, Index)
                persistence.slot = Index
            end)
            RageUI.Button("Sauvegarder", "Enregistrer dans le profil sélectionné.", { RightLabel = "ENREGISTRER" }, true, function(_, _, Selected)
                if Selected then
                    -- Logique de sauvegarde à implémenter (ex: TriggerServerEvent vers qb-core / skin / etc.)
                end
            end)
            RageUI.Button("Charger", "Charger le profil sélectionné.", { RightLabel = "CHARGER" }, true, function(_, _, Selected)
                if Selected then
                    -- Logique de chargement à implémenter
                end
            end)
        end)
    end
end, 1)

RegisterCommand('delete-appearance-menu', function()
    for _, name in ipairs({ 'main', 'heritage', 'features', 'appearance', 'wardrobe', 'props', 'model', 'outfits', 'persistence' }) do
        RMenu:Delete(menuName, name)
    end
end, false)
