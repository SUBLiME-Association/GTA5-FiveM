F = {}
-->> Marker <<--
function F:MarkerHelpNotification(helpNotif, marker)
	if marker ~= nil then
		local visible = marker[1]
		if visible then
			local pos = marker.pos
			local scale = marker.scale
			local color = marker.color
			local setup = marker.data
			if scale == nil then
				scale[1], scale[2], scale[3] = 0.7, 0.7, 0.7
			elseif color == nil then
				print("[ERROR]:Text2D -> color vaut nil")
			elseif pos == nil then
				print("[ERROR]:Text2D -> pos vaut nil")
			elseif marker[2] == nil then
				print("[ERROR]:Text2D -> id vaut nil")
			end
			if (setup.rotate == nil) or (setup[2] ~= nil) then
				setup.rotate = nil
				DrawMarker(marker[2], pos[1], pos[2], pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale[1], scale[2], scale[3], color[1], color[2], color[3], color[4], setup[1], setup[2], 2 , setup.rotate, nil, nil, 0)
			else
				if setup[2] ~= nil then
					setup[2] = nil
				end
				DrawMarker(marker[2], pos[1], pos[2], pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale[1], scale[2], scale[3], color[1], color[2], color[3], color[4], setup[1], setup[2], 2 ,setup.rotate, nil, nil, 0)
			end
		else
			return nil
		end
	else
		return nil
	end
	if helpNotif ~= nil then
		if helpNotif[2] == nil or helpNotif[2] == false then
			helpNotif[2] = nil
		end
		F:HelpNotification(helpNotif[1], _, helpNotif[2])
	else
		return nil
	end
end
function F:MarkerText3D(xy, dataTxt, dataMarker)
	local posz = dataMarker.z
	if dataMarker ~= nil then
		local visible = dataMarker[1]
		if visible then
			local scale = dataMarker.scale
			local color = dataMarker.color
			local setup = dataMarker.data
			if scale == nil then
				scale[1], scale[2], scale[3] = 0.7, 0.7, 0.7
			elseif color == nil then
				print("[ERROR]::Text3D -> la couleur du marker vaut nil")
			elseif posz == nil then
				print("[ERROR]::Text3D -> la pos du marker vaut nil")
			elseif dataMarker[2] == nil then
				print("[ERROR]:Text3D -> l'id du marker vaut nil")
			end
			if (setup.rotate == nil) or (setup[2] ~= nil) then
				setup.rotate = nil
				DrawMarker(dataMarker[2], xy[1], xy[2], posz, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale[1], scale[2], scale[3], color[1], color[2], color[3], color[4], setup[1], setup[2], 2 , setup.rotate, nil, nil, 0)
			else
				if setup[2] ~= nil then
					setup[2] = nil
				end
				DrawMarker(dataMarker[2], xy[1], xy[2], posz, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale[1], scale[2], scale[3], color[1], color[2], color[3], color[4], setup[1], setup[2], 2 , setup.rotate, nil, nil, 0)
			end
		else
			return nil
		end
	end	
	if dataTxt ~= nil then
		local textZ = (dataTxt.z + posz)
		F:Text3D(xy[1], xy[2], textZ, dataTxt[1], dataTxt.scale, dataTxt.font)
	else
		return nil
	end
end
function F:MarkerText2D(text, marker)
	if marker ~= nil then
		local visible = marker[1]
		if visible then
			local pos = marker.pos
			local scale = marker.scale
			local color = marker.color
			local setup = marker.data
			if scale == nil then
				scale[1], scale[2], scale[3] = 0.7, 0.7, 0.7
			elseif color == nil then
				print("[ERROR]:.Marker:Text2D -> color vaut nil")
			elseif pos == nil then
				print("[ERROR]:.Marker:Text2D -> pos vaut nil")
			elseif marker[2] == nil then
				print("[ERROR]:.Marker:Text2D -> id vaut nil")
			end
			if (setup.rotate == nil) or (setup[2] ~= nil) then
				setup.rotate = nil
				DrawMarker(marker[2], pos[1], pos[2], pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale[1], scale[2], scale[3], color[1], color[2], color[3], color[4], setup[1], setup[2], 2 , setup.rotate, nil, nil, 0)
			else
				if setup[2] ~= nil then
					setup[2] = nil
				end
				DrawMarker(marker[2], pos[1], pos[2], pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale[1], scale[2], scale[3], color[1], color[2], color[3], color[4], setup[1], setup[2], 2 ,setup.rotate, nil, nil, 0)
			end
		else
			return nil
		end
	else
		return nil
	end
	if text ~= nil then
		F:Text2D(text)
	else
		return nil
	end
