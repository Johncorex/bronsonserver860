local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local tabela = {1, 5, 9, 13}
local c = 0

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	
	
	
	if (msgcontains(msg, 'promotion') or msgcontains(msg, 'promote') or msgcontains(msg, 'promover'))  then
		for x=1,#tabela do
			if getPlayerVocation(cid) == tabela[x] then
				if getPlayerLevel(cid) >= 35 then
					if (getPlayerVocation(cid) == 1) then
						npcHandler:say('Voce quer ser promovido para Master Sorcerer por 10.000gp?', cid)
						talkState[talkUser] = 1
						
					elseif (getPlayerVocation(cid) == 5) and getPlayerLevel(cid) >= 101 then
						npcHandler:say('Voce quer ser promovido para Archmage por 30.000gp?', cid)
						talkState[talkUser] = 1
						
					elseif (getPlayerVocation(cid) == 9) and getPlayerLevel(cid) >= 200 then
						npcHandler:say('Voce quer ser promovido para Arcane Wizard por 200.000gp?', cid)
						talkState[talkUser] = 1
						
					elseif (getPlayerVocation(cid) == 13) then
						npcHandler:say('Voce ja esta na ultima promocao', cid)
						
					else
						npcHandler:say('Voce nao tem level suficiente para se promover.', cid)
					end
				else
					npcHandler:say('Me desculpe, mas eu so posso promover quando estiver level 35.', cid)
				end
				c = 1
				break
			end
		end
		if c == 0 then
			npcHandler:say("Voce tem que ser um Master Sorcerer para ser promovido aqui.", cid)
		end
		
	elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
		if(getPlayerVocation(cid) == 1) then
			if(not doPlayerRemoveMoney(cid, 10000)) then
				npcHandler:say('Desculpe, mas voce nao tem dinheiro suficiente.', cid)
			else
				doPlayerSetVocation(cid, 5)
				npcHandler:say('Voce foi promovido!', cid)
			end
			talkState[talkUser] = 0
			
		elseif(getPlayerVocation(cid) == 5) then
				if(not doPlayerRemoveMoney(cid, 30000)) then
					npcHandler:say('Desculpe, mas voce nao tem dinheiro suficiente.', cid)
				else
					doPlayerSetVocation(cid, 9)
				    npcHandler:say('Voce foi promovido!', cid)
				end
			talkState[talkUser] = 0
			
		elseif(getPlayerVocation(cid) == 9) then
			if isPremium(cid) then
				if(not doPlayerRemoveMoney(cid, 200000)) then
					npcHandler:say('Desculpe, mas voce nao tem dinheiro suficiente.', cid)
				else
					doPlayerSetVocation(cid, 13)
				    npcHandler:say('Voce foi promovido!', cid)
				end
			else
				npcHandler:say("Voce tem que ter uma conta VIP para se tornar um Arcane Wizard!", cid)
			end
			talkState[talkUser] = 0
			
		end
	
	elseif(msgcontains(msg, 'no')) then
		npcHandler:say('Ate mais, volte quando estiver preparado.', cid)
		talkState[talkUser] = 0
		
	end

	return true
end

function msgcontains(message, keyword)
	if(type(keyword) == "table") then
		return table.isStrIn(keyword, message)
	end

	local a, b = message:lower():find(keyword:lower())
	if(a ~= nil and b ~= nil) then
		return true
	end

	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
