

function _Admin.DeveloppementMod()
    local pCoords = GetEntityCoords(PlayerPedId())
    local pHeading = GetEntityHeading(PlayerPedId())

    -- Obj
    local closestObject, distance = ESX.Game.GetClosestObject( GetEntityCoords(PlayerPedId()))
    _Admin.Laser.DrawEntityBoundingBox(closestObject, {r = 0, g = 255, b = 0, a = 200})
    local entityObject = GetEntityCoords(closestObject)
    _Admin.Laser.DrawText3D(entityObject.x, entityObject.y, entityObject.z, "Obj: " .. closestObject .. " Model: " .. GetEntityModel(closestObject).. "", 2)

    --Vehicle
    local closestVehicle, distance = ESX.Game.GetClosestVehicle( GetEntityCoords(PlayerPedId()))
    _Admin.Laser.DrawEntityBoundingBox(closestVehicle, {r = 0, g = 255, b = 0, a = 200})
    local entityVehicle = GetEntityCoords(closestVehicle)
    _Admin.Laser.DrawText3D(entityVehicle.x, entityVehicle.y, entityVehicle.z, "Obj: " .. closestVehicle .. " Model: " .. GetEntityModel(closestVehicle).. "", 2)

    --Peds
    local closestPeds, distance = ESX.Game.GetClosestPed( GetEntityCoords(PlayerPedId()))
    _Admin.Laser.DrawEntityBoundingBox(closestPeds, {r = 0, g = 255, b = 0, a = 200})
    local entityPeds = GetEntityCoords(closestPeds)
    _Admin.Laser.DrawText3D(entityPeds.x, entityPeds.y, entityPeds.z, "Obj: " .. closestPeds .. " Model: " .. GetEntityModel(closestPeds).. "", 2)

    -- Coords
    _Admin.DrawText(0.3, 0.010, 0.58, 6, "~b~X~s~ : " .. ESX.Math.Round(pCoords.x, 4) .. "\n~g~Y~s~ : " .. ESX.Math.Round(pCoords.y, 4) .. "\n~y~Z~s~ : " .. ESX.Math.Round(pCoords.z, 4) .. "\n~o~H~s~ : " .. ESX.Math.Round(pHeading, 4) , 255, 255, 255, 255)

    --Street Label
    local zone = GetNameOfZone(pCoords.x, pCoords.y, pCoords.z);
    local zoneLabel = GetLabelText(zone);
    local var1, var2 = GetStreetNameAtCoord(pCoords.x, pCoords.y, pCoords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    local hash1 = GetStreetNameFromHashKey(var1);
    local hash2 = GetStreetNameFromHashKey(var2);

    _Admin.DrawText(0.4, 0.010, 0.58, 6, "~p~Quartier~s~ : " .. zoneLabel .. "\n~p~Rue~s~ : "..hash1.." , "..hash2, 255, 255, 255, 255)

end