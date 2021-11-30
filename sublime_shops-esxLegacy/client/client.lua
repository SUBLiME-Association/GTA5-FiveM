--[[			__ESX__				]]--
BUY = {}
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) ESX.PlayerData.job = job end)
RegisterNetEvent('esx:setFaction')
AddEventHandler('esx:setFaction', function(faction) ESX.PlayerData.faction = faction end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)
RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)
--[[			__Shop__				]]--
local openMenu, notifAction = false, false
local shopMenu = RageUI.CreateMenu("","")
shopMenu.Closed = function()
	openMenu = false
end
local shopSubMenu = RageUI.CreateSubMenu(shopMenu,'',"")
-->> Notre Menu <<--
ShopMenu = function(shopIndex)
	--openMenu = not openMenu
	RageUI.Visible(shopMenu, true)
	selectedLabel, selectedPrice, quantity = "", 0, 0
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5.0)
			if openMenu then
				notifAction = false --> ici pour rendre impossible le double texte en cas d'achat trop rapide (pour que la dernière action soit affichée)
				for k,v in pairs(Config.Shops)do
					if k == shopIndex then
						local menu = v.menu
						local subMenu = v.subMenu
						--> menu <--
						shopMenu:SetSubtitle(menu.subtitle)
						shopMenu.TitleScale, shopMenu.TitleFont = menu.titleScale, menu.titleFont
						shopMenu:DisplayGlare(menu.glare)
						shopMenu:SetTitle(menu.title)
						shopMenu:SetRectangleBanner(menu.colorBanner.r, menu.colorBanner.g, menu.colorBanner.b, menu.colorBanner.a)
						--> subMenu <--
						shopSubMenu.TitleScale, shopSubMenu.TitleFont = subMenu.titleScale, subMenu.titleFont
						shopSubMenu:DisplayGlare(subMenu.glare)
						shopSubMenu:SetTitle(subMenu.title)
						shopSubMenu:SetRectangleBanner(subMenu.colorBanner.r, subMenu.colorBanner.g, subMenu.colorBanner.b, subMenu.colorBanner.a)
					end
				end
				RageUI.IsVisible(shopMenu, function()
					for k,v in pairs(Config.Shops)do
						if k == shopIndex then
							local item, btn = v.item, v.button
							for i = 1, #item, 1 do
								RageUI.Button(btn.colorText..item[i].label, nil, {RightBadge = nil, RightLabel = btn.colorPriceRightLabel..item[i].price.."$"..btn.colorRightLabel.."/u", Color = {HightLightColor = {btn.HighlightColor.r, btn.HighlightColor.g, btn.HighlightColor.b, btn.HighlightColor.a}, BackgroundColor = {btn.BackgroundColor.r, btn.BackgroundColor.g, btn.BackgroundColor.b, btn.BackgroundColor.a}}}, true, {
								onSelected = function()
									selectedName, selectedPrice, selectedLabel = item[i].name, item[i].price, item[i].label
									quantity = F:BoxInput('BOX_Quantity_Shop', 'Quantité [255 Charactères Max / chiffre]', '', 255)
									if quantity ~= nil then
										quantity = tonumber(quantity)
										if type(quantity) == 'number' then
											if quantity > 0 then
												quantity = quantity
												--subMenuOk = shopSubMenu
											else
												RageUI.GoBack()
												print("Quantité incorrecte!!![1]")
											end
										else
											RageUI.GoBack()
											print("Quantité incorrecte!!![2]")
										end
									else
										RageUI.GoBack()
									end
								end}, shopSubMenu);
							end
						end
					end
				end, function() end)
				RageUI.IsVisible(shopSubMenu, function()
					if quantity ~= nil then
						for k,v in pairs(Config.Shops)do
							if k == shopIndex then
								shopSubMenu:SetSubtitle(v.subMenu.subtitle..selectedLabel)
								local money, btn = v.money, v.button
								for i = 1, #money, 1 do
									if money[i].activate then
										RageUI.Button(btn.colorText..money[i].label, nil, {RightBadge = nil, RightLabel = btn.colorPriceRightLabel..selectedPrice*quantity.."$"..btn.colorRightLabel.."", Color = {HightLightColor = {btn.HighlightColor.r, btn.HighlightColor.g, btn.HighlightColor.b, btn.HighlightColor.a}, BackgroundColor = {btn.BackgroundColor.r, btn.BackgroundColor.g, btn.BackgroundColor.b, btn.BackgroundColor.a}}}, true, {
										onSelected = function()
											selectedMoney = money[i].name
											notifAction = true
											TriggerServerEvent("spk_shops:BuyItem", selectedName, quantity, selectedLabel, selectedPrice, selectedMoney)
											BUY.Time = GetGameTimer()
											RageUI.CloseAll()
											openMenu = false
										end});
									end
								end
							end
						end
					end
				end, function() end)
			else
				openMenu = false
				RageUI.Visible(shopMenu, false)
				return
			end
		end
	end)
