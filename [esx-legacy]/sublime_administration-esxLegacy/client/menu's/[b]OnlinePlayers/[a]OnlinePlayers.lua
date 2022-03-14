local _ = {
    rank = nil,
    aPerms = _Admin.Permissions.Button_PlayerConnected.inside,
    playersId = {},
    foundPlayer = false,
}

_Admin.SelectedPlayer = {}




function _Admin.Panel:OnlinePlayers(rank, players)
    _.rank = rank

    for k,v in ipairs(players) do
        local targetPed = GetPlayerPed(v)
        RageUI.Button(GetPlayerName(v), "ID "..GetPlayerServerId(v).." / Local ID "..v, {RightLabel = "Server #"..GetPlayerServerId(v).." ~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SelectPlayer.access), {
            onSelected = function()
                _Admin.SelectedPlayer = v
            end
        }, _Admin.Menu.sub_allPlayers2);
    end

end

