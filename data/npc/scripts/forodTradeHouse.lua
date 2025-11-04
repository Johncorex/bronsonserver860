--FALTA EXCESSOES, TESTAR DIREITO, categorias de mais tipos.. so tem armas agora


local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)


-- OTServ event handling functions start
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end
-- OTServ event handling functions end


-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())

local state = 0
local nome = 'nome_error'
local price = 0
local id = 0
local focus = 0
local playername = 'pname_error'
local playerid = 0
local talk_start = 0
local tipoN = 0
local tipo = 'other'
local c_itemid = 0
local c_price = 0
local c_cod = 0
local c_vendor = 'vendor_error'
local taxa = 0
local cargas = 1

local function zeraTudo()
	state = 0
	nome = 'erro_de_nome'
	price = 0
	id = 0
	focus = 0
	playername = 'erro_pname'
	playerid = 0
	talk_start = 0
	tipoN = 0
	tipo = 'other'
	c_itemid = 0
	c_price = 0
	c_cod = 0
	c_vendor = 'vendor_error'
	taxa = 0
end

function getCount(msg)
	b, e = string.find(msg, "%d+")
	if b == nil or e == nil then
		count = 1
	else
		count = tonumber(string.sub(msg, b, e))
	end
	return count
end

function msgcontains(txt, str)
  	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

