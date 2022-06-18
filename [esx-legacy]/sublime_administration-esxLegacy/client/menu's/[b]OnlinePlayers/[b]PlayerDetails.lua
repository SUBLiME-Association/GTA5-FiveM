local _ = {
    rank = nil,
    aPerms = _Admin.Permissions.Button_PlayerConnected.inside.SelectPlayer.inside,
    playersId = {},
    foundPlayer = false,
    pointGPS = false,
    listRankIndex = 1,
    listRank = {},

}



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
_Admin.jSelected = {}
function _Admin.Panel:PlayerDetailsJobs1(Jobs)
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

function _Admin.Panel:PlayerDetailsJobs2(rank, nTitle, jName, serverId, localId, name)
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
                        end
                    elseif _Admin.Config.DoubleJob == false then
                        _Admin.Print("[".._.rank.name.." - "..cache.playerName.."] SetJob -> [".._name.." - "..jName.." | "..v.grade_label.."]")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..cache.playerName.."] SetJob -> [".._name.." - "..jName.." | "..v.grade_label.."]")
                        ESX.ShowNotification("Vous avez ~y~setJob~s~ : \n- ~c~".._name.."\n~s~- ~g~"..nTitle.." ~s~|~b~ "..v.grade_label)
                        TriggerServerEvent(_Admin.Prefix.."setJob", 2, serverId, jName, v.job_grade, nTitle, v.grade_label)   
                    end
                end
            });
        end
    end
end