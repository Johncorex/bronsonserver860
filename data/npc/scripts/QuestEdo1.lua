--SISTEMA DE QUEST SEQUENCIAL BY BRONSON
local focus = 0
local talk_start = 0
local target = 0
local following = false
local attacking = false
local buying = true
local item = 0
local count = 1
local state = 0

--recruta de edoras
--id 3000
--nomes dos npcs:
--1 Cepheus
--2 Horatius
--3 Pamphilos

--vars
local levelmin = 1
local levelmax = 12
local main_id = 3000
local mission1_id = 3001

--strings
local greet_sem_quest = 'Oi, voce parece ser novo por aqui. Quer que eu te ajude?'
local greet_com_quest = 'Oi de novo, eu ja te dei uma missao, olhe na sua janela de quests.'
local mission1_text = 'Fale com o Horatius, ele ira te ajudar. Ele esta sempre proximo a loja de arcos e flechas...'
local mission1_complete = 'Ola! O Cepheus me avisou de sua chegada... vejo que voce precisa de ajuda. Vou te dar 500 pontos de experiencia.'


function getCount(msg)
	b, e = string.find(msg, "%d+")
	if b == nil or e == nil then
		count = 1
	else
		count = tonumber(string.sub(msg, b, e))
	end
	return count
end

 function onThingMove(creature, thing, oldpos, oldstackpos)
 
 end
 
 
 function onCreatureAppear(creature)
 
 end
 
 
 function onCreatureDisappear(cid, pos)
 	if focus == cid then
         selfSay('Adeus.')
         focus = 0
         talk_start = 0
 	end
 end
 
 
 function onCreatureTurn(creature)
 
 end
 
function msgcontains(txt, str)
	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end
 

function onCreatureSay(cid, type, msg)
 	msg = string.lower(msg)


	if string.find(msg, 'hi') and (focus == 0) and getNpcDistanceToCreature(cid) < 3 and not string.find(msg, 'shield') then
		if (getPlayerLevel(cid) > levelmin and getPlayerLevel(cid) < levelmax) or getPlayerAccess(cid) > 3 then
			if getPlayerStorageValue(cid,main_id) == -1 then
				selfSay(greet_sem_quest)
				focus = cid
				talk_start = os.clock()
				state = 1
			elseif getPlayerStorageValue(cid,main_id) >= 0 then
				selfSay(greet_com_quest)
				focus = cid
				talk_start = os.clock()
				state = 2
			end
		else
			selfSay('Desculpe, nao posso te ajudar')
		end
	end

	
	if focus == cid then
		
		if state == 1 then --o cara nao tem missao, vamos falar a primeira missao
			if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
				setPlayerStorageValue(focus,main_id,1)
				selfSay(mission1_text)
				setPlayerStorageValue(focus,mission1_id,1)
			elseif msgcontains(msg, 'nao') or msgcontains(msg, 'no') then
				focus = 0
				state = 0
				selfSay('Adeus')
			end
		end
		
	end

end 
 
 

function onCreatureChangeOutfit(creature)
 
end
 
 


function onThink()
 	if (os.clock() - talk_start) > 15 then
 		if focus > 0 then
 			selfSay('Adeus irmao')
		end
 		
		focus = 0
	end

	if focus > 0 and getNpcDistanceToCreature(focus) > 3 then
		selfSay('Ate mais ' .. getCreatureName(focus) .. '.')
		focus = 0
		item = 0
		talk_start = 0
 	end


	if focus > 0 then 
		lookAtPlayer(focus)
	end
end
