local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local playerTopics = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end

function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)
    playerTopics[cid] = nil
end

function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- Configuração de preço por level
local STAGE1_MAX_LVL, STAGE2_MAX_LVL, STAGE3_MAX_LVL, STAGE4_MAX_LVL = 50, 100, 180, 230
local STAGE1_FACTOR, STAGE2_FACTOR, STAGE3_FACTOR, STAGE4_FACTOR  = 120, 200, 300, 400
local MAX_PRICE = 100000

local function getBlessPrice(level)
    if level <= STAGE1_MAX_LVL then
        return level * STAGE1_FACTOR
    elseif level <= STAGE2_MAX_LVL then
        return level * STAGE2_FACTOR
    elseif level <= STAGE3_MAX_LVL then
        return level * STAGE3_FACTOR
	elseif level <= STAGE4_MAX_LVL then
        return level * STAGE4_FACTOR
    else
        return MAX_PRICE
    end
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local player = Player(cid)
    if not player then return false end

    local level = player:getLevel()
    local price = getBlessPrice(level)

    if msgcontains(msg, 'valor') or msgcontains(msg, 'preco') or msgcontains(msg, 'price') then
        npcHandler:say(
            "Tabela de precos da bless:\n\n" ..
            "Level 1-" .. STAGE1_MAX_LVL .. ": " .. STAGE1_FACTOR .. " gp por level\n" ..
            "Level " .. (STAGE1_MAX_LVL + 1) .. "-" .. STAGE2_MAX_LVL .. ": " .. STAGE2_FACTOR .. " gp por level\n" ..
            "Level " .. (STAGE2_MAX_LVL + 1) .. "-" .. STAGE3_MAX_LVL .. ": " .. STAGE3_FACTOR .. " gp por level\n" ..
			"Level " .. (STAGE3_MAX_LVL + 1) .. "-" .. STAGE4_MAX_LVL .. ": " .. STAGE4_FACTOR .. " gp por level\n" ..
            "Level > " .. STAGE4_MAX_LVL .. ": " .. MAX_PRICE .. " gp (maximo)\n\n" ..
            "Seu level: " .. level .. "\n" ..
            "Seu preco: " .. price .. " gp", cid)
        return true
    end

    if msgcontains(msg, 'bless') or msgcontains(msg, 'abencoar') then
        npcHandler:say("Sua bless vai custar " .. price .. " gold coins. Vai querer? Fale {yes}!", cid)
        playerTopics[cid] = 1
        return true
    end

    if playerTopics[cid] == 1 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            if player:hasBlessing(1) and player:hasBlessing(2) and player:hasBlessing(3) and
               player:hasBlessing(4) and player:hasBlessing(5) then
                npcHandler:say("Voce ja esta com todas as blesses!", cid)
                npcHandler:releaseFocus(cid)
                playerTopics[cid] = nil
                return true
            end

            if player:getMoney() < price then
                npcHandler:say("Voce precisa de " .. price .. " gold coins. Volte quando tiver essa grana...", cid)
                npcHandler:releaseFocus(cid)
                playerTopics[cid] = nil
                return true
            end

            player:removeMoney(price)
            for i = 1, 5 do
                if not player:hasBlessing(i) then
                    player:addBlessing(i)
                end
            end

            npcHandler:say("Parabens " .. player:getName() .. "! Voce recebeu todas as blesses por " .. price .. " gold coins!", cid)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)

            playerTopics[cid] = nil
            npcHandler:releaseFocus(cid)
            return true

        elseif msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
            npcHandler:say("Okay, tchau!", cid)
            playerTopics[cid] = nil
            npcHandler:releaseFocus(cid)
            return true
        else
            npcHandler:say("Responda {yes} ou {no}, por favor.", cid)
            return true
        end
    end

    return false
end

-- CALLBACKS
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- MENSAGENS AUTOMÁTICAS
npcHandler:setMessage(MESSAGE_GREET, "Ola |PLAYERNAME|! Como posso te ajudar? Os players choravam muito na hora de pagar para o pai, entao reduzi os precos. Posso te {abencoar} ou te mostrar a tabela de {preco}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Tchau |PLAYERNAME|!")         -- Quando o player fala bye
npcHandler:setMessage(MESSAGE_WALKAWAY, "Tchau Tchau!")                -- Quando o player se afasta
npcHandler:setMessage(MESSAGE_IDLETIMEOUT, "Tchau!")                   -- Quando o player fica AFK

-- Módulo que escuta "hi", "bye", etc
npcHandler:addModule(FocusModule:new())
