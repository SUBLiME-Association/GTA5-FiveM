-------------------------------------------------------------------------------------------
--------------------------------VERSION CHECK----------------------------------------------
-------------------------------------------------------------------------------------------

-- Ne pas toucher
local Version = 
([==[{ 
    "enable": true,
    "script": "sublime_playerCreator",
    "version": "0.0.1",
    "changelog": "Correction coord z au first spawn + possibiliter de créer un personnage chauve.",
    "link": "https://github.com/SUBLiME-Association/GTA5-FiveM/tree/main/%5Besx-legacy%5D/sublime_playerCreator-esxLegacy"
}]==])

local HTTPrequest = "https://raw.githubusercontent.com/SUBLiME-Association/version-script-sublime/main/sublime-playerCreator.json"

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
^7----------------------------------------------------------------------
^3INFORMATION: ^6Veuillez mettre à jour %s!
^3VERSION: ^6La version %s est disponible!
^3CHANGELOG:^6 %s
^3DOWNLOAD:^6 %s
^7-----------------------------------------------------------------------
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