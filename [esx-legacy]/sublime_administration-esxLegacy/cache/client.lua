local _cache = {}
cache = setmetatable(_cache,{
    __index = function(t,k)
        local v = _cache[k]
        if v then
            return v
        end
    end,
})

CreateThread(function()
    _cache.playerPedId = PlayerPedId()
    _cache.playerId = PlayerId()
    _cache.serverId = GetPlayerServerId(_cache.playerId)
    _cache.playerName = GetPlayerName(_cache.playerId) 
end)

playersCache = {}
local _playersCache = {}

function RefreshPlayersCallback()
    _playersCache = nil
    ESX.TriggerServerCallback(_Admin.Prefix.."GetAllPlayersOnline", function(data)
        _playersCache = data
    end)
    CachePlayers()
end

function CachePlayers()
    local _newCache = {}
    while not _playersCache do Wait(50) end
    if _playersCache then
        for k,v in pairs(_playersCache)do
            _newCache[#_newCache+1] = {
                serverId = v.serverId,
                playerId = GetPlayerFromServerId(v.serverId),
                gtaName = v.gtaName,
                playerName = v.playerName,
                jobLabel = v.jobLabel,
                jobGrade = v.jobGrade,
                jobGradeLabel = v.jobGradeLabel,
                jobSalary = v.jobSalary,
                inventory = v.inventory,
            }
        end
        playersCache = setmetatable(_newCache,
        {
            __index = function(t,k)
                local v = _newCache[k]
                if v then
                    return v
                end
            end,
        })
        collectgarbage()
    end
end

