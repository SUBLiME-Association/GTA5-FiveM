
local _ = {
    rank = nil;
    shearchItem = nil;
    isShearch = false;
    aPerms = _Admin.Permissions.Button_myPlayer.inside.ItemsOptions.inside,

}


function _Admin.Panel:MyPlayerItemsList(rank)
    _.rank = rank
    RageUI.Button('Rechercher un item : ', nil, {RightLabel = "~c~→→→"},  _Admin:HaveAccess(_.rank, _.aPerms.GiveItem), {onSelected = function()
        _.shearchItem = KI("Rechercher un vehicule : ", "", 25)
        if _.shearchItem ~= nil then
            _.shearchItem = string.lower(_.shearchItem):gsub("^%l", string.upper)
            _.isShearch = true
        else
            _.isShearch = false
        end
    end});
    RageUI.Line()
    if not _.isShearch then
        for k,v in pairs(_Admin.ItemsList) do
            RageUI.Button(v.label, "Label = ~y~"..v.label.."~s~\nName = ~o~"..v.name.."~s~\nWeight = ~r~"..v.weight, {RightLabel = "~c~→→→"}, _Admin:HaveAccess(_.rank, _.aPerms.GiveItem), { 
                onSelected = function() 
                    local qty = KI("Quantité à ~g~s'ajouter~s~", "", 15)
                    qty = tonumber(qty)
                    if type(qty) == 'number' then
                        qty = ESX.Math.Round(qty)
                        TriggerServerEvent(_Admin.Prefix.."GiveItem", _.rank, v.label, v.name, tonumber(qty))
                        _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] C'est give "..qty.."x "..v.label)
                    else
                        ESX.ShowNotification("~r~Quantité invalide")
                    end 
                end 
            });
        end
    else
        for k,v in pairs(_Admin.ItemsList) do
            local FindItems = string.find(v.label, tostring((_.shearchItem):gsub("^%l", string.upper)))
            if FindItems then
                RageUI.Button(v.label, "Label : ~y~"..v.label.."~s~\nName : ~o~"..v.name.."~s~\nWeight : #~r~"..v.weight, {RightLabel = "~c~→→→"}, true, { 
                    onSelected = function() 
                        local qty = KI("Quantité à ~g~s'ajouter~s~", "", 15)
                        qty = tonumber(qty)
                        if type(qty) == 'number' then
                            qty = ESX.Math.Round(qty)
                            TriggerServerEvent(_Admin.Prefix.."GiveItem", _.rank, v.label, v.name, tonumber(qty))
                            _Admin.SendServerLogs("[".._.rank.name.." - "..GetPlayerName(PlayerId()).."] C'est give "..qty.."x "..v.label)
                        else
                            ESX.ShowNotification("~r~Quantité invalide")
                        end 
                    end 
                });
            end
        end
    end
end