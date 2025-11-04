-- Bree City Quest by Bronson --

function onUse(cid, item, frompos, item2, topos)
if item.uid == 1210 then
	if item.itemid == 1945 then
		
		local player1pos = {x=578, y=512, z=7, stackpos=253}
		local player1 = getTopCreature(player1pos)
		
		local player2pos = {x=579, y=512, z=7, stackpos=253}
		local player2 = getTopCreature(player2pos)
		
		local player3pos = {x=580, y=512, z=7, stackpos=253}
		local player3 = getTopCreature(player3pos)
		
		local player4pos = {x=581, y=512, z=7, stackpos=253}
		local player4 = getTopCreature(player4pos)
		
		
		if player1.itemid > 0 and player2.itemid > 0 and player3.itemid > 0 and player4.itemid > 0 then
			
			local player1level = getPlayerLevel(player1.uid)
			local player2level = getPlayerLevel(player2.uid)
			local player3level = getPlayerLevel(player3.uid)
			local player4level = getPlayerLevel(player4.uid)
			
			local questlevelmin = 35
			local questlevelmax = 45
			
			
			if player1level >= questlevelmin and player2level >= questlevelmin and player3level >= questlevelmin and player4level >= questlevelmin and player1level <= questlevelmax and player2level <= questlevelmax and player3level <= questlevelmax and player4level <= questlevelmax then
				
				local queststatus1 = getPlayerStorageValue(player1.uid,5020)
				local queststatus2 = getPlayerStorageValue(player2.uid,5020)
				local queststatus3 = getPlayerStorageValue(player3.uid,5020)
				local queststatus4 = getPlayerStorageValue(player4.uid,5020)
				
				if queststatus1 == -1 and queststatus2 == -1 and queststatus3 == -1 and queststatus4 == -1 then
					
					local nplayer1pos = {x=602, y=520, z=8}
					local nplayer2pos = {x=604, y=520, z=8}
					local nplayer3pos = {x=606, y=520, z=8}
					local nplayer4pos = {x=604, y=524, z=8}
					
					doSendMagicEffect(player1pos,3)
					doSendMagicEffect(player2pos,2)
					doSendMagicEffect(player3pos,2)
					doSendMagicEffect(player4pos,2)
					
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
					setPlayerStorageValue(player1.uid, 5020, 1)
					setPlayerStorageValue(player2.uid, 5020, 1)
					setPlayerStorageValue(player3.uid, 5020, 1)
					setPlayerStorageValue(player4.uid, 5020, 1)
					
					doTransformItem(item.uid,item.itemid+1)
					
				else
				doPlayerSendCancel(cid,"Algum dos jogadores ja fez esta quest.")
				end
			else
				doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level correto para fazer a quest.")
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


if item.uid == 1211 then --primeira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=590, y=516, z=8, stackpos=1}
		local portaobPos = {x=590, y=497, z=8, stackpos=1}
		
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return 1
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
					return 1
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "elite novice"
		
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
			
		mon1pos = {x=584, y=507, z=8}
		mon2pos = {x=584, y=505, z=8}
		mon3pos = {x=589, y=500, z=8}
		mon4pos = {x=591, y=500, z=8}
		mon5pos = {x=595, y=507, z=8}
		mon6pos = {x=595, y=505, z=8}
		mon7pos = {x=589, y=513, z=8}
		mon8pos = {x=591, y=513, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite novice")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1212 then --segunda sala
	if item.itemid == 1945 then
		local portaoaPos = {x=590, y=489, z=8, stackpos=1}
		local portaobPos = {x=590, y=470, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return 1
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
					return 1
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "elite dark monk"
		
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
			
		mon1pos = {x=584, y=480, z=8}
		mon2pos = {x=584, y=478, z=8}
		mon3pos = {x=589, y=473, z=8}
		mon4pos = {x=591, y=473, z=8}
		mon5pos = {x=595, y=480, z=8}
		mon6pos = {x=595, y=478, z=8}
		mon7pos = {x=589, y=486, z=8}
		mon8pos = {x=591, y=486, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite dark monk")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1213 then --terceira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=590, y=462, z=8, stackpos=1}
		local portaobPos = {x=590, y=443, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)

		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return 1
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
					return 1
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao

		
		local monstro = "elite witch"
		
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
			
		mon1pos = {x=584, y=453, z=8}
		mon2pos = {x=584, y=451, z=8}
		mon3pos = {x=589, y=446, z=8}
		mon4pos = {x=591, y=446, z=8}
		mon5pos = {x=595, y=453, z=8}
		mon6pos = {x=595, y=451, z=8}
		mon7pos = {x=589, y=459, z=8}
		mon8pos = {x=591, y=459, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite witch")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1214 then --quarta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=590, y=435, z=8, stackpos=1}
		local portaobPos = {x=590, y=416, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return 1
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
					return 1
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "elite monk"
		
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
			
		mon1pos = {x=584, y=426, z=8}
		mon2pos = {x=584, y=424, z=8}
		mon3pos = {x=589, y=419, z=8}
		mon4pos = {x=591, y=419, z=8}
		mon5pos = {x=595, y=426, z=8}
		mon6pos = {x=595, y=424, z=8}
		mon7pos = {x=589, y=432, z=8}
		mon8pos = {x=591, y=432, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite monk")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1215 then --quinta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=590, y=408, z=8, stackpos=1}
		local portaobPos = {x=590, y=389, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return 1
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
					return 1
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "elite acolyte"
		
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
			
		mon1pos = {x=584, y=399, z=8}
		mon2pos = {x=584, y=397, z=8}
		mon3pos = {x=589, y=392, z=8}
		mon4pos = {x=591, y=392, z=8}
		mon5pos = {x=595, y=399, z=8}
		mon6pos = {x=595, y=397, z=8}
		mon7pos = {x=589, y=405, z=8}
		mon8pos = {x=591, y=405, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite acolyte")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1216 then --sala do boss
	if item.itemid == 1945 then
		local portaoaPos = {x=590, y=381, z=8, stackpos=1}
		local portaobPos = {x=590, y=362, z=8, stackpos=1}
		portaoa = getTopCreature(portaoaPos)
		portaob = getTopCreature(portaobPos)
		
		--verificacao de seguranca
		local portaoc = {x= portaoaPos.x, y = portaoaPos.y, z = portaoaPos.z, stackpos=253}
		local verifica = getTopCreature(portaoc)
		
		if verifica.uid > 0 then
			doPlayerSendCancel(cid,"A porta esta obstruida.")
			return 1
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
					return 1
				end
				
				i = i+1
			end
		j=j+1
		end
		--fim da verificacao
		
		
		local monstro = "ratzinger"
		
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
			
		mon1pos = {x=590, y=370, z=8}
			
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


return 1
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            