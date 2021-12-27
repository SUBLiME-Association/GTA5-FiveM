let isOpen = false
RegisterCommand('weather', () => {  
    if(isOpen){
        isOpen = false
        SetNuiFocus(false, false);
        SendNuiMessage(JSON.stringify({type: 'closed'}))
    }else{
        isOpen = true
        SetNuiFocus(true, true);  
        SendNuiMessage(JSON.stringify({type: 'opened'}))
    }  
},false);
RegisterNuiCallbackType('weather')
on('__cfx_nui:weather', (data, cb) => {
    const weatherId = data.weatherId;
    cb(Weather(weatherId));
});
function Weather(weather) {
    SetWeatherTypePersist(weather);
    SetWeatherTypeNowPersist(weather);
    SetWeatherTypeNow(weather);
    SetOverrideWeather(weather);
}
