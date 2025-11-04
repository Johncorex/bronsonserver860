local focus = 0
local talk_start = 0
local target = 0
local following = false
local attacking = false
local buying = true
local item = 0
local price = 0

 function onThingMove(creature, thing, oldpos, oldstackpos)
 
 end
 
 
 function onCreatureAppear(creature)
 
 end

 function onCreatureChangeOutfit(creature)
 
 end
 
 function onCreatureDisappear(cid, pos)
 	if focus == cid then
         selfSay('Good Bye.')
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


if string.find(msg, 'hi') and (focus == 0) then
	if getNpcDistanceToCreature(cid) < 3 and not string.find(msg, 'shield') then
	selfSay('Oi ' .. getCreatureName(cid) .. ', Eu compro e vendo moveis!')
	focus = cid
	talk_start = os.clock()
	end

elseif string.find(msg, 'hi') and (focus ~= cid) and getNpcDistanceToCreature(cid) < 3 and not string.find(msg, 'shield') then
	selfSay('Espere por favor')


elseif focus == cid then 

	if getNpcDistanceToCreature(cid) < 3 then
	

	if msgcontains(msg, 'square table') then
	item = 3901 --1615
	price = 150
	buying = true
	selfSay('Voce quer comprar uma square table por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'small round table') then
	item = 3902 --1616
	price = 160
	buying = true
	selfSay('Voce quer comprar uma small round table por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'small table') then
	item = 3903 --1619
	price = 130
	buying = true
	selfSay('Voce quer comprar uma small table por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'wooden chair') then
	item = 3904 --1652
	price = 145
	buying = true
	selfSay('Voce quer comprar uma wooden chair por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'sofa chair') then
	item = 3905 --1658
	price = 280
	buying = true
	selfSay('Voce quer comprar uma sofa chair por ' .. price .. ' gp?')
 	talk_start = os.clock()
	
	elseif msgcontains(msg, 'red cushioned chair') then
	item = 3906  --1666
	price = 270
	buying = true
	selfSay('Voce quer comprar uma red cushioned chair por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'green cushioned chair') then
	item = 3907  --1670
	price = 270
	buying = true
	selfSay('Voce quer comprar uma green cushioned chair por ' .. price .. ' gp?')
 	talk_start = os.clock()
	
	elseif msgcontains(msg, 'rocking chair') then
	item = 3908  --1674
	price = 200
	buying = true
	selfSay('Voce quer comprar uma rocking chair por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'pendulum clock') then
	item = 3911 --1728
	price = 600
	buying = true
	selfSay('Voce quer comprar um pendulum clock por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'locker') then
	item = 3912 --1732
	price = 450
	buying = true
	selfSay('Voce quer comprar um locker por ' .. price .. ' gp?')
 	talk_start = os.clock()
	
	elseif msgcontains(msg, 'mirror') then
	item = 6373 --1736
	price = 320
	buying = true
	selfSay('Voce quer comprar um mirror por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'rocking horse') then
	item = 3917 --2117
	price = 290
	buying = true
	selfSay('Voce quer comprar um rocking horse por ' .. price .. ' gp?')
 	talk_start = os.clock()
	
	elseif msgcontains(msg, 'piano') then
	item = 3913 --2080
	price = 800
	buying = true
	selfSay('Voce quer comprar um piano por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'harp') then
	item = 3914 --2084
	price = 650
	buying = true
	selfSay('Voce quer comprar uma harpa por ' .. price .. ' gp?')
 	talk_start = os.clock()
	
	elseif msgcontains(msg, 'bird cage') then
	item = 3923 --2094
	price = 150
	buying = true
	selfSay('Voce quer comprar uma bird cage por ' .. price .. ' gp?')
 	talk_start = os.clock()
	
	elseif msgcontains(msg, 'globe') then
	item = 3924 --2098
	price = 230
	buying = true
	selfSay('Voce quer comprar um globe por ' .. price .. ' gp?')
 	talk_start = os.clock()
	
	elseif msgcontains(msg, 'big water-pipe') then
	item = 5088 --2099
	price = 180
	buying = true
	selfSay('Voce quer comprar um big water-pipe por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'water-pipe') then
	item = 3922 --2093
	price = 150
	buying = true
	selfSay('Voce quer comprar um water-pipe por ' .. price .. ' gp?')
 	talk_start = os.clock()
	
	elseif msgcontains(msg, 'indoor plant') then
	item = 3925 --2101
	price = 80
	buying = true
	selfSay('Voce quer comprar uma indoor plant por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'potted flower') then
	item = 3928 --2104
	price = 100
	buying = true
	selfSay('Voce quer comprar uma potted flower por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'christmas tree') then
	item = 3929 --2105
	price = 200
	buying = true
	selfSay('Voce quer comprar uma christmas tree por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'wooden telescope') then
	item = 3927 --2586
	price = 450
	buying = true
	selfSay('Voce quer comprar um wooden telescopeo por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'telescope') then
	item = 3918 --2582
	price = 550
	buying = true
	selfSay('Voce quer comprar um telescope por ' .. price .. ' gp?')
 	talk_start = os.clock()

	
	elseif msgcontains(msg, 'stone table') then
	item = 3919 --3806
	price = 550
	buying = true
	selfSay('Voce quer comprar uma stone table por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'tusk table') then
	item = 3920 --3808
	price = 400
	buying = true
	selfSay('Voce quer comprar uma tusk table por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'bamboo table') then
	item = 3921 --3810
	price = 360
	buying = true
	selfSay('Voce quer comprar uma bamboo table tree por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'tusk chair') then
	item = 3930 --3813
	price = 190
	buying = true
	selfSay('Voce quer comprar uma tusk chair por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'ivory chair') then
	item = 3935 --3817
	price = 230
	buying = true
	selfSay('Voce quer comprar uma ivory chair por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'bamboo drawer') then
	item = 3934 --3832
	price = 300
	buying = true
	selfSay('Voce quer comprar um bamboo drawer por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'nice bookcase') then
	item = 3936 --6371
	price = 310
	buying = true
	selfSay('Voce quer comprar um nice bookcase por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'drawers') then
	item = 3909 --1716
	price = 420
	buying = true
	selfSay('Voce quer comprar drawers por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'dresser') then
	item = 3916 --1724
	price = 450
	buying = true
	selfSay('Voce quer comprar um dresser por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'purple tapestry') then
	item = 1857
	price = 75
	buying = true
	selfSay('Voce quer comprar um purple tapestry por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'green tapestry') then
	item = 1860
	price = 75
	buying = true
	selfSay('Voce quer comprar um green tapestry por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'yellow tapestry') then
	item = 1853
	price = 75
	buying = true
	selfSay('Voce quer comprar um yellow tapestry por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'orange tapestry') then
	item = 1866
	price = 75
	buying = true
	selfSay('Voce quer comprar um orange tapestry por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'red tapestry') then
	item = 1869
	price = 75
	buying = true
	selfSay('Voce quer comprar um red tapestry por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'blue tapestry') then
	item = 1872
	price = 75
	buying = true
	selfSay('Voce quer comprar um blue tapestry por ' .. price .. ' gp?')
 	talk_start = os.clock()

	elseif msgcontains(msg, 'white tapestry') then
	item = 1880
	price = 75
	buying = true
	selfSay('Voce quer comprar um white tapestry por ' .. price .. ' gp?')
 	talk_start = os.clock()

	end


 	if string.find(msg, 'bye') then
		selfSay('Ate mais ' .. getCreatureName(cid) .. '.')
		focus = 0
		item = 0
 		talk_start = 0
 	end

	if (buying == true) and item > 0 then

	 	if string.find(msg, 'bye') then
 			selfSay('Ate mais ' .. getCreatureName(cid) .. '.')
 			focus = 0
	 		talk_start = 0
	 	end

		if (string.find(msg, 'yes') or string.find(msg, 'sim')) then
	 		if doPlayerRemoveMoney(cid,price) then
				doPlayerAddItem(cid,item)
			else
				selfsay('Voce nao tem dinheiro')
			end
			
		elseif (string.find(msg, 'no') or string.find(msg, 'nao')) then
			selfSay('Okay. Continue comprando')
			item = 0
			talk_start = os.clock()
		end

	elseif (buying == false) and item > 0 then

	 	if string.find(msg, 'bye') then
 			selfSay('Ate mais ' .. getCreatureName(cid) .. '.')
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


end
 

function onThink()

 	if (os.clock() - talk_start) > 15 then
 		if focus > 0 then
 			selfSay('Proximo...')
		end
 		
		focus = 0
	end

	if focus > 0 then
		if getNpcDistanceToCreature(focus) > 3 then
			selfSay('Ate mais ' .. getCreatureName(focus) .. '.')
			focus = 0
			item = 0
			talk_start = 0
		end
 	end

	if focus > 0 then 
		lookAtPlayer(focus)
	end
end
