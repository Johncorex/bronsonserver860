-- Edoras City Quest by Bronson --

function onUse(cid, item, frompos, item2, topos)
if item.uid == 1200 then
	if item.itemid == 1945 then
		
		local player1pos = {x=1057, y=1132, z=6, stackpos=253}
		local player1 = getTopCreature(player1pos)
		
		local player2pos = {x=1058, y=1132, z=6, stackpos=253}
		local player2 = getTopCreature(player2pos)
		
		local player3pos = {x=1059, y=1132, z=6, stackpos=253}
		local player3 = getTopCreature(player3pos)
		
		local player4pos = {x=1060, y=1132, z=6, stackpos=253}
		local player4 = getTopCreature(player4pos)
		
		
		if player1.itemid > 0 and player2.itemid > 0 and player3.itemid > 0 and player4.itemid > 0 then
			
			local player1level = getPlayerLevel(player1.uid)
			local player2level = getPlayerLevel(player2.uid)
			local player3level = getPlayerLevel(player3.uid)
			local player4level = getPlayerLevel(player4.uid)
			
			local questlevelmin = 20
			local questlevelmax = 35
			
			
			if player1level >= questlevelmin and player2level >= questlevelmin and player3level >= questlevelmin and player4level >= questlevelmin and player1level <= questlevelmax and player2level <= questlevelmax and player3level <= questlevelmax and player4level <= questlevelmax then
				
				local queststatus1 = getPlayerStorageValue(player1.uid,5010)
				local queststatus2 = getPlayerStorageValue(player2.uid,5010)
				local queststatus3 = getPlayerStorageValue(player3.uid,5010)
				local queststatus4 = getPlayerStorageValue(player4.uid,5010)
				
				if queststatus1 == -1 and queststatus2 == -1 and queststatus3 == -1 and queststatus4 == -1 then
					
					local nplayer1pos = {x=1126, y=1291, z=6}
					local nplayer2pos = {x=1127, y=1291, z=6}
					local nplayer3pos = {x=1129, y=1291, z=6}
					local nplayer4pos = {x=1130, y=1291, z=6}
					
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
					setPlayerStorageValue(player1.uid, 5010, 1)
					setPlayerStorageValue(player2.uid, 5010, 1)
					setPlayerStorageValue(player3.uid, 5010, 1)
					setPlayerStorageValue(player4.uid, 5010, 1)
					
					doTransformItem(item.uid,item.itemid+1)
					
				else
				doPlayerSendCancel(cid,"Algum dos jogadores ja fez esta quest.")
				end
			else
				doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level correto para fazer a quest (20 a 35).")
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


if item.uid == 1201 then --primeira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=1114, y=1287, z=6, stackpos=1}
		local portaobPos = {x=1114, y=1268, z=6, stackpos=1}
		
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
		
		
		local monstro = "elite smuggler"
		
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
			
		mon1pos = {x=1111, y=1283, z=6}
		mon2pos = {x=1117, y=1283, z=6}
		mon3pos = {x=1111, y=1271, z=6}
		mon4pos = {x=1117, y=1271, z=6}
		mon5pos = {x=1108, y=1275, z=6}
		mon6pos = {x=1108, y=1279, z=6}
		mon7pos = {x=1120, y=1275, z=6}
		mon8pos = {x=1120, y=1279, z=6}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite smuggler")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1202 then --segunda sala
	if item.itemid == 1945 then
		local portaoaPos = {x=1114, y=1260, z=6, stackpos=1}
		local portaobPos = {x=1114, y=1241, z=6, stackpos=1}
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
		
		
		local monstro = "elite amazon"
		
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
			
		mon1pos = {x=1111, y=1256, z=6}
		mon2pos = {x=1117, y=1256, z=6}
		mon3pos = {x=1111, y=1244, z=6}
		mon4pos = {x=1117, y=1244, z=6}
		mon5pos = {x=1108, y=1248, z=6}
		mon6pos = {x=1108, y=1252, z=6}
		mon7pos = {x=1120, y=1248, z=6}
		mon8pos = {x=1120, y=1252, z=6}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite amazon")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1203 then --terceira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=1114, y=1233, z=6, stackpos=1}
		local portaobPos = {x=1114, y=1214, z=6, stackpos=1}
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

		
		local monstro = "elite bandit"
		
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
			
		mon1pos = {x=1111, y=1229, z=6}
		mon2pos = {x=1117, y=1229, z=6}
		mon3pos = {x=1111, y=1217, z=6}
		mon4pos = {x=1117, y=1217, z=6}
		mon5pos = {x=1108, y=1221, z=6}
		mon6pos = {x=1108, y=1225, z=6}
		mon7pos = {x=1120, y=1221, z=6}
		mon8pos = {x=1120, y=1225, z=6}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite bandit")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1204 then --quarta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=1114, y=1206, z=6, stackpos=1}
		local portaobPos = {x=1114, y=1187, z=6, stackpos=1}
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
		
		
		local monstro = "elite valkyrie"
		
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
			
		mon1pos = {x=1111, y=1202, z=6}
		mon2pos = {x=1117, y=1202, z=6}
		mon3pos = {x=1111, y=1190, z=6}
		mon4pos = {x=1117, y=1190, z=6}
		mon5pos = {x=1108, y=1194, z=6}
		mon6pos = {x=1108, y=1198, z=6}
		mon7pos = {x=1120, y=1194, z=6}
		mon8pos = {x=1120, y=1198, z=6}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite valkyrie")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1205 then --quinta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=1114, y=1177, z=6, stackpos=1}
		local portaobPos = {x=1114, y=1260, z=6, stackpos=1}
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
		
		
		local monstro = "elite assasin"
		
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
			
		mon1pos = {x=1111, y=1175, z=6}
		mon2pos = {x=1117, y=1175, z=6}
		mon3pos = {x=1111, y=1173, z=6}
		mon4pos = {x=1117, y=1173, z=6}
		mon5pos = {x=1108, y=1167, z=6}
		mon6pos = {x=1108, y=1171, z=6}
		mon7pos = {x=1120, y=1167, z=6}
		mon8pos = {x=1120, y=1171, z=6}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite assassin")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1206 then --sala do boss
	if item.itemid == 1945 then
		local portaoaPos = {x=1114, y=1150, z=6, stackpos=1}
		local portaobPos = {x=1114, y=1233, z=6, stackpos=1}
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
		
		
		local monstro = "fingerless butcher"
		
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
			
		mon1pos = {x=1114, y=1139, z=6}
			
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


return true
end