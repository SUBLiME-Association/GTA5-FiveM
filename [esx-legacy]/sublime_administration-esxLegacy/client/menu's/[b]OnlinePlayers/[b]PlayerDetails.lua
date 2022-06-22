local _ = {
    rank = nil,
    aPerms = _Admin.Permissions.Button_PlayerConnected.inside.SelectPlayer.inside,
    playersId = {},
    foundPlayer = false,
    pointGPS = false,
    listRankIndex = 1,
    listRank = {},
    isShearch = false,
    listAccountIndex = 1,
    listAccount = {'Donnez', 'Retirez', 'Videz'},
    checkboxVeh = false,
    shearchCar = nil,
    findVehicle = nil,
    checkboxPlate = false,
    checkboxStored = false,
}

local refreshCount = 0

function _Admin.Panel:PlayerDetails(rank, serverId, localId, name, jobName, gradeName)
    _.rank = rank
    local _name = tostring(name)
    RageUI.Separator("~c~NOM :~s~ ~h~".._name.."~r~ | ~c~ID :~s~ ~h~"..serverId)
    RageUI.Separator("~c~JOB :~s~ ~h~"..jobName.."~r~ | ~c~GRADE :~s~ ~h~"..gradeName)
    RageUI.Line()

    RageUI.Button("SetJob", "Attribuer un job au joueur", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _Admin.Permissions.SetJob), {}, _Admin.Menu.sub_allPlayers3);

    --RageUI.Button("SetFaction", "Attribuer une faction au joueur", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _Admin.Permissions.SetFaction), {}, sub_allPlayers4);

    RageUI.Button("Goto", "Se téléporter sur le joueur", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Goto), {
        onSelected = function()
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..cache.playerName.."^7] Goto → [^5".._name.."^7]")
            _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] Goto → [".._name.."]")
            TriggerServerEvent(_Admin.Prefix.."teleport", serverId, 3)
        end
    });

    RageUI.Button("Inventory", "Voir l'inventaire du joueur", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Goto), {
        onSelected = function()
            _Admin.GetTargetInventory(serverId)
            refreshCount = 0
            Wait(300)
        end
    }, _Admin.Menu.sub_allplayerInventory);

    RageUI.Button("Accounts", "Voir les comptes du joueur", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Goto), {
        onSelected = function()
            _Admin.GetTargetAccounts(serverId)
            Wait(300)
        end
    }, _Admin.Menu.sub_allplayerAccounts);

    RageUI.Button("Vehicle", "Attribuer/Retirer un véhicule au joueur", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _Admin.Permissions.GiveVehicle), {onSelected = function()
        _Admin.GetVehicleAllPlayers(serverId)
        Wait(400)
        _Admin.GetVehicleAllPlayers(serverId)
    end}, _Admin.Menu.sub_allPlayers5);

    RageUI.Button("Bring", "Téléporter le joueur sur sois même", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Bring), {
        onSelected = function()
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..cache.playerName.."^7] Bring → [^5".._name.."^7]")
            _Admin.SendServerLogs("[^1".._.rank.name.." - "..cache.playerName.."] Bring → [".._name.."]")
            TriggerServerEvent(_Admin.Prefix.."teleport", serverId, 1)
        end
    });

    RageUI.Button("Envoyer un message privé", nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Private_Message), {
        onSelected = function()
            local msg = KI("Message", "", 150)
            if msg ~= nil and msg ~= "" then
                local mugshot, mugshotStr = ESX.Game.GetPedMugshot(cache.playerPedId)
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..cache.playerName.."^7] Message privé → [^5".._name.."^7] Message : ^6"..msg.."^7")
                _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] Message privé → [".._name.."] Message : "..msg)
                TriggerServerEvent(_Admin.Prefix.."sendPrivateNotification", serverId, msg, mugshotStr)
                UnregisterPedheadshot(mugshot)
            end
        end
    });

    if not _.pointGPS then
        RageUI.Button("Point GPS", "Voir le joueur sur le GPS", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.GPS_View), {
            onSelected = function()
                ToggleGPS(GetEntityCoords(GetPlayerPed(localId)), _name)
                _.pointGPS = true
            end
        });
    else 
        RageUI.Button("~r~Retirer Point GPS", nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.GPS_View), {
            onSelected = function()
                DeleteGPS()
                _.pointGPS = false
            end
        });
    end
    
    RageUI.Button("Soigné", nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Heal), {
        onSelected = function()
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..cache.playerName.."^7] Soigné → [^5".._name.."^7]")
            _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] Soigné → [".._name.."]")
            SetEntityHealth((GetPlayerPed(localId)),  GetEntityMaxHealth((GetPlayerPed(localId))))
            ESX.ShowNotification("Vous avez soigné ~g~".._name)
        end
    });

    RageUI.Button("Revive", nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Revive), {
        onSelected = function()
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..cache.playerName.."^7] Revive → [^5".._name.."^7]")
            _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] Revive → [".._name.."]")
            if _Admin.Config.Revive.enable then
                ExecuteCommand(_Admin.Config.Revive.command..serverId) --playerId
            else
                TriggerServerEvent(_Admin.Prefix.."revivePlayer", serverId)
            end
        end
    });

    RageUI.Button("Tuer",  nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Kill), {
        onSelected = function()
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..cache.playerName.."^7] Tuer → [^5".._name.."^7]")
            _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] Tuer → [".._name.."]")
            SetEntityHealth(GetPlayerPed(localId), 0)
            TriggerServerEvent(_Admin.Prefix.."teleport", serverId , 2)

            ESX.ShowNotification("Vous avez tuer ~g~".._name)
        end
    });

    RageUI.Button("~r~Kick",  nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Kick), {
        onSelected = function()
            local kickreason = KI("Kick raison", "", 150)
            if kickreason ~= nil and kickreason ~= "" then
                _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] Kick → [".._name.."] Raison : "..kickreason)
                TriggerServerEvent(_Admin.Prefix.."kickPlayer", _.rank, serverId, kickreason)
            end
        end
    });

    RageUI.Button("~r~Bannir ".._name,  nil, {RightLabel = "~r~~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Ban), {
        onSelected = function()
            local banTime = KI("Combien de ~r~JOUR~s~ de Ban ?", "", 150)
            banTime = tonumber(banTime)
            if type(banTime) == 'number' then
                banTime = ESX.Math.Round(banTime) 
                if banTime > 0 and banTime < 365 then
                    local banReason = KI("Ban raison", "", 150)
                    if banReason ~= nil and banReason ~= "" then
                        TriggerServerEvent(_Admin.Prefix.."banPlayer", _.rank, _name, serverId, banTime, banReason)
                        _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] Ban → [".._name.."] Raison : "..banReason.." pour "..banTime.." jour")
                    end
                else
                    ESX.ShowNotification("~r~Quantité invalide")
                end
            else
                ESX.ShowNotification("~r~Quantité invalide")
            end 
        end
    });
    
    RageUI.Line()

    RageUI.Button("~b~Ajouté des permission au joueur",  nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.AddPermissions), {
        onSelected = function()
            local rankNumber = KI("RANK NUMBER", "", 150)
            rankNumber = tonumber(rankNumber)
            if type(rankNumber) == 'number' then
                rankNumber = ESX.Math.Round(rankNumber)
                for k,v in pairs(_Admin.Ranks) do 
                    if v.grade == rankNumber then
                        _Admin.Print("[^1".._.rank.name.." ^7- ^2"..cache.playerName.."^7] Ajouter des permissions → [^5".._name.."^7] Rank Grade : ^6"..rankNumber.."^7")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] Ajouter des permissions → [".._name.."] Rank Grade : "..rankNumber)
                        TriggerServerEvent(_Admin.Prefix.."SetAdminPermissions", _.rank, serverId, rankNumber)
                    end
                end
            else
                ESX.ShowNotification("~r~Quantité invalide")
            end 
        end
    });
