fx_version 'adamant'
game 'gta5'

name 'sublime_weaponshopUi-esxLegacy'
author 'COSSART'
description 'Boutique d\'armes en items avec ui'

version '1.0'
ui_page "ui/index.html"

shared_script 'config.lua'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

files {
    "ui/index.html",
    "ui/app.js",
    "ui/style.css",
    "ui/img/*.png",
    "ui/img/*.jpg"
}