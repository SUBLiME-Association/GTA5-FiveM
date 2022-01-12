
---Update Identity in Data Base
---@param args.firstName string
---@param args.lastName string
---@param args.dateOfBirth string
---@param args.sex string
---@param args.height number
---@public
RegisterServerEvent(Config.Prefix..'updateIdentity')
AddEventHandler(Config.Prefix..'updateIdentity', function(args)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    MySQL.Sync.execute('UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height WHERE identifier = @identifier', {
        ['@identifier']  = xPlayer.identifier,
        ['@firstname'] = args.firstName,
        ['@lastname'] = args.lastName,
        ['@dateofbirth'] = args.dateOfBirth,
        ['@sex'] = args.sex,
        ['@height'] = args.height
    })
    xPlayer.setName(('%s %s'):format(args.firstName, args.lastName))
    xPlayer.set('firstName', args.firstName)
    xPlayer.set('lastName', args.lastName)
    xPlayer.set('dateofbirth', args.dateOfBirth)
    xPlayer.set('sex', args.sex)
    xPlayer.set('height', args.height)
end)