end

-- Jobs

_Admin.jSelected = {}
function _Admin.Panel:PlayerDetailsJobs1(Jobs) -- LIST JOB
    _Admin.jSelected = nil or {}
    for k,v in pairs(Jobs)do
        RageUI.Button(v.label,nil, {RightLabel = "~c~→→→"}, true, {
            onSelected = function()
                _Admin.newMenuTitle = v.label
                _Admin.jobName = k
                _Admin.jSelected = v
            end
        }, _Admin.Menu.sub_allPlayers33);
    end
end

function _Admin.Panel:PlayerDetailsJobs2(rank, nTitle, jName, serverId, localId, name) -- IN JOB
    _.rank = rank
    local _name = tostring(name)
    _Admin.Menu.sub_allPlayers33:SetTitle(nTitle)
    for k,v in pairs(_Admin.jSelected)do
        if v.grade_label == nil then else
            local description = ("~c~~y~job_name ~s~\t: \t"..jName..'\n~c~~y~job_label ~s~\t: \t'..nTitle..'\n~c~~y~grade ~s~\t\t: \t'..v.job_grade..'\n~c~~y~grade_label ~s~\t: \t'..v.grade_label..'\n~c~~y~salary ~s~\t\t: \t~g~'..v.salary..'$')
            RageUI.Button(v.grade_label, description, {RightLabel = "~c~→→→"}, true, {
                onSelected = function() -- serverId
                    if _Admin.Config.DoubleJob == 'fbase' then
                        local wut = KI("Ecrivez : job / job2", "", 25)
                        if wut ~= nil and type(wut) == "string" then
                            if wut == 'job' then
                                _Admin.Print("[".._.rank.name.." - "..cache.playerName.."] SetJob -> [".._name.." - "..jName.." | "..v.grade_label.."]")
                                _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] SetJob -> [".._name.." - "..jName.." | "..v.grade_label.."]")
                                ESX.ShowNotification("Vous avez ~y~setJob~s~ : \n- ~c~".._name.."\n~s~- ~g~"..nTitle.." ~s~|~b~ "..v.grade_label)
                            elseif wut == 'job2' then
                                _Admin.Print("[".._.rank.name.." - "..cache.playerName.."] SetJob2 -> [".._name.." - "..jName.." | "..v.grade_label.."]")
                                _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] SetJob2 -> [".._name.." - "..jName.." | "..v.grade_label.."]")
                                ESX.ShowNotification("Vous avez ~y~setJob2~s~ : \n- ~c~".._name.."\n~s~- ~g~"..nTitle.." ~s~|~b~ "..v.grade_label)
                            end
                            TriggerServerEvent(_Admin.Prefix.."setJob", 2, serverId, jName, v.job_grade, nTitle, v.grade_label, tostring(wut))
                            Wait(250)
                            _Admin.GetTargetJob(serverId) 
                        end
                    elseif _Admin.Config.DoubleJob == false then
                        _Admin.Print("[".._.rank.name.." - "..cache.playerName.."] SetJob -> [".._name.." - "..jName.." | "..v.grade_label.."]")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] SetJob -> [".._name.." - "..jName.." | "..v.grade_label.."]")
                        ESX.ShowNotification("Vous avez ~y~setJob~s~ : \n- ~c~".._name.."\n~s~- ~g~"..nTitle.." ~s~|~b~ "..v.grade_label)
                        TriggerServerEvent(_Admin.Prefix.."setJob", 2, serverId, jName, v.job_grade, nTitle, v.grade_label)
                        Wait(250)
                        _Admin.GetTargetJob(serverId)   
                    end
                end
            });
        end
    end
