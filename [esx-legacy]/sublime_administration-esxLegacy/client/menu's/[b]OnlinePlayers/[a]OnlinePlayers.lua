local _ = {
    rank = nil,
    aPerms = _Admin.Permissions.Button_PlayerConnected.inside,
    playersId = {},
    foundPlayer = false,
    refresh = false,
}

_Admin.AdminName = _Admin.AdminName or _Admin.adminName
_Admin.TargetId = _Admin.TargetId or 0
_Admin.SelectedPlayerName = _Admin.SelectedPlayerName or ''
_Admin.TargetJobGradeLabel = _Admin.TargetJobGradeLabel or ''
_Admin.TargetJobLabel = _Admin.TargetJobLabel or ''
_Admin.SelectedPlayerLocalId = _Admin.SelectedPlayerLocalId or 0
function _Admin.Panel:OnlinePlayers(rank)
    
    _.rank = rank

    if not _.refresh then
        RageUI.Button("Refresh List", nil, {}, true, {
            onSelected = function()
                _.refresh = true
                RefreshPlayersCallback()
            end
        })
    end

    RageUI.Line()

    if #playersCache >= 1 then
        _.refresh = false
        for k,v in pairs(playersCache)do
            --if ESX.GetConfig().Identity == false then named = v.gtaName else named = v.playerName end
            RageUI.Button(v.playerName..' - ('..v.gtaName..')', "ID "..v.serverId.." / Local ID "..v.playerId, {RightLabel = "Server #"..k.." ~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SelectPlayer.access), {
                onSelected = function()
                    _Admin.SelectedPlayerLocalId = v.playerId
                    _Admin.SelectedPlayerName = v.playerName
                    _Admin.TargetId = v.serverId
                    _Admin.TargetJobLabel = v.jobLabel
                    _Admin.TargetJobGradeLabel = v.jobGradeLabel
                end
            }, _Admin.Menu.sub_allPlayers2);
        end
    else
        RageUI.Separator("En attentes de joueurs ...")
    end
    
end

