# sublime_multiFarming

# EN COURS DE DEVELOPPEMENT VIA TUTO YOUTUBE!!!!!

- __dependency__ : ``es_extended (Legacy [1.3])``

- __library__ : ``RageUI v2.1.7`` or not

- __conso cpu@client__ : ``0.01ms``

[require] :

> https://github.com/esx-framework/esx-legacy

#

:fr:

# attention !
Si vous voulez utilisez le shops avec le doublejob vous aurez besoin de faire des modifications exemple : ``ESX.PlayerData.job2.name`` 

 - ``[client/client.lua]``
```lua
-->> l.5 & l.6 <<--
RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2) ESX.PlayerData.job2 = job2 end)
-->> l.126<<--
if v.restricted and (ESX.PlayerData.job.name == vv or ESX.PlayerData.job2.name == vvv) then
```

#

:en:

#