end

-- Inventory

function _Admin.Panel:TargetInventory(targetInventory, serverId, weight, maxWeight) -- INVENTORY
    local subtitle
    if weight > 0 then subtitle = '~c~Poids ~s~: '..weight..'~s~/~o~'..maxWeight..'~s~'.._Admin.Config.TypeWeight else subtitle = '~c~Poids ~s~: ~r~'..weight..'~s~/~o~'..maxWeight..'~s~'.._Admin.Config.TypeWeight end
    _Admin.Menu.sub_allplayerInventory:SetSubtitle(subtitle)
    if #targetInventory > 0 then
        for i,v in ipairs(targetInventory) do
            RageUI.Button(v.label,'Supprimez un item en selectionnant sa quantité', {RightLabel = "~c~x~s~"..v.count}, true, {
                onSelected = function()
                    local qty = KI("Quantité à ~g~s'ajouter~s~", "", 15)
                    qty = tonumber(qty)
                    if type(qty) == 'number' then
                        qty = ESX.Math.Round(qty)
                        TriggerServerEvent(_Admin.Prefix.."InventoryItems", 1, serverId, v.name, v.label, qty)
                        Wait(100)
                        _Admin.GetTargetInventory(serverId)
                        Wait(300)
                    else
                        ESX.ShowNotification("~r~Quantité invalide")
                    end
                end
            });
        end
        RageUI.Line()
        RageUI.Button('~r~ClearInventory', '~r~Attentions cette action est irréversible', {RightBadge = RageUI.BadgeStyle.Alert},  true, {onSelected = function()
            TriggerServerEvent(_Admin.Prefix.."InventoryItems", 3, serverId)
            Wait(100)
            refreshCount = 5
            _Admin.GetTargetInventory(serverId)
            Wait(300)
        end});
    elseif #targetInventory == 0 and refreshCount < 5 then
        refreshCount += 1
        _Admin.GetTargetInventory(serverId)
    end
    RageUI.Line()
    if _.isShearch then
        RageUI.Button('~r~Annulez', nil, {},  true, {onSelected = function()
            _.isShearch = false
            _.shearchItem = nil
        end});
        RageUI.Line()
    end
    if not _.isShearch then
        RageUI.Button('Rechercher un item ', nil, {RightLabel = "~c~→→→"},  true, {onSelected = function()
            _.shearchItem = KI("Rechercher un item : ", "", 25)
            if _.shearchItem ~= nil then
                _.shearchItem = string.lower(_.shearchItem):gsub("^%l", string.upper)
                _.isShearch = true
            else
                _.isShearch = false
            end
        end});
        for k,v in pairs(_Admin.ItemsList) do
            RageUI.Button(v.label, "Label = ~y~"..v.label.."~s~\nName = ~o~"..v.name.."~s~\nWeight = ~r~"..v.weight, {RightLabel = "~c~→"}, true, { 
                onSelected = function() 
                    local qty = KI("Quantité à ~g~s'ajouter~s~", "", 15)
                    qty = tonumber(qty)
                    if type(qty) == 'number' then
                        qty = ESX.Math.Round(qty)
                        TriggerServerEvent(_Admin.Prefix.."InventoryItems", 2, serverId, v.name, v.label, qty)
                        Wait(100)
                        refreshCount = 0
                        _Admin.GetTargetInventory(serverId)
                        Wait(300)
                    else
                        ESX.ShowNotification("~r~Quantité invalide")
                    end 
                end 
            });
        end
    else
        for k,v in pairs(_Admin.ItemsList) do
            local FindItems = string.find(v.label, tostring((_.shearchItem):gsub("^%l", string.upper)))
            if FindItems then
                RageUI.Button(v.label, "Label : ~y~"..v.label.."~s~\nName : ~o~"..v.name.."~s~\nWeight : #~r~"..v.weight, {RightLabel = "~c~→"}, true, { 
                    onSelected = function() 
                        local qty = KI("Quantité à ~g~s'ajouter~s~", "", 15)
                        qty = tonumber(qty)
                        if type(qty) == 'number' then
                            qty = ESX.Math.Round(qty)
                            TriggerServerEvent(_Admin.Prefix.."InventoryItems", 2, serverId, v.name, v.label, qty)
                            Wait(100)
                            refreshCount = 0
                            _Admin.GetTargetInventory(serverId)
                            Wait(300)
                        else
                            ESX.ShowNotification("~r~Quantité invalide")
                        end 
                    end 
                });
            end
        end
    end
