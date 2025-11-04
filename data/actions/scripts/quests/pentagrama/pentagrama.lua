-- Pentagrama by Brosnon

function onUse(cid, item, frompos, item2, topos)
	if item.uid == 1240 then
		if item.itemid == 1945 then
			
			local player1pos = {x=1621, y=854, z=14, stackpos=253}
			local player1 = getTopCreature(player1pos)
			
			local player2pos = {x=1622, y=854, z=14, stackpos=253}
			local player2 = getTopCreature(player2pos)
			
			local player3pos = {x=1623, y=854, z=14, stackpos=253}
			local player3 = getTopCreature(player3pos)
			
			local player4pos = {x=1624, y=854, z=14, stackpos=253}
			local player4 = getTopCreature(player4pos)
			
			local player5pos = {x=1625, y=854, z=14, stackpos=253}
			local player5 = getTopCreature(player5pos)
			
			
			if player1.itemid > 0 or player2.itemid > 0 or player3.itemid > 0 or player4.itemid > 0 or player5.itemid > 0 then
				
				local questlevelmin = 150
				
				if player1.uid ~= 0 then
					if getPlayerLevel(player1.uid) > 8 and getPlayerLevel(player1.uid) < questlevelmin then
						doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level minimo ("..questlevelmin..")")
						return true
					end
				end
				if player2.uid ~= 0 then
					if getPlayerLevel(player2.uid) > 8 and getPlayerLevel(player2.uid) < questlevelmin then
						doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level minimo ("..questlevelmin..")")
						return true
					end
				end
				if player3.uid ~= 0 then
					if getPlayerLevel(player3.uid) > 8 and getPlayerLevel(player3.uid) < questlevelmin then
						doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level minimo ("..questlevelmin..")")
						return true
					end
				end
				if player4.uid ~= 0 then
					if getPlayerLevel(player4.uid) > 8 and getPlayerLevel(player4.uid) < questlevelmin then
						doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level minimo ("..questlevelmin..")")
						return true
					end
				end
				if player5.uid ~= 0 then
					if getPlayerLevel(player5.uid) > 8 and getPlayerLevel(player5.uid) < questlevelmin then
						doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level minimo ("..questlevelmin..")")
						return true
					end
				end
				
				if 1 == 1 then
					
					local queststatus1 = 0
					local queststatus2 = 0
					local queststatus3 = 0
					local queststatus4 = 0
					local queststatus5 = 0
					
					if player1.itemid > 0 then
						queststatus1 = getPlayerStorageValue(player1.uid,5050)
					else
						queststatus1 = -1
					end
					if player2.itemid > 0 then
						queststatus2 = getPlayerStorageValue(player2.uid,5050)
					else
						queststatus2 = -1
					end
					if player3.itemid > 0 then
						queststatus3 = getPlayerStorageValue(player3.uid,5050)
					else
						queststatus3 = -1
					end
					if player4.itemid > 0 then
						queststatus4 = getPlayerStorageValue(player4.uid,5050)
					else
						queststatus4 = -1
					end
					if player5.itemid > 0 then
						queststatus5 = getPlayerStorageValue(player5.uid,5050)
					else
						queststatus5 = -1
					end
					
					if queststatus1 == -1 and queststatus2 == -1 and queststatus3 == -1 and queststatus4 == -1 and queststatus5 == -1 then
						
						if player1.itemid > 0 then
							local nplayer1pos = {x=1698, y=830, z=14}
							doSendMagicEffect(player1pos,3)
							doTeleportThing(player1.uid,nplayer1pos)
							doSendMagicEffect(nplayer1pos,10)
							doPlayerRemoveItem(player1.uid, 2086, 2)
							doPlayerRemoveItem(player1.uid, 2086, 1)
							doPlayerRemoveItem(player1.uid, 2086, 1)
							doPlayerRemoveItem(player1.uid, 2086, 1)
						end
						if player2.itemid > 0 then
							local nplayer2pos = {x=1699, y=830, z=14}
							doSendMagicEffect(player2pos,3)
							doTeleportThing(player2.uid,nplayer2pos)
							doSendMagicEffect(nplayer2pos,10)
							doPlayerRemoveItem(player2.uid, 2086, 2)
							doPlayerRemoveItem(player2.uid, 2086, 1)
							doPlayerRemoveItem(player2.uid, 2086, 1)
							doPlayerRemoveItem(player2.uid, 2086, 1)
						end
						if player3.itemid > 0 then
							local nplayer3pos = {x=1700, y=830, z=14}
							doSendMagicEffect(player3pos,3)
							doTeleportThing(player3.uid,nplayer3pos)
							doSendMagicEffect(nplayer3pos,10)
							doPlayerRemoveItem(player3.uid, 2086, 2)
							doPlayerRemoveItem(player3.uid, 2086, 1)
							doPlayerRemoveItem(player3.uid, 2086, 1)
							doPlayerRemoveItem(player3.uid, 2086, 1)
						end
						if player4.itemid > 0 then
							local nplayer4pos = {x=1701, y=830, z=14}
							doSendMagicEffect(player4pos,3)
							doTeleportThing(player4.uid,nplayer4pos)
							doSendMagicEffect(nplayer4pos,10)
							doPlayerRemoveItem(player4.uid, 2086, 2)
							doPlayerRemoveItem(player4.uid, 2086, 1)
							doPlayerRemoveItem(player4.uid, 2086, 1)
							doPlayerRemoveItem(player4.uid, 2086, 1)
						end
						if player5.itemid > 0 then
							local nplayer5pos = {x=1702, y=830, z=14}
							doSendMagicEffect(player5pos,3)
							doTeleportThing(player5.uid,nplayer5pos)
							doSendMagicEffect(nplayer5pos,10)
							doPlayerRemoveItem(player5.uid, 2086, 2)
							doPlayerRemoveItem(player5.uid, 2086, 1)
							doPlayerRemoveItem(player5.uid, 2086, 1)
							doPlayerRemoveItem(player5.uid, 2086, 1)
						end
						
						doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você borrou suas melhores calças")
						
						balrogPos = {x=1699, y=838, z=14}
						doSummonCreature("gothmog", balrogPos)
						
						doTransformItem(item.uid,item.itemid+1)
						
					else
					doPlayerSendCancel(cid,"Algum dos jogadores já fez esta quest.")
					end
				else
					doPlayerSendCancel(cid,"Algum dos jogadores não tem o level correto para fazer a quest (150).")
				end
			else
				doPlayerSendCancel(cid,"Somente é possivel entrar em grupos de 5 jogadores.")
			end
			
			
		elseif item.itemid == 1946 then
			
			if getPlayerGroupId(cid) >= 4 then
				doTransformItem(item.uid,item.itemid-1)
			else
				doPlayerSendCancel(cid,"Um grupo entrou recentemente e ainda nao esta liberada.")
			end
		end
		
	elseif item.uid == 1241 then --primeira sala
		if item.itemid == 1945 then
			
            local lever1pos = getTileItemById ({x=1698, y=846, z=14, stackpos=2},1946)
			local lever2pos = getTileItemById ({x=1679, y=833, z=14, stackpos=2},1946)
			local lever3pos = getTileItemById ({x=1686, y=807, z=14, stackpos=2},1946)
			local lever4pos = getTileItemById ({x=1711, y=807, z=14, stackpos=2},1946)
			local lever5pos = getTileItemById ({x=1718, y=833, z=14, stackpos=2},1946)

			
		    local portao = getTileItemById ({x=1699, y=824, z=13, stackpos=1},5733)
			
			--abre o portao de cima
			if portao.itemid == 5733 then
				if lever2pos.itemid == 1946 and lever3pos.itemid == 1946 and lever4pos.itemid == 1946 and lever5pos.itemid == 1946 then
					doTransformItem(portao.uid,portao.itemid+1)
					doTransformItem(item.uid,item.itemid+1)
				else 
					doPlayerSendCancel(cid,"Você não consegue mover esta alavanca.")
				end
			end
			
		elseif item.itemid == 1946 then
			--doPlayerSendCancel(cid,"Voce nao consegue mover esta alavanca.")
			doTransformItem(item.uid,item.itemid-1)
		end
		
	elseif item.uid == 1242 then
		if item.itemid == 1945 then
			doTransformItem(item.uid,item.itemid+1)
		elseif item.itemid == 1946 then
			doTransformItem(item.uid,item.itemid-1)
		end
		
	elseif item.uid == 1243 then
		if item.itemid == 1945 then
			doTransformItem(item.uid,item.itemid+1)
		elseif item.itemid == 1946 then
			doTransformItem(item.uid,item.itemid-1)
		end
		
	elseif item.uid == 1244 then
		if item.itemid == 1945 then
			doTransformItem(item.uid,item.itemid+1)
		elseif item.itemid == 1946 then
			doTransformItem(item.uid,item.itemid-1)
		end
		
	elseif item.uid == 1245 then
		if item.itemid == 1945 then
			doTransformItem(item.uid,item.itemid+1)
		elseif item.itemid == 1946 then
			doTransformItem(item.uid,item.itemid-1)
		end
		
	elseif item.uid == 5005 then
		local queststatus = getPlayerStorageValue(cid,5050)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Você achou a Anduril.")
			doPlayerAddItem(cid,2390,1)
			setPlayerStorageValue(cid,5050,1)
		else
			doPlayerSendTextMessage(cid,22,"Está vazia.")
		end
		
	elseif item.uid == 5006 then
		local queststatus = getPlayerStorageValue(cid,5050)
		
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Você achou a Dramborleg.")
			doPlayerAddItem(cid,7413,1)
			setPlayerStorageValue(cid,5050,1)
		else
			doPlayerSendTextMessage(cid,22,"Está vazia.")
		end
		
	elseif item.uid == 5007 then
		local queststatus = getPlayerStorageValue(cid,5050)
		
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Você achou a Grond.")
			doPlayerAddItem(cid,7415,1)
			setPlayerStorageValue(cid,5050,1)
		else
			doPlayerSendTextMessage(cid,22,"Está vazia.")
		end
		
	elseif item.uid == 5008 then
		local queststatus = getPlayerStorageValue(cid,5050)
		
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Você achou uma Chain Bolter.")
			doPlayerAddItem(cid,8850,1)
			setPlayerStorageValue(cid,5050,1)
		else
			doPlayerSendTextMessage(cid,22,"Está vazia.")
		end	
	end


	return 1
end
