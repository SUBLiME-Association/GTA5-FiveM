fx_version 'adamant'
game 'gta5'
author 'SUP2Ak'
description 'sublime_boilerplate'
version 'esx_legacy'


shared_scripts { -->> shared script compte aussi bien que pour les client que le server
	'@es_extended/imports.lua', --> toujours en premier pour récuperer l'object ESX [client/server]
	'config.lua'
}

client_scripts { -->> côté client
	'client/main.lua'
}

server_scripts { -->> côté server
	--'@mysql-async/lib/MySQL.lua', Si jamais vous avez besoin de mysql-async pour le script que vous créez
	'server/main.lua'
}

dependency 'es_extended' -->> Ce que votre ressource dépends (ici on dépends de es_extended) donc votre ressource sera stop / non start si es_extended n'est pas start avant