function onCreatureSay(cid, type, msg)
 	msg = string.lower(msg)

	if state > 0 and cid ~= focus then
		return
	end

	if state == 0 then
		if msgcontains(msg, 'hi') and getNpcDistanceToCreature(cid) < 3 then
			selfSay('Olá! Voce quer \'comprar\' ou \'vender\' itens?')
			focus = cid
			state = 1
			talk_start = os.clock()
		end
		
	elseif state == 1 then
		if msgcontains(msg, 'vender') then
			if getPlayerLevel(focus) >= 20 then
				selfSay('Diga o nome do item que quer colocar para vender')
				state = 2
				playername = getPlayerName(focus)
				playerid = getPlayerGUID(focus)
				talk_start = os.clock()
			else
				selfSay('Voce tem que ter level 20 ou mais para poder vender na Trade House. Adeus.')
				zeraTudo()
			end
		elseif msgcontains(msg, 'comprar') then
			if getPlayerLevel(focus) >= 10 then
				selfSay('Diga o código do Item que Voce quer comprar')
				state = 10
				playername = getPlayerName(focus)
				playerid = getPlayerGUID(focus)
				talk_start = os.clock()
			else
				selfSay('Voce tem que ter level 20 ou mais para poder comprar na Trade House. Adeus.')
				zeraTudo()
			end
		end
		
	elseif state == 2 then
		
		id = getItemIdByName(msg,false)
		
		if id ~= false then
			tipoN = tipoItem(id)
			
			if tipoN == 0 then tipo = 'peidou'
				elseif tipoN == 666 then tipo = 'peidou'
				elseif tipoN == 1 then tipo = 'sword'
				elseif tipoN == 2 then tipo = 'club'
				elseif tipoN == 3 then tipo = 'axe'
				elseif tipoN == 4 then tipo = 'shield'
				elseif tipoN == 5 then tipo = 'dist'
				elseif tipoN == 6 then tipo = 'wand'
				elseif tipoN == 7 then tipo = 'peidou' --ammo
				elseif tipoN == 8 then tipo = 'helmet'
				elseif tipoN == 9 then tipo = 'armor'
				elseif tipoN == 10 then tipo = 'boot'
				elseif tipoN == 11 then tipo = 'necklace'
				--elseif tipoN == 12 then tipo = 'ring'
				elseif tipoN == 13 then tipo = 'legs'
				elseif tipoN == 14 then tipo = 'rune'
				else tipo = 'peidou'
			end
				
			if tipo ~= 'peidou' then
				local descr = getItemDescriptionsById(id)
				nome = descr.name
				selfSay('Por quantos gps voce quer colocar a venda?')
				state = 3
				talk_start = os.clock()
			else
				selfSay('Item inválido!')
			end
		else
			selfSay('Item invalido!')
		end
		
	--pergunta custo
	elseif state == 3 then
		price = getCount(msg)
		taxa = price / 100
		if taxa > 1000 then
			taxa = 1000
		end
		
		if price >= 1000 and price <= 5000000 then
			selfSay('Voce tem certeza que quer colocar um '..nome..' para vender por '..price..' gps? Será cobrada uma taxa de 1%: ' ..taxa.. 'gps')
			state = 4
			talk_start = os.clock()
		else
			selfSay('Valor inválido. Eu so aceito itens entre 1.000(1k) e 5.000.000(5kk) de gps')
		end
		
	--efetua o deposito
	elseif state == 4 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
			if doPlayerRemoveMoney(focus, taxa) == true then
				if tipoN == 14 then --para runas e diferente pq tem que por as cargas
					if doPlayerRemoveItem(focus,id,1,200) == true then
						if addItemToTradeHouse(id,nome,playerid,playername,price,tipo) == true then
							state = 1
							zeraTudo()
							selfSay('Seu item foi colocado na Trade House! Ele ficará lá por 2 semanas e se nao for vendido ele será devolvido ao seu depot.')
						else
							doPlayerAddMoney(focus, taxa)
							state = 1
							doPlayerAddItem(focus,id)
							zeraTudo()
							selfSay('Ocorreu um erro interno, informe ao GM o codigo: TH-SQL'..id..' '..playerid)
							print('TH-SQL!')
						end
					else
						doPlayerAddMoney(focus, taxa)
						zeraTudo()
						selfSay('Voce so pode colocar runas de 200 cargas para vender.')
					end
				else
					if doPlayerRemoveItem(focus,id,1) == true then
						if addItemToTradeHouse(id,nome,playerid,playername,price,tipo) == true then
							state = 1
							zeraTudo()
							selfSay('Seu item foi colocado na Trade House! Ele ficará lá por 2 semanas e se nao for vendido ele será devolvido ao seu depot.')
						else
							doPlayerAddMoney(focus, taxa)
							state = 1
							doPlayerAddItem(focus,id)
							zeraTudo()
							selfSay('Ocorreu um erro interno, informe ao GM o codigo: TH-SQL'..id..' '..playerid)
							print('TH-SQL!')
						end
					else
						doPlayerAddMoney(focus, taxa)
						zeraTudo()
						selfSay('Voce nao tem esse item! Adeus!')
					end
				end
			else
				zeraTudo()
				selfSay('Voce nao tem dinheiro para pagar a taxa! Adeus!')
			end
			
		elseif msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
			zeraTudo()
			selfSay('Quer tentar outra venda ou compra?')
			state = 5
			talk_start = os.clock()
		end
		
	--Tentar de novo
	elseif state == 5 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
			selfSay('Diga o nome do item que quer colocar para vender')
			state = 2
			talk_start = os.clock()
		elseif msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
			zeraTudo()
			focus = 0
			state = 0
			selfSay('Tchau...')
		end
	
	--comprar
	elseif state == 10 then
		c_cod = getCount(msg)
		if c_cod > 0 and c_cod < 10000000 then
			local infos = {item_id = 0, price = 0, itemname = 'fdp', vendor_name = 'name_error'}
			infos = getInfoFromTradeHouse(cid,c_cod)
			
			if infos.item_id == 1 then
				selfSay("Voce nao pode comprar este item, ele nao está no seu mundo.")
				zeraTudo()
			
			elseif infos.item_id == 2 then
				selfSay("Código inválido. Consulte os produtos a venda pelo site www.bronsonserver.com/th")
		
			elseif infos.item_id > 2 then
				c_itemid = infos.item_id
				c_price = infos.price
				c_vendor = infos.vendor_name
				
				if tipoItem(c_itemid) == 14 then
					cargas = 200
				end
				
				selfSay('Voce tem certeza que quer comprar este '..infos.itemname..' por '..infos.price..' gp?')
				
				state = 11
				talk_start = os.clock()
				
			else
				state = 0
				zeraTudo()
				selfSay('Código inválido. Consulte os produtos a venda pelo site www.bronsonserver.com/th')
			end
			
		else
			state = 0
			zeraTudo()
			selfSay('Código inválido.. Consulte os produtos a venda pelo site www.bronsonserver.com/th')
		end
		
	elseif state == 11 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
			if doPlayerRemoveMoney(focus, c_price) == true then
				if getPlayerFreeCap(focus) > 150 then
					if removeFromTradeHouse(c_cod,c_vendor,c_price) == true then
						if doPlayerAddItem(focus, c_itemid,cargas) ~= false then
							
							selfSay('Tome seu item!')
							zeraTudo()
							talk_start = os.clock()
							state = 0 --volta pra pergunta
						else
							doPlayerAddMoney(focus, c_price)
							selfSay('Ocorreu um erro, informe a um GM: R1')
							print('--------------======TH Erro R1: '..getPlayerName(focus))
							zeraTudo()
						end
						
					else
						doPlayerAddMoney(focus, c_price)
						selfSay('Ocorreu um erro, informe a um GM: R2')
						print('--------------======TH Erro R2: '..getPlayerName(focus))
						zeraTudo()
					end
				else
					doPlayerAddMoney(focus, c_price)
					selfSay('Voce nao tem capacidade suficiente. Adeus.')
					zeraTudo()
				end
			else
				selfSay('Voce nao tem dinheiro suficiente. Adeus.')
				zeraTudo()
			end
			
		elseif msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
			zeraTudo()
			selfSay('Entao diga o código do Item que voce quer comprar')
			state = 10
			talk_start = os.clock()
		end
		
	end
	
end


function onCreatureDisappear(cid)
	if focus == cid then
		zeraTudo()
	end
end
	
function onThink()

 	if (os.clock() - talk_start) > 30 then
 		if focus > 0 then
 			selfSay('Proximo...')
		end
		
		zeraTudo()
	end

	if focus > 0 then
		lookAtPlayer(focus)
		
		if getNpcDistanceToCreature(focus) > 2 then
			selfSay('Ate mais ' .. getCreatureName(focus) .. '.')
			zeraTudo()
		end
 	end

end
