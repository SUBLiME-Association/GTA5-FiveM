fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'


author 'SUBLiME - Association'
description 'sublime_core'
version '1.0'


shared_scripts {
   'shared/main.lua',
   'shared/exports.lua',
   'shared/**/*.lua',
}

client_scripts {
    'client/main.lua',
    'client/utils/blips.lua',
    'client/utils/marker.lua',
    -------------------------
    'shared/main.lua',
    'shared/exports.lua',
    'shared/**/*.lua',
}

server_scripts {
    'server/**/*.lua',
    -------------------------
    'shared/main.lua',
    'shared/exports.lua',
    'shared/**/*.lua',
}


files {
    'imports.lua'
}