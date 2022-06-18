ESX.RegisterServerCallback(_Admin.Prefix.."OwnerPermissions", function(source, cb, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local found = false
    for _,v in ipairs(_Admin.MainUser) do
        if v == xPlayer.identifier then
            found = true
        end
    end
    if found then
        cb(true)
    else
        cb(false)
    end
end)


function _Admin.CheckOwnerPermissions(xPlayer)
    for _,v in ipairs(_Admin.MainUser) do
        if v == xPlayer.identifier then
            return true
        else
            return false
        end
    end
end


ESX.RegisterServerCallback(_Admin.Prefix.."CheckStaffPermissions", function(source, cb, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bool, result = _Admin.CheckStaffPermissions(xPlayer)
    if bool then
        cb(result)
    end
end)




function _Admin.CheckStaffPermissions(xPlayer)
    local _result = {bool = nil, name = nil; grade = nil}
    if _Admin.SQLWrapperType == 1 then 
        MySQL.Async.fetchScalar("SELECT `rank` FROM `sublime_permissions` WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier
        }, function(result)
            if result ~= nil then
                for k,v in pairs(_Admin.Ranks) do
                    if v.grade == result then
                        _result.bool = true
                        _result.grade = result
                        _result.name = v.name
                    end
                end
            end
        end)
    else
        MySQL.scalar('SELECT rank FROM sublime_permissions WHERE identifier = ?', {xPlayer.identifier}, function(result)
            if result ~= nil then
                for k,v in pairs(_Admin.Ranks) do
                    if v.grade == result then
                        _result.bool = true
                        _result.grade = result
                        _result.name = v.name
                    end
                end
            end
        end)
    end
    Wait(20)
    if _result.bool then
        return true, _result
    end
end
