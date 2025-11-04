-- teleport.lua
function onSay(cid, words, param)
    local config = {
        pz = false, -- players precisam estar em protection zone para usar? (true or false)
        battle = true, -- players deve estar sem battle (true or false)
        custo = false, -- se os teleport irão custar (true or false)
        need_level = false, -- se os teleport irão precisar de level (true or false)
        premium = false -- se precisa ser premium account (true or false) - configuração geral
    }
	
    -- Configuração dos lugares
    local lugar = {
        ["anfallas"] = {pos = {x=982, y=1298, z=7}, level = 1, price = 0},
		["minas"] = {pos = {x=1345, y=1371, z=6}, level = 1, price = 0},
        ["dol"] = {pos = {x=1206, y=753, z=7}, level = 1, price = 0},
        ["edoras"] = {pos = {x=1066, y=1008, z=5}, level = 1, price = 0},
        ["bree"] = {pos = {x=742, y=537, z=7}, level = 1, price = 0},
        ["belfallas"] = {pos = {x=1187, y=1514, z=7}, level = 1, price = 0},
        ["ashenport"] = {pos = {x=334, y=611, z=6}, level = 1, price = 0},
        ["esg"] = {pos = {x=1413, y=502, z=7}, level = 1, price = 0},
        ["argond"] = {pos = {x=607, y=867, z=7}, level = 1, price = 0},
        ["moria"] = {pos = {x=1018, y=636, z=7}, level = 1, price = 0},
        ["forod"] = {pos = {x=709, y=105, z=7}, level = 1, price = 0},
        ["condado"] = {pos = {x=621, y=533, z=7}, level = 1, price = 0},
        ["dunedain"] = {pos = {x=1591, y=371, z=6}, level = 1, price = 0},
        ["troll1"] = {pos = {x=1071, y=877, z=8}, level = 1, price = 0},
        ["troll2"] = {pos = {x=1168, y=922, z=8}, level = 1, price = 0},
        ["rot"] = {pos = {x=1152, y=930, z=9}, level = 1, price = 0},
        ["pirata"] = {pos = {x=193, y=651, z=7}, level = 1, price = 0},
        ["mino1"] = {pos = {x=740, y=415, z=8}, level = 1, price = 0},
        ["mino2"] = {pos = {x=556, y=570, z=7}, level = 1, price = 0},
        ["pantano"] = {pos = {x=1247, y=1074, z=7}, level = 1, price = 0},
        ["eriador"] = {pos = {x=825, y=724, z=7}, level = 1, price = 0},
        ["dwarf1"] = {pos = {x=1410, y=438, z=7}, level = 1, price = 0},
        ["dwarf2"] = {pos = {x=1000, y=617, z=7}, level = 1, price = 0},
        ["macacos1"] = {pos = {x=1270, y=753, z=7}, level = 1, price = 0},
        ["macacos2"] = {pos = {x=624, y=610, z=7}, level = 1, price = 0},
        ["slime2"] = {pos = {x=1365, y=475, z=7}, level = 1, price = 0},
        ["slime3"] = {pos = {x=433, y=651, z=7}, level = 1, price = 0},
        ["bandit1"] = {pos = {x=1120, y=1090, z=7}, level = 1, price = 0},
        ["bandit2"] = {pos = {x=710, y=383, z=7}, level = 1, price = 0},
        ["cyc1"] = {pos = {x=1038, y=869, z=7}, level = 1, price = 0},
        ["cyc2"] = {pos = {x=1104, y=788, z=10}, level = 1, price = 0},
        ["cyc3"] = {pos = {x=1276, y=914, z=6}, level = 1, price = 0},
        ["stonegolem"] = {pos = {x=1324, y=1047, z=7}, level = 1, price = 0},
        ["dworc1"] = {pos = {x=640, y=214, z=7}, level = 1, price = 0},
        ["eregion"] = {pos = {x=901, y=725, z=7}, level = 1, price = 0},
        ["erebor"] = {pos = {x=1415, y=424, z=4}, level = 1, price = 0},
        ["mirkwood"] = {pos = {x=1253, y=637, z=7}, level = 1, price = 0},
        ["forochel"] = {pos = {x=507, y=116, z=6}, level = 1, price = 0},
        ["carn"] = {pos = {x=676, y=199, z=6}, level = 1, price = 0},
        ["enedwaith"] = {pos = {x=867, y=1004, z=7}, level = 1, price = 0},
        ["elven"] = {pos = {x=999, y=582, z=2}, level = 1, price = 0},
        ["wyvern"] = {pos = {x=823, y=354, z=6}, level = 1, price = 0},
        ["beleghost"] = {pos = {x=182, y=589, z=6}, level = 1, price = 0},
        ["evendim"] = {pos = {x=580, y=242, z=6}, level = 1, price = 0},
        ["bonebeast1"] = {pos = {x=1302, y=658, z=7}, level = 1, price = 0},
        ["blacknight1"] = {pos = {x=861, y=416, z=7}, level = 1, price = 0},
        ["hero1"] = {pos = {x=1137, y=1453, z=7}, level = 1, price = 0},
        ["hero2"] = {pos = {x=1200, y=1440, z=7}, level = 1, price = 0},
        ["hydra1"] = {pos = {x=667, y=724, z=6}, level = 1, price = 0},
        ["hydra2"] = {pos = {x=526, y=641, z=6}, level = 1, price = 0},
        ["hydra3"] = {pos = {x=498, y=686, z=6}, level = 1, price = 0},
        ["lich"] = {pos = {x=1470, y=1034, z=7}, level = 1, price = 0},
        ["icewitch1"] = {pos = {x=723, y=74, z=7}, level = 1, price = 0},
        ["crystal"] = {pos = {x=696, y=80, z=7}, level = 1, price = 0},
        ["barbarian"] = {pos = {x=951, y=98, z=7}, level = 1, price = 0},
        ["dragon1"] = {pos = {x=679, y=327, z=7}, level = 1, price = 0},
        ["dragon2"] = {pos = {x=368, y=660, z=7}, level = 1, price = 0},
        ["turtle"] = {pos = {x=452, y=509, z=7}, level = 1, price = 0},
        ["purga"] = {pos = {x=1085, y=346, z=7}, level = 1, price = 0},
        ["northern"] = {pos = {x=1541, y=142, z=7}, level = 1, price = 0},
        ["ered"] = {pos = {x=1282, y=90, z=7}, level = 1, price = 0},
        ["orodruin"] = {pos = {x=1578, y=1208, z=0}, level = 1, price = 0},
        ["ice"] = {pos = {x=859, y=127, z=7}, level = 1, price = 0},
        ["nimrais"] = {pos = {x=740, y=1210, z=0}, level = 1, price = 0},
        ["defiler"] = {pos = {x=642, y=492, z=7}, level = 1, price = 0},
        ["behedemon"] = {pos = {x=996, y=611, z=10}, level = 1, price = 0},
        ["harlond"] = {pos = {x=379, y=812, z=5}, level = 1, price = 0},
        ["riv"] = {pos = {x=1052, y=541, z=4}, level = 1, price = 0},
        ["mordor"] = {pos = {x=1510, y=1235, z=7}, level = 1, price = 0},
        ["orc"] = {pos = {x=1275, y=804, z=7}, level = 1, price = 0},
		["promotion2"] = {pos = {x=2035, y=637, z=7}, level=1, price = 0},
		
		-- adicione premium = true nos locais que devem ser restritos
		["dragonvip"] = {pos = {x=1539, y=723, z=6}, level = 1, price = 0, premium = true},
		["rhun"] = {pos = {x=1759, y=813, z=7}, level = 1, price = 0, premium = true},
		["icewitch2"] = {pos = {x=1306, y=1290, z=3}, level = 1, price = 0, premium = true},
		["dunland"] = {pos = {x=808, y=930, z=7}, level = 1, price = 0, premium = true},
		["vamp"] = {pos = {x=1275, y=1382, z=7}, level = 1, price = 0, premium = true},
		["blacknight2"] = {pos = {x=1257, y=1371, z=5}, level = 1, price = 0, premium = true},
		["hero3"] = {pos = {x=1257, y=1367, z=5}, level = 1, price = 0, premium = true},
		["slime1"] = {pos = {x=1362, y=1426, z=6}, level = 1, price = 0, premium = true},
		["bonebeast2"] = {pos = {x=1327, y=1300, z=5}, level = 1, price = 0, premium = true},
		["orcmordor"]= {pos = {x = 1499, y = 1293, z = 7}, level = 1, price = 0, premium = true},
		["lizard"]= {pos = {x = 289, y = 329, z = 5}, level = 1, price = 0, premium = true},
		["cyc4"]= {pos = {x = 826, y = 1277, z = 7}, level = 1, price = 0, premium = true}
    }
    
    local a = lugar[param:lower()]
    if not a then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "As cidades: edoras, belfallas, ashenport, bree, riv, dol, esg, argond, moria, mordor, forod, condado, dunedain, anfallas, minas")
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Locais que Free podem ir são:")
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "troll1, troll2, rot, pirata, mino1, mino2, pantano, eriador, dwarf1, dwarf2, macacos1, macacos2, slime2, slime3, bandit1, bandit2, cyc1, cyc2, cyc3, stonegolem, dworc1, eregion, erebor, mirkwood, forochel, carn, enedwaith, elven, wyvern, beleghost, evendim, bonebeast1, orc, blacknight1, hero1, hero2, hydra1, hydra2, hydra3, lich, icewitch1, crystal, barbarian, dragon1, dragon2, turtle, purga, northern, ered, orodruin, ice, nimrais, defiler, behedemon, harlond")
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Locais que Premium podem ir são:")
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "dragonvip, rhun, blacknight2, hero3, slime1, bonebeast2, dunland, vamp, icewitch2, orcmordor, lizard, cyc4")
        doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
        return false
    end
    
    -- Verificações de segurança
    -- Verifique primeiro se o local requer premium e se o jogador é premium
    if (a.premium or config.premium) and not isPremium(cid) then
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Apenas contas vip podem acessar este local.")
        return false
    end
		
		-- Se não estiver em PZ, checa o battle normalmente
	if not getTileInfo(getCreaturePosition(cid)).protection then
		if config.battle and getCreatureCondition(cid, CONDITION_INFIGHT) then
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Você não pode se teleportar em uma batalha.")
			return false
		end
	end

    
    if config.pz and not getTileInfo(getCreaturePosition(cid)).protection then
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Você precisa estar em uma protection zone para usar este comando.")
        return false
    end
    
    if config.need_level and getPlayerLevel(cid) < a.level then
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Você precisa do nível " .. a.level .. " para teleportar para este local.")
        return false
    end
    
    if config.custo and not doPlayerRemoveMoney(cid, a.price) then
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Você não tem dinheiro suficiente para este teleporte.")
        return false
    end
    
    -- Teleportar
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
    if doTeleportThing(cid, a.pos) then
        doSendMagicEffect(a.pos, CONST_ME_TELEPORT)
    else
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Falha ao teleportar. Posição inválida.")
        doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
    end
    
    return false
end