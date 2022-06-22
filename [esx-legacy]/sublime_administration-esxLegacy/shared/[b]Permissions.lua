
_Admin.Ranks = { --> Vous pouvez crée autant de grade que vous le souhaité
    {name = "Administrator", grade = 3},
    {name = "Moderator", grade = 2},
    {name = "Helpeur", grade = 1},
    {name = "Assistant", grade = 0},
}





_Admin.Permissions = {

    NoClip = {3;2;1};
    SetJob = {3;2;1};
    GiveVehicle = {3,2,1};

    Button_PlayerConnected = { access = {3;2;1}; inside = {
        --
        SelectPlayer = { access = {3;2;1}; inside = {
            Goto = {3;2;1};
            Bring = {3;2;1};
            Private_Message = {3;2;1};
            GPS_View = {3;2;1};
            Heal = {3;2};
            Revive = {3;2};
            Kill = {3;2};
            Kick = {3;2;1};
            Ban = {3};
            AddPermissions = {3};
        };};
    };};


    Button_myPlayer = { access = {3;2;1}; inside = {
        --
        MyOptions = { access = {3;2;1}; inside = {
            Health_Management = {3;2};
            Godmode = {3;2};
            Invisible = {3;2};
            Fast_Run = {3;2;1};
            Fast_Swim = {3;2;1};
            Super_Jump = {3;2;1};
            StayInVehicle = {3;2;1};
            Thermal_Vision = {3;2;1};
            ShowPlayerName = {3;2;1};
            Clear_Blood = {3;2;1};
            Suicide = {3;2;1};
        };};
        --
        MyApparence = {access = {3;2;1}; inside = {
            ChangeApparence = {3;2;1};
            SaveApparence = {3};
            SelectApparence = {3};
        };};
        -- 
        ItemsOptions = {access = {3;2}; inside = {
            GiveItem = {3;2}
        }};
        -- 
        WeaponsOptions = {access = {3;2}; inside = {
            GiveAllWeapons = {3};
            GiveSelectedWeapons = {3;2};
        }};        
    };};


    Button_Vehicle = { access = {3;2;1}; inside = {
        --
        ModMenu = { access = {3;2;1}; inside = {
            Repair = {3;2;1};
            Clean = {3;2;1};
            Plate = {3;2};
            OpenDoords = {3;2;1};
            CloseDoords = {3;2;1};
            ChangeColor = {3;2;1};
            BoostVehicle = {3;2};
        };};
        --
        SaveVehicle = {3;2;1};
        MySavedVehicle = {3;2;1};
        SpawnVehicle = {3;2};
    };};
    

    Button_ServerSystem = { access = {3;2;1}; inside = {
        WeatherOptions = {3;2};
        ReportOptions = {access = {3;2;1}; inside = {
            ClearReports = {3;2};
        }};
        ClearAllZone = {3;2;1};
        ClearVehicles = {3;2;1};
        ClearPeds = {3;2;1};
        ClearObjects = {3;2;1};

    };};


    Button_Developpement = { access = {3;2}; inside = {
        DevMode = {3;2};
        CopyCoords = {3;2};
        LazerInfo = {3};
    };};

}