end
-->> Notre Gestion de Zone <<--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5.0)
		local intervale = true --> notre switch de wait pour avoir une ressource optimisé
		local myPedCoord = GetEntityCoords(PlayerPedId()) --> Récupérer la pos en vector3 de notre player
		for k,v in pairs(Config.Shops)do
			for pos = 1, #v.pos, 1 do
				local shopPos = v.pos[pos]
				local distance = #(myPedCoord - shopPos) --> Le résultat de la différence de valeur en vector3 de mon joueur à mes coords des shops 
				if distance < 10 then intervale = false
					for _,vv in pairs(v.job)do
						for _, vvv in pairs(v.faction)do
							if v.restricted and (ESX.PlayerData.job.name == vv or ESX.PlayerData.faction.name == vvv) then
								local marker = v.marker
								if shopPos and distance > 2 then
									if v.typeNotif == 1 then 
										F:HelpNotification(nil, {true, marker.Type, scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, pos = {shopPos.x, shopPos.y, shopPos.z}, data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a}})
									elseif v.typeNotif == 2 then -- ok
										F:Text2D(nil, {true, marker.Type, scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, pos = {shopPos.x, shopPos.y, shopPos.z}, data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a}})
									elseif v.typeNotif == 3 then
										F:Text3D({shopPos.x, shopPos.y}, nil, {true, marker.Type, scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, z = shopPos.z, data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a}})
									end
								end
								if distance <= 2 then
									if IsControlJustPressed(1,51) and not openMenu then
										openMenu, notifAction = true, true
										ShopMenu(k)
									elseif not openMenu then
										if v.typeNotif == 1 then
											F:HelpNotification(
												{v.notif.msg},
												{
													true, --> visible
													marker.Type, --> id marker
													scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, --> scale marker
													pos = {shopPos.x, shopPos.y, shopPos.z},
													data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, --> marker updown / marker faceCamera
													color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a} --> Color RGBA marker
												}
											)
										elseif v.typeNotif == 2 then -- ok
											F:Text2D(
												v.notif.msg,
												{
													true, --> visible
													marker.Type, --> id marker
													scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, --> scale marker
													pos = {shopPos.x, shopPos.y, shopPos.z},
													data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, --> marker updown / marker faceCamera
													color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a} -->
												}
											)
										elseif v.typeNotif == 3 then
											F:Text3D(
												{shopPos.x, shopPos.y}, --> pos x,y --> Marker & Text 3D
												{v.notif.msg, scale = nil, font = v.notif.police, z = 0.0}, -->Text 3D, z = pos.z + z
												{
													true, --> visible
													marker.Type, --> id marker
													scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, --> scale marker
													z = shopPos.z, --> pos.z marker
													data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, --> marker updown / marker faceCamera
													color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a} --> Color RGBA marker
												}
											)
										end
									end
								else
									openMenu = false
								end
							end
						end
					end
					if not v.restricted then
						local marker = v.marker
						if shopPos and distance > 2 then
							if v.typeNotif == 1 then
								F:HelpNotification(nil, {true, marker.Type, scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, pos = {shopPos.x, shopPos.y, shopPos.z}, data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a}})
							elseif v.typeNotif == 2 then -- ok
								F:Text2D(nil, {true, marker.Type, scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, pos = {shopPos.x, shopPos.y, shopPos.z}, data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a}})
							elseif v.typeNotif == 3 then
								F:Text3D({shopPos.x, shopPos.y}, nil, {true, marker.Type, scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, z = shopPos.z, data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a}})
							end
						end
						if distance <= 2 then
							if IsControlJustPressed(1,51) and not openMenu then
								openMenu, notifAction = true, true
								ShopMenu(k)
							elseif not openMenu then
								if v.typeNotif == 1 then
									F:HelpNotification(
										{v.notif.msg},
										{
											true, --> visible
											marker.Type, --> id marker
											scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, --> scale marker
											pos = {shopPos.x, shopPos.y, shopPos.z},
											data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, --> marker updown / marker faceCamera
											color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a} --> Color RGBA marker
										}
									)
								elseif v.typeNotif == 2 then -- ok
									F:Text2D(
										v.notif.msg,
										{
											true, --> visible
											marker.Type, --> id marker
											scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, --> scale marker
											pos = {shopPos.x, shopPos.y, shopPos.z},
											data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, --> marker updown / marker faceCamera
											color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a} -->
										}
									)
								elseif v.typeNotif == 3 then
									F:Text3D(
										{shopPos.x, shopPos.y}, --> pos x,y --> Marker & Text 3D
										{v.notif.msg, scale = nil, font = v.notif.police, z = 0.0}, -->Text 3D, z = pos.z + z
										{
											true, --> visible
											marker.Type, --> id marker
											scale = {marker.Scale.x, marker.Scale.y, marker.Scale.z}, --> scale marker
											z = shopPos.z, --> pos.z marker
											data = {rotate = marker.Rotate, marker.UpDown, marker.FaceCamera}, --> marker updown / marker faceCamera
											color = {marker.ColorMarker.r,marker.ColorMarker.g,marker.ColorMarker.b,marker.ColorMarker.a} --> Color RGBA marker
										}
									)
								end
							end
						else
							openMenu = false
						end
					end
				end
			end	
		end
		if intervale then --> Toujour à la fin
			Citizen.Wait(1000)
		end
	end
