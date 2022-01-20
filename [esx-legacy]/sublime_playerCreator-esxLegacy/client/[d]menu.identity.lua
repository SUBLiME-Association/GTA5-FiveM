local nom = ''
local prenom = ''
local taille = 50.
local sexe = "Homme"
local dob = "../../...."
local progress = 0.
local loadProgress, endIdentity_ = false, true


---@class VeinUI
---@param text string
local function dLabel(text)
    VeinUI.setNextWidgetWidth(0.1)
    VeinUI.Label(text)
end

---@public 
local function endIdentity()
    if endIdentity_ then
        local _sex if sexe == "Homme" then _sex = "H" else _sex = "F" end
        TriggerServerEvent(Config.Prefix.."updateIdentity", {
            lastName = nom,
            firstName = prenom,
            height = taille,
            sex = _sex,
            dateOfBirth = dob
        })
        SublimeIndex.OpenCharacterCreator()
        endIdentity_ = false
    end
end


---@return SublimeIndex . OpenIdentityCreator
---@public
function SublimeIndex.OpenIdentityCreator()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            VeinUI.beginWindow(0.7, 0.5)

            VeinUI.Heading(string.upper(Config.Prefix).." Role Play")
            dLabel('~h~Bienvenue !')
            dLabel('Vous venez de rejoindre l\'aventure,\nprenez le temps de bien crée votre personnage.')
            dLabel('Bon jeu !')

            VeinUI.beginRow()
            dLabel('Votre Nom')
            _, nom = VeinUI.TextEdit(nom, 'Nom', 15)
            VeinUI.endRow()


            VeinUI.beginRow()
            dLabel('Votre Prénom')
            _, prenom = VeinUI.TextEdit(prenom, 'Prénom', 15)
            VeinUI.endRow()


            VeinUI.beginRow()
            dLabel('Votre Taille    ~c~'..ESX.Math.Round(taille).."cm")
            _, taille = VeinUI.Slider(0., taille, 250., 0.133)
            VeinUI.endRow()


            VeinUI.beginRow()
            dLabel('Votre Sexe   ~c~'..sexe)
            RequestStreamedTextureDict('mpleaderboard')
            if VeinUI.SpriteButton('mpleaderboard', 'leaderboard_male_icon', 'Homme') then
                sexe = "Homme"
                SublimeIndex.ChangeSexeCreator(sexe)
            elseif VeinUI.SpriteButton('mpleaderboard', 'leaderboard_female_icon', 'Femme') then
                sexe = "Femme"
                SublimeIndex.ChangeSexeCreator(sexe)
            end
            VeinUI.endRow()


            VeinUI.beginRow()
            dLabel('Date de Naissance')
            _, dob = VeinUI.TextEdit(dob, 'Date de Naissance', 15)
            VeinUI.endRow()


            if not loadProgress then
                if VeinUI.Button('Suivant') then
                    loadProgress = true
                end
            else
                VeinUI.beginRow()
                dLabel('Check des données')
                VeinUI.ProgressBar(0., progress, 100., 0.133)
                if progress <  100.00 then
                    progress = progress + 0.7
                else
                    if SublimeIndex.IsIdentityValid(nom ,"Name") and SublimeIndex.IsIdentityValid(prenom,"Name") and SublimeIndex.IsIdentityValid(dob, "Date") then
                        ESX.ShowNotification("~g~Identité mise à jour")
                        endIdentity()
                        break
                    else
                        loadProgress = false
                        progress = 0.
                    end
                end
                VeinUI.endRow()
            end
            VeinUI.endWindow()
        end
    end)
end
