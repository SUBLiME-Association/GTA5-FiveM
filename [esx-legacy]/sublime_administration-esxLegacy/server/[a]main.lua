
RegisterServerEvent(_Admin.Prefix.."sendPrivateNotification")
AddEventHandler(_Admin.Prefix.."sendPrivateNotification", function(player, message, mugshot)
    local _src = source
    local xTarget = ESX.GetPlayerFromId(player)
    local xPlayer = ESX.GetPlayerFromId(_src)

	TriggerClientEvent('esx:showAdvancedNotification', xTarget.source, "~h~ADMINISTRATION", "~r~"..string.upper(xPlayer.getName()), message, mugshot, 1)
    xPlayer.showNotification("Message Envoyé ✔️")
end)




RegisterServerEvent(_Admin.Prefix.."revivePlayer")
AddEventHandler(_Admin.Prefix.."revivePlayer", function(player)
    local _src = source
    TriggerClientEvent(_Admin.Prefix.."reviveTargetPlayer", player)
end)


function GetSQL_Wrapper()
    if _Admin.Config.SQL_Wrapper == "mysql-async" or _Admin.Config.SQL_Wrapper == "mysql" then
        return 1
    elseif _Admin.Config.SQL_Wrapper == "oxmysql" then
        return 2
    else
        _Admin.Print("~r~ERROR SQL WRAPPER NON RECONNU")
    end
end

_Admin.SQLWrapperType = GetSQL_Wrapper()



RegisterNetEvent(_Admin.Prefix.."kickPlayer")
AddEventHandler(_Admin.Prefix.."kickPlayer", function(rank, target, reason)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if rank.name == "Owner" then
        local checkPerms = _Admin.CheckOwnerPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("Player : ^1"..GetPlayerName(target).."^7 à été ^KICK^7 par ^2"..xPlayer.getName().."^7 Raison : "..reason)
            DropPlayer(target, reason)
        end
    else
        local checkPerms, result = _Admin.CheckStaffPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("Player : ^1"..GetPlayerName(target).."^7 à été ^KICK^7 par ^2"..xPlayer.getName().."^7 Raison : "..reason)
            DropPlayer(target, reason)
        end
    end
end)




RegisterServerEvent(_Admin.Prefix.."GiveItem")
AddEventHandler(_Admin.Prefix.."GiveItem", function(rank, label, name, qty)
	local _src = source
	local playerGroup = false
	local xPlayer = ESX.GetPlayerFromId(_src)


    if rank.name == "Owner" then
        local checkPerms = _Admin.CheckOwnerPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("[^1"..rank.name.." ^7- ^2"..xPlayer.getName().."^7] Give → [^5".. qty .."" .. label .."^7]")
            xPlayer.addInventoryItem(name, qty)
        end
    else
        local checkPerms, result = _Admin.CheckStaffPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("[^1"..rank.name.." ^7- ^2"..xPlayer.getName().."^7] Goto → [^5".. qty .. "" .. label .."^7]")
            xPlayer.addInventoryItem(name, qty)
        end
    end
end)




RegisterServerEvent(_Admin.Prefix.."GiveWeapon")
AddEventHandler(_Admin.Prefix.."GiveWeapon", function(rank, weapon, ammo)
	local _src = source
	local playerGroup = false
	local xPlayer = ESX.GetPlayerFromId(_src)
    if rank.name == "Owner" then
        local checkPerms = _Admin.CheckOwnerPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("[^1"..rank.name.." ^7- ^2"..xPlayer.getName().."^7] Give → [^5".. weapon .." x" .. ammo .." ammo^7]")
            xPlayer.addWeapon(weapon, ammo)
        end
    else
        local checkPerms, result = _Admin.CheckStaffPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("[^1"..rank.name.." ^7- ^2"..xPlayer.getName().."^7] Give → [^5".. weapon .." x" .. ammo .." ammo^7]")
            xPlayer.addWeapon(weapon, ammo)
        end
    end
end)