end)
-->> Blips <<--
for _,v in pairs(Config.Shops)do
	local blips = v.blips
	for i = 1, #v.pos, 1 do
		F:Blips({v.pos[i].x, v.pos[i].y, v.pos[i].z}, {sprite = blips.sprite, display = blips.display, scale = blips.scale, colour =  blips.colour, range = blips.range, name = blips.string}, blips.visible)
	end
end
allPed = {}
-->> Npc <<--
if(Config.SetNpc[1])then
	RegisterNetEvent("[spk_shops]:buyText")
	for _,v in pairs(Config.Npc) do
		for i = 1, #v.pos, 1 do
			Citizen.CreateThread(function()		
				RequestModel(v.hash)
				while not HasModelLoaded(v.hash)  do
					Citizen.Wait(1)
				end
				ped = CreatePed(_, v.hash, v.pos[i].x, v.pos[i].y, v.pos[i].z,  v.pos[i].h, false, true)
				if v.data == nil then else
					if v.data.blockEvent ~= nil then
						SetBlockingOfNonTemporaryEvents(ped, v.data.blockEvent)
					end
					if v.data.invincible ~= nil then
						SetEntityInvincible(ped, v.data.invincible)
					end
					if v.data.freeze ~= nil then
						FreezeEntityPosition(ped, v.data.freeze)
					end
					if v.data.variation ~= nil then
						SetPedComponentVariation(ped, v.data.variation)
					else
						SetPedDefaultComponentVariation(ped)
					end
				end
			end)
		end
		if Config.SetNpc.DrawText then
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(5.0)
					local letSleep = true
					local playerCoords = GetEntityCoords(PlayerPedId())
					if v.drawText.text ~= nil then
						for i = 1, #v.pos, 1 do
							local distance = #(playerCoords - vector3(v.pos[i].x, v.pos[i].y, v.pos[i].z))
							if distance <= 10.0 then
								letSleep = false
								if v.typeText == 1 and openMenu == true then
									F:Text3D(v.pos[i].x, v.pos[i].y, v.pos[i].z + v.drawText.z, v.drawText.text.open, v.drawText.scale, v.drawText.font)
								elseif v.typeText == 2 and openMenu == true then
									F:FloatNotification(v.drawText.text.open, vector3(v.pos[i].x, v.pos[i].y, v.pos[i].z + v.drawText.z))
								end
							end
						end
					end
					if letSleep then
						Citizen.Wait(1000)
					end
				end
			end)
		end
		AddEventHandler("[spk_shops]:buyText", function(value)
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(5)
					local playerCoords = GetEntityCoords(PlayerPedId())
					if notifAction then
						for i = 1, #v.pos, 1 do
							local distance = #(playerCoords - vector3(v.pos[i].x, v.pos[i].y, v.pos[i].z))
							if (GetGameTimer() - BUY.Time < 5000) then --> 5000 = 5seconds
								if distance <= 10.0 then
									if v.typeText == 1 and openMenu == false then
										if value == 1 then
											F:Text3D(v.pos[i].x, v.pos[i].y, v.pos[i].z + v.drawText.z, v.drawText.text.success, v.drawText.scale, v.drawText.font)
										elseif value == 2 then
											F:Text3D(v.pos[i].x, v.pos[i].y, v.pos[i].z + v.drawText.z, v.drawText.text.full, v.drawText.scale, v.drawText.font)
										elseif value == 3 then
											F:Text3D(v.pos[i].x, v.pos[i].y, v.pos[i].z + v.drawText.z, v.drawText.text.noMoney, v.drawText.scale, v.drawText.font)
										end
									elseif v.typeText == 2 and openMenu == false then
										if value == 1 then
											F:FloatNotification(v.drawText.text.success, vector3(v.pos[i].x, v.pos[i].y, v.pos[i].z + v.drawText.z))
										elseif value == 2 then
											F:FloatNotification(v.drawText.text.full, vector3(v.pos[i].x, v.pos[i].y, v.pos[i].z + v.drawText.z))
										elseif value == 3 then
											F:FloatNotification(v.drawText.text.noMoney, vector3(v.pos[i].x, v.pos[i].y, v.pos[i].z + v.drawText.z))
										end
									end
								end
							else
								notifAction = false --> forcing
								return false --> coupe le thread une fois les 5seconds écoulées!
							end
						end
					else
						notifAction = false --> forcing
						return false --> coupe le thread en cas d'action trop vite pour éviter les double text si achat + achate rapide < 5s
					end
				end
			end)
		end)
	end
end