end

-- Accounts

function _Admin.Panel:TargetAccounts(targetAccounts, serverId)
    local description
    for i,v in ipairs(targetAccounts) do
        if v.name == 'bank' then
            description = '~c~Solde~s~ : ~b~'..v.money.._Admin.Config.TypeMoney
        elseif v.name == 'money' then
            description = '~c~Solde~s~ : ~g~'..v.money.._Admin.Config.TypeMoney
        elseif v.name == 'black_money' then
            description = '~c~Solde~s~ : ~r~'..v.money.._Admin.Config.TypeMoney
        else
            description = '~c~Solde~s~ : ~o~'..v.money.._Admin.Config.TypeMoney
        end
        RageUI.List(v.label, _.listAccount, _.listAccountIndex, description, {}, true, {
            onListChange = function(index)
                _.listAccountIndex = index
            end,
            onSelected = function(index, item)
                if index == 1 then -- give
                    local qty = KI("Quantité à ~g~s'ajouter~s~", "", 15)
                    qty = tonumber(qty)
                    if type(qty) == 'number' then
                        qty = ESX.Math.Round(qty)
                        TriggerServerEvent(_Admin.Prefix.."Accounts", 1, serverId, v.name, v.label, qty)
                        Wait(100)
                        _Admin.GetTargetAccounts(serverId)
                        Wait(300)
                    else
                        ESX.ShowNotification("~r~Quantité invalide")
                    end
                elseif index == 2 then -- remove
                    local qty = KI("Quantité à ~r~retirer~s~", "", 15)
                    qty = tonumber(qty)
                    if type(qty) == 'number' then
                        qty = ESX.Math.Round(qty)
                        TriggerServerEvent(_Admin.Prefix.."Accounts", 2, serverId, v.name, v.label, qty)
                        Wait(100)
                        _Admin.GetTargetAccounts(serverId)
                        Wait(300)
                    else
                        ESX.ShowNotification("~r~Quantité invalide")
                    end                    
                elseif index == 3 then -- clear
                    TriggerServerEvent(_Admin.Prefix.."Accounts", 3, serverId, v.name, v.label)
                end
            end
        });
    end