RegisterServerEvent(_Admin.Prefix.."GiveAllWeapon")
AddEventHandler(_Admin.Prefix.."GiveAllWeapon", function(rank)
	local _src = source
	local playerGroup = false
	local xPlayer = ESX.GetPlayerFromId(_src)
    if rank.name == "Owner" then
        local checkPerms = _Admin.CheckOwnerPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("[^1"..rank.name.." ^7- ^2"..xPlayer.getName().."^7] Give → [^5ALL WEAPONS^7]")
            for k,v in pairs(_Admin.Weapon.List) do
                xPlayer.addWeapon(v.name, 500)
            end
        end
    else
        local checkPerms, result = _Admin.CheckStaffPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("[^1"..rank.name.." ^7- ^2"..xPlayer.getName().."^7] Give → [^5ALL WEAPONS^7]")
            for k,v in pairs(_Admin.Weapon.List) do
                xPlayer.addWeapon(v.name, 500)
            end
        end
    end
end)



RegisterServerEvent(_Admin.Prefix.."RemoveAllWeapon")
AddEventHandler(_Admin.Prefix.."RemoveAllWeapon", function(rank)
	local _src = source
	local playerGroup = false
	local xPlayer = ESX.GetPlayerFromId(_src)
    if rank.name == "Owner" then
        local checkPerms = _Admin.CheckOwnerPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("[^1"..rank.name.." ^7- ^2"..xPlayer.getName().."^7] Remove → [^5ALL WEAPONS^7]")
            for k,v in pairs(xPlayer.getLoadout()) do
                xPlayer.removeWeapon(v.name)
            end
        end
    else
        local checkPerms, result = _Admin.CheckStaffPermissions(xPlayer)
        if checkPerms then
            _Admin.Print("[^1"..rank.name.." ^7- ^2"..xPlayer.getName().."^7] Remove → [^5ALL WEAPONS^7]")
            for k,v in pairs(xPlayer.getLoadout()) do
                xPlayer.removeWeapon(v.name)
            end
        end
    end
end)



RegisterServerEvent(_Admin.Prefix.."SendPrint2Server") 
AddEventHandler(_Admin.Prefix.."SendPrint2Server", function(msg)
    _Admin.Print(msg)
end)




function _Admin.Print(msg)
    if _Admin.Config.EnablePrints then
        print(msg)
    end
end




