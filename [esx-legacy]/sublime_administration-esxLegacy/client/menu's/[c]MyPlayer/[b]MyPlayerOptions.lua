local _ = {
    rank = nil;
    aPerms = _Admin.Permissions.Button_myPlayer.inside.MyOptions.inside,
    listSante = {"HP","Shield","Faim","Soif", "Revive"},
    listSanteIndex = 1,
    hunger = nil;
    thirst = nil;
    health = nil;
    shield = nil;
    checkboxGodmode = false;
    checkboxInvisible = false;
    checkboxFastRun = false;
    checkboxSuperJump = false;
    checkboxFastSwim = false;
    checkboxStayInVehicle = false;
    checkboxVisionThermique = false;
    checkboxPlayerName = false
}


function _Admin.Panel:MyPlayerOptions(rank)
    _.rank = rank

    TriggerEvent('esx_status:getStatus', 'hunger', function(status)  _.hunger = status.getPercent() end) 
    TriggerEvent('esx_status:getStatus', 'thirst', function(status) _.thirst = status.getPercent() end)
    _.health = GetEntityHealth(PlayerPedId())
    _.shield = GetPedArmour(PlayerPedId())

    if _Admin:HaveAccess(_.rank, _.aPerms.Health_Management) then 
        RageUI.List("Votre Santé          [~c~S'ajouter~s~] →", _.listSante, _.listSanteIndex, nil, {}, true, { 
            onListChange = function(Index, Item) _.listSanteIndex = Index; end, 
            onSelected = function(Index, Item) 
                if Index == 5 then
                    _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3REVIVE^7")
                    _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] REVIVE")
                    TriggerEvent(_Admin.Prefix.."reviveTargetPlayer") 
                else
                    HealMyPed(Item, _.rank.name)
                end
            end,
            onActive = function()
                RageUI.StatisticPanel(_.health/200, " - ~g~Santé", 1)
                RageUI.StatisticPanel(_.shield/100, " - ~p~Shield", 1) 
                RageUI.StatisticPanel(_.hunger/100, " - ~o~Faim", 1) 
                RageUI.StatisticPanel(_.thirst/100, " - ~b~Soif", 1) 
            end 
        })
    end

    if _Admin:HaveAccess(_.rank, _.aPerms.Godmode) then
        RageUI.Checkbox('Godmode', nil, _.checkboxGodmode, {}, {
            onChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3GOD MODE^7 ACTIVÉ")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] GOD MODE")
                _Admin.addThread[1][1] = true 
                _.checkboxGodmode = true 
            end, 
            onUnChecked = function() 
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3GOD MODE^7 DÉSACTIVÉ")
                _Admin.addThread[1][1] = false 
                SetEntityInvincible(PlayerPedId(), false) 
                _.checkboxGodmode = false 
            end
        })
    end

    if _Admin:HaveAccess(_.rank, _.aPerms.Invisible) then
        RageUI.Checkbox('Invisible', nil, _.checkboxInvisible, {}, { 
            onChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3INVISIBLE^7 ACTIVÉ")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] INVISIBLE")
                _Admin.addThread[2][1] = true
                _.checkboxInvisible = true 
            end, 
            onUnChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3INVISIBLE^7 DÉSACTIVÉ")
                _Admin.addThread[2][1] = false 
                SetEntityVisible(PlayerPedId(), true, 0) 
                _.checkboxInvisible = false 
            end, 
        })
    end
    
    if _Admin:HaveAccess(_.rank, _.aPerms.Fast_Run) then 
        RageUI.Checkbox('Fast run', nil, _.checkboxFastRun, {}, { 
            onChecked = function() 
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3FAST RUN^7 ACTIVÉ")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] FAST RUN")
                _Admin.addThread[3][1] = true
                _.checkboxFastRun = true 
            end, 
            onUnChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3FAST RUN^7 DÉSACTIVÉ")
                _Admin.addThread[3][1] = false 
                SetPedMoveRateOverride(PlayerPedId(), 0.00) 
                _.checkboxFastRun = false 
            end, 
        })
    end

    if _Admin:HaveAccess(_.rank, _.aPerms.Fast_Swim) then
        RageUI.Checkbox('Fast swim', nil, _.checkboxFastSwim, {}, { 
            onChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3FAST SWIM^7 ACTIVÉ")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] FAST SWIM")
                _Admin.addThread[4][1] = true 
                _.checkboxFastSwim = true 
            end, 
            onUnChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3FAST SWIM^7 DÉSACTIVÉ")
                _Admin.addThread[4][1] = false 
                _.checkboxFastSwim = false
            end, 
        })
    end

    if _Admin:HaveAccess(_.rank, _.aPerms.Super_Jump) then
        RageUI.Checkbox('Super jump', nil, _.checkboxSuperJump, {}, {
            onChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3SUPER JUMP^7 ACTIVÉ")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] SUPER JUMP")
                _Admin.addThread[5][1] = true 
                _.checkboxSuperJump = true 
            end, 
            onUnChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3SUPER JUMP^7 DÉSACTIVÉ")
                _Admin.addThread[5][1] = false 
                _.checkboxSuperJump = false 
            end,  
        })
    end


    if _Admin:HaveAccess(_.rank, _.aPerms.StayInVehicle) then
        RageUI.Checkbox('Stay in vehicle', nil, _.checkboxStayInVehicle, {}, {
            onChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3STAY IN VEHICLE^7 ACTIVÉ")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] STAY IN VEHICLE")
                _Admin.addThread[6][1] = true 
                _.checkboxStayInVehicle = true 
            end, 
            onUnChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3STAY IN VEHICLE^7 DÉSACTIVÉ")
                _Admin.addThread[6][1] = false
                SetPedCanRagdoll(PlayerPedId(), true)
                _.checkboxStayInVehicle = false 
            end,
        })
    end


    if _Admin:HaveAccess(_.rank, _.aPerms.Thermal_Vision) then 
        RageUI.Checkbox('Vision Thermique', nil, _.checkboxVisionThermique, {}, {
            onChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3VISION THERMIQUE^7 ACTIVÉ")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] VISION THERMIQUE")
                _Admin.addThread[7][1] = true 
                _.checkboxVisionThermique = true 
            end, 
            onUnChecked = function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3VISION THERMIQUE^7 DÉSACTIVÉ")
                _Admin.addThread[7][1] = false
                SetSeethrough(false)
                _.checkboxVisionThermique = false 
            end,
        })
    end

    if _Admin:HaveAccess(_.rank, _.aPerms.ShowPlayerName) then 
        RageUI.Checkbox('Afficher les noms des joueurs', nil, _.checkboxPlayerName, {}, {
            onChecked = function() 
                _Admin.addThread[8][1] = true 
                _.checkboxPlayerName = true 
            end, 
            onUnChecked = function()
                _Admin.addThread[8][1] = false
                _.checkboxPlayerName = false
                for targetPlayer, gamerTag in pairs(_Admin.addThread[8][3]) do
                    RemoveMpGamerTag(gamerTag) 
                    _Admin.addThread[8][3] = {}
                end 
            end,
        })
    end

    RageUI.Button("SetJob", "S'attribuer un job", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _Admin.Permissions.SetJob), {}, _Admin.Menu.sub_myPlayerOptions1);
    
    RageUI.Button('Éliminer les dommages de sangs', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Clear_Blood), {
        onSelected = function()
            ClearPedBloodDamage(PlayerPedId())
        end
    });


    RageUI.Button('Se suicider', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Suicide), {
        onSelected = function()
            SetEntityHealth(PlayerPedId(), 0)
        end
    });
    

