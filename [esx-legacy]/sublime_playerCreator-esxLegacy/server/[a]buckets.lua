
---@param InOrOut boolean
---@return SetPlayerBuckets
---@public
RegisterServerEvent(Config.Prefix.."Buckets")
AddEventHandler(Config.Prefix.."Buckets", function(InOrOut)
    local _src = source
    if InOrOut then
        SetPlayerRoutingBucket(_src, GetPlayerIdentifier(_src))
    else
        SetPlayerRoutingBucket(_src, 0)
    end
end)