RegisterServerEvent(_Admin.Prefix.."SetAdminPermissions")
AddEventHandler(_Admin.Prefix.."SetAdminPermissions", function(adminRank, target, rank)
    local xTarget = ESX.GetPlayerFromId(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.fetchScalar("SELECT `rank` FROM `sublime_permissions` WHERE identifier = @identifier", {
            ["@identifier"] = xTarget.identifier
        }, function(result)
            if result == nil then
                MySQL.Async.execute('INSERT INTO sublime_permissions (identifier, rank) VALUES (@identifier, @rank)',{
                    ['@identifier']   = xTarget.identifier;
                    ['@rank'] = rank;
                }, function ()

                end)
            else
                MySQL.Async.execute('UPDATE sublime_permissions SET rank = @rank WHERE identifier = @identifier',{
                    ['@identifier']   = xTarget.identifier;
                    ['@rank'] = rank;
                }, function()
                    xPlayer.showNotification("~g~Rank de "..xTarget.getName().." mis à jour")
                    xTarget.showNotification("~g~Vous avez reçus les permissions grade n°~s~"..rank)
                end)
            end
        end)
    else
        MySQL.scalar('SELECT rank FROM sublime_permissions WHERE identifier = ?', {xTarget.identifier}, function(result)
            if result == nil then
                MySQL.insert('INSERT INTO sublime_permissions (identifier, rank) VALUES (?, ?) ', {xTarget.identifier, rank},function() end)
            else
                MySQL.update('UPDATE sublime_permissions SET rank = ? WHERE identifier = ? ', {rank, xTarget.identifier}, function()
                    xPlayer.showNotification("~g~Rank de "..xTarget.getName().." mis à jour")
                    xTarget.showNotification("~g~Vous avez reçus les permissions grade n°~s~"..rank)
                end)
            end
        end)
    end
end)




RegisterServerEvent(_Admin.Prefix.."UpdateAdminPermissions")
AddEventHandler(_Admin.Prefix.."UpdateAdminPermissions", function(identifier, newRank)
    local xPlayer = ESX.GetPlayerFromId(source)
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.fetchScalar("SELECT `rank` FROM `sublime_permissions` WHERE identifier = @identifier", {
            ["@identifier"] = identifier
        }, function(result)
            if result == nil then
                xPlayer.showNotification("Identifier : ~r~"..identifier.."~s~ introuvable dans la table sublime_permissions")
            else
                MySQL.Async.execute('UPDATE sublime_permissions SET rank = @rank WHERE identifier = @identifier',{
                    ['@identifier']   = identifier,
                    ['@rank'] = newRank;
                }, function()
                    xPlayer.showNotification("~g~Rank mis à jour")
                end)
            end
        end)
    else
        MySQL.scalar('SELECT rank FROM sublime_permissions WHERE identifier = ?', {identifier}, function(result)
            if result == nil then
                xPlayer.showNotification("Identifier : ~r~"..identifier.."~s~ introuvable dans la table sublime_permissions")
            else
                MySQL.update('UPDATE sublime_permissions SET rank = ? WHERE identifier = ? ', {newRank, identifier}, function()
                    xPlayer.showNotification("~g~Rank mis à jour")
                end)
            end
        end)
    end
end)



RegisterServerEvent(_Admin.Prefix.."RemoveAdminPermissions")
AddEventHandler(_Admin.Prefix.."RemoveAdminPermissions", function(identifier)
    local xPlayer = ESX.GetPlayerFromId(source)
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.execute('DELETE FROM sublime_permissions WHERE identifier = @identifier',{
            ['@identifier'] =  identifier
        })
        xPlayer.showNotification("~r~Permissions retirer")
    else
        MySQL.update('DELETE FROM sublime_permissions WHERE identifier = ', {identifier}, function()
            xPlayer.showNotification("~r~Permissions retirer")
        end)
    end
end)

RegisterServerEvent(_Admin.Prefix.."setJob")
AddEventHandler(_Admin.Prefix.."setJob", function(value,target,job,grade,label,grade_label,job_type)
    if _Admin.Config.DoubleJob == false then
        if value == 1 then
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.setJob(job, grade)
            xPlayer.showNotification("Vous êtes à présent~s~ : \n- ~g~"..label.." ~s~|~b~ "..grade_label)
        else
	        local xTarget = ESX.GetPlayerFromId(target)
            xTarget.setJob(job, grade)
            xTarget.showNotification("Vous êtes à présent~s~ : \n- ~g~"..label.." ~s~|~b~ "..grade_label)
        end
    elseif _Admin.Config.DoubleJob == 'fbase' then
        if value == 1 then
            local xPlayer = ESX.GetPlayerFromId(source)
            if job_type == 'job' then
                xPlayer.setJob(job, grade)
                xPlayer.showNotification("Vous êtes à présent~s~ : \n- ~g~"..label.." ~s~|~b~ "..grade_label.." ~s~|~b~ ~c~["..'~b~'..job_type..'~c~]')
            elseif job_type == 'job2' then
                xPlayer.setJob2(job, grade)
                xPlayer.showNotification("Vous êtes à présent~s~ : \n- ~g~"..label.." ~s~|~b~ "..grade_label.." ~s~|~b~ ~c~["..'~b~'..job_type..'~c~]')
            end
        else
	        local xTarget = ESX.GetPlayerFromId(target)
            if job_type == 'job' then
                xTarget.setJob(job, grade)
                xTarget.showNotification("Vous êtes à présent~s~ : \n- ~g~"..label.." ~s~|~b~ "..grade_label.." ~s~|~b~ ~c~["..'~b~'..job_type..'~c~]')
            elseif job_type == 'job2' then
                xTarget.setJob2(job, grade)
                xTarget.showNotification("Vous êtes à présent~s~ : \n- ~g~"..label.." ~s~|~b~ "..grade_label.." ~s~|~b~ ~c~["..'~b~'..job_type..'~c~]')
            end
        end
    end
end) 

RegisterServerEvent(_Admin.Prefix.."teleport")
AddEventHandler(_Admin.Prefix.."teleport", function(target, value)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)
	local xPlayerCoord, xTargetCoord = xPlayer.getCoords(), xTarget.getCoords()
    if value == 1 then    
	    xTarget.setCoords(xPlayerCoord)
    elseif value == 2 then
        xTarget.setCoords({x = xPlayerCoord.x, y = xPlayerCoord.y, z = xPlayerCoord.z + 200.0})
    elseif value == 3 then
        xPlayer.setCoords(xTargetCoord)
    end
end)


