_Admin = _Admin or {}
_Admin.Panel = _Admin.Panel or {}


--| ESX Legacy Version & RageUI Library

_Admin.MainUser = {
    "3ec9bce5eb7535d3878b70bc3aad0d48fb307b18"; -- "license"
}


_Admin.Prefix = "Sublime-Administration"; 


_Admin.Logs = {
    WebHook = "https://discord.com/api/webhooks/868195899594141737/4p5pDCqnfuGiTi06u_e1BJlFTwn1RCEaSqgMV38uihzB0_2YA7NiDRvIUnd53KsZF44F";
    BotName = "Sublime-Logs";
    Color = 3092790;
    IconURL = "https://zupimages.net/up/21/48/fy8g.png"; 
}


_Admin.Config = {
    EnablePrints = true;
    --
    SQL_Wrapper = "mysql-async", --> mysql or oxmysql -- IMPORTANT (change in fxmanifest your dependencies)
    --
    Macro = {
        ['Open Main Menu'] = {btn = 'F10', description = "~r~Open Admin Panel~s~"}, --> Open panel
        ['No Clip Toggle'] = {btn = 'F3', description = "No Clip"}, --> No clip
    },
    --
    NoClip = {
        Controls = {
            goSprint = 21,-- Left Shift
            goUp = 85, -- A
            goDown = 48, -- W
            turnLeft = 34, -- Q
            turnRight = 35, -- D
            goForward = 32,  -- Z
            goBackward = 33, -- S
        },
        Speeds = { 0, 0.5, 2, 5, 10, 15 },
        Offsets = {y = 0.5, z = 0.2, h = 3},
    },
    --
    -- Weather System from https://github.com/thefrcrazy/crz_weather
    UseWeatherAndTimeSync = true;
    Weather = {
        allWeatherList = { "EXTRASUNNY", "CLEAR", "SMOG", "FOGGY", "OVERCAST", "CLOUDS", "NEUTRAL", "CLEARING", "RAIN", "THUNDER", "SNOW", "SNOWLIGHT", "BLIZZARD", "XMAS", "HALLOWEEN" },
        defaultWeather = "EXTRASUNNY",
        defaultNextWeather = { "CLEARING","RAIN","CLEAR" },
        blackout = false,
        freezeWeather = false,
        freezeTime = false,
        maxRandom = 4,
    },

}
