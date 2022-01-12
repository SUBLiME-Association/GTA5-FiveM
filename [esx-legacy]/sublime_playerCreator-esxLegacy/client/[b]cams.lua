---@class iCam 
local iCam = {
    CharacterCreator = {
        main = nil,
        head = nil,
        torso = nil,
        pants = nil,
        shoes = nil,
    }
}

---CamsCharacterCreator
---@public
function SublimeIndex.CamsCharacterCreator()
    iCam.CharacterCreator.main = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', -770.13348389,322.37780762,195.88615417, -0.0000, -0.0000, -87.3369, 43.0557, false, 2)
    SetCamActive(iCam.CharacterCreator.main, true)
    RenderScriptCams(true, false, 3000, true, false, false)
    if iCam.CharacterCreator.head then
        SetCamActiveWithInterp(iCam.CharacterCreator.main, iCam.CharacterCreator.head, 2000, true, true)
        iCam.CharacterCreator.head = nil
    elseif iCam.CharacterCreator.torso ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.main, iCam.CharacterCreator.torso, 2000, true, true)
        iCam.CharacterCreator.torso = nil
    elseif iCam.CharacterCreator.pants ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.main, iCam.CharacterCreator.pants, 2000, true, true)
        iCam.CharacterCreator.pants = nil
    elseif iCam.CharacterCreator.shoes ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.main, iCam.CharacterCreator.shoes, 2000, true, true)
        iCam.CharacterCreator.shoes = nil
    end
end


---CamsCharacterCreator_Head
---@public
function SublimeIndex.CamsCharacterCreator_Head()
    iCam.CharacterCreator.head = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', -770.13348389,322.87780762,195.98615417, 5.0000, -0.0000, -87.3369, 43.0557, false, 2)
    SetCamActive(iCam.CharacterCreator.head, true)
    SetCamFov(iCam.CharacterCreator.head, 20.)
    RenderScriptCams(true, false, 3000, true, false, false)
    if iCam.CharacterCreator.main ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.head, iCam.CharacterCreator.main, 2000, true, true)
        iCam.CharacterCreator.main = nil
    elseif iCam.CharacterCreator.torso ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.head, iCam.CharacterCreator.torso, 2000, true, true)
        iCam.CharacterCreator.torso = nil
    elseif iCam.CharacterCreator.pants ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.head, iCam.CharacterCreator.pants, 2000, true, true)
        iCam.CharacterCreator.pants = nil
    elseif iCam.CharacterCreator.shoes ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.head, iCam.CharacterCreator.shoes, 2000, true, true)
        iCam.CharacterCreator.shoes = nil
    end
end


---CamsCharacterCreator_Torso
---@public
function SublimeIndex.CamsCharacterCreator_Torso()
    iCam.CharacterCreator.torso = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', -770.13348389,322.87780762,195.98615417, -5.0000, -0.0000, -87.3369, 43.0557, false, 2)
    SetCamActive(iCam.CharacterCreator.torso, true)
    SetCamFov(iCam.CharacterCreator.torso, 20.)
    RenderScriptCams(true, false, 3000, true, false, false)
    if iCam.CharacterCreator.main ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.torso, iCam.CharacterCreator.main, 2000, true, true)
        iCam.CharacterCreator.main = nil
    elseif iCam.CharacterCreator.head ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.torso, iCam.CharacterCreator.head, 2000, true, true)
        iCam.CharacterCreator.head = nil
    elseif iCam.CharacterCreator.pants ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.torso, iCam.CharacterCreator.pants, 2000, true, true)
        iCam.CharacterCreator.pants = nil
    elseif iCam.CharacterCreator.shoes ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.torso, iCam.CharacterCreator.shoes, 2000, true, true)
        iCam.CharacterCreator.shoes = nil
    end
end


---CamsCharacterCreator_Pants
---@public
function SublimeIndex.CamsCharacterCreator_Pants()
    iCam.CharacterCreator.pants = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', -770.13348389,322.87780762,195.98615417, -16.0000, -0.0000, -87.3369, 43.0557, false, 2)
    SetCamActive(iCam.CharacterCreator.pants, true)
    SetCamFov(iCam.CharacterCreator.pants, 32.)
    RenderScriptCams(true, false, 3000, true, false, false)
    if iCam.CharacterCreator.main ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.pants, iCam.CharacterCreator.main, 2000, true, true)
        iCam.CharacterCreator.main = nil
    elseif iCam.CharacterCreator.head ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.pants, iCam.CharacterCreator.head, 2000, true, true)
        iCam.CharacterCreator.head = nil
    elseif iCam.CharacterCreator.torso ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.pants, iCam.CharacterCreator.torso, 2000, true, true)
        iCam.CharacterCreator.torso = nil
    elseif iCam.CharacterCreator.shoes ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.pants, iCam.CharacterCreator.shoes, 2000, true, true)
        iCam.CharacterCreator.shoes = nil
    end
end

---CamsCharacterCreator_Shoes
---@public
function SublimeIndex.CamsCharacterCreator_Shoes()
    iCam.CharacterCreator.shoes = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', -770.13348389,322.87780762,195.98615417, -28.0000, -0.0000, -87.3369, 43.0557, false, 2)
    SetCamActive(iCam.CharacterCreator.shoes, true)
    SetCamFov(iCam.CharacterCreator.shoes, 30.)
    RenderScriptCams(true, false, 3000, true, false, false)
    if iCam.CharacterCreator.main ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.shoes, iCam.CharacterCreator.main, 2000, true, true)
        iCam.CharacterCreator.main = nil
    elseif iCam.CharacterCreator.head ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.shoes, iCam.CharacterCreator.head, 2000, true, true)
        iCam.CharacterCreator.head = nil
    elseif iCam.CharacterCreator.torso ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.shoes, iCam.CharacterCreator.torso, 2000, true, true)
        iCam.CharacterCreator.torso = nil
    elseif iCam.CharacterCreator.pants ~= nil then
        SetCamActiveWithInterp(iCam.CharacterCreator.shoes, iCam.CharacterCreator.pants, 2000, true, true)
        iCam.CharacterCreator.pants = nil
    end
end

---DestroyCams
---@return SublimeIndex  DestroyCams
---@public
function SublimeIndex.DestroyCams()
    DestroyAllCams(false)
    RenderScriptCams(false, true, 1500, false, false)
end