RegisterServerEvent(_Admin.Prefix.."InventoryItems")
AddEventHandler(_Admin.Prefix.."InventoryItems", function(value, target, itemName, itemLabel, count)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)
	if value == 1 then -- remove target
        xTarget.removeInventoryItem(itemName, count)
        xPlayer.showNotification("~g~"..itemLabel.." ~s~retiré de l'inventaire de ~r~"..xTarget.name)
    elseif value == 2 then -- add target
        xTarget.addInventoryItem(itemName, count)
        xPlayer.showNotification("~g~"..itemLabel.." ~s~ajouté à l'inventaire de ~r~"..xTarget.name)
    elseif value == 3 then -- clear target
        local inventory = xTarget.getInventory()
        for i,v in ipairs (inventory) do
            if v.count > 0 then
                xTarget.setInventoryItem(v.name, 0)
            end
        end
        xPlayer.showNotification("~g~Inventaire de ~r~"..xTarget.name.." ~s~vidé")
    end
end)

RegisterServerEvent(_Admin.Prefix.."Accounts")
AddEventHandler(_Admin.Prefix.."Accounts", function(value, target, accounts, accountsLabel, count)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)
	if value == 1 then -- give target
        xTarget.addAccountMoney(accounts, count)
        xPlayer.showNotification("~g~"..accountsLabel.." ~s~ajouté à l'argent de ~r~"..xTarget.name)
    elseif value == 2 then -- remove target
        xTarget.removeAccountMoney(accounts, count)
        xPlayer.showNotification("~g~"..accountsLabel.." ~s~retiré de l'argent de ~r~"..xTarget.name)
    elseif value == 3 then -- clear target
        xTarget.setAccountMoney(accounts, 0)
        xPlayer.showNotification("~g~"..accountsLabel.." ~s~de ~r~"..xTarget.name.." ~s~vidé")        
    end
end)



-- VEHICULES WIP


local allVehiclesListed = {}

RegisterServerEvent(_Admin.Prefix.."GetAllVehicleSQL")
AddEventHandler(_Admin.Prefix.."GetAllVehicleSQL", function()
    TriggerLatentClientEvent(_Admin.Prefix.."Receive:GetAllVehicleSQL", source, 50000, allVehiclesListed)
end)

