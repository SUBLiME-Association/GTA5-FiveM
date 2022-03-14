local _ = {
    rank = nil;
    aPerms = _Admin.Permissions.Button_myPlayer.inside,

}


function _Admin.Panel:MyPlayer(rank)
    _.rank = rank
    RageUI.Separator("ID : ~b~"..GetPlayerServerId(PlayerId()).."~s~ - Name : ~b~"..GetPlayerName(PlayerId()))
    RageUI.Button('Mes Options', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.MyOptions.access), {},  _Admin.Menu.sub_myPlayerOptions);
    RageUI.Button('Mon Apparence', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.MyApparence.access), {}, _Admin.Menu.sub_myPlayerApparence);
    RageUI.Button('Gestion Items', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.ItemsOptions.access), {}, _Admin.Menu.sub_myPlayerItemsOptions);
    RageUI.Button('Gestion Armes', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.WeaponsOptions.access), {}, _Admin.Menu.sub_myPlayerWeaponsOptions);
end

