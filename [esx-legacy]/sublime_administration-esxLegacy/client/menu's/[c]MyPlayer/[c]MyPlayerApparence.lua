
local _ = {
    rank = nil;
    aPerms = _Admin.Permissions.Button_myPlayer.inside.MyApparence.inside,

}


function _Admin.Panel:MyPlayerApparence(rank)
    _.rank = rank

    RageUI.Button('Modifier mon apparence', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.ChangeApparence), {}, _Admin.Menu.sub_myPlayerChangeApparence);
    RageUI.Button('Ajouter mon apparence au favoris', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SaveApparence), {
        onSelected = function()
            local name = KI("Donner un nom à votre apparence", "", 25)
            if name ~= nil and name ~= "" then
                Citizen.CreateThread(function()
                    TriggerEvent('skinchanger:getSkin', function(saveApparence)
                        Wait(25)
                        _Admin.Print("[^1".._.rank.name.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] À ajouter une nouvelle apparence au favoris ^6"..name.."^7")
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] À ajouter une nouvelle apparence au favoris :"..name)
                        TriggerServerEvent(_Admin.Prefix.."SaveData", "apparence", name, saveApparence)
                    end)
                end)
            end
        end
    });
    RageUI.Button('Sélection d\'un ped/apparence', nil, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.SelectApparence), {
        onSelected = function()
            _Admin.RefreshSublimeData()
        end
    }, _Admin.Menu.sub_myPlayerApparencePedList);

end 