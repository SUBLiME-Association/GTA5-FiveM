
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

RegisterServerEvent(_Admin.Prefix.."bring")
AddEventHandler(_Admin.Prefix.."bring", function(target, value)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)
	local xPlayerCoord = xPlayer.getCoords()
    if value == 1 then    
	    xTarget.setCoords(xPlayerCoord)
    elseif value == 2 then
        xTarget.setCoords({x = xPlayerCoord.x, y = xPlayerCoord.y, z = xPlayerCoord.z + 200.0})
    end
end)
