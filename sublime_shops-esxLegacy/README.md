# sublime_shops

- __dependency__ : ``es_extended (1.2/v1-final/legacy)``

- __library__ : ``RageUI v2.1.7``

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

# comment ...

Pour créer un type de shop c'est facile, il vous suffit d'aller dans : ``config/config.lua`` et de copier/collé un type de shop puis de changez la clée obligatoirement puis les autres valeurs par ce que vous voulez

exemple :
```lua
    Ltd = {
		restricted = false, --> true = Vous pouvez ajoutez autant de [job/faction] exemple job = {"police",'mechanic'} (ou) job = {"police",'mechanic'} faction = {'vagos', 'ballas'}
		job = {''},
		faction = {''},
		menu = {title = "~u~LTD", subtitle = "~r~Boutique :", glare = false, colorBanner = {r = 150, g = 0, b = 0, a = 150}, titleFont = 1, titleScale = 1.25},
		subMenu = {title = "~u~LTD", subtitle = "~r~Boutique :", glare = false, colorBanner = {r = 150, g = 0, b = 0, a = 150}, titleFont = 1, titleScale = 1.25},
		button = {BackgroundColor = {r = 0, g = 0, b = 0, a = 150}, HighlightColor = {r = 255, g = 0, b = 0, a = 100}, colorText = "~w~", colorRightLabel = "~w~", colorPriceRightLabel = "~g~"},
		money = {
			{name = 'money', label = 'Cash', activate = true},
			{name = 'black_money', label = 'Argent sale', activate = true},
			{name = 'bank', label = 'Banque', activate = true},
		},
		item = {
			{name = 'burger', label = 'Burger', price = 5},
			{name = 'beer', label = 'Bière', price = 10}
		},
		pos = {
			vector3(-48.5,  -1757.5, 28.4),
			vector3(1163.3, -323.8, 68.2),
			vector3(-707.5, -914.2, 18.2),
			vector3(-1820.5, 792.5, 137.1),
			vector3(1698.3, 4924.4, 41.0)
		},
		marker = {Type = 21, ColorMarker = {r = 255, g = 0, b = 0, a = 150}, UpDown = true, Scale = {x = 0.5, y = 0.5, z = 0.5}, Rotate = true, FaceCamera = false},
		blips = {
			visible = false,
			sprite 	= 446,
			display = 4,
			scale 	= 0.8,
			colour 	= 5,
			range 	= true,
			string	= 'LTD'
		},
		typeNotif = 2, --> Type 3 à besoin du paramêtre police en plus mais si il vaut nil il y a une valeur par défaut dans spk_serverSetting
		notif = {msg = "Appuyez sur [E] pour accéder au shop", police = nil}
	},
```
Et de renommer la clée de la table Ltd par ce que vous voulez

Pour créer des npc a votre nouveau type de shop ``config/config.npc.lua`` il vous suffit juste de copié/collé
par exemple :
```lua
    Ltd = {
		hash = `mp_m_shopkeep_01`,
		data = {
			blockEvent = nil,
			invincible = nil,
			freeze = nil,
			variation = nil
		},
		pos = {
			{x = -48.5,  y = -1757.5,z =  28.4 - 1, h = 10.0},
			{x = 1163.3, y = -323.8, z = 68.2 - 1, h = 10.0},
			{x = -707.5, y = -914.2, z = 18.2 - 1, h = 10.0},
			{x = -1820.5,y =  792.5, z = 137.1 - 1, h = 10.0},
			{x = 1698.3, y = 4924.4, z = 41.0 - 1, h = 10.0},
		},
		typeText = 1,
		drawText = {
			text = {
				open = "~r~Yo ~3~morray",
				success = "~g~Merci pour ton achat frérot, reviens quand tu veux !",
				noMoney = "~r~Désoler mec tu as pas assez d'argent !",
				full = "~r~Reviens plus tard quand tu seras moins chargé !"
			},
			font = 1,
			scale = 1.0,
			z = 1,
		}
	},
```
Et de renommer Ltd par ce que vous venez de copié/collé et renommée plus haut

# features

> Créer vos & npc facilement via les config
> 3 type de notification (pour ouvrir le shop (helpnotif,text2d,text3d))
> Petite intéraction avec le npc (si vous activez les npc ainsi que le drawText)
> Personnaliser vos menu unique à chaque type de shops
> 3 types de paiements (money, bank, black money (vous pouvez activez ce que vous voulez 1,2 ou les 3)) pour chaque type de shops
> Créer vos blips personnalisable par type de shops (visible ou non)
> MultiJob & Multifaction shop (vous pouvez restreindre le shop a plusiueurs job ou faction ou les 2 ou ne pas les restreindres (donc tout le monde a accès))

Ce shop est idéal, vous avez énormément de personnalisation disponible directement depuis les configurations, vous n'aurez pas besoin de toucher au code concrètement et il peut vous servir pour plein de type de job que sa soit pour les métier, gangs, normaux, arme en item etc...