if _Admin.Config.esx_vehicleshop then
    CreateThread(function()
        local query = 'SELECT vehicles.name AS `vehicle_label`, vehicles.model AS `vehicle_model`, vehicles.price AS `vehicle_price`, vehicles.category AS `vehicle_category`, vehicle_categories.name, vehicle_categories.label FROM vehicles,vehicle_categories'
        if _Admin.SQLWrapperType == 1 then
            local result = MySQL.Sync.fetchAll(query, {}) -- à voir pour les gens sous mysql-async si ca fonctionne
            if result ~= nil then
                for k,v in pairs(result) do
                    if v.name == v.vehicle_category then
                        allVehiclesListed[#allVehiclesListed+1] = {
                            veh_name = v.vehicle_model,
                            veh_label = v.vehicle_label,
                            veh_price = v.vehicle_price,
                            veh_cat_name = v.vehicle_category,
                            veh_cat_label = v.label,
                        }
                    end
                end
                return allVehiclesListed
            end
        else
            local result = MySQL.query.await(query, {})
            if result ~= nil then
                for k,v in pairs(result) do
                    if v.name == v.vehicle_category then
                        allVehiclesListed[#allVehiclesListed+1] = {
                            veh_name = v.vehicle_model,
                            veh_label = v.vehicle_label,
                            veh_price = v.vehicle_price,
                            veh_cat_name = v.vehicle_category,
                            veh_cat_label = v.label,
                        }
                    end
                end
                return allVehiclesListed
            end
        end   
    end)
end


