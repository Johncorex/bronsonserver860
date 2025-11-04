-- batched (keep infra for other features; leech removal below disables use)
--local manaleechBatched, lifeleechBatched = {}, {}

local checkweaponslots = { CONST_SLOT_LEFT, CONST_SLOT_RIGHT, CONST_SLOT_NECKLACE, CONST_SLOT_HEAD, CONST_SLOT_RING }
local checkallslots    = { CONST_SLOT_LEFT, CONST_SLOT_RIGHT, CONST_SLOT_HEAD, CONST_SLOT_NECKLACE, CONST_SLOT_ARMOR, CONST_SLOT_LEGS, CONST_SLOT_FEET, CONST_SLOT_RING }

local animation = {
  [2543]=CONST_ANI_BOLT,[2547]=CONST_ANI_POWERBOLT,[6529]=CONST_ANI_INFERNALBOLT,[7363]=CONST_ANI_PIERCINGBOLT,[15649]=CONST_ANI_VORTEXBOLT,[18435]=CONST_ANI_PRISMATICBOLT,[18436]=CONST_ANI_DRILLBOLT,
  [2544]=CONST_ANI_ARROW,[2545]=CONST_ANI_POISONARROW,[2546]=CONST_ANI_BURSTARROW,[7365]=CONST_ANI_ONYXARROW,[7364]=CONST_ANI_SNIPERARROW,[7838]=CONST_ANI_FLASHARROW,[7840]=CONST_ANI_FLAMMINGARROW,[7839]=CONST_ANI_SHIVERARROW,[7850]=CONST_ANI_EARTHARROW,[15648]=CONST_ANI_TARSALARROW,[18437]=CONST_ANI_ENVENOMEDARROW,[18304]=CONST_ANI_CRYSTALLINEARROW,
  [2111]=CONST_ANI_SNOWBALL,[2389]=CONST_ANI_SPEAR,[3965]=CONST_ANI_HUNTINGSPEAR,[7367]=CONST_ANI_ENCHANTEDSPEAR,[7378]=CONST_ANI_ROYALSPEAR,[2399]=CONST_ANI_THROWINGSTAR,[7368]=CONST_ANI_REDSTAR,[7366]=CONST_ANI_GREENSTAR,[2410]=CONST_ANI_THROWINGKNIFE
}

local function shuffle(t)
  local rand = math.random
  for i = #t, 2, -1 do
    local j = rand(i)
    t[i], t[j] = t[j], t[i]
  end
end

-- Resist helpers -------------------------------------------------------------
local function filterResistance(damage, damageType, immunity, resistance)
  if resistance[damageType] then
    damage = ((100 - resistance[damageType]) / 100) * damage
  end
  if bit.band(immunity, damageType) == damageType then
    damage = 0
  end
  return math.floor(damage)
end

-- Elemental bonus application ------------------------------------------------
local function elementalDmg(weaponDescription, elementType, extraAnimation, creature, resistances, primaryDamage, primaryType, secondaryDamage, secondaryType, elementalroll)
  local elementName = ({[COMBAT_FIREDAMAGE]="Fire",[COMBAT_ICEDAMAGE]="Ice",[COMBAT_ENERGYDAMAGE]="Energy"})[elementType]
  local dmgmin, dmgmax = string.match(weaponDescription, '%[Enhanced ' .. elementName .. ' Damage: (%d+)%-(%d+)%]')
  
  if not dmgmin then 
    return primaryDamage, primaryType, secondaryDamage, secondaryType, elementalroll 
  end
  
  local eleDmg = math.random(tonumber(dmgmin), tonumber(dmgmax))
  
  if creature:isMonster() then
    local resistance = creature:getType():getElementList()
    local immunity = creature:getType():getCombatImmunities()
    eleDmg = filterResistance(eleDmg, elementType, immunity, resistance)
  elseif creature:isPlayer() then
    eleDmg = eleDmg / 2
    if (resistances[elementType].Native + resistances[elementType].Custom ~= 0) then
      eleDmg = ((100 - (resistances[elementType].Custom + resistances[elementType].Native)) / 100) * eleDmg
    end
  end
  
  if eleDmg ~= 0 then
    if extraAnimation == true then
      local pos = creature:getPosition()
      pos:sendMagicEffect(elementType == COMBAT_FIREDAMAGE and CONST_ME_FIREATTACK or CONST_ME_ENERGYAREA)
    end
    
    if elementalroll then
      if primaryType == elementType then
        primaryDamage = primaryDamage + eleDmg
      else
        if primaryType == 0 then
          if secondaryType == elementType then
            secondaryDamage = secondaryDamage + eleDmg
          else
            primaryDamage = eleDmg
            primaryType = elementType
          end
        else
          secondaryDamage = secondaryDamage + eleDmg
          secondaryType = elementType
        end
      end
    else
      local originalDamage, originalType = primaryDamage, primaryType
      primaryDamage, primaryType = secondaryDamage + eleDmg, elementType
      secondaryDamage, secondaryType = originalDamage, originalType
      elementalroll = true
    end
  end
  
  return primaryDamage, primaryType, secondaryDamage, secondaryType, elementalroll
