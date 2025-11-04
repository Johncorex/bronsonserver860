
function onUse(cid, item, frompos, item2, topos)
	if item.uid == 1666 then
		if item.itemid == 1945 then

			player1pos = {x=1004, y=622, z=12, stackpos=253}
			player1 = getTopCreature(player1pos)

			player2pos = {x=1005, y=622, z=12, stackpos=253}
			player2 = getTopCreature(player2pos)

			player3pos = {x=1006, y=622, z=12, stackpos=253}
			player3 = getTopCreature(player3pos)

			player4pos = {x=1007, y=622, z=12, stackpos=253}
			player4 = getTopCreature(player4pos)


			if player1.itemid > 0 and player2.itemid > 0 and player3.itemid > 0 and player4.itemid > 0 then

				local player1level = getPlayerLevel(player1.uid)
				local player2level = getPlayerLevel(player2.uid)
				local player3level = getPlayerLevel(player3.uid)
				local player4level = getPlayerLevel(player4.uid)
				
				local questlevel = 100

				if player1level >= questlevel and player2level >= questlevel and player3level >= questlevel and player4level >= questlevel then

					queststatus1 = getPlayerStorageValue(player1.uid,5000)
					queststatus2 = getPlayerStorageValue(player2.uid,5000)
					queststatus3 = getPlayerStorageValue(player3.uid,5000)
					queststatus4 = getPlayerStorageValue(player4.uid,5000)

					if queststatus1 == -1 and queststatus2 == -1 and queststatus3 == -1 and queststatus4 == -1 then
	
						demon1pos = {x=1004, y=620, z=13}
						demon2pos = {x=1006, y=620, z=13}
						demon3pos = {x=1003, y=624, z=13}
						demon4pos = {x=1005, y=624, z=13}
						demon5pos = {x=1007, y=622, z=13}
						demon6pos = {x=1008, y=622, z=13}
					 
						doSummonCreature("Demon", demon1pos)
						doSummonCreature("Demon", demon2pos)
						doSummonCreature("Demon", demon3pos)
						doSummonCreature("Demon", demon4pos)
						doSummonCreature("Demon", demon5pos)
						doSummonCreature("Demon", demon6pos)

						nplayer1pos = {x=1003, y=622, z=13}
						nplayer2pos = {x=1004, y=622, z=13}
						nplayer3pos = {x=1005, y=622, z=13}
						nplayer4pos = {x=1006, y=622, z=13}

						doSendMagicEffect(player1pos,3)
						doSendMagicEffect(player2pos,3)
						doSendMagicEffect(player3pos,3)
						doSendMagicEffect(player4pos,3)

						doTeleportThing(player1.uid,nplayer1pos)
						doTeleportThing(player2.uid,nplayer2pos)
						doTeleportThing(player3.uid,nplayer3pos)
						doTeleportThing(player4.uid,nplayer4pos)

						doSendMagicEffect(nplayer1pos,11)
						doSendMagicEffect(nplayer2pos,11)
						doSendMagicEffect(nplayer3pos,11)
						doSendMagicEffect(nplayer4pos,11)

						doTransformItem(item.uid,item.itemid+1)

					else
						doPlayerSendCancel(cid,"Algum dos jogadores não pode fazer a quest.")
					end
					
				else
				doPlayerSendCancel(cid,"Algum dos jogadores não tem level suficiente.")
				end
				
			else
				doPlayerSendCancel(cid,"A equipe precisa ser de 4 jogadores.")
			end
			
		elseif item.itemid == 1946 then
			if getPlayerGroupId(cid) >= 4 then
				doTransformItem(item.uid,item.itemid-1)
			else
				doPlayerSendCancel(cid,"Uma equipe já entrou hoje, aguarde até amanhã.")
			end
		end
		
	elseif item.uid == 5001 then
		queststatus = getPlayerStorageValue(cid,5000)
		
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Você achou uma magic sword.")
			doPlayerAddItem(cid,2400,1)
			setPlayerStorageValue(cid,5000,1)
		else
			doPlayerSendTextMessage(cid,22,"Está vazia.")
		end
		
	elseif item.uid == 5002 then
		queststatus = getPlayerStorageValue(cid,5000)
		
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Você achou uma stonecutters axe.")
			doPlayerAddItem(cid,2431,1)
			setPlayerStorageValue(cid,5000,1)
		else
			doPlayerSendTextMessage(cid,22,"Está vazia.")
		end
	
	elseif item.uid == 5003 then
		queststatus = getPlayerStorageValue(cid,5000)
		
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Você achou um thunder hammer.")
			doPlayerAddItem(cid,2421,1)
			setPlayerStorageValue(cid,5000,1)
		else
			doPlayerSendTextMessage(cid,22,"Está vazia.")
		end
	
	elseif item.uid == 5004 then
		queststatus = getPlayerStorageValue(cid,5000)
		
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Você achou um heavy crossbow.")
			doPlayerAddItem(cid,5947,1)
			setPlayerStorageValue(cid,5000,1)
		else
			doPlayerSendTextMessage(cid,22,"Está vazia.")
		end
	end
	
return true

end