local berserk = Condition(CONDITION_ATTRIBUTES)
berserk:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
berserk:setParameter(CONDITION_PARAM_SKILL_MELEE, 5)
berserk:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
berserk:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local mastermind = Condition(CONDITION_ATTRIBUTES)
mastermind:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
mastermind:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 3)
mastermind:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local bullseye = Condition(CONDITION_ATTRIBUTES)
bullseye:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
bullseye:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 5)
bullseye:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
bullseye:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local potions = {
	[6558] = { -- concentrated demonic blood
		transform = {7588, 7589},
		effect = CONST_ME_DRAWBLOOD
	},
	[7439] = { -- berserk potion
		condition = berserk,
		vocations = {4, 8, 12, 16, 17, 18, 19, 20, 25, 26, 27, 28, 29, 30},
		effect = CONST_ME_MAGIC_RED,
		description = "Only warriors may drink this potion.",
		text = "You feel stronger."
	},
	[7440] = { -- mastermind potion
		condition = mastermind,
		vocations = {1, 2, 5, 6, 9, 10, 13, 14},
		effect = CONST_ME_MAGIC_BLUE,
		description = "Only mages may drink this potion.",
		text = "You feel smarter."
		},
	[7443] = { -- bullseye potion
		condition = bullseye,
		vocations = {3, 7, 11, 15, 21, 22, 23, 24},
		effect = CONST_ME_MAGIC_GREEN,
		description = "Only paladins and elfs may drink this potion.",
		text = "You feel more accurate."
	},
	[7588] = { -- strong health potion
		health = {220, 300},
		vocations = {4, 8, 12, 16, 17, 18, 19, 20, 25, 26, 27, 28, 29, 30},
		level = 50,
		flask = 7634,
		description = "Only warriors of level 50 or above may drink this fluid."
	},
	[7589] = { -- strong mana potion
		mana = {220, 300},
		level = 50,
		flask = 7634,
	},
	[7590] = { -- great mana potion
		mana = {420, 500},
		vocations = {1, 2, 5, 6, 9, 10, 13, 14},
		level = 80,
		flask = 7635,
		description = "Only mages of level 80 or above may drink this fluid."
	},
	[7591] = { -- great health potion
		health = {420, 550},
		vocations = {4, 8, 12, 16, 17, 18, 19, 20, 25, 26, 27, 28, 29, 30},
		level = 80,
		flask = 7635,
		description = "Only warriors of level 80 or above may drink this fluid."
	},
	[7618] = { -- health potion
		health = {150, 200},
		flask = 7636
	},
	[7620] = { -- mana potion
		mana = {130, 180},
		flask = 7636
	},
	[8472] = { -- great spirit potion
		health = {220, 300},
		mana = {120, 200},
		vocations = {3, 7, 11, 15},
		level = 80,
		flask = 7635,
		description = "Only paladins of level 80 or above may drink this fluid."
	},
	[8473] = { -- ultimate health potion
		health = {750, 950},
		vocations = {4, 8, 12, 16, 17, 18, 19, 20, 25, 26, 27, 28, 29, 30},
		level = 150,
		flask = 7635,
		description = "Only warriors of level 150 or above may drink this fluid."
	},
	[8474] = { -- antidote potion
		antidote = true,
		flask = 7636,
	},
	[8704] = { -- small health potion
		health = {60, 90},
		flask = 7636,
	}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- alvo: se não for player, usa em si mesmo
    if not target or type(target) ~= "userdata" or not target:isPlayer() then
        target = player
    end

    local potion = potions[item:getId()]
    if not potion then
        return false
    end

    -- checagens de level / vocation
    if (potion.level and player:getLevel() < potion.level)
        or (potion.vocations and not table.contains(potion.vocations, player:getVocation():getId())) then
        if potion.description then
            player:say(potion.description, TALKTYPE_MONSTER_SAY)
        end
        return true
    end

    local pos = target:getPosition()

    -- 1) Potions de atributo (buffs)
    if potion.condition then
        target:addCondition(potion.condition)
        if potion.text then
            player:say(potion.text, TALKTYPE_MONSTER_SAY)
        end
        if potion.effect then
            pos:sendMagicEffect(potion.effect)
        end
        -- consome a potion de buff
        item:remove(1)
        return true
    end

    -- 2) Transform (concentrated demonic blood)
    if potion.transform then
        local reward = potion.transform[math.random(#potion.transform)]
        if fromPosition.x == CONTAINER_POSITION then
            local targetContainer = Container(item:getParent().uid)
            targetContainer:addItem(reward, 1)
        else
            Game.createItem(reward, 1, fromPosition)
        end
        if potion.effect then
            item:getPosition():sendMagicEffect(potion.effect)
        end
        item:remove(1)
        return true
    end

    -- 3) Cura/Antidote
    local beforeHP = target:getHealth()
    local beforeMP = target:getMana()

    -- antidote (remove veneno)
    if potion.antidote then
        target:removeCondition(CONDITION_POISON)
    end

    -- aplicar cura de vida
    if potion.health then
        local gain = math.random(potion.health[1], potion.health[2])
        target:addHealth(gain)
    end

    -- aplicar cura de mana
    if potion.mana then
        local gain = math.random(potion.mana[1], potion.mana[2])
        target:addMana(gain)
    end

    -- ganhos reais
    local hpGain = math.max(0, target:getHealth() - beforeHP)
    local mpGain = math.max(0, target:getMana() - beforeMP)

    -- números flutuantes (cores seguras em muitos distros)
    --if hpGain > 0 then
        --Game.sendAnimatedText(tostring(hpGain), pos, 180)
    --end
    if mpGain > 0 then
        -- azul claro (use o que você testou; você citou 152)
        Game.sendAnimatedText(tostring(mpGain), pos, 152)
    end

    -- efeito visual genérico para uso de potion
    pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)

    -- adiciona frasco vazio (se definido)
    --if potion.flask then
      --  player:addItem(potion.flask, 1)
    --end

    -- consome 1 potion do stack
    item:remove(1)
    return true
end
