local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local tabela = {21, 22, 23, 24}
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
					if (getPlayerVocation(cid) == 21) then
						npcHandler:say('Voce quer ser promovido para Elf Ranger por 10.000gp?', cid)
						talkState[talkUser] = 1
						
					elseif (getPlayerVocation(cid) == 22) and getPlayerLevel(cid) >= 101 then
						npcHandler:say('Voce quer ser promovido para High Elf por 30.000gp?', cid)
						talkState[talkUser] = 1
						
					elseif (getPlayerVocation(cid) == 23) and getPlayerLevel(cid) >= 200 then
						npcHandler:say('Voce quer ser promovido para High Elf por 200.000gp?', cid)
						talkState[talkUser] = 1

					elseif (getPlayerVocation(cid) == 24) then
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
			npcHandler:say("Voce tem que ser um Elf Ranger para ser promovido aqui.", cid)
		end
		
	elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
		if(getPlayerVocation(cid) == 21) then
			if(not doPlayerRemoveMoney(cid, 10000)) then
				npcHandler:say('Desculpe, mas voce nao tem dinheiro suficiente.', cid)
			else
				 doPlayerSetVocation(cid, 22)
				npcHandler:say('Voce foi promovido!', cid)
			end
			talkState[talkUser] = 0
			
		elseif(getPlayerVocation(cid) == 22) then
				if(not doPlayerRemoveMoney(cid, 30000)) then
					npcHandler:say('Desculpe, mas voce nao tem dinheiro suficiente.', cid)
				else
					 doPlayerSetVocation(cid, 23)
				    npcHandler:say('Voce foi promovido!', cid)
				end
			talkState[talkUser] = 0
			
		elseif(getPlayerVocation(cid) == 23) then
			if isPremium(cid) then
				if(not doPlayerRemoveMoney(cid, 200000)) then
					npcHandler:say('Desculpe, mas voce nao tem dinheiro suficiente.', cid)
				else
					 doPlayerSetVocation(cid, 24)
				    npcHandler:say('Voce foi promovido!', cid)
				end
			else
				npcHandler:say("Voce tem que ter uma conta VIP para se tornar um Elven Elite!", cid)
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
