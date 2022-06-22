

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
            if result ~= nil then
                for _,v in pairs(result) do
                    Bans[#Bans+1] = {
                        identifier = result[i].identifier,
                        name = result[i].firstname..' '..result[i].lastname,
                        reason = v.reason,
                        expiration = v.expiration,
                    }
                end
            end
            TriggerClientEvent(_Admin.Prefix.."SendBans", _src, Bans)
        end)
    else
        MySQL.query(query, {}, function(result)
            if result ~= nil then
                for i = 1, #result do
                    Bans[#Bans+1] = {
                        identifier = result[i].identifier,
                        name = result[i].firstname..' '..result[i].lastname,
                        reason = v.reason,
                        expiration = v.expiration,
                    }
                end
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
            if result ~= nil then
                for i = 1, #result do
                    Staff[#Staff+1] = {
                        identifier = result[i].identifier,
                        rank = result[i].rank,
                        name = result[i].firstname..' '..result[i].lastname,
                    }
                end
            end
            TriggerClientEvent(_Admin.Prefix.."SendStaff", _src, Staff)
        end)
    else
        MySQL.query(query, {}, function(result)
            if result ~= nil then
                for i = 1, #result do
                    Staff[#Staff+1] = {
                        identifier = result[i].identifier,
                        rank = result[i].rank,
                        name = result[i].firstname..' '..result[i].lastname,
                    }
                end
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


ESX.RegisterServerCallback(_Admin.Prefix.."GetAdminName", function(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getName())
end)


ESX.RegisterServerCallback(_Admin.Prefix.."GetAllPlayersOnline", function(source,cb)
    local data = {}
    local players = ESX.GetExtendedPlayers()
    for _,v in pairs(players)do
        data[#data+1] = {
            serverId = v.playerId,
            gtaName = GetPlayerName(v.playerId),
            playerName = v.name,
            jobLabel = v.job.label,
            jobGrade = v.job.grade,
            jobGradeLabel = v.job.grade_label,
            jobSalary = v.job.salary,
        }
    end
    cb(data)
end)


if _Admin.Config.DoubleJob == true then
    CreateThread(function()
        while true do
            Wait(3500)
            print("VEUILLEZ REMETTRE Config.DoubleJob SUR FALSE ou 'fbase' SI VOUS UTILISEZ ESX-LEGACY DE FELLOW, ACTUELLEMENT NON DISPONIBLE SUR TRUE")
        end
    end)
elseif _Admin.Config.DoubleJob == 'fbase' or _Admin.Config.DoubleJob == false then
    ESX.RegisterServerCallback(_Admin.Prefix.."GetAllJobsGrades", function(source,cb)
        local query = "SELECT jobs.name AS `job_name`, jobs.label AS `job_label`, job_grades.grade, job_grades.name AS `grade_name`, job_grades.label AS `grade_label`, job_grades.salary AS `salary` FROM jobs,job_grades WHERE jobs.name = job_grades.job_name"
        local data = {}
        local job = {}
        if _Admin.SQLWrapperType == 1 then 
            MySQL.Async.fetchAll(query, {}, function(result)
                if result ~= nil then
                    for k,v in pairs(result)do
                        job[v.job_name] = {}
                        job[v.job_name].label = v.job_label
                        data[#data+1] = {
                            job_grade = v.grade,
                            job_name = v.job_name,
                            grade_name = v.grade_name,
                            grade_label = v.grade_label,
                            salary = v.salary
                        }
                    end
                    for i = 1, #data do
                        if job[data[i].job_name] then
                            table.insert(job[data[i].job_name], {
                                grade_label = data[i].grade_label, job_grade = data[i].job_grade, grade_name = data[i].grade_name, salary = data[i].salary
                            })
                        end
                    end
                    cb(job)
                end
            end)
        else
            MySQL.query(query, {}, function (result)
                if result ~= nil then
                    for k,v in pairs(result)do
                        job[v.job_name] = {}
                        job[v.job_name].label = v.job_label
                        data[#data+1] = {
                            job_grade = v.grade,
                            job_name = v.job_name,
                            grade_name = v.grade_name,
                            grade_label = v.grade_label,
                            salary = v.salary
                        }
                    end
                    for i = 1, #data do
                        if job[data[i].job_name] then
                            table.insert(job[data[i].job_name], {
                                grade_label = data[i].grade_label, job_grade = data[i].job_grade, grade_name = data[i].grade_name, salary = data[i].salary
                            })
                        end
                    end
                    cb(job)
                end
            end)
        end
    end)
--elseif _Admin.Config.DoubleJob == false then
--    ESX.RegisterServerCallback(_Admin.Prefix..'Get:Jobs-Factions', function(source, cb)
--        local data = {}
--        data.jobs = ESX.GetJobs()
--        --if Config.SetFaction then
--        --    data.factions = ESX.GetFactions()
--        --end
--        cb(data)
--    end)
end

ESX.RegisterServerCallback(_Admin.Prefix.."GetInventoryTargetPlayers", function(source, cb, target)
    local xTarget = ESX.GetPlayerFromId(target)
    local getInventory = xTarget.getInventory()
    local data, inventory = {}, {}
    for i,v in ipairs (getInventory) do
        if v.count > 0 then
            inventory[#inventory+1] = {
                name = v.name,
                count = v.count,
                label = v.label,
                type = v.type,
                usable = v.usable,
                rare = v.rare,
                limit = v.limit,
                canremove = v.canremove
            }
        end 
    end
    data.inventory = inventory
    data.weight = xTarget.getWeight()
    data.maxWeight = ESX.GetConfig().MaxWeight

    cb(data)
end)

ESX.RegisterServerCallback(_Admin.Prefix.."GetJobTargetPlayers", function(source, cb, target)
    local xTarget = ESX.GetPlayerFromId(target)
    local GetJob = xTarget.getJob()
    local data = {}
    data.job = GetJob.label
    data.grade = GetJob.grade_label
    cb(data)
end)


ESX.RegisterServerCallback(_Admin.Prefix.."GetAccountsTargetPlayers", function(source, cb, target)
    local xTarget = ESX.GetPlayerFromId(target)
    local GetAcoounts = xTarget.getAccounts()
    cb(GetAcoounts)
end)


-- VEHICLE WIP
ESX.RegisterServerCallback(_Admin.Prefix.."GetAllPlayersVehicle", function(source, cb, target)
    local xTarget = ESX.GetPlayerFromId(target)
    local query = "SELECT * FROM owned_vehicles WHERE owner = ? "
    local vehicle = {}
    if _Admin.SQLWrapperType == 1 then
        MySQL.Async.fetchAll(query, {xTarget.identifier}, function(result)
            if result ~= nil then
                for k,v in pairs(result)do
                    local data = json.decode(v.vehicle)
                    vehicle[v.plate] = {}
                    vehicle[v.plate].stored = v.stored
                    vehicle[v.plate].data = data
                    for k,v2 in pairs(vehicle[v.plate].data) do
                        if k == 'model' then
                            vehicle[v.plate].model = v2
                        end
                    end
                end
                cb(vehicle)
            end
        end)
    else
        MySQL.query(query, {xTarget.identifier}, function(result)
            if result ~= nil then
                for k,v in pairs(result)do
                    local data = json.decode(v.vehicle)
                    vehicle[v.plate] = {}
                    vehicle[v.plate].stored = v.stored
                    vehicle[v.plate].data = data
                    for k,v2 in pairs(vehicle[v.plate].data) do
                        if k == 'model' then
                            vehicle[v.plate].model = v2
                        end
                    end
                end
                cb(vehicle)
            end
        end)
    end
end)
