--SISTEMA DE QUEST SEQUENCIAL BY BRONSON
--os arquivos sao iguais porem renomeados para nao bugar
--esse aqui recebe a missao q o outro deu
--e da um nova
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
local mission_id = 3001
local new_mission_id = 3002

local bonus_exp = 500

--strings
local mission_complete = 'Ola! O Cepheus me avisou de sua chegada... vejo que voce precisa de ajuda. Vou te dar 500 pontos de experiencia.'
local sem_missao = 'Nao tenho nada para falar com voce hoje...'
local new_mission_text = 'Encontre o Pamphilos, ele fica proximo ao depot de Edoras e vai te ensinar aonde matar criaturas'
local greet_com_quest = 'Oi de novo, eu ja te dei uma missao, olhe na sua janela de quests.'

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
function onCreatureTurn(creature)
end 
 
function onCreatureDisappear(cid, pos)
 	if focus == cid then
         selfSay('Adeus.')
         focus = 0
         talk_start = 0
 	end
end

function msgcontains(txt, str)
	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end
 


function onCreatureSay(cid, type, msg)
 	msg = string.lower(msg)

	if string.find(msg, 'hi') and (focus == 0) and getNpcDistanceToCreature(cid) < 3 and not string.find(msg, 'shield') then
		if (getPlayerLevel(cid) > levelmin and getPlayerLevel(cid) < levelmax) or getPlayerAccess(cid) > 3 then
			if getPlayerStorageValue(cid,mission_id) == 1 then --como era so chegar ate aqui, ele ja recebe o premio agora
				focus = cid
				
				selfSay(mission_complete)
				
				doPlayerAddExp(focus,bonus_exp)
				setPlayerStorageValue(focus,mission_id,2)
				
				talk_start = os.clock()
				
				selfSay('Esta pronto para a proxima missao??')
				state = 1
				
			elseif getPlayerStorageValue(cid,mission_id) == 2 and getPlayerStorageValue(cid,new_mission_id) <= 0 then --se ja fez a que veio mas nao pegou a nova
				selfSay('Esta pronto para a proxima missao??')
				focus = cid
				state = 1
				talk_start = os.clock()
				
			elseif getPlayerStorageValue(cid,new_mission_id) == 1 then --se ja recebeu a nova
				selfSay(greet_com_quest)
				
			elseif getPlayerStorageValue(cid,mission_id) <= 0 then
				selfSay(sem_missao)
			end
		else
			selfSay('Desculpe, nao posso te ajudar')
		end
	end

	
	if focus == cid then
		
		if state == 1 then --aqui ele recebe a proxima missao
			if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
				selfSay(new_mission_text)
				setPlayerStorageValue(focus,new_mission_id,1)
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
