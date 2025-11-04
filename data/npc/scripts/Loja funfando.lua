local focus = 0		
local talk_start = 0
local target = 0
local following = false
local attacking = false
local buying = false
local item = 0


 function onThingMove(creature, thing, oldpos, oldstackpos)
 
 end
 
 
 function onCreatureAppear(creature)
 
 end
 
 
 function onCreatureTurn(creature)
 
 end
 

 function onCreatureDisappear(cid, pos)
 	if focus == cid then
         selfSay('Good Bye.')
         focus = 0
         talk_start = 0
 	end
 end


function msgcontains(txt, str)
	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end


function onCreatureSay(cid, type, msg)
 	msg = string.lower(msg)
 

if string.find(msg, 'hi') and (focus == 0) and getNpcDistanceToCreatureCreature(cid) < 3 and not string.find(msg, 'shield') then
	selfSay('Oi ' .. creatureGetName(cid) .. ', Eu compro e vendo escudos!')
	focus = cid
	talk_start = os.clock()


elseif string.find(msg, 'hi') and (focus ~= cid) and getNpcDistanceToCreatureCreature(cid) < 3 and not string.find(msg, 'shield') then
	selfSay('Espere por favor')
end


	if focus == cid and getNpcDistanceToCreatureCreature(cid) < 3 then



	if msgcontains(msg, 'sell wooden shield') then
	item = 2512
	price = 6
	buying = false
	selfSay('Voce quer vender um wooden shield por ' .. price .. ' gp?')
 	talk_start = os.clock()



	elseif msgcontains(msg, 'wooden shield') then
	item = 2512
	price = 12
	buying = true
	selfSay('Voce quer comprar um wooden shield por ' .. price .. ' gp?')
 	talk_start = os.clock()
 	
	end






 	if string.find(msg, 'bye') then
		selfSay('Ate mais ' .. creatureGetName(cid) .. '.')
		focus = 0
		item = 0
 		talk_start = 0
 	end

	if (buying == true) and item > 0 then

	 	if string.find(msg, 'bye') then
 			selfSay('Ate mais ' .. creatureGetName(cid) .. '.')
 			focus = 0
	 		talk_start = 0
	 	end

		if (string.find(msg, 'yes') or string.find(msg, 'sim')) then
	 		buy(cid,item,1,price)
			selfSay('Volte sempre!')
			talk_start = os.clock()
			item = 0

		elseif (string.find(msg, 'no') or string.find(msg, 'nao')) then
			selfSay('Okay. Continue comprando')
			item = 0
			talk_start = os.clock()
		end

	elseif (buying == false) and item > 0 then

	 	if string.find(msg, 'bye') then
 			selfSay('Ate mais ' .. creatureGetName(cid) .. '.')
 			focus = 0
	 		talk_start = 0
	 	end

		if (string.find(msg, 'yes') or string.find(msg, 'sim')) then
	 	sell(cid,item,1,price)
		talk_start = os.clock()
		item = 0

		elseif (string.find(msg, 'no') or string.find(msg, 'nao')) then
		selfSay('Okay. Continue comprando')
		item = 0
		talk_start = os.clock()
		end

	end

    end


end
 



 function onCreatureChangeOutfit(creature)
 
 end
 

function onThink()
 	if (os.clock() - talk_start) > 20 then
 		if focus > 0 then
 			selfSay('Proximo...')
		end
 		
		focus = 0
	end

	if focus > 0 and getNpcDistanceToCreatureCreature(focus) > 2 then
		selfSay('Ate mais ' .. creatureGetName(focus) .. '.')
		focus = 0
		item = 0
		talk_start = 0
 	end

	if focus == 0 then
	selfTurn(0)
	end

end