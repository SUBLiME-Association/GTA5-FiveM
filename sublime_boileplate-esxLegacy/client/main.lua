--[[__ESX__]]--

-->> Si vous avez besoin que votre job sois refresh dans ce script!
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) ESX.PlayerData.job = job end)

-->> Si vous avez besoin que votre secondJob sois refresh dans ce script!
RegisterNetEvent('esx:setFaction')
AddEventHandler('esx:setFaction', function(faction) ESX.PlayerData.faction = faction end)

-->> Obligatoire pour que votre player soit chargé dans ce script !
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

-->> Obligatoire pour décharge le player qui se déconnect de ce script!
RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)


--------------------------------------------------------


print(Config.client)