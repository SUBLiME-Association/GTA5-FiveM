
local _ = {
    rank = nil;
}



function _Admin.Panel:OwnerManagementBans(rank)
    _.rank = rank

    if json.encode(_Admin.Bans) ~= "[]" then
        for k, v in pairs(_Admin.Bans) do
            RageUI.Button(v.name, "Motif : \n"..v.reason, {RightLabel = "~r~Deban ~c~→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent(_Admin.Prefix.."DebanPlayer", v.identifier)
                    Citizen.CreateThread(function()
                        Wait(500)
                        _Admin.RefreshBans()
                        _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À déban ^3"..v.name.."^7")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À déban "..v.name.."")
                    end)
                end
            })
        end
    else
        RageUI.Line()
        RageUI.Separator("~r~Aucun ban !")
        RageUI.Line()
    end
end