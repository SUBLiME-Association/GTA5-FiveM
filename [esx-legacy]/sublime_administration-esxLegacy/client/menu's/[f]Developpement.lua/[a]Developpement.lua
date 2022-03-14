
local _ = {
    rank = nil;
    checkLaser = false;
    checkTotalDeveloppement = false;
    aPerms = _Admin.Permissions.Button_Developpement.inside,

}




function _Admin.Panel:Developpement(rank)
    _.rank = rank
    local heading, coords = GetEntityHeading(PlayerPedId()), GetEntityCoords(PlayerPedId())

    if _Admin:HaveAccess(_.rank, _.aPerms.DevMode) then
        RageUI.Checkbox("Activé le mode développement total", nil, _.checkTotalDeveloppement, {}, {
            onChecked = function()
                _.checkTotalDeveloppement = true
                _Admin.addThread[11][1] = true
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À ^2activé^7 le mode ^3développement total ^7")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À activé le mode ^3développement total ")
            end,
            onUnChecked = function()
                _.checkTotalDeveloppement = false
                _Admin.addThread[11][1] = false
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À ^1désactivé^7 le mode ^3développement total ^7")
            end,
        })
    end

    RageUI.Button("Copier mes coordonées", ESX.Math.Round(coords.x, 2).." ~r~|~s~ " ..ESX.Math.Round(coords.y, 2) .." ~r~|~s~ "..ESX.Math.Round(coords.z, 2) .." ~r~|~s~ "..ESX.Math.Round(heading, 2) , {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.CopyCoords), {
        onSelected = function()
            SendNUIMessage({
                type = 'copy-coords',
                data = '' .. vec(coords.x, coords.y, coords.z, heading)
            })
            ESX.ShowNotification("Coordonées copier dans le presse-papiers ✔️")
            _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À copié ca position en vector4 ^7")
            _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À copié ca position en vector4 ("..vec(coords.x, coords.y, coords.z, heading)..")")
        end
    })

    if _Admin:HaveAccess(_.rank, _.aPerms.LazerInfo) then
        RageUI.Checkbox("Laser informations", nil, _.checkLaser, {}, {
            onChecked = function()
                _.checkLaser = true
                _Admin.addThread[10][1] = true
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À ^2activé^7 le mode ^3laser informations^7")
                _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À activé le mode laser informations")
            end,
            onUnChecked = function()
                _.checkLaser = false
                _Admin.addThread[10][1] = false
                _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À ^1désactivé^7 le mode ^3laser informations^7")
            end,
        })
    end



end