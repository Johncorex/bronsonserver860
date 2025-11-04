print("[Critical] Script loaded successfully")
local config = {
    weapons = {
        [3962] = {chance = 10, multiplier = 2.0},  --  AXE of MAIN
        [7388] = {chance = 5, multiplier = 2.0},  -- VILE AXE
        [7419] = {chance = 29, multiplier = 2.0},  -- DREADED CLEAVER
		[7413] = {chance = 8, multiplier = 2.0},  -- DRAMBORLEG
        [8924] = {chance = 16, multiplier = 2.0},   -- DURINS AXE
		[7435] = {chance = 4, multiplier = 2.0},   -- STONEGRINDER
		
		[7437] = {chance = 5, multiplier = 2.0},  --  SAPPHIRE HAMMER
        --[7427] = {chance = 30, multiplier = 2.0},  -- CHAOS MACE
        [11308] = {chance = 21, multiplier = 2.0},  -- DRACHAKU
		[7387] = {chance = 7, multiplier = 2.0},  -- DIAMOND SCEPTRE
        [8929] = {chance = 22, multiplier = 2.0},   -- STOMPER
		[7414] = {chance = 6, multiplier = 2.0},   -- GLMADRING
		[7431] = {chance = 4, multiplier = 2.0},   -- OLOG-HAI BREAKER
		
		[7407] = {chance = 8, multiplier = 2.0},  --  HAUNTED BLADE
        [11307] = {chance = 15, multiplier = 2.0},  -- CHAOS BLADE
        [8930] = {chance = 28, multiplier = 2.0},  -- EMERALD SWORD
		[7382] = {chance = 16, multiplier = 2.0},  -- DEMONRAGE SWORD
        [2390] = {chance = 5, multiplier = 2.0},   -- ANDURIL
		[6528] = {chance = 13, multiplier = 2.0},   -- NARSIL
		[7405] = {chance = 4, multiplier = 2.0},   -- DAGORLEAF
		
		
		[8849] = {chance = 1, multiplier = 2.0},   -- MODIFIED CROSSBOW
		[5947] = {chance = 2, multiplier = 2.0},  -- LOMELINDI
		[8852] = {chance = 4, multiplier = 2.0},   -- BURIZA CROSSBOW
		[8851] = {chance = 6, multiplier = 2.0},   -- ROYAL CROSSBOW
		[5803] = {chance = 7, multiplier = 2.0},   -- ARBALEST
		[8850] = {chance = 2, multiplier = 2.0},   -- CHAIN BOLTER
		
		
		[7438] = {chance = 4, multiplier = 2.0},   -- ELVEN BOW
		[8854] = {chance = 6, multiplier = 2.0},   -- WARSINGER BOW
		[8856] = {chance = 6, multiplier = 2.0},   -- CHURCHILLS BOW
		[8855] = {chance = 7, multiplier = 2.0},   -- Eaglehorn
		[8858] = {chance = 9, multiplier = 2.0}   -- elethriel's elemental bow
    },
    crit_message = "CRITICAL!",
    crit_effect = CONST_ME_GROUNDSHAKER
}

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    -- Verifica se o atacante é um jogador válido
    if not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Verifica se o dano veio de ataque físico ou ranged
    if origin ~= ORIGIN_MELEE and origin ~= ORIGIN_RANGED then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Verifica a arma equipada
    local weapon = attacker:getSlotItem(CONST_SLOT_LEFT) or attacker:getSlotItem(CONST_SLOT_RIGHT)
    if not weapon or not config.weapons[weapon:getId()] then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local weaponConfig = config.weapons[weapon:getId()]

    -- Verifica chance de crítico
    if math.random(100) > weaponConfig.chance then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Efeitos visuais
    attacker:say(config.crit_message, TALKTYPE_MONSTER_SAY)
    creature:getPosition():sendMagicEffect(config.crit_effect)
    -- Retorna o dano modificado
    return primaryDamage * weaponConfig.multiplier, primaryType, secondaryDamage, secondaryType
end