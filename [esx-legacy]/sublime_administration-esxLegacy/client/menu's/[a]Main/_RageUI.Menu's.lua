_Admin.Menu = _Admin.Menu or {}



function _Admin.Menu.Create()
    _Admin.Menu.main = RageUI.CreateMenu(GetPlayerName(PlayerId()), "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_allPlayers = RageUI.CreateSubMenu(_Admin.Menu.main, GetPlayerName(PlayerId()), "LISTE DES JOUEURS");
    _Admin.Menu.sub_allPlayers2 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers, GetPlayerName(PlayerId()), "GESTION JOUEUR");
    _Admin.Menu.sub_myPlayer = RageUI.CreateSubMenu(_Admin.Menu.main, GetPlayerName(PlayerId()), "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_myPlayerOptions = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayer, GetPlayerName(PlayerId()), "MES OPTIONS");
    _Admin.Menu.sub_myPlayerApparence = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayer, GetPlayerName(PlayerId()), "MON APPARENCE");
    _Admin.Menu.sub_myPlayerChangeApparence = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerApparence, GetPlayerName(PlayerId()), "MON APPARENCE");
    _Admin.Menu.sub_myPlayerApparencePedList = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerApparence, GetPlayerName(PlayerId()), "MON APPARENCE");
    _Admin.Menu.sub_myPlayerApparencePedList2 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerApparencePedList, GetPlayerName(PlayerId()), "MON APPARENCE");
    _Admin.Menu.sub_myPlayerItemsOptions = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayer, GetPlayerName(PlayerId()), "ITEMS OPTIONS");
    _Admin.Menu.sub_myPlayerWeaponsOptions = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayer, GetPlayerName(PlayerId()), "ARMES OPTIONS");
    _Admin.Menu.sub_myPlayerWeaponsOptions2 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerWeaponsOptions, GetPlayerName(PlayerId()), "ARMES OPTIONS");
    _Admin.Menu.sub_Vehicle = RageUI.CreateSubMenu(_Admin.Menu.main, GetPlayerName(PlayerId()), "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_Vehicle2 = RageUI.CreateSubMenu(_Admin.Menu.sub_Vehicle, GetPlayerName(PlayerId()), "LISTE VEHICULES");
    _Admin.Menu.sub_VehicleModMenu = RageUI.CreateSubMenu(_Admin.Menu.sub_Vehicle, GetPlayerName(PlayerId()), "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_VehicleFav = RageUI.CreateSubMenu(_Admin.Menu.sub_Vehicle, GetPlayerName(PlayerId()), "LISTE VEHICULES FAVORIS");
    _Admin.Menu.sub_ServerOptions = RageUI.CreateSubMenu(_Admin.Menu.main, GetPlayerName(PlayerId()), "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_ServerOptionsWeather = RageUI.CreateSubMenu(_Admin.Menu.sub_ServerOptions, GetPlayerName(PlayerId()), "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_ServerOptionsReports = RageUI.CreateSubMenu(_Admin.Menu.sub_ServerOptions, GetPlayerName(PlayerId()), "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_Developpement = RageUI.CreateSubMenu(_Admin.Menu.main, GetPlayerName(PlayerId()), "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_ownerManagement = RageUI.CreateSubMenu(_Admin.Menu.main, GetPlayerName(PlayerId()), "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_ownerManagementBans = RageUI.CreateSubMenu(_Admin.Menu.sub_ownerManagement, GetPlayerName(PlayerId()), "LISTE DES BANS");
    _Admin.Menu.sub_ownerManagementStaff = RageUI.CreateSubMenu(_Admin.Menu.sub_ownerManagement, GetPlayerName(PlayerId()), "LISTE DES STAFF");
    _Admin.Menu.sub_allPlayers3 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers2, GetPlayerName(PlayerId()), "GESTION JOB")
    _Admin.Menu.sub_allPlayers33 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers3, "", "GESTION JOB - GRADE")
    --_Admin.Menu.sub_allPlayers4 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers2, GetPlayerName(PlayerId()), "GESTION FACTION")
    --_Admin.Menu.sub_allPlayers44 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers4, "", "GESTION FACTION - GRADE")
    _Admin.Menu.sub_myPlayerOptions1 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerOptions, GetPlayerName(PlayerId()), "GESTION JOB")
    _Admin.Menu.sub_myPlayerOptions11 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerOptions1, "", "GESTION JOB - GRADE")
    --_Admin.Menu.sub_myPlayerOptions2 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerOptions, GetPlayerName(PlayerId()), "GESTION FACTION")
    --_Admin.Menu.sub_myPlayerOptions22 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerOptions2, "", "GESTION FACTION - GRADE")
end