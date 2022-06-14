-------------------------------------------------------------------------------------------
--------------------------------VERSION CHECK----------------------------------------------
-------------------------------------------------------------------------------------------
-- Ne pas toucher
local Version = 
([==[{ 
    "enable": true,
	"script": "sublime_administration",
    "version": "1.4.1",
    "changelog": "^2\n\t- Optimisation et mise en cache de la liste de joueur en ligne,^2\n\t- Mise en cache des identifiant client,^2\n\t- Visibilité du job/grade sur le joueur sélectionné dans la liste,^2\n\t- Ajout d'un bouton dans la liste de joueur pour refresh la liste et le cache,^2\n\t- Suppression de la fonction ESX.GetConfig().identity (donc les joueur qui l'ont sur false auront nil en nom ESX et auront que le nom via la native),^2\n\t- La facon de tuer un joueur selectionnée a changé provisoirement suite à un défaut de sync via le serveur,^2\n\t- Correction sur le bring le player selectionnée",
	"link": "https://github.com/SUBLiME-Association/GTA5-FiveM/tree/main/%5Besx-legacy%5D/sublime_administration-esxLegacy"
}]==])

local HTTPrequest = "https://raw.githubusercontent.com/SUBLiME-Association/version-script-sublime/main/sublime-administration.json"

Citizen.CreateThread(function()
	local _v = json.decode(Version)
	if json.encode(_v.enable) == "true" then
		PerformHttpRequest(HTTPrequest, function(code, res, headers)
			if code == 200 then
				local _gv = json.decode(res)
				if _gv.script == _v.script then
					if _gv.version ~= _v.version then 
					    print((
                            [[
^6----------------------------------------------------------------------
^4INFORMATION: ^2Veuillez mettre à jour %s!
^4VERSION: ^2La version %s est disponible!
^4CHANGELOG:^2 %s
^4DOWNLOAD:^2 %s
^6-----------------------------------------------------------------------
]]):format(_gv.script,_gv.version,_gv.changelog,_gv.link))
				    end
			    else
				    print((
                        [[
^6----------------------------------------------------------------------
^4INFORMATION: ^2Veuillez mettre à jour %s!
^4VERSION: ^2La version %s est disponible!
^4CHANGELOG:^2 %s
^4DOWNLOAD:^2 %s
^6-----------------------------------------------------------------------
]]):format(_gv.script,_gv.version,_gv.changelog,_gv.link))
                end
			else
				print(('[^6%s^0] [^1ERROR^0] Impossible de vérifier la version!'):format(tostring(_v.script)))
			end
		end, 'GET')
	end
end)

-------------------------------------------------------------------------------------------
--------------------------------VERSION CHECK----------------------------------------------
-------------------------------------------------------------------------------------------