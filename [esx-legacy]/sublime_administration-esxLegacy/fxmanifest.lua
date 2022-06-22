fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.5.0'


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
    'modules/instructional/*.lua',
}


shared_scripts { 
    '@es_extended/imports.lua', 
    'shared/*.lua', 
}


server_scripts { --'@mysql-async/lib/MySQL.lua' or '@oxmysql/lib/MySQL.lua', + shared/config.lua -> _Admin.Config.SqlWrapper  
    '@oxmysql/lib/MySQL.lua', -- here
    'server/*.lua'
}

client_scripts {
    'cache/*lua',
    'client/fonction\'s/*.lua',
    'client/menu\'s/**/*.lua'
}


ui_page 'web/ui.html'

files {
    'web/ui.html',
    'web/js/*.js',
}


dependencies { 
    'mysql-async', -- or oxmysql
    'es_extended',
    'skinchanger',
    'esx_skin',
}