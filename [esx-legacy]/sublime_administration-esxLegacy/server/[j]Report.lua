
local ReportData = {}


RegisterCommand("report", function(source, args, rawCommand)
	if args[1] ~= nil then
		local xPlayer = ESX.GetPlayerFromId(source)
		table.insert(ReportData, {
			player = source,
			playerName = GetPlayerName(source),
			message = args
		})
		xPlayer.showNotification("Report envoyé avec succès")
		_Admin.Print("[^1NEW REPPORT ^7- ^2"..GetPlayerName(source).."^7] Message : ^6".. table.concat(args, " ").."^7")
	end
end)



ESX.RegisterServerCallback(_Admin.Prefix.."GetReports", function(source, cb, type)
	cb(ReportData)
end)


RegisterServerEvent(_Admin.Prefix.."ManageReports")
AddEventHandler(_Admin.Prefix.."ManageReports", function(type, args)
	if type == "clearall" then
		ReportData = {}
	elseif type == "delete_report" then
		table.remove(ReportData, args.index)
	end
end)

