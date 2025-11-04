-- data/events/scripts/monster.lua

-- =========================
-- Rarity animations (config)
-- =========================
local RARE_POPUP   = true
local RARE_EFFECT  = true
local RARE_EFFECT_ID = CONST_ME_TUTORIALARROW -- escolha um efeito bem visível no seu cliente

-- Conta quantos itens com raridade há dentro de um container (corpse)
local function countRarityInContainer(container)
    if not container or not container.isContainer or not container:isContainer() then
        return 0
    end
    local rares = 0
    local size = container:getSize() or 0
    for i = 0, size - 1 do
        local it = container:getItem(i)
        if it then
            local art = it:getArticle() or ""
            if art:find("legendary") or art:find("epic") or art:find("rare") then
                rares = rares + 1
            end
        end
    end
    return rares
end

function Monster:onDropLoot(corpse)
    if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
        return
    end

    local player = Player(corpse:getCorpseOwner())
    local mType  = self:getType()

    -- BLOQUEIO POR STAMINA (mantenho sua lógica atual):
    -- se não houver player OU stamina > 840, dropa; senão, nada e manda msg.
    if not player or player:getStamina() > 840 then
        -- 1) Preenche o corpse com o loot
        local monsterLoot = mType:getLoot()
        for _, loot in pairs(monsterLoot) do
            local ok = corpse:createLootItem(loot)
            if not ok then
                print('[Warning] DropLoot: Could not add loot item to corpse.')
            end
        end

        -- 2) Rola raridade AGORA (com o corpse já cheio)
        local rareCount = 0
        if type(rollRarity) == "function" then
            rareCount = rollRarity(corpse) or 0
        end
        -- 2b) Sanity: caso a função não retorne contagem, detecta pelo article do item
        if rareCount == 0 then
            rareCount = countRarityInContainer(corpse)
        end

        -- 3) Animação/Popup se caiu algum item raro
        if rareCount > 0 then
            local pos = corpse:getPosition()
            if RARE_EFFECT then
                pos:sendMagicEffect(RARE_EFFECT_ID)
            end
            if RARE_POPUP then
                local popup = _G.rare_text or "Rare!"
                if type(Game.sendAnimatedText) == "function" then
                    Game.sendAnimatedText(popup, pos, TEXTCOLOR_YELLOW)
                else
                    -- fallback simples: "fala" no chão
                    local spectators = Game.getSpectators(pos, false, true, 7, 7, 5, 5)
                    for i = 1, #spectators do
                        spectators[i]:say(popup, TALKTYPE_MONSTER_SAY, false, spectators[i], pos)
                    end
                end
            end
        end

        -- 4) Mensagem de loot normal
        if player then
            local text = ("Loot of %s: %s"):format(mType:getNameDescription(), corpse:getContentDescription())
            local party = player:getParty()
            if party then
                party:broadcastPartyLoot(text)
            else
                player:sendTextMessage(MESSAGE_LOOT, text)
            end
        end
    else
        -- stamina baixa: sem drop e com mensagem (sua lógica)
        local text = ("Loot of %s: nothing (due to low stamina)"):format(mType:getNameDescription())
        local party = player:getParty()
        if party then
            party:broadcastPartyLoot(text)
        else
            player:sendTextMessage(MESSAGE_LOOT, text)
        end
    end
end

function Monster:onSpawn(position, startup, artificial)
    -- registra os eventos de atributos (seu sistema)
    self:registerEvent("rollHealth")
    self:registerEvent("rollMana")

    -- mantém compatibilidade com EventCallback (se sua base usar)
    if hasEventCallback and hasEventCallback(EVENT_CALLBACK_ONSPAWN) then
        return EventCallback(EVENT_CALLBACK_ONSPAWN, self, position, startup, artificial)
    end
    return true
end