end


-- Vehicle

_Admin.VehLabel = ''
_Admin.VehPlate = ''
_Admin.VehCategory = ''
_Admin.VehPrice = 0
_Admin.VehName = ''
_Admin.VehData = {}
_Admin.VehStored = ''
_Admin.TargetListVehicle = ''
local plateSelected = nil
local vehList = _Admin.GetVehicleSQL
function _Admin.Panel:PlayerDetailsVehicle1(rank, vehicleList)
    plateSelected = plateSelected
    if vehicleList ~= nil then
        RageUI.Separator("↓ VEHICULES POSSEDER ↓")
        for i = 1, #_Admin.GetVehicleSQL do
            for k,v in pairs(vehicleList)do
                if GetHashKey(_Admin.GetVehicleSQL[i].veh_name) == tonumber(v.model) then
                    RageUI.Button(k..' - '.._Admin.GetVehicleSQL[i].veh_label,_Admin.GetVehicleSQL[i].veh_cat_label, {RightLabel = "~c~→→→"}, true, {
                        onSelected = function()
                            if v.stored then _Admin.VehStored = 'Rentrée' else _Admin.VehStored = 'Sorti' end
                            _Admin.VehPlate = k
                            _Admin.VehData = v.data
                            _Admin.VehLabel = _Admin.GetVehicleSQL[i].veh_label
                            _Admin.VehName = _Admin.GetVehicleSQL[i].veh_name
                            _Admin.VehCategory = _Admin.GetVehicleSQL[i].veh_cat_label
                            _Admin.VehPrice = _Admin.GetVehicleSQL[i].veh_price
                        end
                    }, _Admin.Menu.sub_allPlayers55);
                end
            end
        end
    else
        RageUI.Separator("~r~AUCUN VEHICULE POSSEDER")
        if refreshCount < 5 then
            refreshCount += 1
            _Admin.GetVehicleAllPlayers(_Admin.TargetId)
        end
    end
    RageUI.Line()
    RageUI.Checkbox('Stored', nil, _.checkboxStored, {}, { onSelected = function(Index) _.checkboxStored = Index end});
    RageUI.Checkbox('Plaque aléatoire', nil, _.checkboxPlate, {}, {
        onChecked = function()							
           plateSelected = exports['esx_vehicleshop']:GeneratePlate() 
        end,
        onUnChecked = function()
            plateSelected = nil
        end, onSelected = function(Index) _.checkboxPlate = Index end
    });	
    if not _.checkboxPlate then --8
        RageUI.Button('Plaque personnaliser', nil, {RightLabel = ""}, true, {
            onSelected = function()
                local newPlate = KI("Personnalisez votre plaque ou écrire remove pour remettre a 0", "", 8)
                if newPlate ~= nil and newPlate ~= ' ' then
                    plateSelected = newPlate
                end
                if newPlate == 'remove' then
                    plateSelected = nil
                end
            end
        });
    end
    if (plateSelected ~= nil) then
        RageUI.Button('Donnez le véhicule', 'Donnez le véhicule au joueur (il faut etre dedans)', {RightLabel = plateSelected, RightBadge = RageUI.BadgeStyle.Tick}, true, {
            onSelected = function()
                ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()), {
                    plate = plateSelected
                })
                Wait(200)
                local properties = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
                TriggerServerEvent(_Admin.Prefix.."owned_vehicles", 5, plateSelected, _Admin.TargetId, GetEntityArchetypeName(GetVehiclePedIsIn(PlayerPedId())), GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), properties, _.checkboxStored)
                Wait(200)
                _Admin.GetVehicleAllPlayers(_Admin.TargetId)
            end
        });
    end
    RageUI.Line()
    if _.shearchCar ~= nil then
        RageUI.Button('~r~Annuler la recherche', nil, {RightLabel = "~c~→→→"}, true, {
            onSelected = function()
                _.shearchCar = nil
            end
        });
        for k,v in ipairs(_Admin.GetVehicleSQL) do
            _.findVehicle = string.find(v.veh_name or v.veh_label, tostring((_.shearchCar):gsub("^%l", string.upper)))
            if _.findVehicle then
                RageUI.Button(v.veh_label, string.upper(v.veh_cat_label), {RightLabel = "~c~→→→"}, true, {
                    onSelected = function()
                        _Admin.Print("[^1"..rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Spawn véhicule → [^6"..v.veh_label.."^7]")
                        _Admin.SendServerLogs("["..rank.name.." - "..GetPlayerName(PlayerId()).."] Spawn véhicule → "..v.veh_label)
                        ESX.Game.SpawnVehicle(v.veh_name, vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z), 100.0, function(vehicle)
                            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        end)
                    end
                })
            end
        end
    else
        RageUI.Button('~y~Rechercher un véhicule', nil, {RightLabel = "~c~→→→"}, true, {
            onSelected = function()
                local vehicle = KI("Rechercher un véhicule", "", 25)
                if vehicle ~= nil and vehicle ~= " " then
                    _.shearchCar = vehicle
                end
            end
        });
        for k, v in ipairs(_Admin.GetVehicleSQL) do 
            RageUI.Button(v.veh_cat_label, v.veh_cat_name, {RightLabel = "~c~→→→"}, true, {
                onSelected = function()
                    print(v.veh_cat_name)
                    _Admin.TargetListVehicle = v.veh_cat_name
                end
            }, _Admin.Menu.sub_allPlayers51);
        end
    end
