---@class iIndex

local iIndex = {
    heritage = {
        mother = 1,
        dad = 1,
        ListMother = { "Hannah", "Aubrey", "Jasmine", "Gisele", "Amelia", "Isabella", "Zoe", "Ava", "Camila", "Violet", "Sophia", "Evelyn", "Nicole", "Ashley", "Gracie", "Brianna", "Natalie", "Olivia", "Elizabeth", "Charlotte", "Emma" },
        ListFather = { "Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony",  "Claude", "Niko" },
        slidecorps = 5,
        slideteint = 5,
    },
    visage = {
        Colors = {{22, 19, 19},{30, 28, 25},{76, 56, 45},{69, 34, 24},{123, 59, 31},{149, 68, 35},{165, 87, 50},{175, 111, 72},{159, 105, 68},{198, 152, 108},{213, 170, 115}, {223, 187, 132}, {202, 164, 110}, {238, 204, 130}, {229, 190, 126}, {250, 225, 167}, {187, 140, 96}, {163, 92, 60}, {144, 52, 37}, {134, 21, 17}, {164, 24, 18}, {195, 33, 24}, {221, 69, 34}, {229, 71, 30}, {208, 97, 56}, {113, 79, 38}, {132, 107, 95}, {185, 164, 150}, {218, 196, 180}, {247, 230, 217}, {102, 72, 93}, {162, 105, 138}, {171, 174, 11}, {239, 61, 200}, {255, 69, 152}, {255, 178, 191}, {12, 168, 146}, {8, 146, 165}, {11, 82, 134}, {118, 190, 117}, {52, 156, 104}, {22, 86, 85}, {152, 177, 40}, {127, 162, 23}, {241, 200, 98}, {238, 178, 16}, {224, 134, 14}, {247, 157, 15}, {243, 143, 16}, {231, 70, 15}, {255, 101, 21}, {254, 91, 34}, {252, 67, 21}, {196, 12, 15}, {143, 10, 14}, {44, 27, 22}, {80, 51, 37}, {98, 54, 37}, {60, 31, 24}, {69, 43, 32}, {8, 10, 14}, {212, 185, 158}, {212, 185, 158}, {213, 170, 115}, },
        cHair = {1,1,1,1},
        iHair = 1,
        cBeard = {1,1, 0.0},
        iBeard = 1,
        cSourcils = {1,1, 0.0},
        iSourcils = 1,
        iHauteurSourcils = -10,
        iEyeColor = 1,
        iRides = 1,
        cRides = 0.0,
        iButtons = 1,
        cButtons = 0.0,
        iNeck = 1,
        grid = {
            default = { x = 0.5, y = 0.5 },
            horizontal = { x = 0.5 },
            vertical = { y = 0.5 },
        },
    },
    tenues = {
        Torso1 = 1,
        Torso2 = 1,
        TShirt1 = 1,
        TShirt2 = 1,
        Arms1 = 1,
        Arms2 = 1,
        Pants1 = 1,
        Pants2 = 2,
        Shoes1 = 1,
        Shoes2 = 1,
        Calques1 = 1,
        Calques2 = 1,
        Chaine1 = 1,
        Chaine2 = 1,
        Montre1 = 1,
        Montre2 = 1,
        Bracelets1 = 1,
        Bracelets2 = 1,
    }
}


