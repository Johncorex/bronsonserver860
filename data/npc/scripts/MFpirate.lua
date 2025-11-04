local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid)    npcHandler:onCreatureAppear(cid)   end
function onCreatureDisappear(cid)   npcHandler:onCreatureDisappear(cid)   end
function onCreatureSay(cid, type, msg)   npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()     npcHandler:onThink()     end
 
local items = {
           item1 = {6097, 7620}, -- item1 item que será pedido e que será dado na primeira troca
           item2 = {6098, 7620}, -- item2 item que será pedido e que será dado na segunda troca
		   item3 = {6126, 7620}, -- item2 item que será pedido e que será dado na segunda troca
		 
		  
}
local counts = {
          count1 = {20, 20}, -- count1 quantidade que será pedido e que será dado na primeira troca
          count2 = {20, 20}, -- count2 quantidade que será pedido e que será dado na segunda troca
		  count3 = {20, 20}, -- count2 quantidade que será pedido e que será dado na segunda troca
		 
		  
}
 
function creatureSayCallback(cid, type, msg)
          if(not npcHandler:isFocused(cid)) then
                    return false
          end
          local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

          if   msgcontains(msg, 'hook') or msgcontains(msg, 'hooks')  then
                    if getPlayerItemCount(cid, items.item1[1]) >= counts.count1[1] then
                              doPlayerRemoveItem(cid, items.item1[1], counts.count1[1])
                              doPlayerAddItem(cid, items.item1[2], counts.count1[2])
                              selfSay('Aqui está...', cid)
                    else
                              selfSay('Voce precisa de '.. counts.count1[1] ..' '.. getItemName(items.item1[1]) ..'.', cid)
                    end

          elseif msgcontains(msg, 'eye patch') or msgcontains(msg, 'eye patches') then
                    if getPlayerItemCount(cid, items.item2[1]) >= counts.count2[1] then
                              doPlayerRemoveItem(cid, items.item2[1], counts.count2[1])
                              doPlayerAddItem(cid, items.item2[2], counts.count2[2])
							  selfSay('Aqui está...', cid)
                             
                    else
                              selfSay('Voce precisa de '.. counts.count2[1] ..' '.. getItemName(items.item2[1]) ..'.', cid)
                    end
          
		  elseif msgcontains(msg, 'peg leg') or msgcontains(msg, 'peg legs') then
                    if getPlayerItemCount(cid, items.item3[1]) >= counts.count3[1] then
                              doPlayerRemoveItem(cid, items.item3[1], counts.count3[1])
                              doPlayerAddItem(cid, items.item3[2], counts.count3[2])
							  selfSay('Aqui está...', cid)
                             
                    else
                              selfSay('Voce precisa de '.. counts.count3[1] ..' '.. getItemName(items.item3[1]) ..'.', cid)
                    end
		  
		  
		  
		  
		  
		  
		 	  
          return true

		  end
		  end


npcHandler:setMessage(MESSAGE_GREET, "Oi! estou precisando de alguns itens para minhas criacoes, eu troco eles por Mana Fluids.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())