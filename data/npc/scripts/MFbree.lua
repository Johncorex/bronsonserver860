local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid)    npcHandler:onCreatureAppear(cid)   end
function onCreatureDisappear(cid)   npcHandler:onCreatureDisappear(cid)   end
function onCreatureSay(cid, type, msg)   npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()     npcHandler:onThink()     end
 
local items = {
           item1 = {2677, 7620}, -- item1 item que será pedido e que será dado na primeira troca
           item2 = {5920, 7620}, -- item2 item que será pedido e que será dado na segunda troca
		   item3 = {5919, 7620}, -- item2 item que será pedido e que será dado na segunda troca
		   item4 = {5877, 7620}, -- item2 item que será pedido e que será dado na segunda troca
		   item5 = {5878, 7620}, -- item2 item que será pedido e que será dado na segunda troca
		   item6 = {5882, 7620},-- item2 item que será pedido e que será dado na segunda troca
		   item7 = {5948, 7620} -- item2 item que será pedido e que será dado na segunda troca
}
local counts = {
          count1 = {300, 15}, -- count1 quantidade que será pedido e que será dado na primeira troca
          count2 = {20, 20}, -- count2 quantidade que será pedido e que será dado na segunda troca
		  count3 = {20, 20}, -- count2 quantidade que será pedido e que será dado na segunda troca
		  count4 = {20, 20}, -- count2 quantidade que será pedido e que será dado na segunda troca
		  count5 = {20, 20}, -- count2 quantidade que será pedido e que será dado na segunda troca
		  count6 = {20, 20}, -- count2 quantidade que será pedido e que será dado na segunda troca
		  count7 = {20, 20} -- count2 quantidade que será pedido e que será dado na segunda troca
		  
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

          elseif msgcontains(msg, 'green dragon scale') or msgcontains(msg, 'green dragon scales') then
                    if getPlayerItemCount(cid, items.item2[1]) >= counts.count2[1] then
                              doPlayerRemoveItem(cid, items.item2[1], counts.count2[1])
                              doPlayerAddItem(cid, items.item2[2], counts.count2[2])
							  selfSay('Aqui está...', cid)
                             
                    else
                              selfSay('Voce precisa de '.. counts.count2[1] ..' '.. getItemName(items.item2[1]) ..'.', cid)
                    end
          
		  elseif msgcontains(msg, 'dragon claw') or msgcontains(msg, 'dragon claws') then
                    if getPlayerItemCount(cid, items.item3[1]) >= counts.count3[1] then
                              doPlayerRemoveItem(cid, items.item3[1], counts.count3[1])
                              doPlayerAddItem(cid, items.item3[2], counts.count3[2])
							  selfSay('Aqui está...', cid)
                             
                    else
                              selfSay('Voce precisa de '.. counts.count3[1] ..' '.. getItemName(items.item3[1]) ..'.', cid)
                    end
		  
		  
		  
		  elseif msgcontains(msg, 'green dragon leather') or msgcontains(msg, 'green dragon leathers') then
                    if getPlayerItemCount(cid, items.item4[1]) >= counts.count4[1] then
                              doPlayerRemoveItem(cid, items.item4[1], counts.count4[1])
                              doPlayerAddItem(cid, items.item4[2], counts.count4[2])
							  selfSay('Aqui está...', cid)
                             
                    else
                              selfSay('Voce precisa de '.. counts.count4[1] ..' '.. getItemName(items.item4[1]) ..'.', cid)
                    end
		  

		  elseif msgcontains(msg, 'minotaur leather') or msgcontains(msg, 'minotaur leathers') then
                    if getPlayerItemCount(cid, items.item5[1]) >= counts.count5[1] then
                              doPlayerRemoveItem(cid, items.item5[1], counts.count5[1])
                              doPlayerAddItem(cid, items.item5[2], counts.count5[2])
							  selfSay('Aqui está...', cid)
                             
                    else
                              selfSay('Voce precisa de '.. counts.count5[1] ..' '.. getItemName(items.item5[1]) ..'.', cid)
                    end
					
		  elseif msgcontains(msg, 'red dragon scale') or msgcontains(msg, 'red dragon scales') then
                    if getPlayerItemCount(cid, items.item6[1]) >= counts.count6[1] then
                              doPlayerRemoveItem(cid, items.item6[1], counts.count6[1])
                              doPlayerAddItem(cid, items.item6[2], counts.count6[2])
							  selfSay('Aqui está...', cid)
                             
                    else
                              selfSay('Voce precisa de '.. counts.count6[1] ..' '.. getItemName(items.item6[1]) ..'.', cid)
                    end
					
								
		  elseif msgcontains(msg, 'red dragon leather') or msgcontains(msg, 'red dragon leathers') then
                    if getPlayerItemCount(cid, items.item7[1]) >= counts.count7[1] then
                              doPlayerRemoveItem(cid, items.item7[1], counts.count7[1])
                              doPlayerAddItem(cid, items.item7[2], counts.count7[2])
							  selfSay('Aqui está...', cid)
                             
                    else
                              selfSay('Voce precisa de '.. counts.count7[1] ..' '.. getItemName(items.item7[1]) ..'.', cid)
                    end
		  
		  
		  
		  
		 	  
          return true

		  end
		  end


npcHandler:setMessage(MESSAGE_GREET, "Oi! estou precisando de alguns itens para minhas criacoes, eu troco eles por Mana Fluids.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())