Veuillez juste pour les npc a bien respecter se format : 
```lua
`votre_npc` --> cette syntaxe n'est pas du lua mais spécifique à fivem, elle permet de récupérer automatiquement le hash sans utiliser la native GetHashKey() donc plus performant.
-- et non :
'votre_npc' or "votre_npc"
```
# 

:en:

# warning !

If you want use shops type "faction" (doublejob) and you use job2 and not faction, example : ``ESX.PlayerData.job2.name`` you need to replace it :

 - ``[client/client.lua]``
```lua
-->> l.5 & l.6 <<--
RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2) ESX.PlayerData.job2 = job2 end)
-->> l.126<<--
if v.restricted and (ESX.PlayerData.job.name == vv or ESX.PlayerData.job2.name == vvv) then
```

# how to ...

if you want created shops easily, you need to copy/paste an example in ``config/config.lua``

example :
```lua
    Ltd = {
		restricted = false, --> true = Vous pouvez ajoutez autant de [job/faction] exemple job = {"police",'mechanic'} (ou) job = {"police",'mechanic'} faction = {'vagos', 'ballas'}
		job = {''},
		faction = {''},
		menu = {title = "~u~LTD", subtitle = "~r~Boutique :", glare = false, colorBanner = {r = 150, g = 0, b = 0, a = 150}, titleFont = 1, titleScale = 1.25},
		subMenu = {title = "~u~LTD", subtitle = "~r~Boutique :", glare = false, colorBanner = {r = 150, g = 0, b = 0, a = 150}, titleFont = 1, titleScale = 1.25},
		button = {BackgroundColor = {r = 0, g = 0, b = 0, a = 150}, HighlightColor = {r = 255, g = 0, b = 0, a = 100}, colorText = "~w~", colorRightLabel = "~w~", colorPriceRightLabel = "~g~"},
		money = {
			{name = 'money', label = 'Cash', activate = true},
			{name = 'black_money', label = 'Argent sale', activate = true},
			{name = 'bank', label = 'Banque', activate = true},
		},
		item = {
			{name = 'burger', label = 'Burger', price = 5},
			{name = 'beer', label = 'Bière', price = 10}
		},
		pos = {
			vector3(-48.5,  -1757.5, 28.4),
			vector3(1163.3, -323.8, 68.2),
			vector3(-707.5, -914.2, 18.2),
			vector3(-1820.5, 792.5, 137.1),
			vector3(1698.3, 4924.4, 41.0)
		},
		marker = {Type = 21, ColorMarker = {r = 255, g = 0, b = 0, a = 150}, UpDown = true, Scale = {x = 0.5, y = 0.5, z = 0.5}, Rotate = true, FaceCamera = false},
		blips = {
			visible = false,
			sprite 	= 446,
			display = 4,
			scale 	= 0.8,
			colour 	= 5,
			range 	= true,
			string	= 'LTD'
		},
		typeNotif = 2, --> Type 3 à besoin du paramêtre police en plus mais si il vaut nil il y a une valeur par défaut dans spk_serverSetting
		notif = {msg = "Appuyez sur [E] pour accéder au shop", police = nil}
	},
```
and rename Ltd

to create npc for your new shop, go to ``config/config.npc.lua`` and copy/past
example :
```lua
    Ltd = {
		hash = `mp_m_shopkeep_01`,
		data = {
			blockEvent = nil,
			invincible = nil,
			freeze = nil,
			variation = nil
		},
		pos = {
			{x = -48.5,  y = -1757.5,z =  28.4 - 1, h = 10.0},
			{x = 1163.3, y = -323.8, z = 68.2 - 1, h = 10.0},
			{x = -707.5, y = -914.2, z = 18.2 - 1, h = 10.0},
			{x = -1820.5,y =  792.5, z = 137.1 - 1, h = 10.0},
			{x = 1698.3, y = 4924.4, z = 41.0 - 1, h = 10.0},
		},
		typeText = 1,
		drawText = {
			text = {
				open = "~r~Yo ~3~morray",
				success = "~g~Merci pour ton achat frérot, reviens quand tu veux !",
				noMoney = "~r~Désoler mec tu as pas assez d'argent !",
				full = "~r~Reviens plus tard quand tu seras moins chargé !"
			},
			font = 1,
			scale = 1.0,
			z = 1,
		}
	},
```
and rename Ltd like your new shop

# features

> Create shops & npc easily in config
> 3 Types of notification (To open shops (helpnotif,text2d,text3d))
> Little interaction Npc (if you turn on npc and drawText in config)
> Edit menu for your type of shops
> 3 Types of payments (money,bank,black money)
> Blips Created by type of shops (if you turn on blips for this type)
> MultiJob & Multifaction shops (only job or only faction or both or erveryone)
