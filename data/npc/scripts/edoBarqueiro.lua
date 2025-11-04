--Barqueiro de transferencia entre mundos

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
local mundo1 = 'kersey'
local mundo2 = 'tarrasque'
local mundo3 = 'valinor'
local custodias = 0
local custodias1 = 5
local custodias2 = 10
local custodias3 = 15
local mundo_gratis = 1

local pid = 0
local novomundo = ''
local novomundoid = -1
local talk_start = 0
local focus = 0
local acc = 0
local world_id = 10

local function zeraTudo()
	focus = 0
	state = 0
	talk_start = 0
end

local function getCount(msg)
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
			focus = cid
			selfSay('Olá! Eu posso te levar para outro mundo, pra qual mundo Voce quer ir?('..mundo1..')('..mundo2..')('..mundo3..')')
			
			if getPlayerLevel(focus) > 200 then
				custodias = custodias3
			elseif getPlayerLevel(focus) > 100 then
				custodias = custodias2
			else
				custodias = custodias1
			end
			
			pid = getPlayerGUID(focus)
			local result = db.getResult("SELECT `world_id`,`account_id` FROM `players` WHERE `id` = "..pid..";")
			if result:getID() >= 0 then
				world_id = result:getDataLong("world_id")
				acc = result:getDataLong("account_id")
			else
				selfSay('Erro interno: X33')
				zeraTudo()
			end
			
			if world_id == mundo_gratis then
				custodias = 0
			end
			
			selfSay('A transferência pro seu level custa '..custodias..' dias de VIP.')
			
			state = 1
			talk_start = os.clock()
		end
		
	elseif state == 1 then
		if msgcontains(msg, mundo1) or msgcontains(msg, mundo2) or msgcontains(msg, mundo3) then
			if getPlayerPremiumDays(focus) >= custodias then
				selfSay('Voce ja saiu da sua Guild, vendeu sua casa e colocou seus itens no depot?')
				state = 2
				novomundo = msg
				
				if(novomundo == 'kersey') then
					novomundoid = 0
				elseif(novomundo == 'desolator') then
					novomundoid = 1
				elseif(novomundo == 'tarrasque') then
					novomundoid = 2
				elseif(novomundo == 'valinor') then
					novomundoid = 3
				end
				
				talk_start = os.clock()
			else
				selfSay('Voce nao tem dias de VIP suficientes. Adeus.')
				zeraTudo()
			end
		else
			selfSay('Mundo inválido.')
		end
		
	elseif state == 2 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
			if getHouseByPlayerGUID(focus) == nil then
				if getPlayerGuildId(focus) == 0 then
					local custonome
					if custodias > 0 then
						custonome = 'por '..custodias..' dias de VIP'
					else
						custonome = 'gratuitamente'
					end
					
					selfSay('Voce tem certeza que quer se transferir para o mundo '..novomundo..' '..custonome..'?')
					talk_start = os.clock()
					state = 3
				else
					selfSay('Voce ainda está em uma Guild, saia dela antes de se transferir. Adeus.')
					zeraTudo()
				end
			else
				selfSay('Voce ainda tem uma casa, saia dela antes de se transferir. Adeus.')
				zeraTudo()
			end
		else
			selfSay('Entao vá fazer isso antes...')
			zeraTudo()
		end
		
	elseif state == 3 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		
			if world_id < 4 then
				
				if (world_id == 0 and novomundo == 'kersey') or (world_id == 1 and novomundo == 'desolator') or (world_id == 2 and novomundo == 'tarrasque') or (world_id == 3 and novomundo == 'valinor') or (novomundoid < 0) then
					selfSay("Voce ja e desse mundo! Adeus")
					zeraTudo()
				else
					local nomeputo = getCreatureName(focus)
					
					doAddAccountBanishment(acc,0,os.time()+60,8,2,'Seu personagem está sendo transferido, saia da conta e volte em 1 minuto',3143,'')
					doRemoveCreature(focus,true)
					db.executeQuery("UPDATE `accounts` set `lastday`=(`lastday`-(86400*"..custodias..")) WHERE `id` = '"..acc.."';")
					db.executeQuery("UPDATE `accounts` SET `premDays` = ((`lastDay` - UNIX_TIMESTAMP()) / 86400)+1 WHERE `lastDay` > UNIX_TIMESTAMP()")
					db.executeQuery("UPDATE accounts SET premDays = 0,lastDay = 0 WHERE lastDay < UNIX_TIMESTAMP()")
					db.executeQuery("DELETE FROM account_viplist WHERE `player_id` = "..pid..";")
					db.executeQuery("DELETE FROM account_viplist WHERE `account_id` = "..acc..";")
					db.executeQuery("DELETE FROM guild_invites WHERE `player_id` = "..pid..";")
					db.executeQuery("DELETE FROM guilds WHERE `ownerid` = "..pid..";")
					db.executeQuery("UPDATE `players` set `world_id` = "..novomundoid..", `rank_id` = 0, `isnopvp` = 0 WHERE `id` = "..pid..";")
					db.executeQuery("UPDATE `trade_house` set `world_id` = "..novomundoid.." WHERE `vendor_id` = "..pid..";")
					db.executeQuery("UPDATE `server_stats` set `mudaMundo`=`mudaMundo`+"..custodias.." WHERE `mes` = "..os.date("%m").." AND `ano` = "..os.date("%Y")..";")
					db.executeQuery("INSERT INTO `log_security` (`account_id`,`type`,`days`,`details`,`date`) VALUES ("..acc..",'mudaMundo',"..custodias..",'"..nomeputo.." to "..novomundo.."',UNIX_TIMESTAMP())")
					
					--print('Transf: '..novomundo)
					zeraTudo()
				end
			else
				selfSay('Erro 3231')
				zeraTudo()
			end
			
		else
			selfSay('Eu tambem nao queria te levar mesmo...')
			zeraTudo()
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
