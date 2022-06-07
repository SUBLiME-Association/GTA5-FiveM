sCore = sCore or {}
sCore.Blip = sCore.Blip or {}
Sublime_Blips = {}
sCore.Blips = sCore.Blips or {}

local defaultParams = {
    sprite = 66,
    color = 5,
    display = 4, -- 4 map only / 8 map + minimap
    scale = 0.8,
    range = true,
    label = "Default Sublime Blips",
}


function sCore.Blip:CreateBlips(pos, params, type)
    local self = {} 
    self.id = AddBlipForCoord(pos.x, pos.y, pos.z)
    self.sprite = params.sprite or defaultParams['sprite']
    self.color = params.color or defaultParams['color']
    self.display = params.display or defaultParams['display']
    self.scale = params.scale or defaultParams['scale']
    self.range = params.range or defaultParams['range']
    self.label = params.label or defaultParams['label']
    self.exist = DoesBlipExist(self.id)
    self.type = type or 'none'
    SetBlipSprite (self.id, self.sprite)
    SetBlipDisplay(self.id, self.display)
    SetBlipScale  (self.id, self.scale)
    SetBlipColour (self.id, self.colour)
    SetBlipAsShortRange(self.id, self.range)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(self.label)
    EndTextCommandSetBlipName(self.id)
    sCore.Blips[#sCore.Blips+1] = {id = self.id, label = self.label, sprite = self.sprite, range = self.range, scale = self.scale, display = self.display, color = self.color, exist = self.exist, pos = pos, type = self.type}
    sCore.Table:ExportMetatable(Sublime_Blips, self)
    return setmetatable(self,  {__index = Sublime_Blips})
end

function sCore.Blip:GetBlips()
    if sCore.Blips then
        return sCore.Blips
    end
end

function Sublime_Blips:SetBlipParams(pos, params, type)
    if self.exist then
        self:RemoveBlips()
        self.id = AddBlipForCoord(pos.x, pos.y, pos.z)
        self.type = self.type or type
        SetBlipSprite(self.id, params.sprite or self.sprite)
        SetBlipDisplay(self.id, params.display  or self.display)
        SetBlipColour(self.id, params.color or self.color)
        SetBlipScale(self.id, params.scale or self.scale)
        SetBlipAsShortRange(self.id, params.range or self.range)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(params.label or self.label)
        EndTextCommandSetBlipName(self.id)
    end
end

function Sublime_Blips:RemoveBlips()
    if self.exist then
        RemoveBlip(self.id)
    end
end

function sCore.Blip:RemoveAllBlips()
    for i = 1, #sCore.Blips do
        RemoveBlip(sCore.Blips[i].id)
    end
end

function sCore.Blip:SetAllBlips()
    for i = 1, #sCore.Blips do
        sCore.Blips[i].id = AddBlipForCoord(sCore.Blips[i].pos.x, sCore.Blips[i].pos.y, sCore.Blips[i].pos.z)
        SetBlipSprite(sCore.Blips[i].id, sCore.Blips[i].sprite)
        SetBlipDisplay(sCore.Blips[i].id, sCore.Blips[i].display)
        SetBlipColour(sCore.Blips[i].id, sCore.Blips[i].color)
        SetBlipScale(sCore.Blips[i].id, sCore.Blips[i].scale)
        SetBlipAsShortRange(sCore.Blips[i].id, sCore.Blips[i].range)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(sCore.Blips[i].label)
        EndTextCommandSetBlipName(sCore.Blips[i].id)
    end
end

function sCore.Blip:GetBlipsByType(t)
    local blips = {}
    for i = 1, #sCore.Blips do
        if sCore.Blips[i].type == t then
            blips[#blips+1] = sCore.Blips[i]
        end 
    end
    return blips
end

function sCore.Blip:DeleteBlipsByType(t)
    for i = 1, #sCore.Blips do
        if sCore.Blips[i].type == t then
            RemoveBlip(sCore.Blips[i].id)
        end
    end
end

function sCore.Blip:SetAllBlipsByType(t)
    for i = 1, #sCore.Blips do
        if sCore.Blips[i].type == t then
            sCore.Blips[i].id = AddBlipForCoord(sCore.Blips[i].pos.x, sCore.Blips[i].pos.y, sCore.Blips[i].pos.z)
            SetBlipSprite(sCore.Blips[i].id, sCore.Blips[i].sprite)
            SetBlipDisplay(sCore.Blips[i].id, sCore.Blips[i].display)
            SetBlipColour(sCore.Blips[i].id, sCore.Blips[i].color)
            SetBlipScale(sCore.Blips[i].id, sCore.Blips[i].scale)
            SetBlipAsShortRange(sCore.Blips[i].id, sCore.Blips[i].range)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(sCore.Blips[i].label)
            EndTextCommandSetBlipName(sCore.Blips[i].id)
        end
    end
end


--------------------------------
-------- Utilisation -----------
--------------------------------



--CreateThread(function()
--    newBlip = sCore.Blip:CreateBlips(
--            vector3(100.0,200.0,10.0),
--       {  -- setting
--            sprite = 66,
--            color = 5,
--            display = 4, -- 4 map only / 8 map + minimap
--            scale = 0.8,
--            range = true,
--            label = "Your text",
--       },
--         'job' -- par defaut si non selectionné il vaut 'none'
--   ) 
--end)
--
--RegisterCommand('dt', function() 
--    newBlip:RemoveBlips(newBlip.id)
--end, false)

