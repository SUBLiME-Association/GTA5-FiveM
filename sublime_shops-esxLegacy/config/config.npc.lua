Config.SetNpc = {true, DrawText = true} --> Activez les Npc ainsi que les texte au dessus
-->> Création des npc <<--
Config.Npc = {
	TwentyFourSeven = {
		hash = `mp_m_shopkeep_01`, --> (hash du npc, gardez se forme `nom_du_npc`)
		data = { --> Paramètre global du npc
			blockEvent = true, --> (bloque les events (le npc de réagis pas))
			invincible = true, --> (invincible)
			freeze = true, --> (il ne peut pas bouger)
			variation = nil --> (set une variation du npc, nil = variation par défaut)
		},
		pos = { --> Position des NPC
			{x = 24.47, y = -1347.35, z = 29.5 - 1, h = 271.8},
			{x = 373.8, y = 325.8, 	z = 102.5 - 1, h = 10.0},
			{x = 2557.4, y = 382.2, z = 107.6 - 1, h = 10.0},
			{x = -3038.9,y = 585.9, z = 6.9	 - 1, h = 10.0},
			{x = -3241.9,y = 1001.4, z = 11.8 - 1, h = 10.0},
			{x = 547.4, y = 2671.7, z = 41.1 - 1, h = 10.0},
			{x = 1961.4, y = 3740.6, z = 31.3 - 1, h = 10.0},
			{x = 2678.9, y = 3280.6, z = 54.2 - 1, h = 10.0},
			{x = 1729.2, y = 6414.1, z = 34.0 - 1, h = 10.0},
		},
		typeText = 2, --> type de texte (1 = 3D / 2 = Float)
		drawText = { --> Paramètre du texte
			text = {
				open = "~s~Bonjour, puis-je vous aidez?",
				success = "~g~Merci pour ton achat frérot, reviens quand tu veux !",
				noMoney = "~r~Désoler mec tu as pas assez d'argent !",
				full = "~r~Reviens plus tard quand tu seras moins chargé !"
			},
			font = 1, --> Police
			scale = 1.0, --> Taille de la Police
			z = 2, --> addition de la pos Z par rapport au Ped (par exemple pour la pos[1] c'est : 29.5 + 2)
		}
	},

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

	AmmuNations = {
		hash = `s_m_y_swat_01`,
		data = {
			blockEvent = false,
			invincible = false,
			freeze = false,
			variation = nil
		},
		pos = {
			{x = -662.1, y = -935.3, z = 20.8 - 1, h = 10.0},
			{x = 810.2, y = -2157.3, z = 28.6 - 1, h = 10.0},
			{x = 1693.4, y = 3759.5, z = 33.7 - 1, h = 10.0},
			{x = -330.2, y = 6083.8, z = 30.4 - 1, h = 10.0},
			{x = 252.3, y = -50.0, 	z = 68.9 - 1	, h = 	10.0},
			{x = 22.0, 	y = -1107.2, z = 28.8 - 1, h = 10.0},
			{x = 2567.6, y = 294.3, z = 107.7 - 1, h = 10.0},
			{x = -1117.5,y = 2698.6, z = 17.5 - 1, h = 10.0},
			{x = 842.4, y = -1033.4, z = 27.1 - 1, h = 10.0},
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
			z = 2,
		}
	},

	RobsLiquor = {
		hash = `mp_m_shopkeep_01`,
		data = {
			blockEvent = nil,
			invincible = nil,
			freeze = nil,
			variation = nil
		},
		pos = {
			{x = 1135.8, y = -982.2,  z = 45.4	- 1, h = 10.0},
			{x = -1222.9,y =  -906.9, z =  11.3	- 1, h = 10.0},
			{x = -1487.5,y =  -379.1, z =  39.1	- 1, h = 10.0},
			{x = -2968.2,y =  390.9,  z = 14.0	- 1, h = 10.0},
			{x = 1166.0, y = 2708.9,  z = 37.1	- 1, h = 10.0},
			{x = 1392.5, y = 3604.6,  z =  33.9	- 1, h = 10.0},
			{x = 127.8,  y = -1284.7, z =  28.2	- 1, h = 10.0},		--StripClub
			{x = -1393.4,y =  -606.6, z =  29.3	- 1, h = 10.0},		--Tequila la
			{x = -559.9, y = 287.0, z = 81.1	- 1, h = 10.0},		--Bahamamas
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

	PoliceShop = {
		hash = `s_m_y_swat_01`,
		data = {
			blockEvent = true,
			invincible = true,
			freeze = true,
			variation = nil
		},
		pos = {
			{x = 49.8, y = -1379.2, z = 29.4 - 1, h = 10.0},
		},
		typeText = 2,
		drawText = {
			text = {
				open = "~r~Yo ~3~morray",
				success = "~g~Merci pour ton achat frérot, reviens quand tu veux !",
				noMoney = "~r~Désoler mec tu as pas assez d'argent !",
				full = "~r~Reviens plus tard quand tu seras moins chargé !"
			},
			font = 7,
			scale = 1.0,
			z = 3,
		}
	},
}

