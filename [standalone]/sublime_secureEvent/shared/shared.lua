shared = {}
shared.__index = shared

Sublime = Sublime or {}
Sublime.event = Sublime.event or {}
Sublime.trigger = Sublime.trigger or {}


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
        for k,v in pairs(Sublime.Config.Event)do
            if tostring(k) == tostring(key) then else
                if v.name == Sublime.Config.Event[key].name then
                    return print(string.format('[ERROR] Le name "%s" de votre key [%s] correspond à une key déjà enregister qui est [%s]', v.name, key, k))  
                end
            end
            break
        end
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