RegisterServerEvent(_Admin.Prefix.."owned_vehicles")
AddEventHandler(_Admin.Prefix.."owned_vehicles", function(value, plate, target, label, name, properties, stored, price, newtarget)
    local isTarget = false
    local player, xPlayer, newTarget

    if target ~= nil and type(target) == 'number' then
        player = ESX.GetPlayerFromId(target)
        xPlayer = ESX.GetPlayerFromId(source)
        if newtarget ~= nil and type(newtarget == 'number') then newTarget = ESX.GetPlayerFromId(newtarget) end
        isTarget = true
    elseif target == nil then
        player = ESX.GetPlayerFromId(source)
        isTarget = false
    else
        return
    end

    if value == 1 then -- supprimer véhicule
        local query = "DELETE FROM owned_vehicles WHERE plate = ? AND owner = ?"
        if _Admin.SQLWrapperType == 1 then
            MySQL.Async.execute(query, {plate, player.identifier})
        else
            MySQL.update(query, {plate, player.identifier})
        end
        if isTarget then
            player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été ~r~supprimé!', plate))
            xPlayer.showNotification(string.format('Vous avez ~r~supprimé~s~ le véhicule ~o~%s~s~ de ~b~%s~s~!',plate, player.getName()))
        else
            player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été ~r~supprimé!', plate))
        end
    elseif value == 2 then -- store le véhicule
        local query = "UPDATE owned_vehicles SET stored = ? WHERE plate = ?"
        if _Admin.SQLWrapperType == 1 then
            MySQL.Async.execute(query, {stored, plate})
        else
            MySQL.update(query, {stored, plate})
        end
        if isTarget then
            if stored == 1 then
                player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été ~g~rentré~s~ au garage', plate))
                xPlayer.showNotification(string.format('Vous avez ~g~rentré~s~ le véhicule ~o~%s~s~ de ~b~%s~s~ au garage', plate, player.getName()))
            else
                player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été ~r~sorti~s~ au garage', plate))
                xPlayer.showNotification(string.format('Vous avez ~g~sorti~s~ le véhicule ~o~%s~s~ de ~b~%s~s~ au garage', plate, player.getName()))
            end
        else
            if stored then
                player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été ~g~rentré~s~ au garage', plate))
            else
                player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été ~r~sorti~s~ au garage', plate))
            end
        end
    elseif value == 3 then -- vendre véhicule // remboursement
        local query = "DELETE FROM owned_vehicles WHERE plate = ? AND owner = ?"
        if _Admin.SQLWrapperType == 1 then
            MySQL.Async.execute(query, {plate, player.identifier})
            player.addAccountMoney('bank', price)
        else
            MySQL.update(query, {plate, player.identifier})
            player.addAccountMoney('bank', price)
        end
        if isTarget then
            player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été remboursé de ~g~%s'.._Admin.Config.TypeMoney, plate, price))
            xPlayer.showNotification(string.format('Vous avez remboursé le véhicule ~o~%s~s~ de ~b~%s~g~ %s'.._Admin.Config.TypeMoney, plate, player.getName(), price))
        else
            player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été remboursé de ~g~%s'.._Admin.Config.TypeMoney, plate, price))
        end
    elseif value == 4 then -- save properties
        local query = "UPDATE owned_vehicles SET vehicle = ? WHERE plate = ?"
        if _Admin.SQLWrapperType == 1 then
            MySQL.Async.execute(query, {properties, plate})
        else
            MySQL.update(query, {json.encode(properties), plate})
        end
        print(json.encode(properties))
        if isTarget then
            player.showNotification(string.format('La ~c~metadata~s~ de votre véhicule ~o~%s~s~ a été mise à jour!'), plate)
            xPlayer.showNotification(string.format('Vous avez mit à jour la ~c~métadata le véhicule ~o~%s~s~ de ~b~%s', plate, player.getName()))
        else
            player.showNotification(string.format('La ~c~metadata~s~ de votre véhicule ~o~%s~s~ a été mise à jour!'), plate)
        end
    elseif value == 5 then -- add vehicles
        local query = "SELECT `plate` FROM owned_vehicles WHERE plate = ?"
        local insert = "INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (?, ?, ?, ?)"
        local storlab
        if _Admin.SQLWrapperType == 1 then
            MySQL.Async.fetchScalar(query, {plate}, function(result)
                print(result)
                if result == nil then
                    MySQL.Async.execute(insert, {player.identifier, plate, json.encode(properties), stored})
                end
            end)
        else
            MySQL.single(query, {plate}, function(result)
                print(json.encode(result))
                if result == nil then
                    MySQL.insert(insert, {player.identifier, plate, json.encode(properties), stored})
                end
            end)
        end
        if stored == 1 then storlab = '~g~Rentré' else storlab = '~r~Sorti' end
        if isTarget then
            player.showNotification(string.format('Le véhicule ~o~%s~s~ vous a été ~g~donné~s~\nStatus : '..storlab, plate))
            xPlayer.showNotification(string.format('Vous avez donné le véhicule ~o~%s~s~ à ~b~%s~s~\nStatus : '..storlab, plate, player.getName()))
        else
            player.showNotification(string.format('Le véhicule ~o~%s~s~ vous a été ~g~donné~s~\nStatus : '..storlab, plate))
        end
    elseif value == 6 then -- transfer owner of vehicle
        local query = "UPDATE owned_vehicles SET owner = ?, stored = ? WHERE plate = ?"
        local storlab
        if _Admin.SQLWrapperType == 1 then
            MySQL.Async.execute(query, {player.identifier, stored, plate})
        else
            MySQL.update(query, {player.identifier, stored, plate})
        end
        if stored == 1 then storlab = '~g~Rentré' else storlab = '~r~Sorti' end
        if isTarget then
            player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été ~g~donné~s~ à ~b~%s~s~\nStatus : '..storlab, plate, newTarget.getName()))
            newTarget.showNotification(string.format('Vous avez reçu le véhicule ~o~%s~s~ venant de ~b~%s~s~\nStaus : '..storlab, plate, player.getName()))
            xPlayer.showNotification(string.format('Vous avez donné le véhicule ~o~%s~s~ de ~c~%s~s~ à ~b~%s~s~\nStatus : '..storlab, plate, player.getName(), newTarget.getName()))
        else
            player.showNotification(string.format('Votre véhicule ~o~%s~s~ a été ~g~donné~s~ à ~b~%s~s~\nStatus : '..storlab, plate, newTarget.getName()))
            newTarget.showNotification(string.format('Vous avez reçu le véhicule ~o~%s~s~ venant de ~b~%s~s~\nStaus : '..storlab, plate, player.getName()))
        end
    end
end)
