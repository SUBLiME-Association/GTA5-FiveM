local _ = {
    rank = nil,
    aPerms = _Admin.Permissions.Button_PlayerConnected.inside.SelectPlayer.inside,
    playersId = {},
    foundPlayer = false,
    pointGPS = false,
    listRankIndex = 1,
    listRank = {},

}



function _Admin.Panel:PlayerDetails(rank, player)
    _.rank = rank
    player = tonumber(player)
    _Admin.Menu.sub_allPlayers2:SetTitle(GetPlayerName(player))
    RageUI.Separator("~c~NOM :~s~ ~h~"..GetPlayerName(player))
    RageUI.Separator("~c~ID :~s~ ~h~"..GetPlayerServerId(player))
    RageUI.Line()

    RageUI.Button("Goto", "Se téléporter sur le joueur", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Goto), {
        onSelected = function()
            local targetCoords = GetEntityCoords(GetPlayerPed(player))
            Citizen.CreateThread(function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Goto → [^5"..GetPlayerName(player).."^7]")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Goto → ["..GetPlayerName(player).."]")
                ESX.Game.Teleport(PlayerPedId(), targetCoords)
            end)
        end
    });

    RageUI.Button("Bring", "Téléporter le joueur sur sois même", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Bring), {
        onSelected = function()
            local myCoords = GetEntityCoords(PlayerPedId())
            Citizen.CreateThread(function()
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Bring → [^5"..GetPlayerName(player).."^7]")
                _Admin.SendServerLogs("[^1".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Bring → ["..GetPlayerName(player).."]")
                ESX.Game.Teleport(GetPlayerPed(player), myCoords)
            end)
        end
    });

    RageUI.Button("Envoyer un message privé", nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Private_Message), {
        onSelected = function()
            local msg = KI("Message", "", 150)
            if msg ~= nil and msg ~= "" then
                local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Message privé → [^5"..GetPlayerName(player).."^7] Message : ^6"..msg.."^7")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Message privé → ["..GetPlayerName(player).."] Message : "..msg)
                TriggerServerEvent(_Admin.Prefix.."sendPrivateNotification", GetPlayerServerId(player), msg, mugshotStr)
                UnregisterPedheadshot(mugshot)
            end
        end
    });

    if not _.pointGPS then
        RageUI.Button("Point GPS", "Voir le joueur sur le GPS", {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.GPS_View), {
            onSelected = function()
                ToggleGPS(GetEntityCoords(GetPlayerPed(player)), GetPlayerName(player))
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
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Soigné → [^5"..GetPlayerName(player).."^7]")
            _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Soigné → ["..GetPlayerName(player).."]")
            SetEntityHealth((GetPlayerPed(player)),  GetEntityMaxHealth((GetPlayerPed(player))))
            ESX.ShowNotification("Vous avez soigné ~g~"..GetPlayerName(player))
        end
    });

    RageUI.Button("Revive", nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Revive), {
        onSelected = function()
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Revive → [^5"..GetPlayerName(player).."^7]")
            _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Revive → ["..GetPlayerName(player).."]")
            TriggerServerEvent(_Admin.Prefix.."revivePlayer", GetPlayerServerId(player))
        end
    });

    RageUI.Button("Tuer",  nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Kill), {
        onSelected = function()
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Tuer → [^5"..GetPlayerName(player).."^7]")
            _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Tuer → ["..GetPlayerName(player).."]")
            SetEntityHealth(GetPlayerPed(player), 0)
            ESX.ShowNotification("Vous avez tuer ~g~"..GetPlayerName(player))
        end
    });

    RageUI.Button("~r~Kick",  nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Kick), {
        onSelected = function()
            local kickreason = KI("Kick raison", "", 150)
            if kickreason ~= nil and kickreason ~= "" then
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Kick → ["..GetPlayerName(player).."] Raison : "..kickreason)
                TriggerServerEvent(_Admin.Prefix.."kickPlayer", _.rank, GetPlayerServerId(player), kickreason)
            end
        end
    });

    RageUI.Button("~r~Bannir "..GetPlayerName(player),  nil, {RightLabel = "~r~~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Ban), {
        onSelected = function()
            local banTime = KI("Combien de ~r~JOUR~s~ de Ban ?", "", 150)
            banTime = tonumber(banTime)
            if type(banTime) == 'number' then
                banTime = ESX.Math.Round(banTime) 
                if banTime > 0 and banTime < 365 then
                    local banReason = KI("Ban raison", "", 150)
                    if banReason ~= nil and banReason ~= "" then
                        TriggerServerEvent(_Admin.Prefix.."banPlayer", _.rank, GetPlayerName(player), GetPlayerServerId(player), banTime, banReason)
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Ban → ["..GetPlayerName(player).."] Raison : "..banReason.." pour "..banTime.." jour")
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
                        _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] Ajouter des permissions → [^5"..GetPlayerName(player).."^7] Rank Grade : ^6"..rankNumber.."^7")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] Ajouter des permissions → ["..GetPlayerName(player).."] Rank Grade : "..rankNumber)
                        TriggerServerEvent(_Admin.Prefix.."SetAdminPermissions", _.rank, GetPlayerServerId(player), rankNumber)
                    end
                end
            else
                ESX.ShowNotification("~r~Quantité invalide")
            end 
        end
    });
end
