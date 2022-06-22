local _ = {
    rank = nil,
    aPerms = _Admin.Permissions,
}





function _Admin.Panel:Main(rank)
    _.rank = rank
    _Admin.Menu.Create()
    RefreshPlayersCallback()
    _Admin.RefreshAllItems()
    _Admin.RefreshSublimeData()
    _Admin.RefreshBans()
    _Admin.RefreshStaff()
    RageUI.Visible(_Admin.Menu.main, not RageUI.Visible(_Admin.Menu.main))
    while _Admin.Menu.main do
        Citizen.Wait(0)
        RageUI.IsVisible(_Admin.Menu.main, function()

            RageUI.Button('Joueurs Connectés', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Button_PlayerConnected.access), {onSelected = function() RefreshPlayersCallback() end}, _Admin.Menu.sub_allPlayers);

            RageUI.Button('Mon Personnage', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Button_myPlayer.access), {}, _Admin.Menu.sub_myPlayer);

            RageUI.Button('Véhicule', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Button_Vehicle.access), {}, _Admin.Menu.sub_Vehicle);

            RageUI.Button('Gestion Serveur', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Button_ServerSystem.access), {}, _Admin.Menu.sub_ServerOptions);

            RageUI.Button('Développement', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.Button_Developpement.access), {}, _Admin.Menu.sub_Developpement);

            RageUI.Button('~r~Gestion Fondateur', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, "Owner"), {}, _Admin.Menu.sub_ownerManagement);

        end)


        RageUI.IsVisible(_Admin.Menu.sub_allPlayers, function()
            _Admin.Panel:OnlinePlayers(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_allPlayers2, function()
            _Admin.Panel:PlayerDetails(_.rank, _Admin.TargetId, _Admin.SelectedPlayerLocalId, _Admin.SelectedPlayerName, _Admin.TargetJobLabel, _Admin.TargetGradeLabel)
        end)
        
        RageUI.IsVisible(_Admin.Menu.sub_myPlayer, function()
            _Admin.Panel:MyPlayer(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_myPlayerOptions, function()
            _Admin.Panel:MyPlayerOptions(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_myPlayerApparence, function()
            _Admin.Panel:MyPlayerApparence(_.rank)
        end)
    
        RageUI.IsVisible(_Admin.Menu.sub_myPlayerChangeApparence, function()
            _Admin.Panel:ChangeMyPlayerApparence(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_myPlayerApparencePedList, function()
            _Admin.Panel:MyPlayerApparencePedList(_.rank)
        end)
    
        RageUI.IsVisible(_Admin.Menu.sub_myPlayerApparencePedList2, function()
            _Admin.Panel:MyPlayerApparencePedList2(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_myPlayerItemsOptions, function()
            _Admin.Panel:MyPlayerItemsList(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_myPlayerWeaponsOptions, function()
            _Admin.Panel:MyPlayerWeaponOptions(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_myPlayerWeaponsOptions2, function()
            _Admin.Panel:MyPlayerWeaponOptions2(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_Vehicle, function()
            _Admin.Panel:Vehicle(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_Vehicle2, function()
            _Admin.Panel:Vehicle2(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_VehicleModMenu, function()
            _Admin.Panel:VehicleModMenu(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_VehicleFav, function()
            _Admin.Panel:VehicleFavoris(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_ServerOptions, function()
            _Admin.Panel:ServerOptions(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_ServerOptionsWeather, function()
            _Admin.Panel:ServerOptionsWeather(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_ServerOptionsReports, function()
            _Admin.Panel:ServerOptionsReports(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_Developpement, function()
            _Admin.Panel:Developpement(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_ownerManagement, function()
            _Admin.Panel:OwnerManagement(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_ownerManagementBans, function()
            _Admin.Panel:OwnerManagementBans(_.rank)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_ownerManagementStaff, function()
            _Admin.Panel:OwnerManagementStaff(_.rank)
        end)

        --

        RageUI.IsVisible(_Admin.Menu.sub_allPlayers3, function() -- JOB ALL PLAYERS 1
            _Admin.Panel:PlayerDetailsJobs1(_Admin.allJobs)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_allPlayers33, function() -- JOB ALL PLAYERS 2
            _Admin.Panel:PlayerDetailsJobs2(_.rank, _Admin.newMenuTitle, _Admin.jobName, _Admin.TargetId ,_Admin.SelectedPlayerLocalId, _Admin.SelectedPlayerName, _Admin.AdminName)
        end)

        --RageUI.IsVisible(_Admin.Menu.sub_allPlayers4, function() -- FACTION ALL PLAYERS 1
        --    _Admin.Panel:PlayerDetailsFactions1(_.rank, allFactions)
        --end)

        --RageUI.IsVisible(_Admin.Menu.sub_allPlayers44, function() -- FACTION ALL PLAYERS 2
        --    _Admin.Panel:PlayerDetailsFactions2(_.rank, )
        --end)

        RageUI.IsVisible(_Admin.Menu.sub_myPlayerOptions1, function() -- JOB MY PLAYER 1
            _Admin.Panel:MyPlayerJobs1(_Admin.allJobs)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_myPlayerOptions11, function() -- JOB MY PLAYER 2
            _Admin.Panel:MyPlayerJobs2(_Admin.newMenuTitle, _Admin.jobName)
        end)

        --RageUI.IsVisible(_Admin.Menu.sub_myPlayerOptions2, function() -- FACTION MY PLAYER 1
        --    _Admin.Panel:MyPlayerFactions1(_.rank, allFactions)
        --end)

        --RageUI.IsVisible(_Admin.Menu.sub_myPlayerOptions22, function() -- FACTION MY PLAYER 2
        --    _Admin.Panel:MyPlayerFactions2(_.rank, )
        --end)

        RageUI.IsVisible(_Admin.Menu.sub_allplayerInventory, function() -- INVENTORY PLAYER TARGET
            _Admin.Panel:TargetInventory(_Admin.TargetInventory, _Admin.TargetId, _Admin.TargetWeight, _Admin.TargetMaxWeight)
        end)

        --RageUI.IsVisible(_Admin.Menu.sub_allplayerInventory, function() -- INVENTORY2 PLAYER TARGET
        --    _Admin.Panel:MyPlayerJobs2(_Admin.newMenuTitle, _Admin.jobName)
        --    _Admin.Panel:TargetInventory(_Admin.TargetInventory)
        --end) 

        RageUI.IsVisible(_Admin.Menu.sub_allplayerAccounts, function() -- INVENTORY PLAYER TARGET
            _Admin.Panel:TargetAccounts(_Admin.TargetAccounts, _Admin.TargetId)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_allPlayers5, function() -- VEHICLE ALL PLAYERS 1
            _Admin.Panel:PlayerDetailsVehicle1(_.rank, _Admin.playersVehicleData)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_allPlayers51, function() -- VEHICLE LIST ALL PLAYERS 
            _Admin.Panel:PlayerDetailsListVehicles(_.rank, _Admin.TargetListVehicle)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_allPlayers55, function() -- VEHICLE ALL PLAYERS 2
            _Admin.Panel:PlayerDetailsVehicle2(_.rank, _Admin.VehPlate, _Admin.VehStored, _Admin.VehData, _Admin.VehLabel, _Admin.VehName, _Admin.VehCategory, _Admin.VehPrice)
        end)

        RageUI.IsVisible(_Admin.Menu.sub_allPlayers555, function() -- VEHICLE ALL PLAYERS 3 TRANSFER
            _Admin.Panel:OnlinePlayersForVehicle(_.rank, _Admin.VehPlate, _Admin.VehLabel, _Admin.VehName, _Admin.VehPrice, _Admin.TargetId)
        end)

        if not RageUI.Visible(_Admin.Menu.main)
        and not RageUI.Visible(_Admin.Menu.sub_allPlayers)
        and not RageUI.Visible(_Admin.Menu.sub_allPlayers2)
        and not RageUI.Visible(_Admin.Menu.sub_myPlayer)
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerOptions)
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerApparence)
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerChangeApparence)
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerApparencePedList)
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerApparencePedList2)
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerItemsOptions)
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerWeaponsOptions)
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerWeaponsOptions2)
        and not RageUI.Visible(_Admin.Menu.sub_Vehicle)
        and not RageUI.Visible(_Admin.Menu.sub_Vehicle2)
        and not RageUI.Visible(_Admin.Menu.sub_VehicleModMenu)
        and not RageUI.Visible(_Admin.Menu.sub_VehicleFav)
        and not RageUI.Visible(_Admin.Menu.sub_ServerOptions)
        and not RageUI.Visible(_Admin.Menu.sub_ServerOptionsWeather)
        and not RageUI.Visible(_Admin.Menu.sub_ServerOptionsReports)
        and not RageUI.Visible(_Admin.Menu.sub_Developpement)
        and not RageUI.Visible(_Admin.Menu.sub_ownerManagement)
        and not RageUI.Visible(_Admin.Menu.sub_ownerManagementBans)
        and not RageUI.Visible(_Admin.Menu.sub_ownerManagementStaff)
        and not RageUI.Visible(_Admin.Menu.sub_allPlayers3) -- Job1
        and not RageUI.Visible(_Admin.Menu.sub_allPlayers33) -- Job2
        --and not RageUI.Visible(_Admin.Menu.sub_allPlayers4) -- Faction1
        --and not RageUI.Visible(_Admin.Menu.sub_allPlayers44) -- Faction2
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerOptions1) -- Job1
        and not RageUI.Visible(_Admin.Menu.sub_myPlayerOptions11) -- Job2
        --and not RageUI.Visible(_Admin.Menu.sub_myPlayerOptions2) -- Faction1
        --and not RageUI.Visible(_Admin.Menu.sub_myPlayerOptions22) -- Faction2
        and not RageUI.Visible(_Admin.Menu.sub_allplayerInventory) -- Inventory target
        and not RageUI.Visible(_Admin.Menu.sub_allplayerAccounts) -- Accounts target
        and not RageUI.Visible(_Admin.Menu.sub_allPlayers5) -- Vehicle1
        and not RageUI.Visible(_Admin.Menu.sub_allPlayers55) -- Vehicle2
        and not RageUI.Visible(_Admin.Menu.sub_allPlayers555) -- Vehicle3
        and not RageUI.Visible(_Admin.Menu.sub_allPlayers51) -- Vehicle cat
        then
            _Admin.Menu.main = RMenu:DeleteType('_Admin.Menu.main', true)   
        end
    end
end
