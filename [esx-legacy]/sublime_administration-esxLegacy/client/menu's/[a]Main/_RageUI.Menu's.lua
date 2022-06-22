_Admin.Menu = _Admin.Menu or {}

--GetPlayerName(PlayerId())

function _Admin.Menu.Create()
    _Admin.Menu.main = RageUI.CreateMenu(cache.playerName, "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_allPlayers = RageUI.CreateSubMenu(_Admin.Menu.main, cache.playerName, "LISTE DES JOUEURS");
    _Admin.Menu.sub_allPlayers2 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers, cache.playerName, "GESTION JOUEUR");
    _Admin.Menu.sub_myPlayer = RageUI.CreateSubMenu(_Admin.Menu.main, cache.playerName, "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_myPlayerOptions = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayer, cache.playerName, "MES OPTIONS");
    _Admin.Menu.sub_myPlayerApparence = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayer, cache.playerName, "MON APPARENCE");
    _Admin.Menu.sub_myPlayerChangeApparence = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerApparence, cache.playerName, "MON APPARENCE");
    _Admin.Menu.sub_myPlayerApparencePedList = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerApparence, cache.playerName, "MON APPARENCE");
    _Admin.Menu.sub_myPlayerApparencePedList2 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerApparencePedList, cache.playerName, "MON APPARENCE");
    _Admin.Menu.sub_myPlayerItemsOptions = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayer, cache.playerName, "ITEMS OPTIONS");
    _Admin.Menu.sub_myPlayerWeaponsOptions = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayer, cache.playerName, "ARMES OPTIONS");
    _Admin.Menu.sub_myPlayerWeaponsOptions2 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerWeaponsOptions, cache.playerName, "ARMES OPTIONS");
    _Admin.Menu.sub_Vehicle = RageUI.CreateSubMenu(_Admin.Menu.main, cache.playerName, "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_Vehicle2 = RageUI.CreateSubMenu(_Admin.Menu.sub_Vehicle, cache.playerName, "LISTE VEHICULES");
    _Admin.Menu.sub_VehicleModMenu = RageUI.CreateSubMenu(_Admin.Menu.sub_Vehicle, cache.playerName, "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_VehicleFav = RageUI.CreateSubMenu(_Admin.Menu.sub_Vehicle, cache.playerName, "LISTE VEHICULES FAVORIS");
    _Admin.Menu.sub_ServerOptions = RageUI.CreateSubMenu(_Admin.Menu.main, cache.playerName, "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_ServerOptionsWeather = RageUI.CreateSubMenu(_Admin.Menu.sub_ServerOptions, cache.playerName, "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_ServerOptionsReports = RageUI.CreateSubMenu(_Admin.Menu.sub_ServerOptions, cache.playerName, "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_Developpement = RageUI.CreateSubMenu(_Admin.Menu.main, cache.playerName, "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_ownerManagement = RageUI.CreateSubMenu(_Admin.Menu.main, cache.playerName, "ACTIONS DISPONIBLES");
    _Admin.Menu.sub_ownerManagementBans = RageUI.CreateSubMenu(_Admin.Menu.sub_ownerManagement, cache.playerName, "LISTE DES BANS");
    _Admin.Menu.sub_ownerManagementStaff = RageUI.CreateSubMenu(_Admin.Menu.sub_ownerManagement, cache.playerName, "LISTE DES STAFF");

    -- v 1.4
    _Admin.Menu.sub_allPlayers3 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers2, cache.playerName, "GESTION JOB")
    _Admin.Menu.sub_allPlayers33 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers3, "", "GESTION JOB - GRADE")
    --_Admin.Menu.sub_allPlayers4 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers2, cache.playerName, "GESTION FACTION")
    --_Admin.Menu.sub_allPlayers44 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers4, "", "GESTION FACTION - GRADE")
    _Admin.Menu.sub_myPlayerOptions1 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerOptions, cache.playerName, "GESTION JOB")
    _Admin.Menu.sub_myPlayerOptions11 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerOptions1, "", "GESTION JOB - GRADE")
    --_Admin.Menu.sub_myPlayerOptions2 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerOptions, cache.playerName, "GESTION FACTION")
    --_Admin.Menu.sub_myPlayerOptions22 = RageUI.CreateSubMenu(_Admin.Menu.sub_myPlayerOptions2, "", "GESTION FACTION - GRADE")

    -- v 1.5
    _Admin.Menu.sub_allplayerInventory = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers2, cache.playerName, "GESTION - INVENTORY")
    _Admin.Menu.sub_allplayerAccounts = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers2, cache.playerName, "GESTION - ACCOUNTS")
    _Admin.Menu.sub_allPlayers5 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers2, cache.playerName, "LISTE DES VEHICULES")
    _Admin.Menu.sub_allPlayers51 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers5, cache.playerName, "CATEGORIE - VEHICULES")
    _Admin.Menu.sub_allPlayers55 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers5, "", "ACTION SUR LE VEHICULE")
    _Admin.Menu.sub_allPlayers555 = RageUI.CreateSubMenu(_Admin.Menu.sub_allPlayers55, "", "TRANSFEREZ LE VEHICULE A")
end