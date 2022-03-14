
local _ = {
    rank = nil;
    staffListIndex = 1,
}




function _Admin.Panel:OwnerManagementStaff(rank)
    _.rank = rank

    if json.encode(_Admin.Staff) ~= "[]" then
        for k, v in pairs(_Admin.Staff) do
            local gradeName = _Admin.GetRankNameFromGrade(v.rank)
            RageUI.List(v.name, {"Changer le grade", "~r~Retirer les permissions~s~"}, _.staffListIndex, "~y~Grade~s~ : "..v.rank.." - "..gradeName.."\n~y~RS License~s~ : "..v.identifier, {}, true, {
                onListChange = function(Index, Item)
                    _.staffListIndex = Index;
                end,
                onSelected = function()
                    if _.staffListIndex == 1 then 
                        local newGrade = KI("Nouveau grade", "", 2)
                        newGrade = tonumber(newGrade)
                        if type(newGrade) == 'number' then
                            for _k, _v in pairs(_Admin.Ranks) do
                                if _v.grade == newGrade then
                                    TriggerServerEvent(_Admin.Prefix.."UpdateAdminPermissions", v.identifier, newGrade)
                                    Citizen.CreateThread(function()
                                        Citizen.Wait(150)
                                        _Admin.RefreshStaff()
                                        _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À mis à jour les permissions de ^3"..v.name.."^7 → [^5"..tostring(newGrade).."^7]^7")
                                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À mis à jour les permissions de "..v.name.." → ["..tostring(newGrade).."]")
                                    end)
                                end
                            end
                        end
                    else
                        TriggerServerEvent(_Admin.Prefix.."RemoveAdminPermissions", v.identifier)
                        Citizen.CreateThread(function()
                            Citizen.Wait(50)
                            _Admin.RefreshStaff()
                            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À ^1retiré^7 les permissions de ^3"..v.name.."^7")
                            _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À retiré les permissions de "..v.name)
                        end)
                    end
                end,
            })
        end
    else
        RageUI.Line()
        RageUI.Separator("~r~Aucun staff !")
        RageUI.Line()
    end
end