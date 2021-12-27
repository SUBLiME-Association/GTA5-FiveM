const container = document.getElementById("container");
function test(v){
    if(v === false) {
        container.style.display = 'none';
    } else {
        container.style.display = 'block';
    }
}
window.addEventListener('message', (event) => {
    if (event.data.type === 'closed') {
        test(false);
    }else if (event.data.type === 'opened') {
        test(true)
    }
});
function Weathers(weather) {
    fetch(`https://sublime_weatherTime/weather`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            weatherId: weather
        })
    });
}
function Timing(value){
    if(value){
        console.log(value + " -> en cours de développement! [voir native pour l'heure in game (h/m/s)]")
    }
}