---OpenCharacterCreator
---@public
function SublimeIndex.OpenCharacterCreator()
    SublimeIndex.CamsCharacterCreator()
    local main = RageUI.CreateMenu("Votre Personnage", "Actions disponibles :", 1400, 40);
    local subheritage = RageUI.CreateSubMenu(main, "Votre Personnage", "HERITAGE :", 1400, 40);
    local subvisage = RageUI.CreateSubMenu(main, "Votre Personnage", "VISAGE :", 1400, 40);
    local subtenues =  RageUI.CreateSubMenu(main, "Votre Personnage", "TENUES :", 1400, 40);
    local subvalid =  RageUI.CreateSubMenu(main, "Votre Personnage", "VALID :", 1400, 40);
    main.Closable = false
    main.EnableMouse = true
    subheritage.EnableMouse = true
    subvisage.EnableMouse = true
    subvisage.Closed = function() SublimeIndex.CamsCharacterCreator() end
    subheritage.Closed = function() SublimeIndex.CamsCharacterCreator() end
    subtenues.Closed = function() SublimeIndex.CamsCharacterCreator() end

    RageUI.Visible(main, not RageUI.Visible(main)) 
    
    while main do Citizen.Wait(0)


        RageUI.IsVisible(main, function()
            RageUI.Separator('~h~Détails de votre personnage');
            RageUI.Line()
            RageUI.Button("~c~→~s~ Héritage", nil, {RightBadge = RageUI.BadgeStyle.Body}, true, {onSelected = function() SublimeIndex.CamsCharacterCreator_Head() end}, subheritage)
            RageUI.Button("~c~→~s~ Visage", nil, {RightBadge = RageUI.BadgeStyle.Mask}, true, {onSelected = function() SublimeIndex.CamsCharacterCreator_Head() end}, subvisage)
            RageUI.Button("~c~→~s~ Tenues", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {}, subtenues)
            RageUI.Line()
            RageUI.Button("~c~→~g~ Valider", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {}, subvalid)
        end)


        RageUI.IsVisible(subheritage, function()
            RageUI.Window.Heritage(iIndex.heritage.mother - 1, iIndex.heritage.dad - 1)
            RageUI.Line()
            RageUI.List('~c~Votre ~s~Mère :', iIndex.heritage.ListMother, iIndex.heritage.mother, "Sélectionner la Mère de votre Personnage", {}, true, { onListChange = function(Index, Item) iIndex.heritage.mother = Index TriggerEvent('skinchanger:change', 'mom', iIndex.heritage.mother - 1) end })
            RageUI.List('~c~Votre ~s~Père :', iIndex.heritage.ListFather, iIndex.heritage.dad, "Sélectionner le Père de votre Personnage", {}, true, { onListChange = function(Index, Item) iIndex.heritage.dad = Index TriggerEvent('skinchanger:change', 'dad', iIndex.heritage.dad - 1) end })
            RageUI.UISliderHeritage('~c~Ressemblance ~s~Corps', iIndex.heritage.slidecorps, "Modifier la ressemblance de votre personnage", { onSliderChange = function(Float, Index) iIndex.heritage.slidecorps = Index TriggerEvent('skinchanger:change', 'face_md_weight', iIndex.heritage.slidecorps * 10) end})
            RageUI.UISliderHeritage('~c~Ressemblance ~s~Teint', iIndex.heritage.slideteint, "Modifier la ressemblance de votre personnage", { onSliderChange = function(Float, Index) iIndex.heritage.slideteint = Index TriggerEvent('skinchanger:change', 'skin_md_weight', iIndex.heritage.slideteint * 10) end})
            RageUI.Button("Retour", nil, {RightLabel = "←←←", Color = {BackgroundColor = {180, 0, 27, 180}}}, true, {onSelected = function() SublimeIndex.CamsCharacterCreator() end}, main)
        end)


        RageUI.IsVisible(subvisage, function()
            local Coiffure = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 2)-1, 1 do Coiffure[i] = i end
            local Barbes = {} for i = 0 , GetNumHeadOverlayValues(1)-1, 1 do Barbes[i] = i end
            local Sourcils = {} for i = 0 , GetNumHeadOverlayValues(2)-1, 1 do Sourcils[i] = i end
            local CouleurYeux = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}
            local Rides = {} for i = 0, GetNumHeadOverlayValues(3)-1, 1 do Rides[i] = i end
            local Boutons = {} for i = 0, GetNumHeadOverlayValues(0)-1, 1 do Boutons[i] = i end

            RageUI.List('Cheveux :', Coiffure, iIndex.visage.iHair, nil, {}, true, {onListChange = function(Index, Item) iIndex.visage.iHair = Index TriggerEvent('skinchanger:change', 'hair_1', iIndex.visage.iHair - 1) end })

            RageUI.List('Barbe :', Barbes, iIndex.visage.iBeard, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iBeard = Index TriggerEvent('skinchanger:change', 'beard_1', iIndex.visage.iBeard - 1) end })
            
            RageUI.List('Sourcils :', Sourcils, iIndex.visage.iSourcils, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iSourcils = Index TriggerEvent('skinchanger:change', 'eyebrows_1', iIndex.visage.iSourcils - 1) end })

            RageUI.Button("Position Sourcils", nil, {}, true, {})

            RageUI.List('Couleur Yeux :', CouleurYeux, iIndex.visage.iEyeColor, nil, {}, true, {onListChange = function(Index, Item) iIndex.visage.iEyeColor = Index TriggerEvent('skinchanger:change', 'eye_color', iIndex.visage.iEyeColor - 1) end })

            RageUI.List('Rides :', Rides, iIndex.visage.iRides, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iRides = Index TriggerEvent('skinchanger:change', 'age_1', iIndex.visage.iRides - 1) end })

            RageUI.Button("Principal Nez", nil, {}, true, {})

            RageUI.Button("Profil du Nez", nil, {}, true, {})

            RageUI.Button("Bout de nez", nil, {}, true, {})

            RageUI.Button("Mâchoire", nil, {}, true, {})

            RageUI.Button("Pommettes", nil, {}, true, {})

            RageUI.List('Boutons :', Boutons, iIndex.visage.iButtons, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iButtons = Index TriggerEvent('skinchanger:change', 'blemishes_1', iIndex.visage.iButtons - 1) end })

            RageUI.List('Épaisseur du cou :', {1,2,3,4,5,6,7,8,9,10}, iIndex.visage.iNeck, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iNeck = Index TriggerEvent('skinchanger:change', 'neck_thickness', iIndex.visage.iNeck - 1) end })

            RageUI.Button("Retour", nil, {RightLabel = "←←←", Color = {BackgroundColor = {180, 0, 27, 180}}}, true, {onSelected = function() SublimeIndex.CamsCharacterCreator() end}, main)

                    -- PANELS --
            -- Cheveux
            RageUI.ColourPanel("Couleur Principale", iIndex.visage.Colors, iIndex.visage.cHair[1], iIndex.visage.cHair[2], { onColorChange = function(MinimumIndex, CurrentIndex) iIndex.visage.cHair[1] = MinimumIndex iIndex.visage.cHair[2] = CurrentIndex TriggerEvent('skinchanger:change', "hair_color_1", iIndex.visage.cHair[2] - 1) end }, 1)
            RageUI.ColourPanel("Couleur Secondaire", iIndex.visage.Colors, iIndex.visage.cHair[3], iIndex.visage.cHair[4], { onColorChange = function(MinimumIndex, CurrentIndex) iIndex.visage.cHair[3] = MinimumIndex iIndex.visage.cHair[4] = CurrentIndex TriggerEvent('skinchanger:change', "hair_color_2", iIndex.visage.cHair[4] - 1) end }, 1)
            -- Barbes
            RageUI.ColourPanel("Couleur Principale", iIndex.visage.Colors, iIndex.visage.cBeard[1], iIndex.visage.cBeard[2], { onColorChange = function(MinimumIndex, CurrentIndex) iIndex.visage.cBeard[1] = MinimumIndex iIndex.visage.cBeard[2] = CurrentIndex TriggerEvent('skinchanger:change', "beard_3", iIndex.visage.cBeard[2] - 1) end }, 2)
            RageUI.PercentagePanel(iIndex.visage.cBeard[3], "Opacité (" .. math.floor(iIndex.visage.cBeard[3]*100) .. "%)", '0%', '100%', { onProgressChange = function(Percentage) iIndex.visage.cBeard[3] = Percentage TriggerEvent('skinchanger:change', "beard_2", iIndex.visage.cBeard[3] * 10) end }, 2)
            -- Sourcils
            RageUI.ColourPanel("Couleur Principale", iIndex.visage.Colors, iIndex.visage.cSourcils[1], iIndex.visage.cSourcils[2], { onColorChange = function(MinimumIndex, CurrentIndex) iIndex.visage.cSourcils[1] = MinimumIndex iIndex.visage.cSourcils[2] = CurrentIndex TriggerEvent('skinchanger:change', "eyebrows_3", iIndex.visage.cSourcils[2] - 1) end }, 3)
            RageUI.PercentagePanel(iIndex.visage.cSourcils[3], "Opacité (" .. math.floor(iIndex.visage.cSourcils[3]*100) .. "%)", '0%', '100%', { onProgressChange = function(Percentage) iIndex.visage.cSourcils[3] = Percentage TriggerEvent('skinchanger:change', "eyebrows_2", iIndex.visage.cSourcils[3] * 10) end }, 3)
            --Position Sourcils
            RageUI.Grid(iIndex.visage.grid.default.x, iIndex.visage.grid.default.y, '', '', 'Haut', 'Bas', { onPositionChange = function(IndexX, IndexY, X, Y) iIndex.visage.grid.default.x = IndexX iIndex.visage.grid.default.y = IndexY TriggerEvent('skinchanger:change', 'eyebrows_5', IndexX * 10) TriggerEvent('skinchanger:change', 'eyebrows_6', IndexY * 10) end }, 4)
            -- Rides
            RageUI.PercentagePanel(iIndex.visage.cRides, "Opacité (" .. math.floor(iIndex.visage.cRides*100) .. "%)", '0%', '100%', { onProgressChange = function(Percentage) iIndex.visage.cRides = Percentage TriggerEvent('skinchanger:change', "age_2", iIndex.visage.cRides * 10) end }, 6)
            --Nose Principale
            RageUI.Grid(iIndex.visage.grid.default.x, iIndex.visage.grid.default.y, 'Haut', 'Bas', 'Étroit', 'Large', { onPositionChange = function(IndexX, IndexY, X, Y) iIndex.visage.grid.default.x = IndexX iIndex.visage.grid.default.y = IndexY TriggerEvent('skinchanger:change', 'nose_1', IndexX * 10)  TriggerEvent('skinchanger:change', 'nose_2', IndexY * 10)  end }, 7)
            RageUI.Grid(iIndex.visage.grid.default.x, iIndex.visage.grid.default.y, 'Courbé', 'Court', 'Long', 'Incurvé', { onPositionChange = function(IndexX, IndexY, X, Y) iIndex.visage.grid.default.x = IndexX iIndex.visage.grid.default.y = IndexY TriggerEvent('skinchanger:change', 'nose_3', IndexX* 10)  TriggerEvent('skinchanger:change', 'nose_4', IndexY* 10)  end }, 8)
            RageUI.Grid(iIndex.visage.grid.default.x, iIndex.visage.grid.default.y, 'Incliner', 'Gauche cassée', 'Droit cassé', 'Basculer', { onPositionChange = function(IndexX, IndexY, X, Y) iIndex.visage.grid.default.x = IndexX iIndex.visage.grid.default.y = IndexY TriggerEvent('skinchanger:change', 'nose_5', IndexX* 10)  TriggerEvent('skinchanger:change', 'nose_6', IndexY* 10)  end }, 9)
            -- Machoire
            RageUI.Grid(iIndex.visage.grid.default.x, iIndex.visage.grid.default.y, 'Haut', 'Bas', 'Étroit', 'Large', { onPositionChange = function(IndexX, IndexY, X, Y) iIndex.visage.grid.default.x = IndexX iIndex.visage.grid.default.y = IndexY TriggerEvent('skinchanger:change', 'jaw_1', IndexX* 10)  TriggerEvent('skinchanger:change', 'jaw_2', IndexY* 10)  end }, 10)
            -- Pommettes
            RageUI.Grid(iIndex.visage.grid.default.x, iIndex.visage.grid.default.y, 'Haut', 'Bas', 'Étroit', 'Large', { onPositionChange = function(IndexX, IndexY, X, Y) iIndex.visage.grid.default.x = IndexX iIndex.visage.grid.default.y = IndexY TriggerEvent('skinchanger:change', 'cheeks_1', IndexX* 10)  TriggerEvent('skinchanger:change', 'cheeks_2', IndexY* 10)  end }, 11)
            --Buttons 
            RageUI.PercentagePanel(iIndex.visage.cButtons, "Opacité (" .. math.floor(iIndex.visage.cButtons*100) .. "%)", '0%', '100%', { onProgressChange = function(Percentage) iIndex.visage.cButtons = Percentage TriggerEvent('skinchanger:change', "blemishes_2", iIndex.visage.cButtons * 10) end }, 12)

        end)


        RageUI.IsVisible(subtenues, function()
            local Torso1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 11)-1, 1 do Torso1[i] = i end
            local Torso2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 11, iIndex.tenues.Torso1) - 1, 1 do Torso2[i] = i end
            local TShirt1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 8) - 1, 1 do TShirt1[i] = i end
            local TShirt2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 8, iIndex.tenues.TShirt1) - 1, 1 do TShirt2[i] = i end
            local Arms1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 3) - 1, 1 do Arms1[i] = i end
            local Pants1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 4) - 1, 1 do Pants1[i] = i end
            local Pants2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 4, iIndex.tenues.Pants1) - 1, 1 do Pants2[i] = i end
            local Shoes1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 6) - 1, 1 do Shoes1[i] = i end
            local Shoes2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 6, iIndex.tenues.Shoes1) - 1, 1 do Shoes2[i] = i end
            local Calques1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 10) - 1, 1 do Calques1[i] = i end
            local Calques2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 10, iIndex.tenues.Calques1) - 1, 1 do Calques2[i] = i end
            local Chaine1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 7) - 1, 1 do Chaine1[i] = i end
            local Chaine2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 7, iIndex.tenues.Chaine1) - 1, 1 do Chaine2[i] = i end
            local Montre1 = {} for i = 0 , GetNumberOfPedPropDrawableVariations(PlayerPedId(), 6) - 1, 1 do Montre1[i] = i end
            local Montre2 = {} for i = 0 , GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, iIndex.tenues.Montre1) - 1, 1 do Montre2[i] = i end
            local Bracelets1 = {} for i = 0 , GetNumberOfPedPropDrawableVariations(PlayerPedId(), 7) - 1, 1 do Bracelets1[i] = i end
            local Bracelets2 = {} for i = 0 , GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, iIndex.tenues.Bracelets1) - 1, 1 do Bracelets2[i] = i end

            RageUI.List('Torse 1', Torso1, iIndex.tenues.Torso1, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Torso1 = Index iIndex.tenues.Torso2 = 1 TriggerEvent('skinchanger:change', 'torso_1', iIndex.tenues.Torso1 - 1) end, })

            RageUI.List('Torse 2', Torso2, iIndex.tenues.Torso2, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Torso2 = Index TriggerEvent('skinchanger:change', 'torso_2', iIndex.tenues.Torso2 - 1) end, })

            RageUI.List('T-Shirt 1', TShirt1, iIndex.tenues.TShirt1, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.TShirt1 = Index iIndex.tenues.TShirt2 = 1 TriggerEvent('skinchanger:change', 'tshirt_1', iIndex.tenues.TShirt1 - 1) end, })

            RageUI.List('T-Shirt 2', TShirt2, iIndex.tenues.TShirt2, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.TShirt2 = Index TriggerEvent('skinchanger:change', 'tshirt_2', iIndex.tenues.TShirt2 - 1) end, })

            RageUI.List('Bras 1', Arms1, iIndex.tenues.Arms1, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Arms1 = Index iIndex.tenues.Arms2 = 1 TriggerEvent('skinchanger:change', 'arms', iIndex.tenues.Arms1 - 1) end, })

            RageUI.List('Bras 2', {1,2,3,4,5,6,7,8,9,10}, iIndex.tenues.Arms2, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Arms2 = Index TriggerEvent('skinchanger:change', 'arms_2', iIndex.tenues.Arms2 - 1) end, })

            RageUI.List('Pantalon 1', Pants1, iIndex.tenues.Pants1, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Pants1 = Index iIndex.tenues.Pants2 = 1 TriggerEvent('skinchanger:change', 'pants_1', iIndex.tenues.Pants1 - 1) end, })

            RageUI.List('Pantalon 2', Pants2, iIndex.tenues.Pants2, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Pants2 = Index TriggerEvent('skinchanger:change', 'pants_2', iIndex.tenues.Pants2 - 1) end, })

            RageUI.List('Chaussures 1', Shoes1, iIndex.tenues.Shoes1, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Shoes1 = Index iIndex.tenues.Shoes2 = 1 TriggerEvent('skinchanger:change', 'shoes_1', iIndex.tenues.Shoes1 - 1) end, })

            RageUI.List('Chaussures 2', Shoes2, iIndex.tenues.Shoes2, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Shoes2 = Index TriggerEvent('skinchanger:change', 'shoes_2', iIndex.tenues.Shoes2 - 1) end, })

            RageUI.List('Calques 1', Calques1, iIndex.tenues.Calques1, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Calques1 = Index iIndex.tenues.Calques2 = 1 TriggerEvent('skinchanger:change', 'decals_1', iIndex.tenues.Calques1 - 1) end, })

            RageUI.List('Calques 2', Calques2, iIndex.tenues.Calques2, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Calques2 = Index TriggerEvent('skinchanger:change', 'decals_2', iIndex.tenues.Calques2 - 1) end, })

            RageUI.List('Chaine 1', Chaine1, iIndex.tenues.Chaine1, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Chaine1 = Index iIndex.tenues.Chaine2 = 1 TriggerEvent('skinchanger:change', 'chain_1', iIndex.tenues.Chaine1 - 1) end, })

            RageUI.List('Chaine 2', Chaine2, iIndex.tenues.Chaine2, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Chaine2 = Index TriggerEvent('skinchanger:change', 'chain_2', iIndex.tenues.Chaine2 - 1) end, })

            RageUI.List('Montre 1', Montre1, iIndex.tenues.Montre1, nil, {}, true, {onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end,  onListChange = function(Index, Item) iIndex.tenues.Montre1 = Index iIndex.tenues.Montre2 = 1 TriggerEvent('skinchanger:change', 'watches_1', iIndex.tenues.Montre1 - 1) end, })

            RageUI.List('Montre 2', Montre2, iIndex.tenues.Montre2, nil, {}, true, {onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Montre2 = Index TriggerEvent('skinchanger:change', 'watches_2', iIndex.tenues.Montre2 - 1) end, })

            RageUI.List('Bracelets 1', Bracelets1, iIndex.tenues.Bracelets1, nil, {}, true, {onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end,  onListChange = function(Index, Item) iIndex.tenues.Bracelets1 = Index iIndex.tenues.Bracelets2 = 1 TriggerEvent('skinchanger:change', 'bracelets_1', iIndex.tenues.Bracelets1 - 1) end, })

            RageUI.List('Bracelets 2', Bracelets2, iIndex.tenues.Bracelets2, nil, {}, true, { onActive = function() SublimeIndex.OnRenderCharacter() Visual.Subtitle("Caméra : ~b~A~s~ Default | ~b~Z~s~ Visage | ~b~E~s~ Torse | ~b~R~s~ Pantalon | ~b~T~s~ Chaussures  ", 1500)  end, onListChange = function(Index, Item) iIndex.tenues.Bracelets2 = Index TriggerEvent('skinchanger:change', 'bracelets_2', iIndex.tenues.Bracelets2 - 1) end, })

            RageUI.Button("Retour", nil, {RightLabel = "←←←", Color = {BackgroundColor = {180, 0, 27, 180}}}, true, {onSelected = function() SublimeIndex.CamsCharacterCreator() end}, main)
        end)


        RageUI.IsVisible(subvalid, function()
            if iIndex.tenues.Torso1 ~= 1 then
                RageUI.Button("Confirmer", "Cette action et définitive", {RightBadge = RageUI.BadgeStyle.Star, Color = {HightLightColor = {100, 178, 82, 220}, BackgroundColor = {100, 178, 82, 130}}}, true, {
                    onSelected = function()
                        Citizen.CreateThread(function()
                            SublimeIndex.EndCharacterCreator()
                        end)
                        main = RMenu:DeleteType('main', true)
                    end
                })
                RageUI.Button("Annuler", nil, {RightLabel = "←←←", Color = {HightLightColor = {180, 0, 27, 180}, BackgroundColor = {180, 0, 27, 180}}}, true, {}, main)
            else
                RageUI.GoBack()
                ESX.ShowNotification("~r~Vous n'avez pas fait les modifications necessaires de votre personnage !")
            end
        end)


        if not RageUI.Visible(main) and not RageUI.Visible(subheritage) and not RageUI.Visible(subvisage) and not RageUI.Visible(subtenues) and not RageUI.Visible(subvalid) then 
            main = RMenu:DeleteType('main', true)
        end
    end
end