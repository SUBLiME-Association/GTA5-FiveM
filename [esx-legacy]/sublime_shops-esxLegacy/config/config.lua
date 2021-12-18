Config = {} --> init table Config
-->> Création de shop <<--
Config.Shops = {
	TwentyFourSeven = {
		restricted = false, --> true = Vous pouvez ajoutez autant de [job/faction] exemple job = {"police",'mechanic'} (ou) job = {"police",'mechanic'} faction = {'vagos', 'ballas'}
		job = {''},
		faction = {''},
		menu = {title = "~u~24 7", subtitle = "~g~Boutique :", glare = true, colorBanner = {r = 0, g = 255, b = 0, a = 150}, titleFont = 7, titleScale = 1.0},
		subMenu = {title = "~u~24 7", subtitle = "~g~Boutique :", glare = true, colorBanner = {r = 0, g = 255, b = 0, a = 150}, titleFont = 7, titleScale = 1.0},
		button = {BackgroundColor = {r = 0, g = 255, b = 0, a = 50}, HighlightColor = {r = 0, g = 0, b = 0, a = 50}, colorText = "~p~", colorRightLabel = "~w~", colorPriceRightLabel = "~g~"},
		money = {
			{name = 'money', label = 'Cash', activate = true},
			{name = 'black_money', label = 'Argent sale', activate = true},
			{name = 'bank', label = 'Banque', activate = true},
		},
		item = {
			{name = 'burger', label = 'Burger', price = 5},
			{name = 'water', label = 'Eau', price = 5},
			{name = 'phone', label = 'Téléphone', price = 51}
		},
		pos = {
			vector3(26.56, -1346.71, 29.5),
			vector3(373.8, 325.8, 102.5),
			vector3(2557.4, 382.2, 107.6),
			vector3(-3038.9, 585.9, 6.9),
			vector3(-3241.9, 1001.4, 11.8),
			vector3(547.4, 2671.7, 41.1),
			vector3(1961.4, 3740.6, 31.3),
			vector3(2678.9, 3280.6, 54.2),
			vector3(1729.2, 6414.1, 34.0)
		},
		marker = {Type = 10, ColorMarker = {r = 0, g = 50, b = 0, a = 150}, UpDown = false, Scale = {x = 1.5, y = 1.5, z = 1.5}, Rotate = false, FaceCamera = true},
		blips = {
			visible = true,
			sprite 	= 59,
			display = 4,
			scale 	= 0.8,
			colour 	= 5,
			range 	= true,
			string	= 'TwentyFourSeven'
		},
		typeNotif = 3, --> Type 3 à besoin du paramêtre police en plus mais si il vaut nil il y a une valeur par défaut dans spk_serverSetting
		notif = {msg = "Appuyez sur [E] pour accéder au shop", police = nil}
	},

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

	AmmuNations = {
		restricted = false, --> true = Vous pouvez ajoutez autant de [job/faction] exemple job = {"police",'mechanic'} (ou) job = {"police",'mechanic'} faction = {'vagos', 'ballas'}
		job = {''},
		faction = {''},
		menu = {title = "~r~AmmuNations", subtitle = "~b~Boutique :", glare = true, colorBanner = {r = 255, g = 255, b = 255, a = 150}, titleFont = 1, titleScale = 1.0},
		subMenu = {title = "~r~AmmuNations", subtitle = "~b~Boutique :", glare = true, colorBanner = {r = 0, g = 0, b = 255, a = 150}, titleFont = 6, titleScale = 1.0},
		button = {BackgroundColor = {r = 255, g = 255, b = 255, a = 150}, HighlightColor = {r = 0, g = 0, b = 0, a = 200}, colorText = "~r~", colorRightLabel = "~r~", colorPriceRightLabel = "~g~"},
		money = {
			{name = 'money', label = 'Cash', activate = true},
			{name = 'black_money', label = 'Argent sale', activate = true},
			{name = 'bank', label = 'Banque', activate = true},
		},
		item = {
			{name = 'bread', label = 'Pain', price = 5},
			{name = 'beer', label = 'Bière', price = 10},
			{name = 'water', label = 'Eau', price = 5}
		},
		pos = {
			vector3(-662.1, -935.3, 20.8 + 0.0),
			vector3(810.2, -2157.3, 28.6+ 0.0),
			vector3(1693.4, 3759.5, 33.7+ 0.0),
			vector3(-330.2, 6083.8, 30.4+ 0.0),
			vector3(252.3, -50.0, 68.9+ 0.0),
			vector3(22.0, -1107.2, 28.8+ 0.0),
			vector3(2567.6, 294.3, 107.7+ 0.0),
			vector3(-1117.5, 2698.6, 17.5+ 0.0),
			vector3(842.4, -1033.4, 27.1+ 0.0)
		},
		marker = {Type = 22, ColorMarker = {r = 0, g = 0, b = 255, a = 150}, UpDown = false, Scale = {x = 0.7, y = 0.7, z = 0.7}, Rotate = true, FaceCamera = false},
		blips = {
			visible = true,
			sprite 	= 110,
			display = 4,
			scale 	= 0.8,
			colour 	= 6,
			range 	= true,
			string	= 'AmmuNation'
		},
		typeNotif = 2, --> Type 3 à besoin du paramêtre police en plus mais si il vaut nil il y a une valeur par défaut dans spk_serverSetting
		notif = {msg = "Appuyez sur [E] pour accéder au shop", police = 0}
	},

	RobsLiquor = {
		restricted = false, --> true = Vous pouvez ajoutez autant de [job/faction] exemple job = {"police",'mechanic'} (ou) job = {"police",'mechanic'} faction = {'vagos', 'ballas'} 
		job = {''},
		faction = {''},
		menu = {title = "~u~RobsLiquor", subtitle = "~b~Boutique :", glare = true, colorBanner = {r = 0, g = 0, b = 255, a = 150}, titleFont = 6, titleScale = 1.0},
		subMenu = {title = "~u~RobsLiquor", subtitle = "~b~Boutique :", glare = true, colorBanner = {r = 0, g = 0, b = 255, a = 150}, titleFont = 6, titleScale = 1.0},
		button = {BackgroundColor = {r = 0, g = 0, b = 0, a = 150}, HighlightColor = {r = 0, g = 0, b = 100, a = 100}, colorText = "~w~", colorRightLabel = "~w~", colorPriceRightLabel = "~g~"},
		money = {
			{name = 'money', label = 'Cash', activate = true},
			{name = 'black_money', label = 'Argent sale', activate = true},
			{name = 'bank', label = 'Banque', activate = true},
		},
		item = {
			{name = 'bread', label = 'Pain', price = 5},
			{name = 'beer', label = 'Bière', price = 10},
			{name = 'water', label = 'Eau', price = 5}
		},
		pos = {
			vector3(1135.8, -982.2, 45.4),
			vector3(-1222.9, -906.9, 11.3),
			vector3(-1487.5, -379.1, 39.1),
			vector3(-2968.2, 390.9, 14.0),
			vector3(1166.0, 2708.9, 37.1),
			vector3(1392.5, 3604.6,  33.9),
			vector3(127.8,  -1284.7, 28.2), --StripClub
			vector3(-1393.4, -606.6, 29.3), --Tequila la
			vector3(-559.9, 287.0, 81.1) --Bahamamas
		},
		marker = {Type = 1, ColorMarker = {r = 0, g = 0, b = 255, a = 150}, UpDown = false, Scale = {x = 1.0, y = 1.0, z = 0.5}, Rotate = false, FaceCamera = false},
		blips = {
			visible = true,
			sprite 	= 59,
			display = 4,
			scale 	= 0.8,
			colour 	= 6,
			range 	= true,
			string	= 'RobsLiquor'
		},
		typeNotif = 1, --> Type 3 à besoin du paramêtre police en plus mais si il vaut nil il y a une valeur par défaut dans spk_serverSetting
		notif = {msg = "Appuyez sur [E] pour accéder au shop", police = 1},
	},

	PoliceShop = {
		restricted = true, --> false = ignora [job / faction]
		job = {'police'},
		faction = {''},
		menu = {title = "~u~Armurie", subtitle = "~b~Armurie :", glare = true, colorBanner = {r = 0, g = 0, b = 255, a = 150}, titleFont = 6, titleScale = 1.0},
		subMenu = {title = "~u~Armurie", subtitle = "~b~Armurie :", glare = true, colorBanner = {r = 0, g = 0, b = 255, a = 150}, titleFont = 6, titleScale = 1.0},
		button = {BackgroundColor = {r = 0, g = 0, b = 0, a = 150}, HighlightColor = {r = 0, g = 0, b = 100, a = 100}, colorText = "~w~", colorRightLabel = "~w~", colorPriceRightLabel = "~g~"},
		money = {
			{name = 'money', label = 'Cash', activate = true},
			{name = 'black_money', label = 'Argent sale', activate = true},
			{name = 'bank', label = 'Banque', activate = true},
		},
		item = {
			{name = 'bread', label = 'Pain', price = 5},
			{name = 'beer', label = 'Bière', price = 10},
			{name = 'water', label = 'Eau', price = 5}
		},
		pos = {
			vector3(49.8, -1379.2, 29.4),
		},
		marker = {Type = 1, ColorMarker = {r = 0, g = 0, b = 255, a = 150}, UpDown = false, Scale = {x = 1.0, y = 1.0, z = 0.5}, Rotate = false, FaceCamera = false},
		blips = {
			visible = true,
			sprite 	= 59,
			display = 4,
			scale 	= 0.8,
			colour 	= 6,
			range 	= true,
			string	= 'RobsLiquor'
		},
		typeNotif = 1, --> Type 3 à besoin du paramêtre police en plus mais si il vaut nil il y a une valeur par défaut dans spk_serverSetting
		notif = {msg = "Appuyez sur [E] pour accéder au shop", police = 1},
	},	
}