end

function _Admin.Panel:PlayerDetailsListVehicles(rank, category)
    for i,v in ipairs(_Admin.GetVehicleSQL) do
        if v.veh_cat_name == category then
            local d = '~y~Hash~s~ \t: ~r~[~s~'..`v.veh_name`..'~r~]~s~\n~y~Name~s~ \t: '..v.veh_name..'~s~\n~y~Label~s~ \t: '..v.veh_label..'~s~\n~y~Prix~s~ \t\t: '..v.veh_price..'~g~$~s~\n~y~Catégorie~s~ : '..v.veh_cat_label
            RageUI.Button(v.veh_label, d, {RightLabel = "~c~→→→"}, true, {
                onSelected = function()
                    _Admin.Print("[^1"..rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Spawn véhicule → [^6"..v.veh_label.."^7]")
                    _Admin.SendServerLogs("["..rank.name.." - "..GetPlayerName(PlayerId()).."] Spawn véhicule → "..v.veh_label)
                    ESX.Game.SpawnVehicle(v.veh_name, vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z), 100.0, function(vehicle)
                        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    end)
                end
            })
        end
    end
end


function _Admin.Panel:PlayerDetailsVehicle2(rank, plate, stored, data, label, name, cat, price)
    _Admin.Menu.sub_allPlayers55:SetTitle('~c~[~s~'..plate..'~c~]~s~')
    
    local d = '~y~Hash~s~ \t: ~r~[~s~'..`name`..'~r~]~s~\n~y~Name~s~ \t: '..name..'~s~\n~y~Label~s~ \t: '..label..'~s~\n~y~Stored~s~ \t: '..stored..'~s~\n~y~Prix~s~ \t\t: '..price..'~g~$~s~\n~y~Catégorie~s~ : '..cat
    local dData = ''
    local GetOwnerPlateVehiclePedIsIn = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
    --print(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)))
    if _.checkboxVeh then dData = json.encode(data) else dData = d end
    --RageUI.Checkbox('Voir/Cacher metadata', dData, _.checkboxVeh, {}, {onSelected = function(Index) _.checkboxVeh = Index end});
    RageUI.Button('Print metadata', d, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
        onSelected = function()
            print(json.encode(data))
        end
    });
    RageUI.Line()
    RageUI.Button('Spawn le véhicule', d, {RightBadge = RageUI.BadgeStyle.Car}, true, {
        onSelected = function()
            ESX.Game.SpawnVehicle(name, vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z), 100.0, function(vehicle)
                SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
            end)
            Wait(200)
            ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false), data)    
        end
    });
    --RageUI.Button('GetProperty', d, {RightLabel = ""}, true, {
    --    onSelected = function()
    --        newd = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()))
    --    end
    --});
    RageUI.Button('Rentrez/Sortir le véhicule', d, {RightBadge = RageUI.BadgeStyle.Car}, true, {
        onSelected = function()
            if stored == 'Sorti' then
                TriggerServerEvent(_Admin.Prefix.."owned_vehicles", 2, plate, _Admin.TargetId, label, name, nil, 1)
                Wait(200)
                _Admin.VehStored = 'Rentrée'
            else
                TriggerServerEvent(_Admin.Prefix.."owned_vehicles", 2, plate, _Admin.TargetId, label, name, nil, 0)
                Wait(200)
                _Admin.VehStored = 'Sorti'
            end
        end
    });
    if GetOwnerPlateVehiclePedIsIn then
        --print(GetOwnerPlateVehiclePedIsIn, plate)
        RageUI.Button('Sauvegardez le véhicule', d, {RightBadge = RageUI.BadgeStyle.Card}, _Admin.GetOwnerVehiclePedIsInPlate(GetOwnerPlateVehiclePedIsIn, plate) , {
            onSelected = function()
                local properties = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
                TriggerServerEvent(_Admin.Prefix.."owned_vehicles", 4, plate, _Admin.TargetId, label, name, properties)
            end
        });
    end
    RageUI.Line()
    RageUI.Button('Transferez le véhicule', '~r~ATTENTION! ~y~Vous allez changez le propriétaire du véhicule!', {RightBadge = RageUI.BadgeStyle.Alert}, true, {}, _Admin.Menu.sub_allPlayers555);
    RageUI.Button('Vendre le véhicule', '~r~ATTENTION! ~y~Vous allez supprimez le véhicule en base de donnée!\n~g~Le joueur sera remboursé.', {RightBadge = RageUI.BadgeStyle.Alert}, true, {
        onSelected = function()
            TriggerServerEvent(_Admin.Prefix.."owned_vehicles", 3, plate, _Admin.TargetId, label, name, nil, nil, price)
            _Admin.GetVehicleAllPlayers(_Admin.TargetId)
            Wait(200)
            RageUI.GoBack()
            _Admin.GetVehicleAllPlayers(_Admin.TargetId)
        end
    });
    RageUI.Button('Supprimez le véhicule', '~r~ATTENTION! ~y~Vous allez supprimez le véhicule en base de donnée!', {RightBadge = RageUI.BadgeStyle.Alert}, true, {
        onSelected = function()
            TriggerServerEvent(_Admin.Prefix.."owned_vehicles", 1, plate, _Admin.TargetId, label, name)
            _Admin.GetVehicleAllPlayers(_Admin.TargetId)
            Wait(200)
            RageUI.GoBack()
            _Admin.GetVehicleAllPlayers(_Admin.TargetId)
        end
    });
    --RageUI.Line()
end