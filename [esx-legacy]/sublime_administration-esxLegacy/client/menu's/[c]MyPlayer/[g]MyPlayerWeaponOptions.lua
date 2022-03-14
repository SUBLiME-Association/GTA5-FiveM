
local _ = {
    rank = nil;
    weaponType = {},
    aPerms = _Admin.Permissions.Button_myPlayer.inside.WeaponsOptions.inside,

}


function _Admin.Panel:MyPlayerWeaponOptions(rank)
    _.rank = rank
    RageUI.Button('S\'ajouter toutes les armes', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.GiveAllWeapons), {
        onSelected = function() 
            TriggerServerEvent(_Admin.Prefix.."GiveAllWeapon", _.rank)
            _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] C'est give toutes les armes")
        end
    });
    RageUI.Button('~r~Supprimer toutes vos armes', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.GiveAllWeapons), {
        onSelected = function() 
            TriggerServerEvent(_Admin.Prefix.."RemoveAllWeapon", _.rank)
            _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] A supprimmer toutes ces armes")
        end
    });
    RageUI.Line()
    for k,v in pairs(_Admin.Weapon.Type) do
        RageUI.Button(v.type, nil, {RightLabel = "~c~→→→"}, true, {
            onSelected = function()
                _.weaponType = v.type
            end
        }, _Admin.Menu.sub_myPlayerWeaponsOptions2);
    end
end



function _Admin.Panel:MyPlayerWeaponOptions2(rank)
    for k, v in pairs(_Admin.Weapon.List) do
        if v.type == _.weaponType then 
            RageUI.Button(ESX.GetWeaponLabel(v.name), nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.GiveSelectedWeapons), {
                onSelected = function()
                    local qty = KI("Quantité de ~o~munitions~s~", "", 15)
                    qty = tonumber(qty)
                    if type(qty) == 'number' then
                        qty = ESX.Math.Round(qty)
                        TriggerServerEvent(_Admin.Prefix.."GiveWeapon", _.rank, v.name, qty)
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] C'est give "..ESX.GetWeaponLabel(v.name).." avec "..qty.." munitions")
                    else
                        ESX.ShowNotification("~r~Quantité invalide")
                    end 
                end
            });
        end
    end
end