RegisterNetEvent("spk_shops:BuyItem")
AddEventHandler("spk_shops:BuyItem", function(itemName, itemCount, itemLabel, price, typeMoney)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local totalPrice = price*itemCount
	--> Condition Pour de la Money choisit dans le shop pour payer <--
	if(typeMoney == 'money')then
		checkMoney = xPlayer.getMoney()
	elseif(typeMoney == 'bank')then
		checkMoney = xPlayer.getAccount("bank").money
	elseif(typeMoney == 'black_money')then
		checkMoney = xPlayer.getAccount("black_money").money
	else
		print("[ERROR] Ce type d'argent n'existe pas!(Condition : typeMoney)")
	end
	---> Le paiement <--
	if checkMoney >= totalPrice then
		if xPlayer.canCarryItem(itemName, itemCount) then
			if(typeMoney == 'money')then
				xPlayer.removeMoney(totalPrice)
				xPlayer.addInventoryItem(itemName, itemCount)
				TriggerClientEvent("[supv]:SimpleNotification", _source, "~u~Vous avez acheté ~w~x"..itemCount.." ~b~"..F:FirstToUpper(itemLabel).." ~u~ pour ~g~"..F:MathRound(totalPrice).."$", false, true, 130)
				TriggerClientEvent("[spk_shops]:buyText", _source, 1)
			elseif(typeMoney == 'bank')then
				xPlayer.removeAccountMoney('bank', totalPrice)
				xPlayer.addInventoryItem(itemName, itemCount)
				TriggerClientEvent("[supv]:SimpleNotification", _source, "~u~Vous avez acheté ~w~x"..itemCount.." ~b~"..F:FirstToUpper(itemLabel).." ~u~ pour ~g~"..F:MathRound(totalPrice).."$", false, true, 130)
				TriggerClientEvent("[spk_shops]:buyText", _source, 1)
			elseif(typeMoney == 'black_money')then
				xPlayer.removeAccountMoney('black_money', totalPrice)
				xPlayer.addInventoryItem(itemName, itemCount)
				TriggerClientEvent("[supv]:SimpleNotification", _source, "~u~Vous avez acheté ~w~x"..itemCount.." ~b~"..F:FirstToUpper(itemLabel).." ~u~ pour ~g~"..F:MathRound(totalPrice).."$", false, true, 130)
				TriggerClientEvent("[spk_shops]:buyText", _source, 1)
			else
				print("[ERROR] Ce type d'argent n'existe pas! (Condition : CanCarryItem)")
			end
		else
			TriggerClientEvent("[supv]:SimpleNotification", _source, "~u~Vous n'avez pas de place de l'inventaire!", false, true, 90)
			TriggerClientEvent("[spk_shops]:buyText", _source, 2)
		end
	else
		TriggerClientEvent("[supv]:SimpleNotification", _source, "~u~Vous n'avez pas assez d'argent!", false, true, 90)
		TriggerClientEvent("[spk_shops]:buyText", _source, 3)
	end
end)