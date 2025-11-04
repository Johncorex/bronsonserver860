local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local count = {}
local transfer = {}

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local function greetCallback(cid)
	count[cid], transfer[cid] = nil, nil
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
---------------------------- help ------------------------
	if msgcontains(msg, 'dushudsohfiosdhfdshfsd') then
		npcHandler:say({
			'Every Tibian has one. The big advantage is that you can access your money in every branch of the Tibian Bank! ...',
			'Would you like to know more about the {basic} functions of your bank account, the {advanced} functions, or are you already bored, perhaps?'
		}, cid)
		npcHandler.topic[cid] = 0
		return true
		
---------------------------- saldo ---------------------
	elseif msgcontains(msg, 'saldo') then
		npcHandler.topic[cid] = 0
		if player:getBankBalance() >= 100000000 then
			npcHandler:say('O saldo da sua conta e ' .. player:getBankBalance() .. ' gold.', cid)
			return true
		elseif player:getBankBalance() >= 10000000 then
			npcHandler:say('O saldo da sua conta e  ' .. player:getBankBalance() .. ' gold.', cid)
			return true
		elseif player:getBankBalance() >= 1000000 then
			npcHandler:say('O saldo da sua conta e ' .. player:getBankBalance() .. ' gold!', cid)
			return true
		elseif player:getBankBalance() >= 100000 then
			npcHandler:say('O saldo da sua conta e  ' .. player:getBankBalance() .. ' gold.', cid)
			return true
		else
			npcHandler:say('O saldo da sua conta e  ' .. player:getBankBalance() .. ' gold.', cid)
			return true
		end
---------------------------- deposit ---------------------
	elseif msgcontains(msg, 'depositar') then
		count[cid] = player:getMoney()
		if count[cid] < 1 then
			npcHandler:say('Voce nao tem dinheiro.', cid)
			npcHandler.topic[cid] = 0
			return false
		end
		if msgcontains(msg, 'tudo') then
			count[cid] = player:getMoney()
			npcHandler:say('Voce tem certeza que quer depositar ' .. count[cid] .. ' gold?', cid)
			npcHandler.topic[cid] = 2
			return true
		else
			if string.match(msg,'%d+') then
				count[cid] = getMoneyCount(msg)
				if count[cid] < 1 then
					npcHandler:say('Voce nao tem o dinheiro.', cid)
					npcHandler.topic[cid] = 0
					return false
				end
				npcHandler:say('Voce tem certeza que quer depositar ' .. count[cid] .. ' gold?', cid)
				npcHandler.topic[cid] = 2
				return true
			else
				npcHandler:say('Por favor me diga o valor que deseja depositar', cid)
				npcHandler.topic[cid] = 1
				return true
			end
		end
		if not isValidMoney(count[cid]) then
			npcHandler:say('Desculpe, mas Voce nao pode depositar tudo isso.', cid)
			npcHandler.topic[cid] = 0
			return false
		end
	elseif npcHandler.topic[cid] == 1 then
		count[cid] = getMoneyCount(msg)
		if isValidMoney(count[cid]) then
			npcHandler:say('Voce tem certeza que quer depositar ' .. count[cid] .. ' gold?', cid)
			npcHandler.topic[cid] = 2
			return true
		else
			npcHandler:say('Voce nao tem o dinheiro.', cid)
			npcHandler.topic[cid] = 0
			return true
		end
	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'yes') then
			if player:getMoney() >= tonumber(count[cid]) then
				player:depositMoney(count[cid])
				npcHandler:say('Pronto, nós adicionamos a quantidade de ' .. count[cid] .. ' gold na sua conta bancaria. Voce pode vim sacar quando quiser. Seu saldo total e de ' .. player:getBankBalance() .. ' gold.', cid)
			else
				npcHandler:say('Voce nao tem o dinheiro.', cid)
			end
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Como desejar. Existe algo mais que eu possa fazer por Voce?', cid)
		end
		npcHandler.topic[cid] = 0
		return true
