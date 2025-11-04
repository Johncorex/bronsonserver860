-- Moria City Quest by Bronson --

function onUse(cid, item, frompos, item2, topos)
if item.uid == 1220 then
	if item.itemid == 1945 then
		
		local player1pos = {x=994, y=696, z=11, stackpos=253}
		local player1 = getTopCreature(player1pos)
		
		local player2pos = {x=995, y=696, z=11, stackpos=253}
		local player2 = getTopCreature(player2pos)
		
		local player3pos = {x=996, y=696, z=11, stackpos=253}
		local player3 = getTopCreature(player3pos)
		
		local player4pos = {x=997, y=696, z=11, stackpos=253}
		local player4 = getTopCreature(player4pos)
		
		
		if player1.itemid > 0 and player2.itemid > 0 and player3.itemid > 0 and player4.itemid > 0 then
			
			local player1level = getPlayerLevel(player1.uid)
			local player2level = getPlayerLevel(player2.uid)
			local player3level = getPlayerLevel(player3.uid)
			local player4level = getPlayerLevel(player4.uid)
			
			local questlevelmin = 100
			local questlevelmax = 120
			
			
			if player1level >= questlevelmin and player2level >= questlevelmin and player3level >= questlevelmin and player4level >= questlevelmin and player1level <= questlevelmax and player2level <= questlevelmax and player3level <= questlevelmax and player4level <= questlevelmax then
				
				local queststatus1 = getPlayerStorageValue(player1.uid,5030)
				local queststatus2 = getPlayerStorageValue(player2.uid,5030)
				local queststatus3 = getPlayerStorageValue(player3.uid,5030)
				local queststatus4 = getPlayerStorageValue(player4.uid,5030)
				
				if queststatus1 == -1 and queststatus2 == -1 and queststatus3 == -1 and queststatus4 == -1 then
					
					local nplayer1pos = {x=928, y=893, z=12}
					local nplayer2pos = {x=928, y=894, z=12}
					local nplayer3pos = {x=928, y=895, z=12}
					local nplayer4pos = {x=926, y=896, z=12}
					
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
					setPlayerStorageValue(player1.uid, 5030, 1)
					setPlayerStorageValue(player2.uid, 5030, 1)
					setPlayerStorageValue(player3.uid, 5030, 1)
					setPlayerStorageValue(player4.uid, 5030, 1)
					
					doTransformItem(item.uid,item.itemid+1)
					
				else
				doPlayerSendCancel(cid,"Algum dos jogadores já fez esta quest.")
				end
			else
				doPlayerSendCancel(cid,"Algum dos jogadores nao tem o level correto para fazer a quest. (100 a 120)")
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


