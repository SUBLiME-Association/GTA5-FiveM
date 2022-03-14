

--| Admin Panels
Keys.Register(_Admin.Config.Macro['Open Main Menu'].btn, _Admin.Config.Macro['Open Main Menu'].btn, _Admin.Config.Macro['Open Main Menu'].description, function()
    if not _Admin.Menu.main then
        ESX.TriggerServerCallback(_Admin.Prefix.."OwnerPermissions", function(bool) 
            if bool then
                local rank = { name = "Owner", grade = "Owner" }
                _Admin.Panel:Main(rank)
            else
                ESX.TriggerServerCallback(_Admin.Prefix.."CheckStaffPermissions", function(rank)
                    _Admin.Panel:Main(rank)
                end)
            end
        end)
    end
end)





--| No Clip Toggle
Keys.Register(_Admin.Config.Macro['No Clip Toggle'].btn, _Admin.Config.Macro['No Clip Toggle'].btn, _Admin.Config.Macro['No Clip Toggle'].description, function()
    ESX.TriggerServerCallback(_Admin.Prefix.."OwnerPermissions", function(bool) 
        if bool then
            _Admin.ToggleNoClip("Owner")
        else
            ESX.TriggerServerCallback(_Admin.Prefix.."CheckStaffPermissions", function(rank)
                for k,v in ipairs(_Admin.Permissions.NoClip) do
                    if (rank.grade == v) then
                        _Admin.ToggleNoClip(rank.name, rank.grade)
                    end
                end
            end)
        end
    end)
end)