---------------------------- withdraw --------------------
	elseif msgcontains(msg, 'sacar') then
		if string.match(msg,'%d+') then
			count[cid] = getMoneyCount(msg)
			if isValidMoney(count[cid]) then
				npcHandler:say('Voce tem certeza que quer sacar ' .. count[cid] .. ' gold da sua conta bancaria?', cid)
				npcHandler.topic[cid] = 7
			else
				npcHandler:say('nao tem dinheiro suficiente na sua conta.', cid)
				npcHandler.topic[cid] = 0
			end
			return true
		else
			npcHandler:say('Quanto Voce deseja sacar ?', cid)
			npcHandler.topic[cid] = 6
			return true
		end
	elseif npcHandler.topic[cid] == 6 then
		count[cid] = getMoneyCount(msg)
		if isValidMoney(count[cid]) then
			npcHandler:say('Voce tem certeza que quer sacar ' .. count[cid] .. ' gold da sua conta bancaria?', cid)
			npcHandler.topic[cid] = 7
		else
			npcHandler:say('nao tem dinheiro suficiente na sua conta.', cid)
			npcHandler.topic[cid] = 0
		end
		return true
	elseif npcHandler.topic[cid] == 7 then
		if msgcontains(msg, 'yes') then
			if player:getFreeCapacity() >= getMoneyWeight(count[cid]) then
				if not player:withdrawMoney(count[cid]) then
					npcHandler:say('nao tem dinheiro suficiente na sua conta.', cid)
				else
					npcHandler:say('Aqui está, ' .. count[cid] .. ' gold. Por favor, deixe-me saber se há algo mais que eu possa fazer por Voce', cid)
				end
			else
				npcHandler:say('Whoah, hold on, you have no room in your inventory to carry all those coins. I don\'t want you to drop it on the floor, maybe come back with a cart!', cid)
			end
			npcHandler.topic[cid] = 0
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Como desejar. Existe algo mais que eu possa fazer por Voce?', cid)
			npcHandler.topic[cid] = 0
		end
		return true
