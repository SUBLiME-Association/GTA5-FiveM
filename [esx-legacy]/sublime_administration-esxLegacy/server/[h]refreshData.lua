

RegisterServerEvent(_Admin.Prefix.."RefreshData") 
AddEventHandler(_Admin.Prefix.."RefreshData", function()
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.fetchAll('SELECT * FROM sublime_data WHERE identifier = @identifier', {
            ["@identifier"] = xPlayer.identifier
        }, function(result)
            TriggerClientEvent(_Admin.Prefix.."SendData", _src, result)
        end)
    else
        MySQL.query('SELECT * FROM sublime_data WHERE identifier = ?', {xPlayer.identifier}, function(result)
            TriggerClientEvent(_Admin.Prefix.."SendData", _src, result)
        end)
    end
end)




RegisterServerEvent(_Admin.Prefix.."RefreshBans")
AddEventHandler(_Admin.Prefix.."RefreshBans", function()
    local _src = source
    local Bans = {}
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.fetchAll('SELECT * FROM sublime_bans ', {}, function(result)
            for _,v in pairs(result) do
                local xPlayer = ESX.GetPlayerFromIdentifier(v.identifier)
                local name = xPlayer.getName()
                table.insert(Bans, {
                    identifier = v.identifier,
                    name = name,
                    reason = v.reason,
                    expiration = v.expiration,
                })
            end
            TriggerClientEvent(_Admin.Prefix.."SendBans", _src, Bans)
        end)
    else
        MySQL.query('SELECT * FROM sublime_bans', {}, function(result)
            for _,v in pairs(result) do
                local xPlayer = ESX.GetPlayerFromIdentifier(v.identifier)
                local name = xPlayer.getName()
                table.insert(Bans, {
                    identifier = v.identifier,
                    name = name,
                    reason = v.reason,
                    expiration = v.expiration,
                })
            end
            TriggerClientEvent(_Admin.Prefix.."SendBans", _src, Bans)
        end)
    end
end)




RegisterServerEvent(_Admin.Prefix.."RefreshStaff")
AddEventHandler(_Admin.Prefix.."RefreshStaff", function()
    local _src = source
    local Staff = {}
    if _Admin.SQLWrapperType == 1 then 
        MySQL.Async.fetchAll('SELECT * FROM sublime_permissions ', {}, function(result)
            for _,v in pairs(result) do
                local xPlayer = ESX.GetPlayerFromIdentifier(v.identifier)
                local name = xPlayer.getName()
                table.insert(Staff, {
                    identifier = v.identifier,
                    name = name,
                    rank = v.rank,
                })
            end
            TriggerClientEvent(_Admin.Prefix.."SendStaff", _src, Staff)
        end)
    else
        MySQL.query('SELECT * FROM sublime_permissions', {}, function(result)
            for _,v in pairs(result) do
                local xPlayer = ESX.GetPlayerFromIdentifier(v.identifier)
                local name = xPlayer.getName()
                table.insert(Staff, {
                    identifier = v.identifier,
                    name = name,
                    rank = v.rank,
                })
            end
            TriggerClientEvent(_Admin.Prefix.."SendStaff", _src, Staff)
        end)
    end
end)



RegisterServerEvent(_Admin.Prefix.."GetListOfAllItems")
AddEventHandler(_Admin.Prefix.."GetListOfAllItems", function()
    local _src = source
    local listItems = {}
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
            for k,v in pairs(result) do
                table.insert(listItems, {
                    label = v.label,
                    name = v.name,
                    weight = v.weight,
                    rare = v.rare,
                    canremove = v.can_remove
                })
            end
            TriggerClientEvent(_Admin.Prefix.."LoadListOfAllItems", _src, listItems)
        end)
    else
        MySQL.query('SELECT * FROM items', {}, function(result)
            for k,v in pairs(result) do
                table.insert(listItems, {
                    label = v.label,
                    name = v.name,
                    weight = v.weight,
                    rare = v.rare,
                    canremove = v.can_remove
                })
            end
            TriggerClientEvent(_Admin.Prefix.."LoadListOfAllItems", _src, listItems)
        end)
    end
end)