end

-- Resist extraction from descriptions (custom resist system)
local function getResistences(resistanceitemdesc, resistances, attackerisplayer)
  local elems = { 
    {t=COMBAT_PHYSICALDAMAGE, s="Physical"},
    {t=COMBAT_FIREDAMAGE,     s="Fire"}, 
    {t=COMBAT_ICEDAMAGE,      s="Ice"}, 
    {t=COMBAT_ENERGYDAMAGE,   s="Energy"},
    {t=COMBAT_EARTHDAMAGE,    s="Earth"}, 
    {t=COMBAT_DEATHDAMAGE,    s="Death"}, 
    {t=COMBAT_HOLYDAMAGE,     s="Holy"},
    {t=COMBAT_LIFEDRAIN,      s="Life Drain"},
    {t=COMBAT_MANADRAIN,      s="Mana Drain"},
    {t=COMBAT_DROWNDAMAGE,    s="Drown"},
    {t=COMBAT_HEALING,        s="Healing"},
    {t=COMBAT_UNDEFINEDDAMAGE,s="Undefined"}
  }
  
  -- Resistências específicas
  for _, v in ipairs(elems) do
    -- Custom (ex.: [Fire Resistance: +10%])
    if resistanceitemdesc:find("%[" .. v.s .. " Resistance") then
      resistances[v.t].Custom = resistances[v.t].Custom + (tonumber(resistanceitemdesc:match('%[' .. v.s .. ' Resistance: %+(%d+)%%%]')) or 0)
    end
    
    -- Native (ex.: "fire -20%") aparece em items vanilla
    if attackerisplayer then
      local native = v.s:lower()
      local n = resistanceitemdesc:match(native .. " ([+-]%d+)%%")
      if n then 
        resistances[v.t].Native = resistances[v.t].Native + tonumber(n) 
      end
    end
  end

  -- Protection All (ex.: [Protection All: +11%])
  if resistanceitemdesc:find("%[Protection All") then
    local allRes = tonumber(resistanceitemdesc:match('%[Protection All: %+(%d+)%%%]')) or 0
    resistances.ProtectionAll.Custom = resistances.ProtectionAll.Custom + allRes
  end
end