end

function _Admin.Panel:MyPlayerJobs1(Jobs)
    _Admin.jSelected = nil or {}
    for k,v in pairs(Jobs)do
        RageUI.Button(v.label, k, {RightLabel = "~c~→→→"}, true, {
            onSelected = function()
                _Admin.newMenuTitle = v.label
                _Admin.jobName = k
                for k2,v2 in pairs(v)do
                    if k2 == 'grades' then
                        for key, value in pairs(v2) do
                            _Admin.jSelected[#j_Admin.Selected+1] = value
                        end
                    end
                end
            end
        }, _Admin.Menu.sub_myPlayerOptions11);
    end
end

function _Admin.Panel:MyPlayerJobs2(nTitle, jName)
    _Admin.Menu.sub_allPlayers33:SetTitle(nTitle)
    for k,v in pairs(_Admin.jSelected)do
        local description = ("~c~~y~job_name ~s~\t: \t"..jName..'\n~c~~y~job_label ~s~\t: \t'..nTitle..'\n~c~~y~grade ~s~\t\t: \t'..v.grade..'\n~c~~y~grade_label ~s~\t: \t'..v.label..'\n~c~~y~salary ~s~\t\t: \t~g~'..v.salary..'$')
        RageUI.Button(v.label, description, {RightLabel = "~c~→→→"}, true, {
            onSelected = function() -- GetPlayerServerId(localId)
                TriggerServerEvent(_Admin.Prefix.."setJob", 1, nil, _Admin.jobName, v.grade, nTitle, v.label)
            end
        });
    end
end