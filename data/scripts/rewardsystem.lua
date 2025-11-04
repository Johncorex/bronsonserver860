-- data/scripts/rewardsystem.lua
-- Reward Chest System (todos os itens tentados; só vale a chance interna)

local ANNOUNCE_TO_SERVER = true
local ANNOUNCE_TO_PARTICIPANTS = true
local ANNOUNCE_TYPE = MESSAGE_STATUS_CONSOLE_ORANGE

-- Town alvo para o depot (usa REWARDCHEST.townId se existir, senão 2)
local function getTownId()
    if REWARDCHEST and REWARDCHEST.townId then
        return REWARDCHEST.townId
    end
    return 2
end

-- helper para loot summary
local function concatLootParts(parts)
    if #parts == 0 then
        return "no items"
    end
    return table.concat(parts, ", ")
end

-- adiciona todos os itens da categoria ao rewardTable
local function addLootCategory(lootTable, rewardTable)
    if not lootTable or #lootTable == 0 then
        return
    end
    for _, loot in ipairs(lootTable) do
        table.insert(rewardTable, loot)
    end
end

-- entrega no depot/backpack
local function addRewardLoot(uid, bossName, rewardTable)
    local money = math.random(10, 40)
    local player = Player(uid)
    local chest = Game.createItem(REWARDCHEST.rewardBagId)
    if not player or not chest then
        return { ok = false, lootSummary = "" }
    end

    chest:setAttribute("description", "Recompensa por matar " .. bossName .. ".")

    local lootParts = {}
    for _, reward in ipairs(rewardTable) do
        if math.random(100) <= (reward[3] or 0) then
            local count = math.max(1, math.random(1, reward[2] or 1))
            chest:addItem(reward[1], count)
            local iname = ItemType(reward[1]):getName()
            table.insert(lootParts, (count > 1 and (count .. "x " .. iname) or iname))
        end
    end

    chest:addItem(2152, money)
    table.insert(lootParts, money .. "x platinum coin")

    local TOWN_ID = getTownId()
    local ok = false
    local depotChest = player:getDepotChest(TOWN_ID, true)
    if depotChest then
        ok = (depotChest:addItemEx(chest) == RETURNVALUE_NOERROR)
    end
    if not ok then
        local bp = player:getSlotItem(CONST_SLOT_BACKPACK)
        if bp then
            ok = (bp:addItemEx(chest) == RETURNVALUE_NOERROR)
        end
    end

    if ok then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Sua recompensa esta no seu depot de Dol Guldur.")
		if player.save then
			player:save()
		end
    else
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "[Sistema de Recompensas] Nao foi possivel colocar no depot nem backpack, voce perdeu a recompensa.")
    end

    local boss = REWARDCHEST.bosses[bossName]
    if boss then
        player:setStorageValue(boss.storage, 0)
    end
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

    return {
        ok = ok,
        lootSummary = concatLootParts(lootParts)
    }
end

-- ===================== CORE DO SISTEMA DE REWARD ==========================
-- Distribui os rewards após a morte do boss (regras acumulativas por % do topo)
local function rewardChestSystem(bossName)
    local boss = REWARDCHEST.bosses[bossName]
    if not boss then return end

    -- Coleta participantes (quem tem pontos > 0)
    local participants = {}
    for _, p in ipairs(Game.getPlayers()) do
        local pts = p:getStorageValue(boss.storage)
        if pts and pts > 0 then
            table.insert(participants, { player = p, points = pts })
        end
    end

    if #participants == 0 then
        if ANNOUNCE_TO_SERVER then
            Game.broadcastMessage("[Sistema de Recompensas] " .. bossName .. " foi removido, nenhum participante engajou na batalha.", ANNOUNCE_TYPE)
        end
        return
    end

    -- Ordena por pontos desc e pega o topo
    table.sort(participants, function(a, b) return a.points > b.points end)
    local topPoints = participants[1].points

    -- Resultados para anunciar
    local results = {} -- { name, points, loot }

    for _, data in ipairs(participants) do
        local player = data.player
        local points = data.points
        local rewardTable = {}

        -- always: todos SEMPRE
        addLootCategory(boss.always, rewardTable)

        -- Regras acumulativas por % do top
        if points >= math.ceil(topPoints * 0.1) then
            addLootCategory(boss.common, rewardTable)
        end
        if points >= math.ceil(topPoints * 0.3) then
            addLootCategory(boss.semiRare, rewardTable)
        end
        if points >= math.ceil(topPoints * 0.5) then
            addLootCategory(boss.rare, rewardTable)
        end
        if points >= math.ceil(topPoints * 0.7) then
            addLootCategory(boss.veryRare, rewardTable)
        end

        -- Entrega e captura resumo
        local res = addRewardLoot(player:getId(), bossName, rewardTable)
        table.insert(results, {
            name = player:getName(),
            points = points,
            loot = (res.lootSummary ~= "" and res.lootSummary or "no items")
        })
    end

    -- Monta e anuncia o placar
    table.sort(results, function(a, b) return a.points > b.points end)
    local lines = { "[Sistema de Recompensas] Resultado do Boss: " .. bossName }
    for idx, row in ipairs(results) do
        table.insert(lines, string.format("#%d %s - %d pts - loot: %s", idx, row.name, row.points, row.loot))
    end
    local board = table.concat(lines, "\n")

    if ANNOUNCE_TO_SERVER then
        Game.broadcastMessage(board, ANNOUNCE_TYPE)
    end
    --if ANNOUNCE_TO_PARTICIPANTS then
       -- for _, data in ipairs(participants) do
         --   data.player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, board)
        --end
    --end