if item.uid == 1221 then --primeira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=923, y=888, z=12, stackpos=1}
		local portaobPos = {x=923, y=864, z=12, stackpos=1}
		
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
		
		
		local monstro = "Elite Wyvern"
				
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
			
		mon1pos = {x=918, y=876, z=12}
		mon2pos = {x=918, y=872, z=12}
		mon3pos = {x=922, y=881, z=12}
		mon4pos = {x=925, y=881, z=12}
		mon5pos = {x=929, y=876, z=12}
		mon6pos = {x=929, y=872, z=12}
		mon7pos = {x=925, y=868, z=12}
		mon8pos = {x=921, y=868, z=12}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		doSummonCreature(monstro, mon7pos)
		doSummonCreature(monstro, mon8pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("Elite Wyvern")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1222 then --segunda sala
	if item.itemid == 1945 then
		local portaoaPos = {x=923, y=854, z=12, stackpos=1}
		local portaobPos = {x=922, y=834, z=12, stackpos=1}
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
		
		
		local monstro = "elite dragon lord"
		
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
			
		mon1pos = {x=921, y=850, z=12}
		mon2pos = {x=923, y=850, z=12}
		mon3pos = {x=921, y=838, z=12}
		mon4pos = {x=923, y=838, z=12}
		mon5pos = {x=916, y=844, z=12}
		mon6pos = {x=928, y=844, z=12}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite dragon lord")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1223 then --terceira sala
	if item.itemid == 1945 then
		local portaoaPos = {x=922, y=824, z=12, stackpos=1}
		local portaobPos = {x=921, y=804, z=12, stackpos=1}
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
		
		local monstro = "Elite Hellfire"
		
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
			
		mon1pos = {x=920, y=821, z=12}
		mon2pos = {x=923, y=821, z=12}
		mon3pos = {x=928, y=814, z=12}
		mon4pos = {x=914, y=814, z=12}
		mon5pos = {x=920, y=807, z=12}
		mon6pos = {x=922, y=807, z=12}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		doSummonCreature(monstro, mon6pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("Elite Hellfire")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1224 then --quarta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=921, y=794, z=12, stackpos=1}
		local portaobPos = {x=920, y=774, z=12, stackpos=1}
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
		
		
		local monstro = "elite warlock"
		
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
			
		mon1pos = {x=920, y=791, z=12}
		mon2pos = {x=922, y=791, z=12}
		mon3pos = {x=913, y=784, z=12}
		mon4pos = {x=927, y=784, z=12}
		mon5pos = {x=920, y=777, z=12}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		doSummonCreature(monstro, mon5pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite warlock")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1225 then --quinta sala
	if item.itemid == 1945 then
		local portaoaPos = {x=920, y=764, z=12, stackpos=1}
		local portaobPos = {x=919, y=744, z=12, stackpos=1}
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
		
		
		local monstro = "elite demon"
		
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
			
		mon1pos = {x=919, y=761, z=12}
		mon2pos = {x=912, y=754, z=12}
		mon3pos = {x=926, y=754, z=12}
		mon4pos = {x=919, y=747, z=12}
			
		doSummonCreature(monstro, mon1pos)
		doSummonCreature(monstro, mon2pos)
		doSummonCreature(monstro, mon3pos)
		doSummonCreature(monstro, mon4pos)
		
	elseif item.itemid == 1946 then
		local thing = getCreatureName("elite demon")
		
		if thing ~= nil then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"Você não consegue mover a alavanca.")
			return true
		end
	end
end

if item.uid == 1226 then --sala do boss
	if item.itemid == 1945 then
		local portaoaPos = {x=919, y=734, z=12, stackpos=1}
		local portaobPos = {x=918, y=714, z=12, stackpos=1}
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
		
		
		local monstro = "beelzeboss"
		
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
			
		mon1pos = {x=919, y=723, z=12}
			
		doSummonCreature(monstro, mon1pos)
		
	elseif item.itemid == 1946 then
		if getPlayerGroupId(cid) >= 3 then
			doPlayerSendCancel(cid,"Cuidado.")
			doTransformItem(item.uid,item.itemid-1)
		else
			doPlayerSendCancel(cid,"A quest nao esta liberada.")
		end
	end
end


if item.itemid == 1746 then
	if item.uid == 5030 then
		queststatus = getPlayerStorageValue(cid,5031)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou uma Terra Mantle.")
			doPlayerAddItem(cid,7884,1)
			setPlayerStorageValue(cid,5031,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazio.")
		end
	elseif item.uid == 5031 then
		queststatus = getPlayerStorageValue(cid,5032)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou uma Terra Legs.")
			doPlayerAddItem(cid,7885,1)
			setPlayerStorageValue(cid,5032,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazio.")
		end
	elseif item.uid == 5032 then
		queststatus = getPlayerStorageValue(cid,5033)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou uma Terra Boots.")
			doPlayerAddItem(cid,7886,1)
			setPlayerStorageValue(cid,5033,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazio.")
		end
	elseif item.uid == 5033 then
		queststatus = getPlayerStorageValue(cid,5034)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid,22,"Voce achou um Terra Amulet.")
			doPlayerAddItem(cid,7887,1)
			setPlayerStorageValue(cid,5034,1)
		else
			doPlayerSendTextMessage(cid,22,"Esta vazio.")
		end
	end
end

return 1
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     