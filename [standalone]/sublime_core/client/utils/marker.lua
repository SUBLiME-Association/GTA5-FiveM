sCore = sCore or {}
sCore.Marker = sCore.Marker or {}

-- NOT FINISHED

function sCore.Marker:CreateMarker(pos, data)
    local self = {}
    self.pos = self.pos or pos
    self.type = data.type or 1
    --self.dir = data.dir or true
    --self.rot = data.rot or true
    self.scale = data.scale or 1.0
    self.color = data.color or 255
    self.updown = data.updown or false
    self.facecam = data.facecam or false
    self.p19 = data.p19 or nil
    self.rotate = data.rotate or false
    self.textureDict = data.textureDict or nil
    self.textureName = data.textureName or nil
    self.drawEnts = data.drawEnts or false
    --if self.dir then self.dir.x = 0.0 self.dir.y = 0.0 self.dir.z = 0.0 end
    --if self.rot then self.rot.x = 0.0 self.rot.y = 0.0 self.rot.z = 0.0 end  
    self.id = DrawMarker(self.type, self.pos.x, self.pos.y, self.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, self.scale.x, self.scale.y, self.scale.z, self.color.r, self.color.g, self.color.b, self.color.a, self.updown, self.facecam, self.p19, self.rotate, self.textureDict, self.textureName, self.drawEnts)
end

function sCore.Marker:Marker(marker)
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
			--if (setup.rotate == nil) or (setup[2] ~= nil) then
			--	setup.rotate = nil
				DrawMarker(marker[2], pos[1], pos[2], pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale[1], scale[2], scale[3], color[1], color[2], color[3], color[4], false, false, 2 , false, nil, nil, 0)
			--else
				--if setup[2] ~= nil then
				--	setup[2] = nil
				--end
			--	DrawMarker(marker[2], pos.x, pos.x, pos.x, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale[1], scale[2], scale[3], color[1], color[2], color[3], color[4], false, false, 2 ,false, nil, nil, 0)
			--end
		else
			return nil
		end
	else
		return nil
	end
	--if helpNotif ~= nil then
	--	if helpNotif[2] == nil or helpNotif[2] == false then
	--		helpNotif[2] = nil
	--	end
	--	--F.Notif:HelpNotification(helpNotif[1], _, helpNotif[2])
	--else
	--	return nil
	--end
end