---------------------------- transfer --------------------
	elseif msgcontains(msg, 'transferir') then
		npcHandler:say('Quanto Voce deseja transferir.', cid)
		npcHandler.topic[cid] = 11
	elseif npcHandler.topic[cid] == 11 then
		count[cid] = getMoneyCount(msg)
		if player:getBankBalance() < count[cid] then
			npcHandler:say('Voce nao possui esse dinheiro na sua conta bancaria', cid)
			npcHandler.topic[cid] = 0
			return true
		end
		if isValidMoney(count[cid]) then
			npcHandler:say('Voce deseja transferir ' .. count[cid] .. ' gold para quem?', cid)
			npcHandler.topic[cid] = 12
		else
			npcHandler:say('Voce nao possui esse dinheiro na sua conta bancaria', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 12 then
		transfer[cid] = msg
		if player:getName() == transfer[cid] then
			npcHandler:say('Voce nao pode transferir dinheiro para si mesmo!', cid)
			npcHandler.topic[cid] = 0
			return true
		end
		if playerExists(transfer[cid]) then
			npcHandler:say('Voce tem certeza que quer transferir ' .. count[cid] .. ' gold para ' .. transfer[cid] .. '?', cid)
			npcHandler.topic[cid] = 13
		else
			npcHandler:say('Este Jogador nao existe.', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 13 then
		if msgcontains(msg, 'yes') then
			if not player:transferMoneyTo(transfer[cid], count[cid]) then
				npcHandler:say('Voce nao pode transferir dinheiro para essa conta.', cid)
			else
				npcHandler:say('Voce transferiu ' .. count[cid] .. ' gold para ' .. transfer[cid] ..'.', cid)
				transfer[cid] = nil
			end
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Alright, is there something else I can do for you?', cid)
		end
		npcHandler.topic[cid] = 0
---------------------------- money exchange --------------
	elseif msgcontains(msg, 'chdsadadasangedasdadasfyyyyyyaaa') then
		npcHandler:say('How many platinum coins would you like to get?', cid)
		npcHandler.topic[cid] = 14
	elseif npcHandler.topic[cid] == 14 then
		if getMoneyCount(msg) < 1 then
			npcHandler:say('Sorry, you do not have enough gold coins.', cid)
			npcHandler.topic[cid] = 0
		else
			count[cid] = getMoneyCount(msg)
			npcHandler:say('So you would like me to change ' .. count[cid] * 100 .. ' of your gold coins into ' .. count[cid] .. ' platinum coins?', cid)
			npcHandler.topic[cid] = 15
		end
	elseif npcHandler.topic[cid] == 15 then
		if msgcontains(msg, 'yes') then
			if player:removeItem(2148, count[cid] * 100) then
				player:addItem(2152, count[cid])
				npcHandler:say('Here you are.', cid)
			else
				npcHandler:say('Sorry, you do not have enough gold coins.', cid)
			end
		else
			npcHandler:say('Well, can I help you with something else?', cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'change platinum') then
		npcHandler:say('Would you like to change your platinum coins into gold or crystal?', cid)
		npcHandler.topic[cid] = 16
	elseif npcHandler.topic[cid] == 16 then
		if msgcontains(msg, 'gold') then
			npcHandler:say('How many platinum coins would you like to change into gold?', cid)
			npcHandler.topic[cid] = 17
		elseif msgcontains(msg, 'crystal') then
			npcHandler:say('How many crystal coins would you like to get?', cid)
			npcHandler.topic[cid] = 19
		else
			npcHandler:say('Well, can I help you with something else?', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 17 then
		if getMoneyCount(msg) < 1 then
			npcHandler:say('Sorry, you do not have enough platinum coins.', cid)
			npcHandler.topic[cid] = 0
		else
			count[cid] = getMoneyCount(msg)
			npcHandler:say('So you would like me to change ' .. count[cid] .. ' of your platinum coins into ' .. count[cid] * 100 .. ' gold coins for you?', cid)
			npcHandler.topic[cid] = 18
		end
	elseif npcHandler.topic[cid] == 18 then
		if msgcontains(msg, 'yes') then
			if player:removeItem(2152, count[cid]) then
				player:addItem(2148, count[cid] * 100)
				npcHandler:say('Here you are.', cid)
			else
				npcHandler:say('Sorry, you do not have enough platinum coins.', cid)
			end
		else
			npcHandler:say('Well, can I help you with something else?', cid)
		end
		npcHandler.topic[cid] = 0
	elseif npcHandler.topic[cid] == 19 then
		if getMoneyCount(msg) < 1 then
			npcHandler:say('Sorry, you do not have enough platinum coins.', cid)
			npcHandler.topic[cid] = 0
		else
			count[cid] = getMoneyCount(msg)
			npcHandler:say('So you would like me to change ' .. count[cid] * 100 .. ' of your platinum coins into ' .. count[cid] .. ' crystal coins for you?', cid)
			npcHandler.topic[cid] = 20
		end
	elseif npcHandler.topic[cid] == 20 then
		if msgcontains(msg, 'yes') then
			if player:removeItem(2152, count[cid] * 100) then
				player:addItem(2160, count[cid])
				npcHandler:say('Here you are.', cid)
			else
				npcHandler:say('Sorry, you do not have enough platinum coins.', cid)
			end
		else
			npcHandler:say('Well, can I help you with something else?', cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'change crystal') then
		npcHandler:say('How many crystal coins would you like to change into platinum?', cid)
		npcHandler.topic[cid] = 21
	elseif npcHandler.topic[cid] == 21 then
		if getMoneyCount(msg) < 1 then
			npcHandler:say('Sorry, you do not have enough crystal coins.', cid)
			npcHandler.topic[cid] = 0
		else
			count[cid] = getMoneyCount(msg)
			npcHandler:say('So you would like me to change ' .. count[cid] .. ' of your crystal coins into ' .. count[cid] * 100 .. ' platinum coins for you?', cid)
			npcHandler.topic[cid] = 22
		end
	elseif npcHandler.topic[cid] == 22 then
		if msgcontains(msg, 'yes') then
			if player:removeItem(2160, count[cid])  then
				player:addItem(2152, count[cid] * 100)
				npcHandler:say('Here you are.', cid)
			else
				npcHandler:say('Sorry, you do not have enough crystal coins.', cid)
			end
		else
			npcHandler:say('Well, can I help you with something else?', cid)
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'banco'}, StdModule.say, {npcHandler = npcHandler, text = 'Aqui Voce pode movimentar o dinheiro que está na sua conta.'})
keywordHandler:addKeyword({'advanced'}, StdModule.say, {npcHandler = npcHandler, text = 'Aqui Voce pode movimentar o dinheiro que está na sua conta'})
keywordHandler:addKeyword({'ajuda'}, StdModule.say, {npcHandler = npcHandler, text = 'Voce pode checar o {saldo} da sua conta bancaria, {depositar} ou {sacar} seu dinheiro . Voce tambem pode {transferir} dinheiro para outos jogadores.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu trabalho neste banco. Eu posso movimentar o dinheiro da sua conta'})

npcHandler:setMessage(MESSAGE_FAREWELL, "Ate Logo...")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate Logo...")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
