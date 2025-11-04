-- Alavancas aberta 1945 fechada 1946

function onUse(cid, item, frompos, item2, topos)
	
	if item.uid == 5010 then
		if getPlayerLevel(cid) <= 50 then
		doPlayerSendCancel(cid,"Voce nao tem level suficiente para mover esta alavanca..")
         return true
		 end
			if item.itemid == 1945 then
			doTransformItem(item.uid,item.itemid+1)
			doRemoveItem(4000)
		elseif item.itemid == 1946 then
			doPlayerSendCancel(cid,"Ela esta emperrada.")
		end
		
			end

	return true
end

		



