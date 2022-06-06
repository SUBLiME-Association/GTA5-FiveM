shared = {}
shared.__index = shared

Sublime = Sublime or {}
Sublime.event = Sublime.event or {}
Sublime.trigger = Sublime.trigger or {}


function Sublime:RandomString(lenght)
    local upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local lowerCase = "abcdefghijklmnopqrstuvwxyz"
    local numbers = "0123456789"
    local symbols = "!@#$%&()*+-,./:;<=>?^[]{}"
    
    local characterSet = upperCase .. lowerCase .. numbers .. symbols
    
    local keyLength = lenght
    local output = ""
    
    for	i = 1, keyLength do
        local rand = math.random(#characterSet)
        output = output .. string.sub(characterSet, rand, rand)
    end
    
    return output
end

for _,v in pairs (Sublime.Config.Event) do
    v.name = v.name..Sublime:RandomString(Sublime.Config.lenght)
end


function Sublime:GetAllEvent()
    return Sublime.Config.Event
end
function Sublime:getEvent(key)
    local self = {}
    if type(key) ~= 'string' then
        return
    end
    if Sublime.Config.Event ~= key then
        self.key = key
        self.label = Sublime.Config.Event[key].label
        self.name = Sublime.Config.Event[key].name 
    end
    return setmetatable(self, shared) 
end


function Sublime.trigger:simple(key, ...)
    if Sublime:getEvent(key) ~= nil then
        TriggerEvent(Sublime:getEvent(key).name, ...)
    end
end


exports('Imports', function()
	return Sublime
end)