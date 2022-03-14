
local _ = {
    rank = nil;
}

function _Admin.Panel:VehicleFavoris(rank)
    _.rank = rank
    for k,v in pairs (_Admin.Data) do
        if v.type == "vehicule" then
            RageUI.Button(v.name, nil, {RightLabel = "~c~→→→"}, true, {
                onSelected = function()
                    _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Spawn véhicule ^3FAVORIS^7 → [^6"..v.name.."^7]")
                    _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Spawn véhicule FAVORIS → ["..v.name.."]")
                    local data = json.decode(v.data)
                    Citizen.CreateThread(function() 
                        local pCoords = GetEntityCoords(PlayerPedId())
                        local pHeading = GetEntityHeading(PlayerPedId())
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            ESX.Game.DeleteVehicle(vehicle)
                            Wait(5)
                            ESX.Game.SpawnVehicle(data.model, pCoords, pHeading, function(vehicle_)
                                ESX.Game.SetVehicleProperties(vehicle_, data)
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle_, -1)
                                SetVehicleEngineOn(vehicle_, true, true, false)
                            end)
                        else
                            ESX.Game.SpawnVehicle(data.model, pCoords, pHeading, function(vehicle_)
                                ESX.Game.SetVehicleProperties(vehicle_, data)
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle_, -1)
                                SetVehicleEngineOn(vehicle_, true, true, false)
                            end)
                        end
                    end)
                end
            });
        end
    end
end






