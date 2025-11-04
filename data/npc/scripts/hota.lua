local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	if(msgcontains(msg, 'hota')) or (msgcontains(msg, 'helmet of the ancients')) then
		npcHandler:say('Voce tem todas as partes?', cid)
		talkState[talkUser] = 1
		
	elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
		local parte1 = (getPlayerItemCount(cid,2335))
		local parte2 = (getPlayerItemCount(cid,2336))
		local parte3 = (getPlayerItemCount(cid,2337))
		local parte4 = (getPlayerItemCount(cid,2338))
		local parte5 = (getPlayerItemCount(cid,2339))
		local parte6 = (getPlayerItemCount(cid,2340))
		local parte7 = (getPlayerItemCount(cid,2341))
		local c = 0
		if parte1 >= 1 and parte2 >= 1 and parte3 >= 1 and parte4 >= 1 and parte5 >= 1 and parte6 >= 1 and parte7 >= 1 then
			npcHandler:say('Aqui está!', cid) 
			doPlayerAddItem(cid,2342, 1)
			doPlayerRemoveItem(cid,2335,1)
			doPlayerRemoveItem(cid,2336,1)
			doPlayerRemoveItem(cid,2337,1)
			doPlayerRemoveItem(cid,2338,1)
			doPlayerRemoveItem(cid,2339,1)
			doPlayerRemoveItem(cid,2340,1)
			doPlayerRemoveItem(cid,2341,1)
		else
			npcHandler:say("Voce nao possui todas as partes...", cid)
		end
	
	elseif(msgcontains(msg, 'no')) then
		npcHandler:say('Alright then.', cid)
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
