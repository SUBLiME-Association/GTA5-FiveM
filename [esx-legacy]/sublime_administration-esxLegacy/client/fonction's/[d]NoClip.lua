_Admin.NoClipStatus = false
local NoClipEntity = false
local indexf5 = 1
local CurrentSpeed = _Admin.Config.NoClip.Speeds[indexf5]
local vitesse = "0"




function _Admin.NoClip()
	while _Admin.NoClipStatus do
		if _Admin.Config.NoClip.ControlsHeadingWithMouse then
			SetIButtons({
				{GetControlInstructionalButton(1,_Admin.Keys["Z"],0),"Avancer"},
				{GetControlInstructionalButton(1,_Admin.Keys["S"],0),"Reculé"},
				{GetControlInstructionalButton(1,_Admin.Keys["A"],0),"Monter"},
				{GetControlInstructionalButton(1,_Admin.Keys["W"],0),"Descendre"},
				{GetControlInstructionalButton(1,_Admin.Keys["LEFTSHIFT"],0), vitesse},

			}, 0)
		else
			SetIButtons({
				{GetControlInstructionalButton(1,_Admin.Keys["Z"],0),"Avancer"},
				{GetControlInstructionalButton(1,_Admin.Keys["S"],0),"Reculé"},
				{GetControlInstructionalButton(1,_Admin.Keys["Q"],0),"Gauche"},
				{GetControlInstructionalButton(1,_Admin.Keys["D"],0),"Droite"},
				{GetControlInstructionalButton(1,_Admin.Keys["A"],0),"Monter"},
				{GetControlInstructionalButton(1,_Admin.Keys["W"],0),"Descendre"},
				{GetControlInstructionalButton(1,_Admin.Keys["LEFTSHIFT"],0), vitesse},

			}, 0)
		end
		DrawIButtons()
		DisableAllControlActions()
		EnableControlAction(0, 1, true)
		EnableControlAction(0, 2, true)
		EnableControlAction(0, 200, true) --> echap

		local yoff = 0.0
		local zoff = 0.0

		if IsDisabledControlPressed(0, _Admin.Config.NoClip.Controls.goForward) then yoff = _Admin.Config.NoClip.Offsets.y end
		if IsDisabledControlPressed(0, _Admin.Config.NoClip.Controls.goBackward) then yoff = -_Admin.Config.NoClip.Offsets.y end
		if IsDisabledControlPressed(0, _Admin.Config.NoClip.Controls.goUp) then zoff = _Admin.Config.NoClip.Offsets.z end
		if IsDisabledControlPressed(0, _Admin.Config.NoClip.Controls.goDown) then zoff = -_Admin.Config.NoClip.Offsets.z end
		if IsDisabledControlJustPressed(0, _Admin.Config.NoClip.Controls.goSprint) then if indexf5 ~= #_Admin.Config.NoClip.Speeds then indexf5 = indexf5+1 CurrentSpeed = _Admin.Config.NoClip.Speeds[indexf5] else CurrentSpeed = _Admin.Config.NoClip.Speeds[1] indexf5 = 1 end end
		if IsDisabledControlPressed(0, _Admin.Config.NoClip.Controls.turnLeft) then SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+_Admin.Config.NoClip.Offsets.h) end
		if IsDisabledControlPressed(0, _Admin.Config.NoClip.Controls.turnRight) then SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-_Admin.Config.NoClip.Offsets.h) end

		if CurrentSpeed == 0 then
			vitesse = "Très Lent"
		elseif CurrentSpeed == 1 then
			vitesse = "Lent"
		elseif CurrentSpeed == 2 then
			vitesse = "Normal"
		elseif CurrentSpeed == 5 then
			vitesse = "Rapide"
		elseif CurrentSpeed == 10 then
			vitesse = "Très Rapide"
		elseif CurrentSpeed == 15 then
			vitesse = "Max Speed"
		end

		local newPos = GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
		local heading = GetEntityHeading(NoClipEntity)
		SetEntityVelocity(NoClipEntity, 0.0, 0.0, 0.0)
		SetEntityRotation(NoClipEntity, 0.0, 0.0, 0.0, 0, false)
		if _Admin.Config.NoClip.ControlsHeadingWithMouse then
			SetEntityHeading(NoClipEntity, GetGameplayCamRelativeHeading());
		else
			SetEntityHeading(NoClipEntity, heading);
		end	
		SetEntityCoordsNoOffset(NoClipEntity, newPos.x, newPos.y, newPos.z, true, true, true)
		SetLocalPlayerVisibleLocally(true);
		Citizen.Wait(0)
	end
end





function _Admin.ToggleNoClip(rank_name, rank_grade)
    if not _Admin.NoClipStatus then
		_Admin.Print("[^1"..rank_name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] à utilisé le ^6No-Clip ^7")
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            NoClipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
        else
            NoClipEntity = PlayerPedId()
        end
        SetEntityAlpha(NoClipEntity, 51, 0)
        if(NoClipEntity ~= PlayerPedId()) then
            SetEntityAlpha(PlayerPedId(), 51, 0)
        end
    else
        ResetEntityAlpha(NoClipEntity)
        if(NoClipEntity ~= PlayerPedId()) then
            ResetEntityAlpha(PlayerPedId())
        end
    end
    SetEntityCollision(NoClipEntity, _Admin.NoClipStatus, _Admin.NoClipStatus)
    FreezeEntityPosition(NoClipEntity, not _Admin.NoClipStatus)
    SetEntityInvincible(NoClipEntity, not _Admin.NoClipStatus)
    SetEntityVisible(NoClipEntity, _Admin.NoClipStatus, not _Admin.NoClipStatus);
    SetEveryoneIgnorePlayer(PlayerPedId(), not _Admin.NoClipStatus);
    SetPoliceIgnorePlayer(PlayerPedId(), not _Admin.NoClipStatus);
    _Admin.NoClipStatus = not _Admin.NoClipStatus
	_Admin.NoClip()
end