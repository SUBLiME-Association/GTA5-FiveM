
local _ = {
    rank = nil;
    reportData = {};
    listIndex = 1;
    aPerms = _Admin.Permissions.Button_ServerSystem.inside.ReportOptions.inside,

}



function _Admin.RefreshReports()

    ESX.TriggerServerCallback(_Admin.Prefix.."GetReports", function(reports) 
        _.reportData = reports
    end)
end




function _Admin.Panel:ServerOptionsReports(rank)
    _.rank = rank

    for k, v in pairs(_.reportData) do

        RageUI.List(k.." | [".. v.player.."] - " .. v.playerName, {"Bring","Goto","Répondre","~r~Supprimer~s~"}, _.listIndex, table.concat(v.message, " "), {}, true, {
            onListChange = function(Index, Item)
                _.listIndex = Index
            end,
            onSelected = function()
                if _.listIndex == 1 then
                    local myCoords = GetEntityCoords(PlayerPedId())
                    Citizen.CreateThread(function()
                        _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Bring → [^5"..v.playerName.."^7]")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Bring → ["..v.playerName.."]")
                        ESX.Game.Teleport(GetPlayerPed(GetPlayerFromServerId(v.player)), myCoords)
                    end)
                elseif _.listIndex == 2 then
                    local targetCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(v.player)))
                    Citizen.CreateThread(function()
                        _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Goto → [^5"..v.playerName.."^7]")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Goto → ["..v.playerName.."]")
                        ESX.Game.Teleport(PlayerPedId(), targetCoords)
                    end)
                elseif _.listIndex == 3 then
                    local msg = KI("Message", "", 150)
                    if msg ~= nil and msg ~= "" then
                        local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                        _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Message privé → [^5"..v.playerName.."^7] Message : ^6"..msg.."^7")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Message privé → ["..v.playerName.."] Message : "..msg)
                        TriggerServerEvent(_Admin.Prefix.."sendPrivateNotification", v.player, msg, mugshotStr)
                        UnregisterPedheadshot(mugshot)
                    end
                elseif _.listIndex == 4 then
                    TriggerServerEvent(_Admin.Prefix.."ManageReports", "delete_report", {index = k})
                    _Admin.RefreshReports()
                end
            end
        })
        
    end

    if json.encode(_.reportData) ~= "[]" then
        RageUI.Button('~r~Supprimer les reports', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.ClearReports), {
            onSelected = function()
                TriggerServerEvent(_Admin.Prefix.."ManageReports", "clearall")
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Clear all reports")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Clear all reports")
                _Admin.RefreshReports()
            end
        });
    else
        RageUI.Line()
        RageUI.Separator("~r~Aucun report")
        RageUI.Line()
    end

end