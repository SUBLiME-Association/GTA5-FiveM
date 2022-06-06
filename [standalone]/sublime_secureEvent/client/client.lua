Sublime = Sublime or {}
Sublime.event = Sublime.event or {}
Sublime.trigger = Sublime.trigger or {}

function Sublime.event:client(register, listen, key, fonction)
    if Sublime:getEvent(key) ~= nil then
        if register then
            RegisterNetEvent(Sublime:getEvent(key).name)
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

function Sublime.trigger:server(key, ...)
    if Sublime:getEvent(key) ~= nil then
        TriggerServerEvent(Sublime:getEvent(key).name, ...)
    end
end

exports('Imports', function()
	return Sublime
end)

--[[
    function detest(a,b)
        return print(a + b)
    end
    Sublime.event:client(true, true, 'test1', detest)
]]

--CreateThread(function()
--    Sublime.trigger:simple('test1', 1, 5)
--end)
