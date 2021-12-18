# sublime_boilerplate

- __dependency__ : ``es_extended (Legacy [1.3])``

[require] :

> https://github.com/esx-framework/esx-legacy

#

:fr:

- Ceci est un boilerplate pour faire un script sur ESX-LEGACY [v1.3] 

# attention !
Si vous voulez utilisez le shops avec le doublejob vous aurez besoin de faire des modifications exemple : ``ESX.PlayerData.job2.name`` 
- Donc remplacez dans ``[client/main.lua]`` :
```lua
RegisterNetEvent('esx:setFaction')
AddEventHandler('esx:setFaction', function(faction) ESX.PlayerData.faction = faction end)
```
- Par :
```lua
RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2) ESX.PlayerData.job2 = job2 end)
```

#

:en:

#