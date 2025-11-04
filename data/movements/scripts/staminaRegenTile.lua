local STAMINA_TILE_ACTIONID = 25000
local activeEvents = {}

-- Configurações para cada tipo de conta
local STAMINA_CONFIG = {
    free = {
        time = 2 * 60 * 1000, -- 2 minutos em ms
        amount = 1
    },
    premium = {
        time = 1 * 60 * 1000, -- 1 minuto em ms
        amount = 2
    }
}

-- Verifica se o jogador ainda está sobre o tile com actionid correto
local function isOnStaminaTile(player)
    local tile = Tile(player:getPosition())
    if not tile then return false end

    local item = tile:getTopVisibleThing(player)
    if item and item:isItem() and item:getActionId() == STAMINA_TILE_ACTIONID then
        return true
    end

    for i = 0, tile:getThingCount() - 1 do
        local thing = tile:getThing(i)
        if thing and thing:isItem() and thing:getActionId() == STAMINA_TILE_ACTIONID then
            return true
        end
    end

    return false
end

-- Função principal de regeneração
local function grantStamina(cid, time, amount)
    local player = Player(cid)
    if player and isOnStaminaTile(player) then
        local currentStamina = player:getStamina()
        local newStamina = math.min(currentStamina + amount, 2520)
        player:setStamina(newStamina)

        if newStamina > currentStamina then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ganhou " .. amount .. " minuto(s) de stamina.")
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua stamina ja esta cheia.")
        end

        activeEvents[cid] = addEvent(grantStamina, time, cid, time, amount)
    else
        activeEvents[cid] = nil
    end
end

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then return true end

    local cid = player:getId()
    local config = player:isPremium() and STAMINA_CONFIG.premium or STAMINA_CONFIG.free

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
        string.format("Como um %s account, voce ganha %d minuto(s) de stamina a cada %d minuto(s).",
            player:isPremium() and "Premium" or "Free",
            config.amount, config.time / 60000)
    )

    if not activeEvents[cid] then
        activeEvents[cid] = addEvent(grantStamina, config.time, cid, config.time, config.amount)
    end

    return true
end

function onStepOut(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then return true end

    local cid = player:getId()
    if activeEvents[cid] then
        stopEvent(activeEvents[cid])
        activeEvents[cid] = nil
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce saiu da area de Treinamento.")
    return true
end
