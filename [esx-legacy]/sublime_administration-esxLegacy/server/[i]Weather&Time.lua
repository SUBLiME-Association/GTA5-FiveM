

if _Admin.Config.UseWeatherAndTimeSync then

---------------------------------------------------- // Weather // ----------------------------------------------------

local nextWeatherTimer = 10
local nextWeather = _Admin.Config.Weather.defaultNextWeather

CreateThread(function()
    TriggerClientEvent(_Admin.Prefix.."syncWeather", -1, _Admin.Config.Weather.defaultNextWeather, _Admin.Config.Weather.blackout)
    while true do
        nextWeatherTimer = nextWeatherTimer-1
        Citizen.Wait(15 * 60 * 1000)
        if nextWeatherTimer == 0 then
            EditNextWeather()
            nextWeatherTimer = 10
        elseif nextWeatherTimer == 5 then
            ReloadNextWeather()
        end
    end
end)


EditNextWeather = function()
    _Admin.Config.Weather.defaultNextWeather = nextWeather[1]
    nextWeather[1] = nextWeather[2]
    nextWeather[2] = nextWeather[3]
    nextWeather[3] = _Admin.Config.Weather.allWeatherList[math.random(#_Admin.Config.Weather.allWeatherList)]
    if not _Admin.Config.Weather.freezeWeather then
        TriggerClientEvent(_Admin.Prefix.."syncWeather", -1, _Admin.Config.Weather.defaultNextWeather, _Admin.Config.Weather.blackout)
    end
    TriggerClientEvent(_Admin.Prefix.."syncNextWeather", -1, nextWeather)
end


ReloadNextWeather = function()
    local rdm = math.random(1, _Admin.Config.Weather.maxRandom)
    if rdm == 1 then
        nextWeather[1] = _Admin.Config.Weather.allWeatherList[math.random(#_Admin.Config.Weather.allWeatherList)]
        nextWeather[2] = _Admin.Config.Weather.allWeatherList[math.random(#_Admin.Config.Weather.allWeatherList)]
        nextWeather[3] = _Admin.Config.Weather.allWeatherList[math.random(#_Admin.Config.Weather.allWeatherList)]
    end
    if not _Admin.Config.Weather.freezeWeather then
        TriggerClientEvent(_Admin.Prefix.."syncNextWeather", -1, nextWeather)
    end
end




-------------------------------------------------- // Time // ----------------------------------------------------

local baseTime = 0
local timeOffset = 0

CreateThread(function()
    while true do
        Wait(5000)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if _Admin.Config.Weather.freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime
        end
        baseTime = newBaseTime
        TriggerClientEvent(_Admin.Prefix.."syncTime", -1, baseTime, timeOffset, _Admin.Config.Weather.freezeTime)
    end
end)

setToHours = function(hours) timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hours ) * 60 end
setToMinute = function(minutes) timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minutes ) end




-------------------------------------------------- // ADMIN FUNCTION // --------------------------------------------------

RegisterServerEvent(_Admin.Prefix.."NewTimeFromAdminPanel")
AddEventHandler(_Admin.Prefix.."NewTimeFromAdminPanel", function(hours)
    setToHours(hours)
end)

RegisterServerEvent(_Admin.Prefix.."NewWeatherFromAdminPanel")
AddEventHandler(_Admin.Prefix.."NewWeatherFromAdminPanel", function(weather, blackout)
    TriggerClientEvent(_Admin.Prefix.."syncWeather", -1, weather, blackout)
end)



end