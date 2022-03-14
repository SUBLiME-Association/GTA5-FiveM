

RegisterNetEvent(_Admin.Prefix.."SaveData")
AddEventHandler(_Admin.Prefix.."SaveData", function(type, name, data)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if _Admin.SQLWrapperType == 1 then
        if type == "apparence" or "vehicule" then
            MySQL.Async.execute("INSERT INTO `sublime_data` (identifier, name, data, type) VALUES (@identifier, @name, @data, @type)", {
                ["@identifier"] = xPlayer.identifier,
                ["@name"] = name,
                ["@data"] = json.encode(data),
                ["@type"] = type,
            }, function()
                xPlayer.showNotification(string.upper(type).." sauvegardé ✔️")
            end)
        end
    else
        if type == "apparence" or "vehicule" then
            MySQL.insert('INSERT INTO sublime_data (identifier, name, data, type) VALUES (?, ?, ?, ?) ', {xPlayer.identifier, name, json.encode(data), type}, function()
                xPlayer.showNotification(string.upper(type).." sauvegardé ✔️")
            end)
        end
    end
end)

