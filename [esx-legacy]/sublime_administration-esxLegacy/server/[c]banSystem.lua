
RegisterNetEvent(_Admin.Prefix.."banPlayer")
AddEventHandler(_Admin.Prefix.."banPlayer", function(rank, targetName, target, time, reason)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if rank.grade == "Owner" then
        local checkPerms = _Admin.CheckOwnerPermissions(xPlayer)
        if checkPerms then
            InsertBanSql(_src,targetName, target, reason, time)
            DropPlayer(target, reason)
        end
    else
        local checkPerms, result = _Admin.CheckStaffPermissions(xPlayer)
        if checkPerms then
            InsertBanSql(_src, targetName, target, reason, time)
            DropPlayer(target, reason)
        end
    end
end)




function InsertBanSql(_src,targetName, target, reason, time)
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xTarget = ESX.GetPlayerFromId(target)
    local expiration = time * 86400

    if expiration < os.time() then
        expiration = os.time() + expiration
    end
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.execute("INSERT INTO `sublime_bans` (identifier, reason, expiration) VALUES (@identifier, @reason, @expiration)", {
            ["@identifier"] = xTarget.identifier,
            ["@reason"] = reason,
            ["@expiration"] = expiration,
        }, function()
            _Admin.Send_Logs("BAN", "Player : "..targetName.." à été BAN par "..xPlayer.getName().." Pendant : "..time.." Heure - Raison : "..reason)
            _Admin.Print("Player : ^1"..targetName.."^7 à été ^1BAN^7 par ^2"..xPlayer.getName().."^7 Pendant : "..time.." Heure - Raison : "..reason)
        end)
    else
        MySQL.insert('INSERT INTO sublime_bans (identifier, reason, expiration) VALUES (?, ?, ?) ', {xTarget.identifier, reason, expiration}, function()
            _Admin.Send_Logs("BAN", "Player : "..targetName.." à été BAN par "..xPlayer.getName().." Pendant : "..time.." Heure - Raison : "..reason)
            _Admin.Print("Player : ^1"..targetName.."^7 à été ^1BAN^7 par ^2"..xPlayer.getName().."^7 Pendant : "..time.." Heure - Raison : "..reason)
        end)
    end
end




function RemoveBannedPlayer(identifier)
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.execute("DELETE FROM `sublime_bans` WHERE identifier = @identifier", {
            ["@identifier"] = identifier
        }, function()
        end)
    else
        MySQL.update('DELETE FROM sublime_permissions WHERE identifier = ?', {identifier}, function() end)
    end
end




RegisterServerEvent(_Admin.Prefix.."DebanPlayer")
AddEventHandler(_Admin.Prefix.."DebanPlayer", function(identifier)
    RemoveBannedPlayer(identifier)
end)




AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	local _src = source
    local identifier = ESX.GetIdentifier(_src)

	deferrals.defer()

	deferrals.update("Vérifications de vos permissions")

	Citizen.Wait(100)
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.fetchAll("SELECT * FROM `sublime_bans` WHERE identifier = @identifier", {
            ["@identifier"] = identifier
        }, function(result)
            if result[1] ~= nil then 
                if (tonumber(result[1].expiration)) > os.time() then
                    local tempsrestant     = (((tonumber(result[1].expiration)) - os.time())/60)
                    if tempsrestant >= 1440 then
                        local day        = (tempsrestant / 60) / 24
                        local hrs        = (day - math.floor(day)) * 24
                        local minutes    = (hrs - math.floor(hrs)) * 60
                        local txtday     = math.floor(day)
                        local txthrs     = math.floor(hrs)
                        local txtminutes = math.ceil(minutes)
                            deferrals.done("Vous êtes banni du serveur | Raison : "..tostring(result[1].reason).." | Temps restant : "..txtday .. " Jour " ..txthrs .. " Heure " ..txtminutes .. " Minutes")
                    elseif tempsrestant >= 60 and tempsrestant < 1440 then
                        local day        = (tempsrestant / 60) / 24
                        local hrs        = tempsrestant / 60
                        local minutes    = (hrs - math.floor(hrs)) * 60
                        local txtday     = math.floor(day)
                        local txthrs     = math.floor(hrs)
                        local txtminutes = math.ceil(minutes)
                            deferrals.done("Vous êtes banni du serveur | Raison : "..tostring(result[1].reason).." | Temps restant : "..txtday .. " Jour " ..txthrs .. " Heure " ..txtminutes .. " Minutes")
                    elseif tempsrestant < 60 then
                        local txtminutes = math.ceil(tempsrestant)
                            deferrals.done("Vous êtes banni du serveur | Raison : "..tostring(result[1].reason).." | Temps restant : " ..txtminutes .. " Minutes")
                    elseif tempsrestant == 0 then
                        RemoveBannedPlayer(identifier)
                            deferrals.done()
                    end
                elseif (tonumber(result[1].expiration)) < os.time() then
                    RemoveBannedPlayer(identifier)
                    deferrals.done()
                end
            else
                deferrals.done()
            end
        end)
    else
        MySQL.query('SELECT * FROM sublime_bans WHERE identifier = ?', {identifier}, function(result)
            if result[1] ~= nil then
                if (tonumber(result[1].expiration)) > os.time() then
                    local tempsrestant     = (((tonumber(result[1].expiration)) - os.time())/60)
                    if tempsrestant >= 1440 then
                        local day        = (tempsrestant / 60) / 24
                        local hrs        = (day - math.floor(day)) * 24
                        local minutes    = (hrs - math.floor(hrs)) * 60
                        local txtday     = math.floor(day)
                        local txthrs     = math.floor(hrs)
                        local txtminutes = math.ceil(minutes)
                            deferrals.done("Vous êtes banni du serveur | Raison : "..tostring(result[1].reason).." | Temps restant : "..txtday .. " Jour " ..txthrs .. " Heure " ..txtminutes .. " Minutes")
                    elseif tempsrestant >= 60 and tempsrestant < 1440 then
                        local day        = (tempsrestant / 60) / 24
                        local hrs        = tempsrestant / 60
                        local minutes    = (hrs - math.floor(hrs)) * 60
                        local txtday     = math.floor(day)
                        local txthrs     = math.floor(hrs)
                        local txtminutes = math.ceil(minutes)
                            deferrals.done("Vous êtes banni du serveur | Raison : "..tostring(result[1].reason).." | Temps restant : "..txtday .. " Jour " ..txthrs .. " Heure " ..txtminutes .. " Minutes")
                    elseif tempsrestant < 60 then
                        local txtminutes = math.ceil(tempsrestant)
                            deferrals.done("Vous êtes banni du serveur | Raison : "..tostring(result[1].reason).." | Temps restant : " ..txtminutes .. " Minutes")
                    elseif tempsrestant == 0 then
                        RemoveBannedPlayer(identifier)
                            deferrals.done()
                    end
                elseif (tonumber(result[1].expiration)) < os.time() then
                    RemoveBannedPlayer(identifier)
                    deferrals.done()
                end
            else
                deferrals.done()
            end
        end)
    end
end)
