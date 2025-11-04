-- Forodwaith City Quest by Bronson --
-- Variables used:
--
-- player?pos = The position of the players before teleport.
-- player? = Get the thing from playerpos.
-- player?level = Get the players levels.
-- questslevel = The level you have to be to do this quest.
-- questtatus? = Get the quest status of the players.
-- demon?pos = The position of the demons.
-- nplayer?pos = The position where the players should be teleported too.
--
--

function onUse(cid, item, frompos, item2, topos)
if item.uid == 1230 then
	if item.itemid == 1945 then
		
		local player1pos = {x=667, y=151, z=7, stackpos=253}
		local player1 = getTopCreature(player1pos)
		
		local player2pos = {x=668, y=151, z=7, stackpos=253}
		local player2 = getTopCreature(player2pos)
		
		local player3pos = {x=669, y=151, z=7, stackpos=253}
		local player3 = getTopCreature(player3pos)
		
		local player4pos = {x=670, y=151, z=7, stackpos=253}
		local player4 = getTopCreature(player4pos)
		
		
		if player1.itemid > 0 and player2.itemid > 0 and player3.itemid > 0 and player4.itemid > 0 then
			
			local player1level = getPlayerLevel(player1.uid)
			local player2level = getPlayerLevel(player2.uid)
			local player3level = getPlayerLevel(player3.uid)
			local player4level = getPlayerLevel(player4.uid)
			
			local questlevelmin = 45
			local questlevelmax = 60
			
			
			if player1level >= questlevelmin and player2level >= questlevelmin and player3level >= questlevelmin and player4level >= questlevelmin and player1level <= questlevelmax and player2level <= questlevelmax and player3level <= questlevelmax and player4level <= questlevelmax then
				
				local queststatus1 = getPlayerStorageValue(player1.uid,5040)
				local queststatus2 = getPlayerStorageValue(player2.uid,5040)
				local queststatus3 = getPlayerStorageValue(player3.uid,5040)
				local queststatus4 = getPlayerStorageValue(player4.uid,5040)
				
				if queststatus1 == -1 and queststatus2 == -1 and queststatus3 == -1 and queststatus4 == -1 then
					
					local nplayer1pos = {x=833, y=286, z=8}
					local nplayer2pos = {x=834, y=286, z=8}
					local nplayer3pos = {x=835, y=286, z=8}
					local nplayer4pos = {x=836, y=286, z=8}
					
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
					setPlayerStorageValue(player1.uid, 5040, 1)
					setPlayerStorageValue(player2.uid, 5040, 1)
					setPlayerStorageValue(player3.uid, 5040, 1)
					setPlayerStorageValue(player4.uid, 5040, 1)
					
					doTransformItem(item.uid,item.itemid+1)
					
				else
				doPlayerSendCancel(cid,"Algum dos jogadores ja fez esta quest.")
				end
			else
				doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level correto para fazer a quest. (40-55)")
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


if item.uid == 1231 then --primeira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=821, y=282, z=8, stackpos=1}
		local portaobPos = {x=821, y=263, z=8, stackpos=1}
		
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
		
		
		local monstro = "Elite Frost Giant"
		
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
			
		mon1pos = {x=820, y=279, z=8}
		mon2pos = {x=822, y=279, z=8}
		mon3pos = {x=828, y=274, z=8}
		mon4pos = {x=828, y=271, z=8}
		mon5pos = {x=814, y=274, z=8}
		mon6pos = {x=814, y=271, z=8}
		mon7pos = {x=820, y=266, z=8}
		mon8pos = {x=822, y=266, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("Elite Frost Giant")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1232 then --segunda sala
	if item.itemid == 1945 then
		local portaoaPos = {x=821, y=255, z=8, stackpos=1}
		local portaobPos = {x=821, y=236, z=8, stackpos=1}
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
		
		
		local monstro = "elite yeti"
		
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
			
		mon1pos = {x=820, y=252, z=8}
		mon2pos = {x=822, y=252, z=8}
		mon3pos = {x=828, y=246, z=8}
		mon4pos = {x=814, y=246, z=8}
		mon5pos = {x=820, y=239, z=8}
		mon6pos = {x=822, y=239, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite yeti")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1233 then --terceira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=821, y=228, z=8, stackpos=1}
		local portaobPos = {x=821, y=209, z=8, stackpos=1}
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

		
		local monstro = "elite ice witch"
		
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
			
		mon1pos = {x=820, y=225, z=8}
		mon2pos = {x=822, y=225, z=8}
		mon3pos = {x=828, y=219, z=8}
		mon4pos = {x=814, y=219, z=8}
		mon5pos = {x=821, y=212, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite ice witch")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1234 then --quarta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=821, y=201, z=8, stackpos=1}
		local portaobPos = {x=821, y=182, z=8, stackpos=1}
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
		
		
		local monstro = "elite crystal spider"
		
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
			
		mon1pos = {x=821, y=198, z=8}
		mon2pos = {x=828, y=192, z=8}
		mon3pos = {x=814, y=192, z=8}
		mon4pos = {x=821, y=185, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite crystal spider")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1235 then --quinta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=821, y=174, z=8, stackpos=1}
		local portaobPos = {x=821, y=155, z=8, stackpos=1}
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
		
		
		local monstro = "elite frost dragon"
		
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
			
		mon1pos = {x=821, y=171, z=8}
		mon2pos = {x=814, y=165, z=8}
		mon3pos = {x=827, y=165, z=8}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite frost dragon")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1236 then --sala do boss
	if item.itemid == 1945 then
		local portaoaPos = {x=821, y=147, z=8, stackpos=1}
		local portaobPos = {x=821, y=128, z=8, stackpos=1}
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
		
		
		local monstro = "goronwy"
		
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
		
		mon1pos = {x=821, y=139, z=8}
		
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
