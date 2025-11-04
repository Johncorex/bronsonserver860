local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid)    npcHandler:onCreatureAppear(cid)   end
function onCreatureDisappear(cid)   npcHandler:onCreatureDisappear(cid)   end
function onCreatureSay(cid, type, msg)   npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()     npcHandler:onThink()     end
 
local items = {
           item1 = {2677, 7620} -- item1 item que será pedido e que será dado na primeira troca
}
local counts = {
          count1 = {300, 15} -- count1 quantidade que será pedido e que será dado na primeira troca

		  
}
 
function creatureSayCallback(cid, type, msg)
          if(not npcHandler:isFocused(cid)) then
                    return false
          end
          local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

          if msgcontains(msg, 'bb') or msgcontains(msg, 'blueberry') or msgcontains(msg, 'blueberries')  then
                    if getPlayerItemCount(cid, items.item1[1]) >= counts.count1[1] then
                              doPlayerRemoveItem(cid, items.item1[1], counts.count1[1])
                              doPlayerAddItem(cid, items.item1[2], counts.count1[2])
                              selfSay('Aqui está...', cid)
                    else
                              selfSay('Voce precisa de '.. counts.count1[1] ..' '.. getItemName(items.item1[1]) ..'.', cid)
                    end

          
		  
		  
		  
		  
		 	  
          return true

		  end
		  end


npcHandler:setMessage(MESSAGE_GREET, "Oi! estou precisando de alguns itens para minhas criacoes, eu troco eles por Mana Fluids.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())