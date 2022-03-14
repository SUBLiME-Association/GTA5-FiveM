
local _ = {
    rank = nil;
    categorySelect = nil;
    shearchCar = nil;
    aPerms = _Admin.Permissions.Button_Vehicle.inside,
    findVehicle = nil;
}


local function SpawnVehicleFromPanel(name)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        ESX.Game.DeleteVehicle(vehicle)
        local pCoords = GetEntityCoords(PlayerPedId())
        local pHeading = GetEntityHeading(PlayerPedId())
        Wait(5)
        ESX.Game.SpawnVehicle(name, pCoords, pHeading, function(vehicle_)
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle_, -1)
            SetVehicleEngineOn(vehicle_, true, true, false)
        end)
    else
        local pCoords = GetEntityCoords(PlayerPedId())
        local pHeading = GetEntityHeading(PlayerPedId())
        Wait(5)
        ESX.Game.SpawnVehicle(name, pCoords, pHeading, function(vehicle_)
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle_, -1)
            SetVehicleEngineOn(vehicle_, true, true, false)
        end)
    end
end



function _Admin.Panel:Vehicle(rank)
    _.rank = rank
    
    RageUI.Button('Véhicule Mod Menu', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.ModMenu.access), {}, _Admin.Menu.sub_VehicleModMenu);

    RageUI.Button('Ajouter le véhicule au favoris', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SaveVehicle), {
        onSelected = function()
            if  IsPedInAnyVehicle(PlayerPedId(), false) then
                local _vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                local name = KI("Donner un nom à votre véhicule", "", 25)
                if name ~= nil and name ~= "" then
                    local vehdata = ESX.Game.GetVehicleProperties(_vehicle)
                    TriggerServerEvent(_Admin.Prefix.."SaveData", "vehicule", name, vehdata)
                    _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À ajouter un nouveau véhicule au favoris ^6"..name.."^7")
                    _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À ajouter un nouveau véhicule au favoris "..name)
                end
            else
                ESX.ShowNotification("~r~Vous n'êtes pas dans un véhicule")
            end
        end
    });

    RageUI.Button('Mes véhicules favoris', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.MySavedVehicle), {
        onSelected = function()
            _Admin.RefreshSublimeData()
        end
    }, _Admin.Menu.sub_VehicleFav);

    RageUI.Line()

    if _.shearchCar ~= nil then
        RageUI.Button('~r~Annuler la recherche', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SpawnVehicle), {
            onSelected = function()
                _.shearchCar = nil
            end
        });
        for k,v in pairs(_Admin.Vehicle.List) do
            _.findVehicle = string.find(v.label, tostring((_.shearchCar):gsub("^%l", string.upper)))
            if _.findVehicle then
                RageUI.Button(v.label, string.upper(v.type), {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SpawnVehicle), {
                    onSelected = function()
                        _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Spawn véhicule → [^6"..v.label.."^7]")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Spawn véhicule → "..v.label)
                        SpawnVehicleFromPanel(v.model)
                    end
                })
            end
        end
    else
        RageUI.Button('~y~Rechercher un véhicule', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SpawnVehicle), {
            onSelected = function()
                local vehicle = KI("Rechercher un véhicule", "", 25)
                if vehicle ~= nil and vehicle ~= " " then
                    _.shearchCar = vehicle
                end
            end
        });
        for k, v in pairs(_Admin.Vehicle.Type) do 
            RageUI.Button(v, nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SpawnVehicle), {
                onSelected = function()
                    _.categorySelect = v
                end
            }, _Admin.Menu.sub_Vehicle2);
        end
    end
end


function _Admin.Panel:Vehicle2(rank)
    for k,v in pairs(_Admin.Vehicle.List) do
        if v.type == _.categorySelect then
            RageUI.Button(v.label, string.upper(v.type), {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SpawnVehicle), {
                onSelected = function()
                    _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Spawn véhicule → [^6"..v.label.."^7]")
                    _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Spawn véhicule → "..v.label)
                    SpawnVehicleFromPanel(v.model)
                end
            })
        end
    end
end