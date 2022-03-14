
local _ = {
    rank = nil;
    weatherIndex = 1,
    weatherItem = {},
    timeList = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23},
    timeIndex = 1,
    checkboxBlackout = false,
    checkboxBlackout2 = false,
    checkboxFreezeWeather = false,
    checkboxFreezeTime = false,
}


function _Admin.Panel:ServerOptionsWeather(rank)
    _.rank = rank

    RageUI.Separator("Météo actuel : ~h~~y~".._Admin.Config.Weather.defaultWeather)
    RageUI.Line()
    RageUI.List("Météos disponibles :", _Admin.Config.Weather.allWeatherList,_.weatherIndex, nil, {}, true, { 
        onListChange = function(Index, Item) 
            _.weatherIndex = Index; 
            _.weatherItem = Item 
        end, 
        onSelected = function(Index, Item) 
            if _.weatherIndex ~= 1 then
                _Admin.Config.Weather.defaultWeather = _.weatherItem 
                TriggerServerEvent(_Admin.Prefix.."NewWeatherFromAdminPanel", _Admin.Config.Weather.defaultWeather, _Admin.Config.Weather.blackout)
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À modifier la météo → ^6".._Admin.Config.Weather.defaultWeather.." ^7")
                Visual.Subtitle("~c~Changement météo en cours...", 2500)
            end 
        end 
    })
    

    RageUI.List("Temps disponibles :",_.timeList,_.timeIndex, nil, {}, true, { 
        onListChange = function(Index, Item)
            _.timeIndex = Index; 
        end, 
        onSelected = function(Index, Item) 
            TriggerServerEvent(_Admin.Prefix.."NewTimeFromAdminPanel",  _.timeIndex)
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À modifier le temps → ^6"..Index..":00 ^7")
            Visual.Subtitle("~c~Changement temps en cours...", 2500) 
        end 
    })
    
    
    RageUI.Checkbox('Blackout complet', nil, _.checkboxBlackout, {}, { 
        onChecked = function() 
            _Admin.Config.Weather.blackout = true
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À activé le ^6blackout^7")
        end, 
        onUnChecked = function() 
            _Admin.Config.Weather.blackout = false 
            SetArtificialLightsStateAffectsVehicles(false)
        end,
        onSelected = function(Index) 
            _.checkboxBlackout = Index
            TriggerServerEvent(_Admin.Prefix.."NewWeatherFromAdminPanel", _Admin.Config.Weather.defaultWeather, _Admin.Config.Weather.blackout) 
        end 
    })
    

    if _.checkboxBlackout then
        RageUI.Checkbox('Vehicle ignore blackout', nil, _.checkboxBlackout2, {}, {
            onChecked = function()
                SetArtificialLightsStateAffectsVehicles(false) 
            end, 
            onUnChecked = function() 
                SetArtificialLightsStateAffectsVehicles(true) 
            end, 
            onSelected = function(Index) 
                _.checkboxBlackout2 = Index 
            end 
        })
    end


    RageUI.Checkbox('Freeze Weather', nil, _.checkboxFreezeWeather, {}, { 
        onChecked = function() 
            _Admin.Config.Weather.freezeWeather = true 
        end, 
        onUnChecked = function() 
            _Admin.Config.Weather.freezeWeather = false 
        end, 
        onSelected = function(Index) 
            _.checkboxFreezeWeather = Index 
        end 
    })
    
    
    RageUI.Checkbox('Freeze Time', nil, _.checkboxFreezeTime, {}, { 
        onChecked = function() 
            _Admin.Config.Weather.freezeTime = true 
        end, 
        onUnChecked = function() 
            _Admin.Config.Weather.freezeTime = false 
        end, 
        onSelected = function(Index) 
            _.checkboxFreezeTime = Index 
        end 
    })




end