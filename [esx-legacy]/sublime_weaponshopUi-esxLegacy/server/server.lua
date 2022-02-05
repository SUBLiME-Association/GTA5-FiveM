local ESX = nil

TriggerEvent(Config.GetESX, function(obj)
    ESX = obj
end)

RegisterNetEvent('sublime_weaponshopUi-esxLegacy:buyServer')
AddEventHandler('sublime_weaponshopUi-esxLegacy:buyServer', function(item, price, count, restricted)
    local xPlayer = ESX.GetPlayerFromId(source)
    local getMoney = xPlayer.getMoney()
    if not restricted then
        if getMoney >= price then
            if xPlayer.canCarryItem(item, count) then
                xPlayer.addInventoryItem(item, count)
                xPlayer.removeMoney(price)
            else
                xPlayer.showNotification('~r~Vous ne pouvez pas prendre plus d\'objets')
            end
        else
            xPlayer.showNotification("~r~Vous n'avez pas assez d'argent !")
        end
    else
        xPlayer.showNotification("~r~Il vous faut une licence pour acheter cette arme!")
    end
end)

RegisterNetEvent('sublime_weaponshopUi-esxLegacy:buyLicenceServer')
AddEventHandler('sublime_weaponshopUi-esxLegacy:buyLicenceServer', function(price)
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
            xPlayer.showNotification("~g~Vous avez acheté le permis de port d'armes")
		end)
	else
		xPlayer.showNotification("~r~Vous n'avez pas assez d'argent !")
	end
end)

-- Copyright (c) 2022 Sublime --