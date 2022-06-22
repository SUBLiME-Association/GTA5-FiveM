_Admin.addThread = {
    {false, "God Mode"};-- 1 
    {false, "Invisible"};-- 2 
    {false, "Fast Run"};-- 3 
    {false, "Fast Swim"};-- 4
    {false, "Super Jump"};-- 5 
    {false, "Stay in Véhicule"};-- 6
    {false, "Vision thermique"};-- 7
    {false, "Show Player Name", {}};-- 8
    {false, "Vehicle Boost", nil, nil};-- 9
    {false, "Laser Informations"};-- 10
    {false; "Dev mode"};-- 11
}




Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(5.0)
        local intervale = true

        if _Admin.addThread[1][1] then
            intervale = false
            SetEntityInvincible(PlayerPedId(), true)
        end

        if _Admin.addThread[2][1] then
            intervale = false
            SetEntityVisible(PlayerPedId(), false, 0)
        end

        if _Admin.addThread[3][1] then
            intervale = false
            SetPedMoveRateOverride(PlayerPedId(), 2.20)
        end

        if _Admin.addThread[4][1] then
            intervale = false 
            SetSwimMultiplierForPlayer(PlayerId(), 1.49);
        end

        if _Admin.addThread[5][1] then
            intervale = false 
            SetSuperJumpThisFrame(PlayerId());
        end

        if _Admin.addThread[6][1] then
            intervale = false 
            SetPedCanRagdoll(PlayerPedId(), false)
        end

        if _Admin.addThread[7][1] then
            intervale = false
            SetSeethrough(true)
        end

        if _Admin.addThread[8][1] then
            intervale = false
            for k, v in ipairs(ESX.Game.GetPlayers()) do
				local otherPed = GetPlayerPed(v)
                if #(GetEntityCoords(PlayerPedId(), false) - GetEntityCoords(otherPed, false)) < 800.0 then
                    _Admin.addThread[8][3][v] = CreateFakeMpGamerTag(otherPed, ('%s | %s'):format(GetPlayerServerId(v), string.upper(GetPlayerName(v))), false, false, '', 0)
                    SetMpGamerTagVisibility(_Admin.addThread[8][3][v], 2, 1)
                    SetMpGamerTagAlpha(_Admin.addThread[8][3][v], 2, 255)
                    SetMpGamerTagHealthBarColor(_Admin.addThread[8][3][v], 129) 
                else
                    RemoveMpGamerTag(_Admin.addThread[8][3][v])
                    _Admin.addThread[8][3][v] = nil
                end
			end
        end

        if _Admin.addThread[9][1] then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                intervale = false
                SetVehicleCheatPowerIncrease(_Admin.addThread[9][3], _Admin.addThread[9][4] /1.5)
            else
                _Admin.addThread[9][1] = false
            end
        end

        if _Admin.addThread[10][1] then
            intervale = false
            _Admin.Laser.Show()
        end

        if _Admin.addThread[11][1] then
            intervale = false
            _Admin.DeveloppementMod()
        end



        if intervale then
            Citizen.Wait(350)
        else
            DrawActivateOptions()
        end
    end
end)




function DrawActivateOptions()
    _Admin.DrawText(0.885, 0.700, 0.5, 6, "- Options Activé -", 255, 255, 255, 255)
    for k,v in pairs(_Admin.addThread) do
        if v[1] then
            _Admin.DrawText(0.900, 0.710 + ( k / 50), 0.38, 6, v[2], 255, 255, 255, 255)
        end
    end
end



CreateThread(function() --> spécial précharge pour Admin les Callback lourd 1x à la connection
    Wait(5000)
    ESX.TriggerServerCallback(_Admin.Prefix.."OwnerPermissions", function(bool) 
        if bool then
            local rank = { name = "Owner", grade = "Owner" }
            if _Admin:HaveAccess(rank, _Admin.Permissions.SetJob) then
                _Admin.GetAllJobsFactions()
                if _Admin.Config.esx_vehicleshop then
                    TriggerServerEvent(_Admin.Prefix.."GetAllVehicleSQL")
                end
            end
        else
            ESX.TriggerServerCallback(_Admin.Prefix.."CheckStaffPermissions", function(rank)
                if _Admin:HaveAccess(rank, _Admin.Permissions.SetJob) then
                    _Admin.GetAllJobsFactions()
                    if _Admin.Config.esx_vehicleshop then
                        TriggerServerEvent(_Admin.Prefix.."GetAllVehicleSQL")
                    end
                end
            end)
        end
    end)
end)