end
-->> Create <<--
function F:Blips(pos, data, visible)
    Citizen.CreateThread(function()
        if visible then
            blip = AddBlipForCoord(pos[1], pos[2], pos[3])
            SetBlipSprite (blip, data.sprite)
            SetBlipDisplay(blip, data.display)
            SetBlipScale  (blip, data.scale)
            SetBlipColour (blip, data.colour)
            SetBlipAsShortRange(blip, data.range)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(data.name)
            EndTextCommandSetBlipName(blip)
        else
            --print('blips non visble -> '..data.name)
        end
    end)
end
-->> Text <<--
function F:Text3D(x, y, z, text, scale, font, r, g, b, a) --> [Client]
	local onScreen, _x, _y = World3dToScreen2d(x,y,z)
	if scale == nil then
		scale = 0.3
	else
		scale = scale
	end
	if onScreen then
		SetTextScale(scale, scale)
		if font == nil then
			SetTextFont(6)
		else
			SetTextFont(font)
		end
		if r == nil or g == nil or b == nil or a == nil then
			SetTextColour(255, 255, 255, 255)
		else
			SetTextColour(r, g, b, a)
		end
		SetTextProportional(1)
		SetTextOutline()
		SetTextEntry('STRING')
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end
function F:TextPerso2D(txt, data)
	local data = {
		pos = data.pos,
		fonts = data.fonts,
		scale = data.scale,
		shadow = data.shadow,
		edge = data.edge
	}
	if data.fonts == nil then SetTextFont(1) else SetTextFont(data.fonts) end
    SetTextProportional(1)
	if data.scale == nil then SetTextScale(0.0, 0.3) else SetTextScale(data.scale[1], data.scale[2]) end
    SetTextColour(128, 128, 128, 255)
	if data.shadow == nil then SetTextDropshadow(0, 0, 0, 0, 255) else SetTextDropshadow(data.shadow[1], data.shadow[2], data.shadow[3], data.shadow[4], data.shadow[5]) end
	if data.edge == nil then SetTextEdge(1, 0, 0, 0, 255) else SetTextEdge(data.edge[1], data.edge[2], data.edge[3], data.edge[4], data.edge[5]) end
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(txt)
	if data.pos == nil then DrawText(0.005, 0.005) else DrawText(data.pos[1], data.pos[2]) end
end
function F:Text2D(txt, msec) --> [Client]
	ClearPrints()
	BeginTextCommandPrint("STRING")
	AddTextComponentSubstringPlayerName(txt)
	SetTextDropshadow(1, 0,0,0,1)
	SetTextDropShadow()
	EndTextCommandPrint(msec and math.ceil(msec) or 0, true)
end
-->> Utils <<--
function F:FirstToUpper(str) return (str:gsub("^%l", string.upper)) end
function F:MathRound(value, numDecimalPlaces)
	if numDecimalPlaces then
		local mult = 10^numDecimalPlaces
		return math.floor((value * mult) + 0.5) / (mult)
	else return math.floor(value + 0.5) end
end
function F:GroupDigits(value) --> [Client / Server]
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1'..' '):reverse())..right
end
function F:BoxInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return nil
	end
end
-->> Notif <<--
function F:SimpleNotification(txt, flash, saveToBrief, color) --> [Client]
	SetNotificationTextEntry('STRING')
	AddTextComponentString(txt)
	if saveToBrief == nil then saveToBrief = true end
	if color then ThefeedNextPostBackgroundColor(color) end
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end
function F:AdvancedNotification(title, subtitle, txt, textureDict, iconType, flash, saveToBrief, color) --> [Client]
	BeginTextCommandThefeedPost("STRING")
	if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('[F]:AdvancedNotification', txt)
	if color then ThefeedNextPostBackgroundColor(color) end
	AddTextComponentSubstringPlayerName(txt)
	EndTextCommandThefeedPostMessagetext(textureDict, textureDict, flash, iconType, title, subtitle)
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end
function F:HelpNotification(txt, thisFrame, beep, duration) --> [Client]
	AddTextEntry('[F]:HelpNotification', txt)
	if thisFrame then
		DisplayHelpTextThisFrame('[F]:HelpNotification', false)
	else
		BeginTextCommandDisplayHelp('[F]:HelpNotification')
		if beep == nil then beep = true end
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end
function F:FloatNotification(txt, coords) --> [Client]
	AddTextEntry('[F]:FloatingHelpNotification', txt)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('[F]:FloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end
RegisterNetEvent("[supv]:SimpleNotification")
AddEventHandler("[supv]:SimpleNotification", function(txt, flash, saveToBrief, color)
	F:SimpleNotification(txt, flash, saveToBrief, color)
end)