Sublime = Sublime or {}
Sublime.event = Sublime.event or {}
Sublime.trigger = Sublime.trigger or {}




function Sublime.event:server(register, listen, key, fonction)
    if Sublime:getEvent(key) ~= nil then
        if register then
            RegisterServerEvent(Sublime:getEvent(key).name)
        end
        if listen then
            AddEventHandler(Sublime:getEvent(key).name, function(...)
                if fonction ~= nil then
                    fonction(...)
                end
            end)
        end
    end
end

function Sublime.trigger:client(key, ...)
    if Sublime:getEvent(key) ~= nil then
        TriggerClientEvent(Sublime:getEvent(key).name, ...)
    end
end


exports('Imports', function()
	return Sublime
end)
