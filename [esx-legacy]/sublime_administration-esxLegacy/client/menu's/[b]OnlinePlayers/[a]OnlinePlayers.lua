local _ = {
    rank = nil,
    aPerms = _Admin.Permissions.Button_PlayerConnected.inside,
    playersId = {},
    foundPlayer = false,
}

--_Admin.SelectedPlayerLocalId = 0

function _Admin.Panel:OnlinePlayers(rank)
    _.rank = rank
    for k,v in pairs(_Admin.dataPlayers) do
        local localId = GetPlayerFromServerId(v.playerId)
        local playerId = v.playerId
        local named = v.name
        if ESX.GetConfig().Identity == false then named = GetPlayerName(localId) end
        RageUI.Button(v.name..' - ('..GetPlayerName(localId)..')', "ID "..v.playerId.." / Local ID "..localId, {RightLabel = "Server #"..k.." ~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SelectPlayer.access), {
            onSelected = function()
                _Admin.SelectedPlayerLocalId = localId
                _Admin.SelectedPlayerName = named
                _Admin.TargetId = playerId
                _Admin.AdminName = _Admin.adminName
            end
        }, _Admin.Menu.sub_allPlayers2);
    end
end

