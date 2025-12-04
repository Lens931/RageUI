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
    makeupOpacity = 5,
    lipstickStyle = 1,
    lipstickOpacity = 5,
    blemishes = 0,
    ageing = 0,
}

local hairStyles = { "Cheveux courts", "Dégradé net", "Coiffé en arrière", "Bouclé", "Chignon", "Tresse", "Crâne rasé" }
local hairColors = { "Noir", "Châtain", "Brun", "Blond", "Blanc", "Rouge", "Cuivre", "Auburn" }
local eyebrows = { "Léger", "Droites", "Courbées", "Épaisses", "Affinées" }
local makeups = { "Naturel", "Smokey", "Glamour", "Cat Eye", "Pop" }
local lipsticks = { "Naturel", "Brillant", "Mat", "Rouge vif", "Rose" }

---@type table
local wardrobe = {
    tshirt = 1,
    torso = 1,
    pants = 1,
    shoes = 1,
    jacket = 1,
}

local wardrobeOptions = {
    tshirts = { "T-shirt basique", "Débardeur", "Col en V", "Longline" },
    torsos = { "Torse par défaut", "Gilet simple", "Chemise ouverte" },
    jackets = { "Blouson", "Veste en cuir", "Manteau long" },
    pants = { "Jean slim", "Cargo", "Chino" },
    shoes = { "Baskets", "Boots", "Derbies", "Skate" },
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
    hats = { "Casquette", "Bonnet", "Borsalino", "Chapeau trilby" },
    glasses = { "Classiques", "Aviateur", "Carrées", "Sport" },
    ears = { "Boucle simple", "Créole", "Stud", "Sans" },
    watches = { "Analogique", "Numérique", "Sport" },
    bracelets = { "Cuir", "Métal", "Perles", "Sans" },
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

local function applyModel(model)
    if not model then return end
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), hash)
    SetModelAsNoLongerNeeded(hash)
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
            end)
            RageUI.List("Mère", parents.mothers, heritage.mother, "Sélectionnez le parent féminin.", {}, true, function(_, _, _, Index)
                heritage.mother = Index
            end)
            RageUI.SliderProgress("Ressemblance", heritage.resemblance, 10, "0 = mère, 10 = père.", {}, true, function(_, _, _, Index)
                heritage.resemblance = Index
            end)
            RageUI.SliderProgress("Couleur de peau", heritage.skinTone, 10, "Mélange des carnations.", {}, true, function(_, _, _, Index)
                heritage.skinTone = Index
            end)
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'features')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Détails du visage")
            RageUI.SliderProgress("Nez", features.nose, 10, "Largeur et hauteur.", {}, true, function(_, _, _, Index)
                features.nose = Index
            end)
            RageUI.SliderProgress("Profil du nez", features.noseProfile, 10, "Pont et cambrure.", {}, true, function(_, _, _, Index)
                features.noseProfile = Index
            end)
            RageUI.SliderProgress("Pointe du nez", features.noseTip, 10, "Affinement de la pointe.", {}, true, function(_, _, _, Index)
                features.noseTip = Index
            end)
            RageUI.SliderProgress("Joues", features.cheeks, 10, "Creux ou volume.", {}, true, function(_, _, _, Index)
                features.cheeks = Index
            end)
            RageUI.SliderProgress("Lèvres", features.lips, 10, "Épaisseur et forme.", {}, true, function(_, _, _, Index)
                features.lips = Index
            end)
            RageUI.SliderProgress("Mâchoire", features.jaw, 10, "Largeur de la mâchoire.", {}, true, function(_, _, _, Index)
                features.jaw = Index
            end)
            RageUI.SliderProgress("Menton", features.chin, 10, "Longueur et creux.", {}, true, function(_, _, _, Index)
                features.chin = Index
            end)
            RageUI.SliderProgress("Yeux", features.eyes, 10, "Ouverture et rotation.", {}, true, function(_, _, _, Index)
                features.eyes = Index
            end)
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'appearance')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Cheveux")
            RageUI.List("Style", hairStyles, appearance.hairStyle, "Choisissez une coupe.", {}, true, function(_, _, _, Index)
                appearance.hairStyle = Index
            end)
            RageUI.List("Couleur", hairColors, appearance.hairColor, "Teinte principale.", {}, true, function(_, _, _, Index)
                appearance.hairColor = Index
            end)
            RageUI.List("Mèches", hairColors, appearance.hairHighlight, "Couleur secondaire.", {}, true, function(_, _, _, Index)
                appearance.hairHighlight = Index
            end)

            RageUI.Separator("~b~Sourcils")
            RageUI.List("Forme", eyebrows, appearance.eyebrows, "Style de sourcil.", {}, true, function(_, _, _, Index)
                appearance.eyebrows = Index
            end)
            RageUI.Slider("Opacité", appearance.eyebrowsOpacity, 10, "Intensité des sourcils.", false, {}, true, function(_, _, _, Index)
                appearance.eyebrowsOpacity = Index
            end)

            RageUI.Separator("~b~Maquillage")
            RageUI.List("Maquillage", makeups, appearance.makeupStyle, "Sélection du style.", {}, true, function(_, _, _, Index)
                appearance.makeupStyle = Index
            end)
            RageUI.Slider("Opacité maquillage", appearance.makeupOpacity, 10, "Appliquer ou atténuer.", false, {}, true, function(_, _, _, Index)
                appearance.makeupOpacity = Index
            end)
            RageUI.List("Rouge à lèvres", lipsticks, appearance.lipstickStyle, "Couleur des lèvres.", {}, true, function(_, _, _, Index)
                appearance.lipstickStyle = Index
            end)
            RageUI.Slider("Opacité lèvres", appearance.lipstickOpacity, 10, "Intensité du rouge à lèvres.", false, {}, true, function(_, _, _, Index)
                appearance.lipstickOpacity = Index
            end)

            RageUI.Separator("~b~Imperfections")
            RageUI.Slider("Imperfections", appearance.blemishes, 10, "Tâches ou grain de peau.", false, {}, true, function(_, _, _, Index)
                appearance.blemishes = Index
            end)
            RageUI.Slider("Rides / Ageing", appearance.ageing, 10, "Signes de l'âge.", false, {}, true, function(_, _, _, Index)
                appearance.ageing = Index
            end)
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'wardrobe')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Tenue de base")
            RageUI.List("T-shirt", wardrobeOptions.tshirts, wardrobe.tshirt, "Couche intérieure.", {}, true, function(_, _, _, Index)
                wardrobe.tshirt = Index
            end)
            RageUI.List("Torse", wardrobeOptions.torsos, wardrobe.torso, "Couche principale.", {}, true, function(_, _, _, Index)
                wardrobe.torso = Index
            end)
            RageUI.List("Veste", wardrobeOptions.jackets, wardrobe.jacket, "Couche extérieure.", {}, true, function(_, _, _, Index)
                wardrobe.jacket = Index
            end)
            RageUI.List("Pantalon", wardrobeOptions.pants, wardrobe.pants, "Bas du corps.", {}, true, function(_, _, _, Index)
                wardrobe.pants = Index
            end)
            RageUI.List("Chaussures", wardrobeOptions.shoes, wardrobe.shoes, "Choix de chaussures.", {}, true, function(_, _, _, Index)
                wardrobe.shoes = Index
            end)
        end)
    end

    if RageUI.Visible(RMenu:Get(menuName, 'props')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Separator("~b~Accessoires")
            RageUI.List("Chapeaux", propOptions.hats, props.hats, "Ajoutez un couvre-chef.", {}, true, function(_, _, _, Index)
                props.hats = Index
            end)
            RageUI.List("Lunettes", propOptions.glasses, props.glasses, "Lunettes et montures.", {}, true, function(_, _, _, Index)
                props.glasses = Index
            end)
            RageUI.List("Oreilles", propOptions.ears, props.ears, "Boucles ou studs.", {}, true, function(_, _, _, Index)
                props.ears = Index
            end)
            RageUI.List("Montres", propOptions.watches, props.watches, "Choisissez un poignet.", {}, true, function(_, _, _, Index)
                props.watches = Index
            end)
            RageUI.List("Bracelets", propOptions.bracelets, props.bracelets, "Accessoire de poignet.", {}, true, function(_, _, _, Index)
                props.bracelets = Index
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
                    -- Logique de sauvegarde à implémenter
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
