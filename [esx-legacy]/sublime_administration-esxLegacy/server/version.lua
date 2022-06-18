-------------------------------------------------------------------------------------------
--------------------------------VERSION CHECK----------------------------------------------
-------------------------------------------------------------------------------------------
-- Ne pas toucher
local Version = 
([==[{ 
    "enable": true,
	"script": "sublime_administration",
    "version": "1.4.4",
    "changelog": "^2\n\t- 1.4.3 : Correction sur la vérification des Owners, vous pouvez à présent être plusieurs Owners dans la table : _Admin.MainUser,^2\n\t- 1.4.4 : Rajout de la fonction de base CheckOwner pour d'autre fonction qui l'utilisé sans problème,^2\n\t- 1.4.4 : Changement sur le fichier .sql suite au varchar sur l'identifier trop court pour cetaine licence rockstar.",
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