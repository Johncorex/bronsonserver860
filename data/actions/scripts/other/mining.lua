-- CONFIGURACOES (somente pools)
-- mapeamento final: pedraId -> pool
local rewardPools = {}

-- helper para registrar um mesmo pool para varias pedras
local function setPool(ids, pool)
    for i = 1, #ids do
        rewardPools[ids[i]] = pool
    end
end

-- Pedras de terra
setPool({5747, 5750, 5751, 5752, 5753, 5754}, {
    { item = 5880,  count = 1, chance = 39 },   -- minerio de ferro
    { item = 10549, count = 1, chance = 60 },   -- ancient stone
    { item = 2157,  count = 1, chance = 0.99 }, -- golden nugget
    { item = 8300, count = 1, chance = 0.01 }  -- cristal impecavel
})

-- Pedras de terra com ferro
setPool({5866, 5867, 5868}, {
    { item = 5880,  count = 1, chance = 60 },   -- minerio de ferro
    { item = 10549, count = 1, chance = 39 },   -- ancient stone
    { item = 2157,  count = 1, chance = 0.99 }, -- golden nugget
    { item = 8300, count = 1, chance = 0.01 }  -- cristal impecavel
})

-- Pedras de Ferro
setPool({5619, 5620, 5621, 5622, 5623, 5624}, {
    { item = 5880,  count = 1, chance = 98 },   -- minerio de ferro
    { item = 5892,  count = 1, chance = 1 },    -- Grande Bloco de Ferro Bruto
    { item = 2157,  count = 1, chance = 0.99 }, -- golden nugget
    { item = 8300, count = 1, chance = 0.01 }  -- cristal impecavel
})

-- Pedras de Ferro Grandes
setPool({5707, 5708, 5709}, {
    { item = 5880,  count = 1, chance = 95 },   -- minerio de ferro
    { item = 5892,  count = 1, chance = 4 },    -- Grande Bloco de Ferro Bruto
    { item = 5889,  count = 1, chance = 0.99 }, -- fragmento de mithril
    { item = 8300, count = 1, chance = 0.01 }, -- cristal impecavel
})

-- Pedras de Carvao
setPool({8748, 8749, 8750, 8751}, {
    { item = 10609, count = 1, chance = 100 }   -- coal
})

-- Lista de picks validas (itemid)
local allowedPickIds = { 2553 } -- adicione outras se tiver

-- Vocacoes permitidas (miner)
local allowedVocations = { [17] = true, [18] = true, [19] = true, [20] = true }

-- COOLDOWN E CHANCES
local storage         = 5000
local delay_timer     = 1
local failChance      = 20
local baseBreakChance = 60
local respawnTime     = 1800 -- 1800
local breakReductionPerSkill = 0.3
local minBreakChance  = 10

-- EFEITOS
local effectFail1   = CONST_ME_POFF
local effectFail2   = CONST_ME_BLOCKHIT
local effectSuccess = CONST_ME_MAGIC_GREEN

-- ===== helpers =====
local function inList(t, v)
    for i = 1, #t do
        if t[i] == v then return true end
    end
    return false
end

-- retorna o pool correspondente ao stoneId (somente se houver pool)
local function getPoolForStone(stoneId)
    return rewardPools[stoneId]
end

-- escolhe exatamente 1 reward
-- se soma das chances <= 100: trata como % (pode retornar nil = nada), com decimais
-- se soma > 100: trata como pesos (sempre retorna 1 item)
local function rollOneReward(pool)
    local total = 0.0
    for i = 1, #pool do
        total = total + (pool[i].chance or 0)
    end

    if total <= 100.0 then
        local roll = math.random() * 100.0  -- 0.0 .. <100.0
        local acc  = 0.0
        for i = 1, #pool do
            acc = acc + (pool[i].chance or 0)
            if roll <= acc then
                return pool[i]
            end
        end
        return nil
    else
        local roll = math.random() * total   -- 0.0 .. <total
        local acc  = 0.0
        for i = 1, #pool do
            acc = acc + (pool[i].chance or 0)
            if roll <= acc then
                return pool[i]
            end
        end
        return pool[#pool]
    end
end

-- respawna a mesma pedra pelo itemid original
local function respawnSameStone(originalId, pos)
    local stone = Game.createItem(originalId, 1, pos)
    return stone
end

-- pedra e mineravel somente se tiver pool configurado
local function isMineable(stoneId)
    return rewardPools[stoneId] ~= nil
end

-- ===================

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- valida pick
    if not inList(allowedPickIds, item:getId()) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa usar uma picareta correta.")
        return true
    end

    -- cooldown
    local cur_time, cur_storage = os.time(), player:getStorageValue(storage)
    if cur_storage > cur_time then
        local s = cur_storage - cur_time
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce pode tentar novamente em " .. s .. (s == 1 and " segundo." or " segundos."))
        return true
    end

    -- vocacao miner obrigatoria
    local voc = player:getVocation()
    local vocId = voc and voc:getId() or 0
    if not allowedVocations[vocId] then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas miners podem minerar.")
        return true
    end

    -- valida alvo
    if not target or not target:isItem() then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao pode usar isso ai.")
        return false
    end

    local stoneId = target:getId()
    if not isMineable(stoneId) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Isso nao pode ser minerado.")
        return true
    end

    -- FALHA
    if math.random(100) <= failChance then
        toPosition:sendMagicEffect(effectFail1)
        toPosition:sendMagicEffect(effectFail2)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua tentativa de minerar falhou.")

        local clubSkill = player:getSkillLevel(SKILL_CLUB)
        local realBreakChance = math.max(minBreakChance, baseBreakChance - (clubSkill * breakReductionPerSkill))

        if math.random(100) <= realBreakChance then
            target:remove()
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A pedra quebrou!")
            addEvent(respawnSameStone, respawnTime * 1000, stoneId, toPosition)
        end

        player:setStorageValue(storage, cur_time + delay_timer)
        return true
    end

    -- SUCESSO (exatamente 1 reward no maximo)
    toPosition:sendMagicEffect(effectSuccess)

    local pool = getPoolForStone(stoneId) -- garantido existir pelo isMineable
    local reward = rollOneReward(pool)

    if reward then
        local count = reward.count or 1
        player:addItem(reward.item, count)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce minerou " .. count .. "x " .. ItemType(reward.item):getName() .. ".")
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao encontrou nada.")
    end

    player:setStorageValue(storage, cur_time + delay_timer)
    return true
end
