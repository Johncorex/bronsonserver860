function onUse(cid, item, frompos, item2, topos)
	local keyId = 2091 -- golden key
	local requiredActionId = 666
	local destination = {x = 516, y = 544, z = 8}

	-- Verifica se o item usado (chave) e a estátua têm o actionid correto
	if item.actionid == requiredActionId and item2.actionid == requiredActionId then
		if getPlayerItemCount(cid, keyId) >= 1 then
			doTeleportThing(cid, destination)
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Você precisa da chave 666!")
		end
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Nada acontece.")
	end

	return true
end
