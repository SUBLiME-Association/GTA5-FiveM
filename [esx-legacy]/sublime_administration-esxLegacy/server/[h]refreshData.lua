

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
    local query = 'SELECT * FROM users, sublime_bans WHERE users.identifier = sublime_bans.identifier'
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.fetchAll(query, {}, function(result)
            for _,v in pairs(result) do
                Bans[#Bans+1] = {
                    identifier = result[i].identifier,
                    name = result[i].firstname..' '..result[i].lastname,
                    reason = v.reason,
                    expiration = v.expiration,
                }
            end
            TriggerClientEvent(_Admin.Prefix.."SendBans", _src, Bans)
        end)
    else
        MySQL.query(query, {}, function(result)
            for i = 1, #result do
                Bans[#Bans+1] = {
                    identifier = result[i].identifier,
                    name = result[i].firstname..' '..result[i].lastname,
                    reason = v.reason,
                    expiration = v.expiration,
                }
            end
            TriggerClientEvent(_Admin.Prefix.."SendBans", _src, Bans)
        end)
    end
end)




RegisterServerEvent(_Admin.Prefix.."RefreshStaff")
AddEventHandler(_Admin.Prefix.."RefreshStaff", function()
    local _src = source
    local query = 'SELECT * FROM users, sublime_permissions WHERE users.identifier = sublime_permissions.identifier'
    local Staff = {}
    if _Admin.SQLWrapperType == 1 then 
        MySQL.Async.fetchAll(query, {}, function(result)
            for i = 1, #result do
                Staff[#Staff+1] = {
                    identifier = result[i].identifier,
                    rank = result[i].rank,
                    name = result[i].firstname..' '..result[i].lastname,
                }
            end
            TriggerClientEvent(_Admin.Prefix.."SendStaff", _src, Staff)
        end)
    else
        MySQL.query(query, {}, function(result)
            for i = 1, #result do
                Staff[#Staff+1] = {
                    identifier = result[i].identifier,
                    rank = result[i].rank,
                    name = result[i].firstname..' '..result[i].lastname,
                }
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