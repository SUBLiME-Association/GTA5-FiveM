fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '0.1' 

--/ Lib (RageUI) & Vein UI /--
client_scripts {
    'modules/rageui/RMenu.lua',
    'modules/rageui/menu/RageUI.lua',
    'modules/rageui/menu/Menu.lua',
    'modules/rageui/menu/MenuController.lua',
    'modules/rageui/components/*.lua',
    'modules/rageui/menu/elements/*.lua',
    'modules/rageui/menu/items/*.lua',
    'modules/rageui/menu/panels/*.lua',
    'modules/rageui/menu/windows/*.lua',

    'modules/vein/core/utils.lua',
    'modules/vein/core/style.lua',
    'modules/vein/core/input.lua',
    'modules/vein/core/painter.lua',
    'modules/vein/core/context.lua',
    'modules/vein/core/vein.lua',
    'modules/vein/widgets/*.lua',
    'modules/ipl/*.lua',

}


shared_scripts {
    '@es_extended/imports.lua', -- esx legacy getter
    'shared/*.lua',

}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server/*.lua'
}


client_scripts {
    'client/*.lua'
}


dependencies { 
    'mysql-async',
    'es_extended',
    'skinchanger',
}