end

-- ===================== EVENTOS DE VIDA/MORTE E LOGIN ======================
-- Dispara a distribuição quando o boss morre
local RewardChestDeath = CreatureEvent("RewardChestDeath")
function RewardChestDeath.onDeath(creature, corpse, killer)
    local boss = REWARDCHEST.bosses[creature:getName():lower()]
    if boss then
        addEvent(rewardChestSystem, 1000, creature:getName():lower())
    end
    return true
end
RewardChestDeath:register()

-- Pontos por DANO causado ao boss
local RewardChestMonster = CreatureEvent("RewardChestMonster")
function RewardChestMonster.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if creature:isMonster() and attacker and attacker:isPlayer() then
        local boss = REWARDCHEST.bosses[creature:getName():lower()]
        if boss and primaryDamage > 0 then
            local currentPoints = attacker:getStorageValue(boss.storage)
            local addPts = math.ceil(primaryDamage / (REWARDCHEST.formula.hit or 1))
            attacker:setStorageValue(boss.storage, (currentPoints > 0 and currentPoints or 0) + addPts)
        end
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
RewardChestMonster:register()

local LoginPlayer = CreatureEvent("LoginPlayer")
function LoginPlayer.onLogin(player)
    player:registerEvent("RewardChestStats")
    return true
end
LoginPlayer:register()

-- BLOCK (dano recebido) e SUPPORT (cura)
local RewardChestStats = CreatureEvent("RewardChestStats")
function RewardChestStats.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    -- BLOCK: monstro bate no player
    if attacker and attacker:isMonster() and (primaryType == COMBAT_PHYSICALDAMAGE or secondaryType == COMBAT_PHYSICALDAMAGE) then
        local boss = REWARDCHEST.bosses[attacker:getName():lower()]
        if boss and primaryDamage < 0 then
            -- primaryDamage para dano sofrido costuma vir negativo; usar abs
            local dmg = math.abs(primaryDamage)
            local currentPoints = creature:getStorageValue(boss.storage)
            local addPts = math.ceil(dmg / (REWARDCHEST.formula.block or 1))
            creature:setStorageValue(boss.storage, (currentPoints > 0 and currentPoints or 0) + addPts)
            -- exaust para validação de suporte (cura) por curto período
            creature:setStorageValue(REWARDCHEST.storageExhaust, os.time() + 5)
        end

    -- SUPPORT: player cura outro alvo que está em combate com boss (e dentro do exhaust)
    elseif attacker and attacker:isPlayer() and (primaryType == COMBAT_HEALING or secondaryType == COMBAT_HEALING)
        and (creature:getHealth() < creature:getMaxHealth())
        and (creature:getStorageValue(REWARDCHEST.storageExhaust) >= os.time()) then

        for _, valor in pairs(REWARDCHEST.bosses) do
            if creature:getStorageValue(valor.storage) > 0 then
                local addHeal = math.min(primaryDamage, creature:getMaxHealth() - creature:getHealth())
                -- em alguns distros primaryDamage de cura vem positivo; garantir não negativo
                addHeal = math.max(0, addHeal or 0)
                if addHeal > 0 then
                    local currentPoints = attacker:getStorageValue(valor.storage)
                    local addPts = math.ceil(addHeal / (REWARDCHEST.formula.support or 1))
                    attacker:setStorageValue(valor.storage, (currentPoints > 0 and currentPoints or 0) + addPts)
                end
            end
        end
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
RewardChestStats:register()
