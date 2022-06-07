sCore = sCore or {}
sCore.Table = sCore.Table or {}


function sCore.Table:ExportMetatable(metatable, class)
    for name, v in pairs(metatable) do
        class[name] = function(o, ...)
            return (v(o, ...))
        end
    end
end