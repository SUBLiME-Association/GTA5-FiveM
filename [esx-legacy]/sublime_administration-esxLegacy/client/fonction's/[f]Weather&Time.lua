

if _Admin.Config.UseWeatherAndTimeSync then

-- // Weather // --
local nextWeather = _Admin.Config.Weather.defaultNextWeather
local current = {
    blackout = nil,
    latestWeather = _Admin.Config.Weather.defaultWeather
}

RegisterNetEvent(_Admin.Prefix.."syncNextWeather")
AddEventHandler(_Admin.Prefix.."syncNextWeather", function(nextWeather2)
    nextWeather = nextWeather2
end)

RegisterNetEvent(_Admin.Prefix.."syncWeather")
AddEventHandler(_Admin.Prefix.."syncWeather", function(weather, blackout)
    _Admin.Config.Weather.defaultWeather = weather
    current.blackout = blackout
    SetArtificialLightsState(current.blackout)
    SetArtificialLightsStateAffectsVehicles(true)
end)


Citizen.CreateThread(function()
    while true do
        if current.latestWeather ~= _Admin.Config.Weather.defaultWeather then
            current.latestWeather = _Admin.Config.Weather.defaultWeather
            SetWeatherTypeOverTime(_Admin.Config.Weather.defaultWeather, 15.0)
            Citizen.Wait(15000)
        end
        Wait(100)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(current.latestWeather)
        SetWeatherTypeNow(current.latestWeather)
        SetWeatherTypeNowPersist(current.latestWeather)
    end
end)




-- // Time // --

local baseTime = 0
local timeOffset = 0
local timer = 0

RegisterNetEvent(_Admin.Prefix.."syncTime")
AddEventHandler(_Admin.Prefix.."syncTime", function(base, offset, freeze)
    baseTime = base
    timeOffset = offset
    _Admin.Config.Weather.freezeTime = freeze
end)


Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(1000)
        local newBaseTime = baseTime
        if GetGameTimer() - 500 > timer then
            newBaseTime = newBaseTime+0.25
            timer = GetGameTimer()
        end
        if _Admin.Config.Weather.freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)


end