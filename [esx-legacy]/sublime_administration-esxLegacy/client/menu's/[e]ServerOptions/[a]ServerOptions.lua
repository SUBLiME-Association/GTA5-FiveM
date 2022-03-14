
local _ = {
    rank = nil;
    aPerms = _Admin.Permissions.Button_ServerSystem.inside,

}


function  _Admin.Panel:ServerOptions(rank)
    _.rank = rank

    if _Admin.Config.UseWeatherAndTimeSync then
        RageUI.Button('Gestion météo & temps', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.WeatherOptions), {}, _Admin.Menu.sub_ServerOptionsWeather);
    end
    
    RageUI.Button('Gestion des reports', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.ReportOptions.access), { onSelected = function() _Admin.RefreshReports() end }, _Admin.Menu.sub_ServerOptionsReports);

    RageUI.Line()

    RageUI.Button('Nettoyer complètement la zone', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.ClearAllZone), {
        onSelected = function()
            local myCoords = GetEntityCoords(PlayerPedId())
            local radius = KI("Rayon","", 5)
            radius = tonumber(radius.. ".0")
            if type(radius) == 'number' then
                TriggerEvent('esx:deleteVehicle', radius)
                ClearArea(myCoords.x, myCoords.y, myCoords.z, radius, true, true, true, false)
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À effectuer un nettoyage complet de la zone ^6"..myCoords.."^7 pour un rayon de ^6"..radius.." ^7")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À effectuer un nettoyage complet de la zone "..myCoords.." pour un rayon de "..radius)

            end
        end
    });

    RageUI.Button('Supprimer les véhicules proches', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.ClearVehicles), {
        onSelected = function()
            local myCoords = GetEntityCoords(PlayerPedId())
            local radius = KI("Rayon","", 5)
            radius = tonumber(radius)
            if type(radius) == 'number' then
                radius = ESX.Math.Round(radius) 
                TriggerEvent('esx:deleteVehicle', radius)
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À supprimer les ^5véhicules^7 de la zone ^6"..myCoords.."^7 pour un rayon de ^6"..radius.." ^7")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À supprimer les véhicules de la zone "..myCoords.." pour un rayon de "..radius)
            end
        end
    });

    RageUI.Button('Supprimer les peds proches', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.ClearPeds), {
        onSelected = function()
            local myCoords = GetEntityCoords(PlayerPedId())
            local radius = KI("Rayon","", 5)
            radius = tonumber(radius.. ".0")
            if type(radius) == 'number' then
                ClearAreaOfPeds(myCoords.x, myCoords.y, myCoords.z, radius, 1)
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À supprimer les ^5peds^7 de la zone ^6"..myCoords.."^7 pour un rayon de ^6"..radius.." ^7")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À supprimer les peds de la zone "..myCoords.." pour un rayon de "..radius)
            end
        end
    });

    RageUI.Button('Supprimer les object proches', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.ClearObjects), {
        onSelected = function()
            local myCoords = GetEntityCoords(PlayerPedId())
            local radius = KI("Rayon","", 5)
            radius = tonumber(radius.. ".0")
            if type(radius) == 'number' then
                ClearAreaOfObjects(myCoords.x, myCoords.y, myCoords.z, radius, 2)
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À supprimer les ^5objets^7 de la zone ^6"..myCoords.."^7 pour un rayon de ^6"..radius.." ^7")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À supprimer les objets de la zone "..myCoords.." pour un rayon de "..radius)
            end
        end
    });



end