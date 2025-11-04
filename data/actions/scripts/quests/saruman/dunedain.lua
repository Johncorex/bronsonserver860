--Quest das armas de level 200

function onUse(cid, item, frompos, item2, topos)

	if item.itemid == 1746 and item.uid >= 5011 and item.uid <= 5018 then
		
		if getPlayerLevel(cid) < 200 then
			doPlayerSendTextMessage(cid,22,"Voce deve estar no level 200.")
			return FALSE
		end
		
		local queststatus = getPlayerStorageValue(cid,5060)
		
		if queststatus == -1 then
			setPlayerStorageValue(cid,5060,1)
			
			if item.uid == 5011 then
				doPlayerSendTextMessage(cid,22,"Voce achou a Narsil.")
				doPlayerAddItem(cid,6528,1)
			elseif item.uid == 5012 then
				doPlayerSendTextMessage(cid,22,"Voce achou o Aghanims Scepter.")
				doPlayerAddItem(cid,7424,1)
			elseif item.uid == 5013 then
				doPlayerSendTextMessage(cid,22,"Voce achou o Eaglehorn.")
				doPlayerAddItem(cid,8855,1)
			elseif item.uid == 5014 then
				doPlayerSendTextMessage(cid,22,"Voce achou a Glamdring.")
				doPlayerAddItem(cid,7414,1)
			elseif item.uid == 5015 then
				doPlayerSendTextMessage(cid,22,"Voce achou um Royal crossbow.")
				doPlayerAddItem(cid,8851,1)
			elseif item.uid == 5016 then
				doPlayerSendTextMessage(cid,22,"Voce achou a Aiglos.")
				doPlayerAddItem(cid,2425,1)
			elseif item.uid == 5017 then
				doPlayerSendTextMessage(cid,22,"Voce achou o Machado de Durin.")
				doPlayerAddItem(cid,8924,1)
			elseif item.uid == 5018 then
				doPlayerSendTextMessage(cid,22,"Voce achou a Mekansm.")
				doPlayerAddItem(cid,7410,1)
			end
			
		else
			doPlayerSendTextMessage(cid,22,"Esta vazia.")
		end
	end
	
	return true

end
