local ESX = nil

TriggerEvent(Config.GetESX, function(obj)
    ESX = obj
end)

-- FERMER LE NUI
RegisterNUICallback('close', function(data, cb)
	SetNuiFocus( false )
	SendNUIMessage({display = false})
  	cb('ok')
end)

-- INTERACTION
CreateThread(function()
	for _,v in pairs(Config.Ammunation.Positions) do
		local blip = AddBlipForCoord(v.pos)
		SetBlipSprite(blip, Config.Ammunation.Blip.Sprite)
		SetBlipDisplay(blip, Config.Ammunation.Blip.Display)
		SetBlipScale(blip, Config.Ammunation.Blip.Scale)
		SetBlipColour(blip, Config.Ammunation.Blip.Color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Ammunation.Blip.Name)
		EndTextCommandSetBlipName(blip)
	end
    while true do
        Citizen.Wait(1)
        local pCoords = GetEntityCoords(PlayerPedId())
        local SleepWait = true
        for _,v in pairs(Config.Ammunation.Positions) do
            if #(pCoords - v.pos) < 1.2 then
                SleepWait = false
                ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder au shop ~b~ammunation.")
                DrawMarker(20, v.pos, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 0, 180, 0, 255, true, true, p19, true)                    
                if IsControlJustReleased(0, 38) then
                    SetNuiFocus( true, true )
    				if Config.Ammunation.Licence then
                        ESX.TriggerServerCallback('esx_license:checkLicense', function(gotLicence)
                            if gotLicence then
                                SendNUIMessage({display = true, licence = true})
                            elseif gotLicence == nil or gotLicence == false then
                                SendNUIMessage({display = true, licence = false})
                            end
                        end, GetPlayerServerId(PlayerId()), 'weapon')
                        
                    else
                        SendNUIMessage({display = true, licence = false})
                    end
                end
			end
        end
        if SleepWait then
           Citizen.Wait(500)
        end
    end
end)

RegisterNUICallback('sublime_weaponshopUi-esxLegacy:buy', function(data, cb)
    if Config.Ammunation.Licence then
        ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
            if hasWeaponLicense and data.restricted then
                restricted = false
                TriggerServerEvent('sublime_weaponshopUi-esxLegacy:buyServer', data.item, data.price, data.count, restricted)
            elseif (hasWeaponLicense == nil or hasWeaponLicense == false or hasWeaponLicense == true) and (data.restricted == false) then
                restricted = false
                TriggerServerEvent('sublime_weaponshopUi-esxLegacy:buyServer', data.item, data.price, data.count, restricted)
            elseif (hasWeaponLicense == nil or hasWeaponLicense == false) and (data.restricted == true) then
                restricted = true
                TriggerServerEvent('sublime_weaponshopUi-esxLegacy:buyServer', data.item, data.price, data.count, restricted)
            end
        end, GetPlayerServerId(PlayerId()), 'weapon')
    else
        TriggerServerEvent('sublime_weaponshopUi-esxLegacy:buyServer', data.item, data.price, data.count, false)
    end
    cb('ok')
end)

RegisterNUICallback('sublime_weaponshopUi-esxLegacy:buyLicence', function(data, cb)
    TriggerServerEvent('sublime_weaponshopUi-esxLegacy:buyLicenceServer', data.licencePrice)
    cb('ok')
end)

-- Copyright (c) 2022 Sublime --