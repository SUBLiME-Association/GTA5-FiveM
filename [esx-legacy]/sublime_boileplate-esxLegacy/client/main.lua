--[[__ESX__]]--

-->> Si vous avez besoin que votre job sois refresh dans ce script!
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) ESX.PlayerData.job = job end)

-->> Si vous avez besoin que votre secondJob sois refresh dans ce script!
RegisterNetEvent('esx:setFaction')
AddEventHandler('esx:setFaction', function(faction) ESX.PlayerData.faction = faction end)

-->> Utile si le joueur se connecte cela permet par exemple d'afficher un blip sur lui idéal pour les policier par exemple
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

-->> Utile pour quand un joueur leave si par exemple vous afficher les blips des policier en service ou en voiture ca permettra de le retirer
RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)


--------------------------------------------------------


print(Config.client)