
local _ = {
    rank = nil;

}


function _Admin.Panel:MyPlayerApparencePedList(rank)
    _.rank = rank

    RageUI.Button('Liste des ped models', nil, {RightLabel = "~c~→→→"}, true, {}, _Admin.Menu.sub_myPlayerApparencePedList2);
    RageUI.Button('Prendre mon apparence initial', nil, {RightLabel = "~c~→→→"}, true, {
        onSelected = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadDefaultModel', skin.sex, function()
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
            end)
        end
    });
    RageUI.Line()
    RageUI.Separator("↓     Apparence Favoris     ↓")
    for k,v in pairs (_Admin.Data) do 
        if v.type == "apparence" then
            RageUI.Button(v.name, nil, {RightLabel = "~c~→→→"}, true, {
                onSelected = function()
                    Citizen.CreateThread(function() 
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            TriggerEvent('skinchanger:loadClothes', skin, json.decode(v.data))
                            Citizen.Wait(50)
                            TriggerEvent('skinchanger:getSkin', function(skin_)
                                TriggerServerEvent('esx_skin:save', skin_)
                            end)
                        end)
                    end)
                end
            });
        end
    end
end



local function LoadPed(pedName)
    local pedHash = GetHashKey(pedName)
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(100)
    end
    SetPlayerModel(PlayerId(), pedHash)
    SetModelAsNoLongerNeeded(pedHash)
end



function _Admin.Panel:MyPlayerApparencePedList2(rank)
    _.rank = rank
    for k,v in pairs(_Admin.PedList) do 
        RageUI.Button(v.label, nil, {RightLabel = "~c~→→→"}, true, {
            onSelected = function()
                LoadPed(v.name)
            end
        });
    end
end