---@class SublimeIndex
---@class Config
RegisterNetEvent('esx:playerLoaded')
RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:playerLoaded', function(xPlayer) ESX.PlayerData = xPlayer ESX.PlayerLoaded = true end)
AddEventHandler('esx:onPlayerLogout', function() ESX.PlayerLoaded = false ESX.PlayerData = {} end)


---onPlayerSpawn
---@public
AddEventHandler('esx:onPlayerSpawn', function()
    Citizen.CreateThread(function()
        while not ESX.PlayerLoaded do Citizen.Wait(100) end
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            if skin == nil then
                TriggerEvent('skinchanger:loadSkin', {sex = 0})
                Citizen.Wait(50)
                SublimeIndex.StartCharacterCreator()
            else
                TriggerEvent('skinchanger:loadSkin', skin)
                Wait(50)
                SublimeIndex.ReLoadSkin() --> Reload le skin ( en cas de bug )
            end
        end)
    end)
end)


---ReLoadSkin
---@public
function SublimeIndex.ReLoadSkin()
    Wait(1000)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end



---@class SetPlayerBuckets
---@public
function SetPlayerBuckets(val)
    TriggerServerEvent(Config.Prefix.."Buckets", val)
end


---startCharacterCreator
---@return SetPlayerBuckets
---@public
function SublimeIndex.StartCharacterCreator()
    DoScreenFadeOut(1)
    SublimeIndex.SetPlayerNaked()
    SetPlayerBuckets(true)
    SublimeIndex.CamsCharacterCreator()
    if Config.DisplayRadar then
        DisplayRadar(false)
    end
    ESX.Game.Teleport(PlayerPedId(), {x = Config.FirstSpawn.x, y = Config.FirstSpawn.y, z = Config.FirstSpawn.z, heading = Config.FirstSpawn.h}, function()
        SublimeIndex.PlayAnimCharacterCreator()
    end)
    Citizen.Wait(2500)
    DoScreenFadeIn(5800)
    SublimeIndex.OpenIdentityCreator()
end


---endCharacterCreator
---@return SetPlayerBuckets
---@public
function SublimeIndex.EndCharacterCreator()
    DoScreenFadeOut(1500)
    Citizen.Wait(1500)
    ESX.Game.Teleport(PlayerPedId(), {x = Config.SpawnAfterCreator.x, y = Config.SpawnAfterCreator.y, z = Config.SpawnAfterCreator.z, heading = Config.SpawnAfterCreator.h}, function()
        SublimeIndex.DestroyCams()
        FreezeEntityPosition(PlayerPedId(), true)
        SetPlayerBuckets(false)
        if Config.DisplayRadar then
            DisplayRadar(true)
        end
        TriggerEvent('skinchanger:getSkin', function(finalSkin)
            TriggerServerEvent('esx_skin:save', finalSkin)
        end)
        DoScreenFadeIn(1500)
        Citizen.Wait(1500)
        FreezeEntityPosition(PlayerPedId(), false)
        ClearPedTasks(PlayerPedId())
        ESX.ShowNotification("<C>~y~Création du personnage terminé !\n ~s~Bon jeu ! </C>")
    end)
end

---@public
function  SublimeIndex.OnRenderCharacter()
    if IsControlJustPressed(0, 44) then --A
        SublimeIndex.CamsCharacterCreator()
    elseif IsControlJustPressed(0, 32) then -- Z
        SublimeIndex.CamsCharacterCreator_Head()
    elseif IsControlJustPressed(0, 38) then --E
        SublimeIndex.CamsCharacterCreator_Torso()
    elseif IsControlJustPressed(0, 45) then --R
        SublimeIndex.CamsCharacterCreator_Pants()
    elseif IsControlJustPressed(0, 245) then --T
        SublimeIndex.CamsCharacterCreator_Shoes()
    end
end


---setPlayerNaked
---@public
function SublimeIndex.SetPlayerNaked()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.Naked.Male)
        else
            TriggerEvent('skinchanger:loadClothes', skin, Config.Naked.Female)
        end
    end)
end


---ChangeSexeCreator
---@param sexe string
---@public
function SublimeIndex.ChangeSexeCreator(sexe)
    Citizen.CreateThread(function()
        TriggerEvent('skinchanger:getSkin', function(skin)
            if sexe == "Homme" then
                TriggerEvent('skinchanger:change', 'sex', 0)
                Citizen.Wait(5)
                SublimeIndex.SetPlayerNaked()
            else sexe = "Femme"
                TriggerEvent('skinchanger:change', 'sex', 1)
                Citizen.Wait(5)
                SublimeIndex.SetPlayerNaked()
            end
        end)
        Citizen.Wait(5)
        SublimeIndex.PlayAnimCharacterCreator()
    end)
end


---isIdentityValid
---@param String string
---@param Type string
---@return SublimeIndex  IsIdentityValid
---@public
function SublimeIndex.IsIdentityValid(String, Type)
    if Type == "Name" then
        if string.len(String) >= 3 then
            return true
        else
            ESX.ShowNotification("~r~Nom ou Prénom trop court")
        end
    elseif Type == "Date" then
        local str = tostring(String)
        if string.match(str, '(%d%d)/(%d%d)/(%d%d%d%d)') ~= nil then
            local d, m, y = string.match(str, '(%d+)/(%d+)/(%d+)')
            d = tonumber(d)
            m = tonumber(m)
            y = tonumber(y)
            if ((d > 0) and (d <= 31)) then
                if ((m > 0) and (m <= 12)) then
                    if ((y > 1920) and (y < 2015)) then
                        return true
                    else
                        ESX.ShowNotification("~r~Année Invalide")
                    end
                else
                    ESX.ShowNotification("~r~Mois Invalide")
                end
            else
                ESX.ShowNotification("~r~Jour Invalide")
            end
        else
            ESX.ShowNotification("~r~Date de naissance invalide")
        end
    end
end