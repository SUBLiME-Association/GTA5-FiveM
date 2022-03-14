
_Admin.Send_Logs = function(Description)
	local Content = {
	        {
				["color"] = _Admin.Logs.Color,
				["description"] = Description,
				["footer"] = {
					["icon_url"] = _Admin.Logs.IconURL,
				},
	        }
	    }
	PerformHttpRequest(_Admin.Logs.WebHook, function(err, text, headers) end, 'POST', json.encode({username = _Admin.Logs.BotName, embeds = Content, avatar_url = _Admin.Logs.IconURL}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent(_Admin.Prefix.."SendServerLogs")
AddEventHandler(_Admin.Prefix.."SendServerLogs", function(msg)
	_Admin.Send_Logs("```"..msg.."```")
end)