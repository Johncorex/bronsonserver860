-- Edoras City Quest by Bronson --

function onUse(cid, item, frompos, item2, topos)
if item.uid == 1250 then
	if item.itemid == 1945 then
		
		local player1pos = {x=935, y=1314, z=6, stackpos=253}
		local player1 = getTopCreature(player1pos)
		
		local player2pos = {x=936, y=1314, z=6, stackpos=253}
		local player2 = getTopCreature(player2pos)
		
		local player3pos = {x=937, y=1314, z=6, stackpos=253}
		local player3 = getTopCreature(player3pos)
		
		local player4pos = {x=938, y=1314, z=6, stackpos=253}
		local player4 = getTopCreature(player4pos)
		
		
		if player1.itemid > 0 and player2.itemid > 0 and player3.itemid > 0 and player4.itemid > 0 then
			
			local player1level = getPlayerLevel(player1.uid)
			local player2level = getPlayerLevel(player2.uid)
			local player3level = getPlayerLevel(player3.uid)
			local player4level = getPlayerLevel(player4.uid)
			
			local questlevelmin = 230
			local questlevelmax = 1000
			
			
			if player1level >= questlevelmin and player2level >= questlevelmin and player3level >= questlevelmin and player4level >= questlevelmin and player1level <= questlevelmax and player2level <= questlevelmax and player3level <= questlevelmax and player4level <= questlevelmax then
				
				local queststatus1 = getPlayerStorageValue(player1.uid,5080)
				local queststatus2 = getPlayerStorageValue(player2.uid,5080)
				local queststatus3 = getPlayerStorageValue(player3.uid,5080)
				local queststatus4 = getPlayerStorageValue(player4.uid,5080)
				
				if queststatus1 == -1 and queststatus2 == -1 and queststatus3 == -1 and queststatus4 == -1 then
					
					local nplayer1pos = {x=676, y=1383, z=8}
					local nplayer2pos = {x=677, y=1383, z=8}
					local nplayer3pos = {x=678, y=1383, z=8}
					local nplayer4pos = {x=679, y=1383, z=8}
					
					doSendMagicEffect(player1pos,3)
					doSendMagicEffect(player2pos,3)
					doSendMagicEffect(player3pos,3)
					doSendMagicEffect(player4pos,3)
					
					doTeleportThing(player1.uid,nplayer1pos)
					doTeleportThing(player2.uid,nplayer2pos)
					doTeleportThing(player3.uid,nplayer3pos)
					doTeleportThing(player4.uid,nplayer4pos)
					
					doSendMagicEffect(nplayer1pos,10)
					doSendMagicEffect(nplayer2pos,10)
					doSendMagicEffect(nplayer3pos,10)
					doSendMagicEffect(nplayer4pos,10)
					
					--protecao contra entrar com chaves-->
					doPlayerRemoveItem(player1.uid, 2086, 2)
					doPlayerRemoveItem(player1.uid, 2086, 1)
					doPlayerRemoveItem(player1.uid, 2086, 1)
					doPlayerRemoveItem(player1.uid, 2086, 1)
					
					doPlayerRemoveItem(player2.uid, 2086, 2)
					doPlayerRemoveItem(player2.uid, 2086, 1)
					doPlayerRemoveItem(player2.uid, 2086, 1)
					doPlayerRemoveItem(player2.uid, 2086, 1)
					
					doPlayerRemoveItem(player3.uid, 2086, 2)
					doPlayerRemoveItem(player3.uid, 2086, 1)
					doPlayerRemoveItem(player3.uid, 2086, 1)
					doPlayerRemoveItem(player3.uid, 2086, 1)
					
					doPlayerRemoveItem(player4.uid, 2086, 2)
					doPlayerRemoveItem(player4.uid, 2086, 1)
					doPlayerRemoveItem(player4.uid, 2086, 1)
					doPlayerRemoveItem(player4.uid, 2086, 1)
					
					--marca como feita
					setPlayerStorageValue(player1.uid, 5080, 1)
					setPlayerStorageValue(player2.uid, 5080, 1)
					setPlayerStorageValue(player3.uid, 5080, 1)
					setPlayerStorageValue(player4.uid, 5080, 1)
					
					doTransformItem(item.uid,item.itemid+1)
					
				else
				doPlayerSendCancel(cid,"Algum dos jogadores ja fez esta quest.")
				end
			else
				doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level correto para fazer a quest (230+).")
			end
		else
			doPlayerSendCancel(cid,"Somente eh possivel entrar em grupos de 4 jogadores.")
		end
		
		
	elseif item.itemid == 1946 then
		
		if getPlayerGroupId(cid) >= 3 then
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Um grupo entrou recentemente e ainda não esta liberada.")
		end
	end
end


