-- Armors Brutas

function onUse(cid, item, frompos, item2, topos)
	--primeiro as 3 alavancas
	
	if item.uid == 1301 then
		if item.itemid == 9827 then
			doTransformItem(item.uid,item.itemid+1)
		elseif item.itemid == 9828 then
			doTransformItem(item.uid,item.itemid-1)
		end
		
	elseif item.uid == 1302 then
		if item.itemid == 9827 then
			doTransformItem(item.uid,item.itemid+1)
		elseif item.itemid == 9828 then
			doTransformItem(item.uid,item.itemid-1)
		end
		
	elseif item.uid == 1303 then
		if item.itemid == 9827 then
			doTransformItem(item.uid,item.itemid+1)
		elseif item.itemid == 9828 then
			doTransformItem(item.uid,item.itemid-1)
		end
		
	--aqui ele tenta abrir o portao
	elseif item.uid == 1304 then
	
		local lever1pos = {x=1481, y=101, z=8, stackpos=2}
		local lever2pos = {x=1598, y=97, z=9, stackpos=2}
		local lever3pos = {x=1535, y=157, z=10, stackpos=2}
		
		local portaoPos = {x=1541, y=112, z=10, stackpos=1}
		
		local lever1 = getThingfromPos(lever1pos)
		local lever2 = getThingfromPos(lever2pos)
		local lever3 = getThingfromPos(lever3pos)
		
		local portao = getThingfromPos(portaoPos)
		
		if portao.itemid == 5733 then
			if lever1.itemid == 9828 and lever2.itemid == 9828 and lever3.itemid == 9828 then
				doTransformItem(portao.uid,portao.itemid+1)
			else 
				doPlayerSendCancel(cid,"Porta esta trancada.")
				return true
			end
		elseif portao.itemid == 5734 then
			doTransformItem(portao.uid,portao.itemid-1)
		end
		
		
	--bau dos itens
	elseif item.uid == 5040 then
		
		if getPlayerLevel(cid) < 240 then
			doPlayerSendTextMessage(cid,22,"Voce tem que estar no level 250 para completar esta quest.")
			return true
		end
		
		local queststatus = getPlayerStorageValue(cid,5070)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou a Divine Cuirass.")
			doPlayerAddItem(cid,9776,1)
			setPlayerStorageValue(cid,5070,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazia.")
		end
		
	elseif item.uid == 5041 then
		
		if getPlayerLevel(cid) < 240 then
			doPlayerSendTextMessage(cid,22,"Voce tem que estar no level 250 para completar esta quest.")
			return true
		end
		
		local queststatus = getPlayerStorageValue(cid,5070)
		
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou a Legolas Plate.")
			doPlayerAddItem(cid,8891,1)
			setPlayerStorageValue(cid,5070,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazia.")
		end
		
	elseif item.uid == 5042 then
		
		if getPlayerLevel(cid) < 240 then
			doPlayerSendTextMessage(cid,22,"Voce tem que estar no level 250 para completar esta quest.")
			return true
		end
		
		local queststatus = getPlayerStorageValue(cid,5070)
		
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou a Robe of Enchanted Twilight.")
			doPlayerAddItem(cid,8868,1)
			setPlayerStorageValue(cid,5070,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazia.")
		end
	end


	return true
end