-- Main stat pipeline ---------------------------------------------------------
local function statChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
  if not attacker or not attacker:isPlayer() then
    return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
  end

  local spellmodifier = 0
  local stunDuration = 2000
  local sourceDamage = primaryDamage
  local elementalroll = false

  local resistances = {
  [COMBAT_PHYSICALDAMAGE] = {Native = 0, Custom = 0, String = "Physical"},
  [COMBAT_FIREDAMAGE]     = {Native = 0, Custom = 0, String = "Fire"},
  [COMBAT_ICEDAMAGE]      = {Native = 0, Custom = 0, String = "Ice"},
  [COMBAT_ENERGYDAMAGE]   = {Native = 0, Custom = 0, String = "Energy"},
  [COMBAT_EARTHDAMAGE]    = {Native = 0, Custom = 0, String = "Earth"},
  [COMBAT_DEATHDAMAGE]    = {Native = 0, Custom = 0, String = "Death"},
  [COMBAT_HOLYDAMAGE]     = {Native = 0, Custom = 0, String = "Holy"},
  [COMBAT_LIFEDRAIN]      = {Native = 0, Custom = 0, String = "Life Drain"},
  [COMBAT_MANADRAIN]      = {Native = 0, Custom = 0, String = "Mana Drain"},
  [COMBAT_DROWNDAMAGE]    = {Native = 0, Custom = 0, String = "Drown"},
  [COMBAT_HEALING]        = {Native = 0, Custom = 0, String = "Healing"},
  [COMBAT_UNDEFINEDDAMAGE]= {Native = 0, Custom = 0, String = "Undefined"},
  ProtectionAll           = {Custom = 0} -- <- suporte ao [Protection All]
}

	-- Apply resistances for the creature being hit
	if creature:isPlayer() then
	  for i = 1, #checkallslots do
		local it = creature:getSlotItem(checkallslots[i])
		if it then
		  getResistences(it:getDescription(), resistances, true)
		end
	  end

	  if primaryType ~= 0 and resistances[primaryType] then
		local totalRes = (resistances[primaryType].Custom or 0) + (resistances[primaryType].Native or 0) + (resistances.ProtectionAll.Custom or 0)
		if totalRes ~= 0 then
		  primaryDamage = ((100 - totalRes) / 100) * primaryDamage
		end
	  end

	  if secondaryType ~= 0 and resistances[secondaryType] then
		local totalRes = (resistances[secondaryType].Custom or 0) + (resistances[secondaryType].Native or 0) + (resistances.ProtectionAll.Custom or 0)
		if totalRes ~= 0 then
		  secondaryDamage = ((100 - totalRes) / 100) * secondaryDamage
		end
	  end
	end


  -- Process attacker's equipment for bonuses
  if origin == ORIGIN_RANGED or origin == ORIGIN_MELEE then
    if secondaryType ~= 0 or primaryType ~= COMBAT_PHYSICALDAMAGE then
      local od, ot = primaryDamage, primaryType
      primaryDamage, primaryType = secondaryDamage, secondaryType
      secondaryDamage, secondaryType = od, ot
      elementalroll = true
    end

    for i = 1, #checkweaponslots do
      local slotitem = attacker:getSlotItem(checkweaponslots[i])
      if slotitem then
        local desc = slotitem:getDescription()
        
        -- Fire Damage
        if desc:find("%[Enhanced Fire Damage") then
          primaryDamage, primaryType, secondaryDamage, secondaryType, elementalroll =
            elementalDmg(desc, COMBAT_FIREDAMAGE, true, creature, resistances, primaryDamage, primaryType, secondaryDamage, secondaryType, elementalroll)
        end
        
        -- Ice Damage
        if desc:find("%[Enhanced Ice Damage") then
          primaryDamage, primaryType, secondaryDamage, secondaryType, elementalroll =
            elementalDmg(desc, COMBAT_ICEDAMAGE, false, creature, resistances, primaryDamage, primaryType, secondaryDamage, secondaryType, elementalroll)
          
          if math.random(1, 5) == 5 and creature and creature:isCreature() then
				local combat = Combat()
				combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_ICEAREA)

				local cond = Condition(CONDITION_PARALYZE)
				cond:setParameter(CONDITION_PARAM_TICKS, 3000)
				cond:setParameter(CONDITION_PARAM_SPEED, -300)
				combat:setCondition(cond)

				-- caster de fallback caso o atacante seja nulo (dano de ambiente, etc.)
				local caster = (attacker and attacker:isCreature()) and attacker or creature
				combat:execute(caster, Variant(creature:getId()))
			end
        end
        
        -- Energy Damage
        if desc:find("%[Enhanced Energy Damage") then
          primaryDamage, primaryType, secondaryDamage, secondaryType, elementalroll =
            elementalDmg(desc, COMBAT_ENERGYDAMAGE, true, creature, resistances, primaryDamage, primaryType, secondaryDamage, secondaryType, elementalroll)
        end

        -- Stun Chance
        if desc:find("%[Stun Chance") then
          local stunchance = tonumber(desc:match('%[Stun Chance: %+(%d+)%%%]')) or 0
          if math.random(1, 100) <= stunchance and attacker ~= creature then
            local mute = Condition(CONDITION_MUTED)
            mute:setParameter(CONDITION_PARAM_TICKS, stunDuration)
            creature:addCondition(mute)
          end
        end

        -- Multi-shot
        if desc:find("%[Multi Shot") then
          if attacker:getSlotItem(CONST_SLOT_AMMO) then
            local multishot = tonumber(desc:match("%[Multi Shot: %+(%d+)%]")) or 0
            local ammoSlot = attacker:getSlotItem(CONST_SLOT_AMMO).itemid
            local distFx = animation[ammoSlot]
            
            if distFx then
              local targetpos = creature:getPosition()
              local targets = getSpectators(targetpos, 2, 2)
              local victims = {}
              
              if targets then
                shuffle(targets)
                for i = 1, #targets do
                  local t = Creature(targets[i])
                  if t and t:isMonster() and isSightClear(attacker:getPosition(), t:getPosition()) and t:getPosition() ~= targetpos then
                    victims[#victims + 1] = t
                    if #victims >= multishot then break end
                  end
                end
              end
              
              if #victims > 0 then
                for i = 1, #victims do
                  local v = victims[i]
                  local resistance = v:getType():getElementList()
                  local immunity = v:getType():getCombatImmunities()
                  attacker:getPosition():sendDistanceEffect(v:getPosition(), distFx)

                  local mainType, altType = primaryType, secondaryType
                  local damage, elementalDamage
                  
                  if elementalroll then
                    mainType, altType = secondaryType, primaryType
                    damage = filterResistance(secondaryDamage, secondaryType, immunity, resistance)
                    elementalDamage = filterResistance(primaryDamage, primaryType, immunity, resistance)
                  else
                    damage = filterResistance(primaryDamage, primaryType, immunity, resistance)
                    elementalDamage = filterResistance(secondaryDamage, secondaryType, immunity, resistance)
                  end

                  if elementalDamage ~= 0 then
                    doTargetCombatHealth(attacker, v, altType, math.ceil(0.8 * elementalDamage), elementalDamage)
                  end
                  
                  if damage ~= 0 then
                    doTargetCombatHealth(attacker, v, mainType, math.ceil(0.8 * damage), damage)
                  else
                    local backup = filterResistance(sourceDamage, COMBAT_PHYSICALDAMAGE, immunity, resistance)
                    if backup ~= 0 then
                      doTargetCombatHealth(attacker, v, COMBAT_PHYSICALDAMAGE, math.ceil(0.8 * sourceDamage), sourceDamage)
                    else
                      v:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

  elseif origin == ORIGIN_SPELL then
    if resistances[primaryType] and resistances[primaryType].Custom ~= 0 then
      primaryDamage = ((100 - resistances[primaryType].Custom) / 100) * primaryDamage
    end

    for i = 1, #checkweaponslots do
      local slotitem = attacker:getSlotItem(checkweaponslots[i])
      if slotitem then
        local desc = slotitem:getDescription()
        
        if desc:find("%[Spell Damage") then
          local spellDamage = tonumber(desc:match("Spell Damage: [+-](%d+)%%")) or 0
          spellmodifier = spellmodifier + spellDamage
        end
        
        -- Stun Chance on spells as well
        if desc:find("%[Stun Chance") then
          local stunchance = tonumber(desc:match('%[Stun Chance: %+(%d+)%%%]')) or 0
          if math.random(1, 100) <= stunchance and attacker ~= creature then
            local mute = Condition(CONDITION_MUTED)
            mute:setParameter(CONDITION_PARAM_TICKS, stunDuration)
            creature:addCondition(mute)
          end
        end
      end
    end

    if spellmodifier > 0 then
      primaryDamage = primaryDamage + ((spellmodifier / 100) * primaryDamage)
    end
  end

  return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
  if primaryType ~= 128 then
    primaryDamage, primaryType, secondaryDamage, secondaryType, origin =
      statChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
  end
  return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
end

function onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
  if primaryType ~= 64 then
    primaryDamage, primaryType, secondaryDamage, secondaryType, origin =
      statChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

    -- Mana shield from description (kept)
    if creature:isPlayer() then
      local manashield = 0
      for i = 1, #checkweaponslots do
        local it = creature:getSlotItem(checkweaponslots[i])
        if it then
          local d = it:getDescription()
          if d:find("%[Mana Shield") then
            manashield = manashield + tonumber(d:match('%[Mana Shield: %+(%d+)%%%]') or 0)
          end
        end
      end
      
      if manashield ~= 0 then
        local shieldPercent = (100 - manashield)
        primaryDamage = (shieldPercent / 100) * primaryDamage
        secondaryDamage = (shieldPercent / 100) * secondaryDamage
      end
    end
  end
  return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
end