if item.uid == 1251 then --primeira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=687, y=1368, z=8, stackpos=1}
		local portaobPos = {x=687, y=1349, z=8, stackpos=1}
		
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta está obstruida.")
			return true
		end
		
		local i = -1
		local j = 1
		
		while j < 8 do
		i = -1
			while i < 2 do
				local xo = portaoc.x + i
				local yo = portaoc.y + j
				
				local verificaPos = {x = xo , y = yo, z = portaoc.z, stackpos = 253}
				verifica = getTopCreature(verificaPos)
				
				if verifica.uid > 0 then
					doPlayerSendCancel(cid,"Todos devem estar dentro da sala.")
					return true
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "Elite Legionnaire"
		
		--fecha os portoes se estiverem abertos
		local door1 = getTileItemById(portaoaPos, 5734)
			if door1 and door1.uid > 0 then
				doTransformItem(door1.uid, 5733)
			end
		
		local door2 = getTileItemById(portaobPos, 5734)
			if door2 and door2.uid > 0 then
				doTransformItem(door2.uid, 5733)
			end
		
		doTransformItem(item.uid,item.itemid+1)
			
		mon1pos = {x=687, y=1360, z=8}
		mon2pos = {x=689, y=1358, z=8}
		mon3pos = {x=685, y=1358, z=8}
		mon4pos = {x=685, y=1360, z=8}
		mon5pos = {x=689, y=1360, z=8}
		mon6pos = {x=685, y=1356, z=8}
		mon7pos = {x=687, y=1356, z=8}
		mon8pos = {x=689, y=1356, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)



		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("Elite Legionnaire")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1252 then --segunda sala
	if item.itemid == 1945 then
		local portaoaPos = {x=687, y=1341, z=8, stackpos=1}
		local portaobPos = {x=687, y=1322, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return true
		end
		
		local i = -1
		local j = 1
		
		while j < 8 do
		i = -1
			while i < 2 do
				local xo = portaoc.x + i
				local yo = portaoc.y + j
				
				local verificaPos = {x = xo , y = yo, z = portaoc.z, stackpos = 253}
				verifica = getTopCreature(verificaPos)
				
				if verifica.uid > 0 then
					doPlayerSendCancel(cid,"Todos devem estar dentro da sala.")
					return true
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "Elite Dragon Priest"
		
		--fecha os portoes se estiverem abertos
		local door1 = getTileItemById(portaoaPos, 5734)
			if door1 and door1.uid > 0 then
				doTransformItem(door1.uid, 5733)
			end
		
		local door2 = getTileItemById(portaobPos, 5734)
			if door2 and door2.uid > 0 then
				doTransformItem(door2.uid, 5733)
			end
		
		doTransformItem(item.uid,item.itemid+1)
			
		mon1pos = {x=685, y=1331, z=8}
		mon2pos = {x=689, y=1331, z=8}
		mon3pos = {x=687, y=1333, z=8}
		mon4pos = {x=689, y=1333, z=8}
		mon5pos = {x=685, y=1333, z=8}
		mon6pos = {x=685, y=1329, z=8}
		mon7pos = {x=687, y=1329, z=8}
		mon8pos = {x=689, y=1329, z=8}

			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)

		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("Elite Dragon Priest")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1253 then --terceira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=687, y=1314, z=8, stackpos=1}
		local portaobPos = {x=687, y=1295, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)

		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return true
		end
		
		local i = -1
		local j = 1
		
		while j < 8 do
		i = -1
			while i < 2 do
				local xo = portaoc.x + i
				local yo = portaoc.y + j
				
				local verificaPos = {x = xo , y = yo, z = portaoc.z, stackpos = 253}
				verifica = getTopCreature(verificaPos)
				
				if verifica.uid > 0 then
					doPlayerSendCancel(cid,"Todos devem estar dentro da sala.")
					return true
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao

		
		local monstro = "Elite High Guard"
		
		--fecha os portoes se estiverem abertos
		local door1 = getTileItemById(portaoaPos, 5734)
			if door1 and door1.uid > 0 then
				doTransformItem(door1.uid, 5733)
			end
		
		local door2 = getTileItemById(portaobPos, 5734)
			if door2 and door2.uid > 0 then
				doTransformItem(door2.uid, 5733)
			end
		
		doTransformItem(item.uid,item.itemid+1)
			
		mon1pos = {x=685, y=1304, z=8}
		mon2pos = {x=689, y=1304, z=8}
		mon3pos = {x=685, y=1306, z=8}
		mon4pos = {x=687, y=1306, z=8}
		mon5pos = {x=689, y=1306, z=8}
		mon6pos = {x=685, y=1302, z=8}
		mon7pos = {x=687, y=1302, z=8}
		mon8pos = {x=689, y=1302, z=8}

			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
	
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("Elite High Guard")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1254 then --quarta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=687, y=1287, z=8, stackpos=1}
		local portaobPos = {x=687, y=1266, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return true
		end
		
		local i = -1
		local j = 1
		
		while j < 8 do
		i = -1
			while i < 2 do
				local xo = portaoc.x + i
				local yo = portaoc.y + j
				
				local verificaPos = {x = xo , y = yo, z = portaoc.z, stackpos = 253}
				verifica = getTopCreature(verificaPos)
				
				if verifica.uid > 0 then
					doPlayerSendCancel(cid,"Todos devem estar dentro da sala.")
					return true
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "Elite Zaogun"
		
		--fecha os portoes se estiverem abertos
		local door1 = getTileItemById(portaoaPos, 5734)
			if door1 and door1.uid > 0 then
				doTransformItem(door1.uid, 5733)
			end
		
		local door2 = getTileItemById(portaobPos, 5734)
			if door2 and door2.uid > 0 then
				doTransformItem(door2.uid, 5733)
			end
		
		doTransformItem(item.uid,item.itemid+1)
			
		mon1pos = {x=685, y=1275, z=8}
		mon2pos = {x=689, y=1275, z=8}
		mon3pos = {x=685, y=1277, z=8}
		mon4pos = {x=687, y=1277, z=8}
		mon5pos = {x=689, y=1277, z=8}
		mon6pos = {x=685, y=1273, z=8}
		mon7pos = {x=687, y=1273, z=8}
		mon8pos = {x=689, y=1273, z=8}

			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)

		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("Elite Zaogun")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1255 then --quinta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=687, y=1258, z=8, stackpos=1}
		local portaobPos = {x=687, y=1239, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return true
		end
		
		local i = -1
		local j = 1
		
		while j < 8 do
		i = -1
			while i < 2 do
				local xo = portaoc.x + i
				local yo = portaoc.y + j
				
				local verificaPos = {x = xo , y = yo, z = portaoc.z, stackpos = 253}
				verifica = getTopCreature(verificaPos)
				
				if verifica.uid > 0 then
					doPlayerSendCancel(cid,"Todos devem estar dentro da sala.")
					return true
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "Elite Chosen"
		
		--fecha os portoes se estiverem abertos
		local door1 = getTileItemById(portaoaPos, 5734)
			if door1 and door1.uid > 0 then
				doTransformItem(door1.uid, 5733)
			end
		
		local door2 = getTileItemById(portaobPos, 5734)
			if door2 and door2.uid > 0 then
				doTransformItem(door2.uid, 5733)
			end
		
		doTransformItem(item.uid,item.itemid+1)
			
		mon1pos = {x=685, y=1248, z=8}
		mon2pos = {x=689, y=1248, z=8}
		mon3pos = {x=685, y=1250, z=8}
		mon4pos = {x=687, y=1250, z=8}
		mon5pos = {x=689, y=1250, z=8}
		mon6pos = {x=685, y=1246, z=8}
		mon7pos = {x=687, y=1246, z=8}
		mon8pos = {x=689, y=1246, z=8}

			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)

		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("Elite Chosen")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1256 then --sala do boss
	if item.itemid == 1945 then
		local portaoaPos = {x=687, y=1231, z=8, stackpos=1}
		local portaobPos = {x=687, y=1212, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return true
		end
		
		local i = -1
		local j = 1
		
		while j < 8 do
		i = -1
			while i < 2 do
				local xo = portaoc.x + i
				local yo = portaoc.y + j
				
				local verificaPos = {x = xo , y = yo, z = portaoc.z, stackpos = 253}
				verifica = getTopCreature(verificaPos)
				
				if verifica.uid > 0 then
					doPlayerSendCancel(cid,"Todos devem estar dentro da sala.")
					return true
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "Gargantua"
		
		--fecha os portoes se estiverem abertos
		local door1 = getTileItemById(portaoaPos, 5734)
			if door1 and door1.uid > 0 then
				doTransformItem(door1.uid, 5733)
			end
		
		local door2 = getTileItemById(portaobPos, 5734)
			if door2 and door2.uid > 0 then
				doTransformItem(door2.uid, 5733)
			end
		
		doTransformItem(item.uid,item.itemid+1)
			
		mon1pos = {x=687, y=1223, z=8}
			
		doSummonCreature(monstro, mon1pos)
		
	elseif item.itemid == 1946 then
		if getPlayerGroupId(cid) >= 3 then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Voce nao consegue mover esta alavanca.")
		end
	end
end
if item.itemid == 1746 then
	if item.uid == 1257 then
		queststatus = getPlayerStorageValue(cid,1258)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou uma Zenit Legs.")
			doPlayerAddItem(cid,11304,1)
			setPlayerStorageValue(cid,1258,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazio.")
		end
	elseif item.uid == 1258 then
		queststatus = getPlayerStorageValue(cid,1259)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou uma Zenit Shoes.")
			doPlayerAddItem(cid,11303,1)
			setPlayerStorageValue(cid,1259,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazio.")
		end
	elseif item.uid == 1259 then
		queststatus = getPlayerStorageValue(cid,1260)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou um Zenit Helmet.")
			doPlayerAddItem(cid,11302,1)
			setPlayerStorageValue(cid,1260,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazio.")
		end
	elseif item.uid == 1260 then
		queststatus = getPlayerStorageValue(cid,1261)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou uma Royal Spear.")
			doPlayerAddItem(cid,7378,1)
			setPlayerStorageValue(cid,1261,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazio.")
		end
	end
end

return true
end