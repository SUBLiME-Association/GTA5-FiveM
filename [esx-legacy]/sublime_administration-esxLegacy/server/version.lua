-------------------------------------------------------------------------------------------
--------------------------------VERSION CHECK----------------------------------------------
-------------------------------------------------------------------------------------------
-- Ne pas toucher
local Version = 
([==[{ 
    "enable": true,
	"script": "sublime_administration",
    "version": "1.3",
    "changelog": "\n\t- Correction du noms des joueurs en ligne (prends identity si es_extended connfig.identity = true\n\t- Ajout du setJob joueur en ligne\n\t- Ajout du setJob player option\n\t- Modification du bouton revive joeur en ligne, passe par la commande esx /revive de esx_ambulancejob (possible de desactiver dans le config pour un revive standalone)",
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