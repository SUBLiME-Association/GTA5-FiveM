local _ = {
    rank = nil;
 
    heritage = {
        mother = 1,
        dad = 1,
        ListMother = { "Hannah", "Aubrey", "Jasmine", "Gisele", "Amelia", "Isabella", "Zoe", "Ava", "Camila", "Violet", "Sophia", "Evelyn", "Nicole", "Ashley", "Gracie", "Brianna", "Natalie", "Olivia", "Elizabeth", "Charlotte", "Emma" },
        ListFather = { "Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony",  "Claude", "Niko" },
        slidecorps = 5,
        slideteint = 5,
    },
}


local function _GetMaxData(k, v)
    local data
    if v.type == 1 then
        data = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), v.componentId)-1, 1 do data[i] = i end
    elseif v.type == 2 then
        data = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), v.componentId, _Admin.ApparenceList[v.drawableId].index) - 1, 1 do data[i] = i end
    elseif v.type == 3 then 
        data = {} for i = 0 , GetNumHeadOverlayValues(v.componentId)-1, 1 do data[i] = i end
    elseif v.type == 4 then 
        data = {} for i = 0 , GetNumberOfPedPropDrawableVariations(PlayerPedId(), v.componentId)- 1, 1 do data[i] = i end
    elseif v.type == 5 then
        data = {} for i = 0, GetNumHairColors()-1, 1 do data[i] = i end
    elseif v.type == 6 then 
        data = {} for i = 1, v.maxData, 1 do table.insert(data, i) end
    elseif v.type == 7 then
        data = {} for i = 0 , GetNumberOfPedPropTextureVariations(PlayerPedId(), v.componentId, _Admin.ApparenceList[v.drawableId].index) - 1, 1 do data[i] = i end
    end
    return data
end



function _Admin.Panel:ChangeMyPlayerApparence(rank)
    _.rank = rank

  --  RageUI.Window.Heritage(_.heritage.mother - 1, _.heritage.dad - 1)
    RageUI.List('~c~Votre ~s~Mère :', _.heritage.ListMother, _.heritage.mother, "Sélectionner la Mère de votre Personnage", {}, true, { 
        onListChange = function(Index, Item) 
            _.heritage.mother = Index 
            TriggerEvent('skinchanger:change', 'mom', _.heritage.mother - 1) 
        end 
    })

    RageUI.List('~c~Votre ~s~Père :', _.heritage.ListFather, _.heritage.dad, "Sélectionner le Père de votre Personnage", {}, true, { 
        onListChange = function(Index, Item) 
            _.heritage.dad = Index 
            TriggerEvent('skinchanger:change', 'dad', _.heritage.dad - 1) 
        end 
    })

    RageUI.UISliderHeritage('~c~Ressemblance ~s~Corps', _.heritage.slidecorps, "Modifier la ressemblance de votre personnage", { 
        onSliderChange = function(Float, Index) 
            _.heritage.slidecorps = Index 
            TriggerEvent('skinchanger:change', 'face_md_weight', _.heritage.slidecorps * 10) 
        end
    })

    RageUI.UISliderHeritage('~c~Ressemblance ~s~Teint', _.heritage.slideteint, "Modifier la ressemblance de votre personnage", { 
        onSliderChange = function(Float, Index) 
            _.heritage.slideteint = Index 
            TriggerEvent('skinchanger:change', 'skin_md_weight', _.heritage.slideteint * 10) 
        end
    })
    
    RageUI.Line()

    for k,v in pairs(_Admin.ApparenceList) do
        if v.line then 
            RageUI.Line()
        else
            RageUI.List(v.label, _GetMaxData(k, v), v.index, nil, {Drawable = true}, true, {
                onListChange = function(Index, Item) 
                    v.index = Index
                    TriggerEvent('skinchanger:change', v.model, v.index - v.remove) 
                end, 
            })
        end
    end

end

