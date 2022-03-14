

function isAdminPanelOpened()
    return _Admin.Menu.main
end


function isAdminNoClip()
    return _Admin.NoClipStatus
end


function getCurrentWeather()
    return _Admin.Config.Weather.defaultWeather
end


function getMainUser()
    return _Admin.MainUser
end


function sendLogs(string)
    _Admin.SendServerLogs(string)
end