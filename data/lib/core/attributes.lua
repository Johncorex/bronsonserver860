-- Categorias de itens --------------------------------------------------------
local categories = {
  armorsAll = {
    "divine plate","molten plate","frozen plate","khel thuzad skin","phoenix plate","magic plate armor","golden armor",
    "pestilence omega","zenit cuirass","voltage armor","demon armor","baalrog robe","dragon scale mail","aegis armor",
    "fireborn giant armor","earthborn titan armor","dark lords cape","windborn colossus armor","crown armor","master archers armor",
    "magma coat","knight armor","terra mantle","aghanim robe","noble armor","amazon armor","serpent coat","greenwood coat",
    "robe of the underworld","dwarven armor","blue robe","elven armor","glacier robe","plate armor","dark armor"
  },
  helmetsAll = {
    "golden helmet","zenit helmet","demon helmet","diadem of twilight","magic steel helmet","dragon scale helmet","horned helmet",
    "winged helmet","aghanim mask","elite draken helmet","skull helmet","royal helmet","beholder helmet","warrior helmet",
    "crusader helmet","devil helmet","crown helmet","krimhorn helmet","ragnir helmet","horseman helmet","steel helmet",
    "strange helmet","dark helmet","dwarven helmet","yalahari mask","iron helmet","soldier helmet","magma monocle","glacier mask",
    "terra hood","jade hat","batwing hat"
  },
  legsAll = {
    "valar kilt","golden legs","blue legs","twilight veil legs","demon legs","zenit legs","dragon scale legs","magma legs",
    "knight legs","crown legs","dwarven legs","terra legs","glacier kilt","plate legs","elven legs","aghanim legs"
  },
  bootsAll = {
    "draken boots","golden boots","firewalker boots","traper boots","steel boots","crystal boots","dragon scale boots","guardian boots",
    "fur boots","zenit shoes","pirate boots","terra boots","magma boots","glacier boots","aghanim boots","soft boots","crocodile boots","boots of haste"
  },
  shieldsAll = {
    "necromancer shield","cerberus shield","permafrost shield","blessed shield","great shield","tempest shield","mastermind shield",
    "terran shield","demon shield","nightmare shield","shield of corruption","sparking shield","phoenix shield","vampire shield",
    "medusa shield","shield of honour","tower shield","crown shield","amazon shield","dragon shield","rainbow shield","guardian shield",
    "griffin shield","norse shield","beholder shield","tusk shield","rose shield","ancient shield","salamander shield","dwarven shield",
    "tortoise shield","dark shield"
  },
  weaponsAll = {
    "glamdring","narsil","durins axe","grond","anduril","olog-hai breaker","stonegrinder","dramborleg","dagorleaf","warlord sword",
    "great axe","executioner","skullcrusher","chaos blade","stonecutter axe","ruthless axe","thunder hammer","heavy mace","war axe",
    "magic sword","hammer of wrath","berserker","drakinata","twiceslicer","dragon lance","demonrage sword","justice seeker",
    "bonebreaker","drachaku","giant sword","guardian halberd","herugrin","nightmare blade","sais","runed sword","onyx flail",
    "angelic axe","mystic blade","dragon slayer","heroic axe","amber staff","mercenary sword","vile axe","bloody edge","relic sword",
    "blacksteel sword","headchopper","orcish maul","ice rapier","spiked squelcher","silver mace","pharaoh sword","glorious axe",
    "lich staff","assassin dagger","haunted blade","noble axe","naginata","daramanian waraxe","diamond sceptre","crystal mace",
    "djinn blade","chaos mace","sapphire hammer","zaoan halberd","epee","dreaded cleaver","bright sword","skull staff",
    "dragonbone staff","crystal sword","frost razor","halberd","double axe","axe of main","emerald sword","knight axe","twin hooks",
    "dragon hammer","wyvern fang","furry club","dwarven axe","taurus mace","two handed sword","mammoth whopper","barbarian axe",
    "clerical mace","crimson sword","fire axe","broadsword","battle axe","morning star","banana staff","spike sword","fire sword",
    "battle hammer","serpent sword"
  },
  distanceWeaponsAll = {
    "elven bow","slingshot","lomelindi","spear","throwing star","throwing knife","aiglos","hunting spear","modified crossbow",
    "chain bolter","royal crossbow","buriza","gondors piercer","warsinger bow","eaglehorn","churchill's bow","silkweaver bow",
    "elethriel's elemental bow","arbalest","viper star","enchanted spear","assassin star","royal spear"
  },
  ringsAll = { "gold ring","ring of the sky","crystal ring","emerald bangle","gandalf ring","ring of the tarrasque" },
  amuletsAll = { "starlight amulet","scarf","platinum amulet" },
  wandNrodsAll = {
    "snakebite rod","wand of vortex","moonlight rod","wand of dragonbreath","necrotic rod","wand of decay","northwind rod","wand of draconia",
    "terra rod","wand of cosmic energy","hailstorm rod","wand of inferno","springsprout rod","wand of starmstorm","crystal rod","arcane wand",
    "motaba scepter","saruman scepter","saurons breath","divine scepter","aghanim's scepter","mekansm","morguls effigy"
  }
}
-- Helpers -------------------------------------------------------------------

local function esc(s) -- escape for patterns
  return (s:gsub("([%%%(%)%[%]%.%+%-%*%?%^%$])","%%%1"))
end

local function getCurrentOrBase(it_u, attr)
  -- try current overriden attribute first
  local cur = it_u:getAttribute(attr)
  if cur ~= nil and cur ~= 0 then
    return cur
  end
  -- fallback to ItemType base
  local id = ItemType(it_u:getId())
  local v = {
    [ITEM_ATTRIBUTE_ATTACK]      = id:getAttack(),
    [ITEM_ATTRIBUTE_DEFENSE]     = id:getDefense(),
    [ITEM_ATTRIBUTE_EXTRADEFENSE]= id:getExtraDefense(),
    [ITEM_ATTRIBUTE_ARMOR]       = id:getArmor(),
    [ITEM_ATTRIBUTE_HITCHANCE]   = id:getHitChance(),
    [ITEM_ATTRIBUTE_SHOOTRANGE]  = id:getShootRange(),
    [ITEM_ATTRIBUTE_CHARGES]     = id:getCharges(),
    [ITEM_ATTRIBUTE_DURATION]    = 0, -- handled via transform below
  }
  if attr == ITEM_ATTRIBUTE_DURATION then
    local it_id = it_u:getId()
    local tid = ItemType(it_id):getTransformEquipId()
    if tid > 0 then
      it_u:transform(tid)
      local vx = it_u:getAttribute(ITEM_ATTRIBUTE_DURATION)
      it_u:transform(it_id)
      return vx or 0
    end
    return 0
  end
  return v[attr] or 0
end

local function mergeDescStatic(desc, label, delta)
  label = esc(label)
  local pat  = "%[" .. label .. ": %+(%-?%d+)%]"
  local found = desc:match(pat)
  if found then
    local new = tostring(tonumber(found) + delta)
    return (desc:gsub("%[" .. label .. ": %+" .. esc(found) .. "%]", "[" .. label .. ": +" .. new .. "]")), true
  else
    return (desc .. "\n[" .. label .. ": +" .. delta .. "]"), false
  end
end

local function mergeDescPercent(desc, label, delta)
  label = esc(label)
  local pat  = "%[" .. label .. ": %+(%-?%d+)%%%]"
  local found = desc:match(pat)
  if found then
    local new = tostring(tonumber(found) + delta)
    return (desc:gsub("%[" .. label .. ": %+" .. esc(found) .. "%%%]", "[" .. label .. ": +" .. new .. "%%]")), true
  else
    return (desc .. "\n[" .. label .. ": +" .. delta .. "%]"), false
  end
end

local function mergeDescDamage(desc, label, addMin, addMax)
  label = esc(label)
  local pat  = "%[" .. label .. ": (%-?%d+)%-(%-?%d+)%]"
  local curMin, curMax = desc:match(pat)
  if curMin and curMax then
    local newMin = tostring(tonumber(curMin) + addMin)
    local newMax = tostring(tonumber(curMax) + addMax)
    local from = "%[" .. label .. ": " .. esc(curMin) .. "%-" .. esc(curMax) .. "%]"
    local to   = "[" .. label .. ": " .. newMin .. "-" .. newMax .. "]"
    return (desc:gsub(from, to)), true
  else
    return (desc .. "\n[" .. label .. ": " .. addMin .. "-" .. addMax .. "]"), false
  end
end

local function minutes(ms) return (ms / 60000) end

-- Resolve nomes para IDs
local function _resolveItemId(k)
  if type(k) == "number" then
    return k
  elseif type(k) == "string" then
    local name = k:lower()
    local it = ItemType and ItemType(name)
    if it and it:getId() and it:getId() > 0 then return it:getId() end
    if getItemIdByName then
      local id = getItemIdByName(name, false) or getItemIdByName(k, false)
      if id and id > 0 then return id end
    end
    print(string.format("[Rarity] AVISO: item '%s' não encontrado no items.xml.", tostring(k)))
  end
  return nil
end

-- Expande categorias
local function _expandItems(list)
  local out = {}
  for _, entry in ipairs(list or {}) do
    if type(entry) == "string" and categories[entry] then
      for _, sub in ipairs(categories[entry]) do table.insert(out, sub) end
    else
      table.insert(out, entry)
    end
  end
  return out
end

-- Normaliza listas (aceita categorias e remove)
local function _normalizeItemsList(list, label, removeList)
  local out, seen = {}, {}
  list = _expandItems(list)
  removeList = _expandItems(removeList or {})
  for _, entry in ipairs(list) do
    local id = _resolveItemId(entry)
    if id and not seen[id] then
      local skip = false
      for _, r in ipairs(removeList) do
        local rid = _resolveItemId(r)
        if rid == id then skip = true break end
      end
      if not skip then table.insert(out, id) seen[id] = true end
    end
  end
  return (#out > 0) and out or nil
end

-- Stats table --------------------------------------------------------------------------------------------------------
local stats = {
  [1] = { -- Attack
    attribute = { name = 'Attack', rare = {1,3}, epic = {4,6}, legendary = {7,10} },
    value = "Static",
    base  = ITEM_ATTRIBUTE_ATTACK
  },
  [2] = { -- Defense
    attribute = { name = 'Defense', rare = {1,2}, epic = {3,4}, legendary = {5,6} },
    value = "Static",
    base  = ITEM_ATTRIBUTE_DEFENSE
  },
  [3] = { -- Extra Defense
    attribute = { name = 'Extra Defense', rare = {1,1}, epic = {2,3}, legendary = {4,5} },
    value = "Static",
    base  = ITEM_ATTRIBUTE_EXTRADEFENSE
  },
  [4] = { -- Armor
    attribute = { name = 'Armor', rare = {1,1}, epic = {2,3}, legendary = {4,5} },
    value = "Static",
    base  = ITEM_ATTRIBUTE_ARMOR
  },
  [5] = { -- Accuracy
    attribute = { name = 'Accuracy', rare = {1,5}, epic = {6,10}, legendary = {11,15} },
    value = "Percent",
    base  = ITEM_ATTRIBUTE_HITCHANCE
  },
  [6] = { -- Range
    attribute = { name = 'Range', rare = {1,1}, epic = {2,2}, legendary = {3,3} },
    value = "Static",
    base  = ITEM_ATTRIBUTE_SHOOTRANGE
  },
  [7] = { -- Charges (< 50)
    attribute = { name = 'Charges', rare = {5,10}, epic = {15,20}, legendary = {31,35} },
    value = "Static",
    base  = ITEM_ATTRIBUTE_CHARGES
  },
  [8] = { -- Charges (>= 50)
    attribute = { name = 'Charges', rare = {100,250}, epic = {350,500}, legendary = {1000,2000} },
    value = "Static",
    base  = ITEM_ATTRIBUTE_CHARGES
  },
  [9] = { -- Time
    attribute = { name = 'Time', rare = {300000,300000}, epic = {900000,900000}, legendary = {2700000,2700000} },
    value = "Duration",
    base  = ITEM_ATTRIBUTE_DURATION
  },
  [10] = { -- Crit Chance
    attribute = { name = 'Crit Chance', rare = {3,9}, epic = {10,15}, legendary = {16,20} },
    value = "Percent",
    --items = { "weaponsAll" },
    --remove = { "fire axe", "fire sword", "chaos mace" }
  },

  [12] = { -- Fire Damage
    attribute = { name = 'Enhanced Fire Damage', rare = {15,30}, epic = {30,45}, legendary = {45,60} },
    value = "Damage",
    items = { 7386,2392,7430,2539,2432,8858,7402,7453,2414,2520,8927,7411,11305,7382 }
  },
  [13] = { -- Ice Damage
    attribute = { name = 'Enhanced Ice Damage', rare = {10,15}, epic = {15,25}, legendary = {25,35} },
    value = "Damage",
    items = { 7386,7453,2445,7428,7407,7437,7387,7455,7390,21697,8858,7410,8927,2534 }
  },
  [14] = { -- Energy Damage
    attribute = { name = 'Enhanced Energy Damage', rare = {50,75}, epic = {100,125}, legendary = {200,250} },
    value = "Damage",
    items = { 7386,7421,8858,7388,7410,7404,2414,2444,7402,2514,2542,8924,7433,2424,8927,7384,7382 }
  },
  [15] = { -- Fire Resistance
    attribute = { name = 'Fire Resistance', rare = {2,3}, epic = {4,6}, legendary = {7,10} },
    value = "Percent",
    items = { 2516,2520,2539,2519,2491,2493,2494,2495,2487,7899,8867,11356,2488,7894,7891,2492,2498,2655,7900,2133,8877,2508,2123 }
  },
  [16] = { -- Ice Resistance (typo fixed)
    attribute = { name = 'Ice Resistance', rare = {2,3}, epic = {4,6}, legendary = {7,10} },
    value = "Percent",
    items = { 3973,7460,7461,7462,7902,7463,7897,8878,8887,7896,7457,11117,7892,7464,2125,2124 }
  },
  [17] = { -- Energy Resistance
    attribute = { name = 'Energy Resistance', rare = {2,3}, epic = {4,6}, legendary = {7,10} },
    value = "Percent",
    items = { 2514,2515,2528,12644,2535,2475,2497,7901,2472,2476,2492,7898,8871,8879,11355,12607,2477,7895,2123,2508,7893 }
  },
  [18] = { -- Earth Resistance
    attribute = { name = 'Earth Resistance', rare = {2,3}, epic = {4,6}, legendary = {7,10} },
    value = "Percent",
    items = { 2518,2535,6131,15491,2540,2479,3971,3972,7885,7903,2664,7463,7884,8869,8880,3982,2123,2135,7886,2508 }
  },
  [19] = { -- Physical Resistance
    attribute = { name = 'Physical Resistance', rare = {2,3}, epic = {4,6}, legendary = {7,10} },
    value = "Percent",
    items = { 2514,2528,2535,2536,12644,2532,2497,3969,5741,2472,2466,3968,8889,8891,2470,11304,2645,2179,11302,2503,2508,8821 }
  },
  [20] = { -- Death Resistance
    attribute = { name = 'Death Resistance', rare = {2,3}, epic = {4,6}, legendary = {7,10} },
    value = "Percent",
    items = { 2521,2529,2532,2536,2462,2490,10016,2489,8889,12607,5462,2129,2508,8752,8885,21253,8821 }
  },
  [21] = { -- Spell Damage
    attribute = { name = 'Spell Damage', rare = {3,5}, epic = {8,10}, legendary = {15,20} },
    value = "Percent",
    items = { "ringsAll",2662 }
  },
  [22] = { -- Multi Shot
    attribute = { name = 'Multi Shot', rare = {1,1}, epic = {2,2}, legendary = {3,3} },
    value = "Static"
  },
  [23] = { -- Stun Chance
    attribute = { name = 'Stun Chance', rare = {3,5}, epic = {6,10}, legendary = {11,15} },
    value = "Percent"
  },
  [24] = { -- Mana Shield (typo fixed)
    attribute = { name = 'Mana Shield', rare = {5,10}, epic = {11,20}, legendary = {21,30} },
    value = "Percent"
  },
  [25] = { -- Sword Skill
    attribute = { name = 'Sword Skill', rare = {1,2}, epic = {3,5}, legendary = {6,10} },
    value = "Static",
    items = { 8881,12644 }
  },
  [26] = { -- Axe Skill
    attribute = { name = 'Axe Skill', rare = {1,2}, epic = {3,5}, legendary = {6,10} },
    value = "Static",
    items = { 8882 }
  },
  [27] = { -- Club Skill
    attribute = { name = 'Club Skill', rare = {1,2}, epic = {3,5}, legendary = {6,10} },
    value = "Static",
    items = { 8883 }
  },
  [28] = { -- Melee Skills
    attribute = { name = 'Melee Skills', rare = {1,2}, epic = {3,5}, legendary = {6,10} },
    value = "Static",
    items = { 2342,2471,15406,15412,2494,9776,21692,2537,2522,6391 }
  },
  [29] = { -- Distance Skill
    attribute = { name = 'Distance Skill', rare = {1,2}, epic = {3,5}, legendary = {6,10} },
    value = "Static",
    items = { 8888,2499,2474,12645,5741,2500,2505,8891,9777,2218}
  },
  [30] = { -- Shield Skill
    attribute = { name = 'Shield Skill', rare = {1,2}, epic = {3,5}, legendary = {6,10} },
    value = "Static",
    items = { 11240,2195,2503,2505,15406,15410,15409,2502 }
  },
  [31] = { -- Magic Level
    attribute = { name = 'Magic Level', rare = {1,2}, epic = {3,5}, legendary = {6,10} },
    value = "Static",
    items = {
      2323,2662,2506,9778,10016,13756,8865,8866,8867,8869,8890,8821,11355,12643,11117,
      2542,6433,2501,8900,8901,8902,8903,8904,8918,12647,2139
    }
  },
  [32] = { -- Max Health
    attribute = { name = 'Max Health', rare = {30,60}, epic = {80,120}, legendary = {150,250} },
    value = "Static",
    items = {
      2493,2496,2471,2474,2498,9778,11302,12645,2472,2492,2655,2494,2508,2505,3968,7463,8881,8882,8883,
      8885,8886,8887,8888,8889,8890,8821,9776,12607,12642,12643,2495,2470,7730,
      9777,11240,11118,2646,2522,2539,12644,2139,2539
    }
  },
  [33] = { -- Max Mana
    attribute = { name = 'Max Mana', rare = {30,60}, epic = {80,120}, legendary = {150,250} },
    value = "Static",
    items = {
      2662,2663,2323,2472,3972,7458,7459,7903,7901,7902,7900,9778,10016,13756,18398,2508,2505,2656,7884,
      7897,7898,7899,8892,8819,15489,11356,18399,7885,7894,7895,7896,7730,7886,7891,7892,7893,
      8900,8901,8902,8903,8904,8918,12647,8870,8871,2139,2195
    }
  },
  [34] = { -- Max Health %
    attribute = { name = 'Max Health', rare = {1,3}, epic = {4,6}, legendary = {7,10} },
    value = "Percent"
  },
  [35] = { -- Max Mana %
    attribute = { name = 'Max Mana', rare = {1,3}, epic = {4,6}, legendary = {7,10} },
    value = "Percent"
  },

  [36] = { -- Life Leech Chance
    attribute = { name = 'Life Leech Chance', rare = {3,5}, epic = {6,10}, legendary = {11,20} },
    value = "Percent",
	items = {"weaponsAll", "distanceWeaponsAl", "ring of the tarrasque"}
  },


  [38] = { -- Mana Leech Chance
    attribute = { name = 'Mana Leech Chance', rare = {3,5}, epic = {6,10}, legendary = {11,20} },
    value = "Percent",
	items = {"wandNrodsAlll", "ringsAll"}
  },

}

-- Normaliza todas as listas
for idx, def in pairs(stats) do
  if def.items then
    def.items = _normalizeItemsList(def.items, ("stats[%s].%s"):format(idx, def.attribute and def.attribute.name or "items"), def.remove)
  end
end

local cannotroll = {7775}

-- === Nome -> ID: normalização das listas de itens ============================

local function _resolveItemId(k)
  if type(k) == "number" then
    return k
  elseif type(k) == "string" then
    local name = k:lower()
    -- 1) Tenta ItemType(name)
    local it = ItemType and ItemType(name)
    if it and it:getId() and it:getId() > 0 then
      return it:getId()
    end
    -- 2) Fallback comum em TFS 1.x
    if getItemIdByName then
      local id = getItemIdByName(name, false) or getItemIdByName(k, false)
      if id and id > 0 then
        return id
      end
    end
    print(string.format("[Rarity] AVISO: item '%s' não encontrado no items.xml.", tostring(k)))
  end
  return nil
end

local function _normalizeItemsList(list, label)
  if not list then return nil end
  local out, seen = {}, {}
  for _, entry in ipairs(list) do
    local id = _resolveItemId(entry)
    if id then
      if not seen[id] then
        table.insert(out, id)
        seen[id] = true
      else
        -- opcional: log de duplicata
        -- print(string.format("[Rarity] Nota: %s tem id duplicado %d; ignorando repetição.", label or "items[]", id))
      end
    end
  end
  return (#out > 0) and out or nil
end

-- Normaliza todas as listas stats[*].items (aceita id ou nome)
for idx, def in pairs(stats) do
  if def.items then
    def.items = _normalizeItemsList(def.items, ("stats[%s].%s"):format(idx, def.attribute and def.attribute.name or "items"))
  end
end

-- Normaliza cannotroll (aceita id ou nome)
cannotroll = _normalizeItemsList(cannotroll, "cannotroll")


local function readPercentFromDesc(desc, label)
  local v = desc:match("%[" .. esc(label) .. ": %+(%-?%d+)%%%]")
  return tonumber(v) or 0
end

-- escreve/atualiza exatamente um valor percentual na descrição
local function setDescPercent(desc, label, target)
  local labelEsc = esc(label)
  local pat  = "%[" .. labelEsc .. ": %+(%-?%d+)%%%]"
  local found = desc:match(pat)
  if found then
    return (desc:gsub("%[" .. labelEsc .. ": %+" .. esc(found) .. "%%%]", "[" .. label .. ": +" .. target .. "%%]"))
  else
    return (desc .. "\n[" .. label .. ": +" .. target .. "%]")
  end
end

-- remove uma linha percentual pela etiqueta
local function removePercentLine(desc, label)
  local labelEsc = esc(label)
  return (desc:gsub("%[" .. labelEsc .. ": %+%-?%d+%%%]\n?", ""))
end

-- Une Base X + X (crit/life/mana) em uma linha só e apaga a linha Base
local function unifyBasePairs(desc)
  local PAIRS = {
    { base = "Base Crit Chance", label = "Crit Chance" },
    { base = "Base Life Leech",  label = "Life Leech Chance" },
    { base = "Base Mana Leech",  label = "Mana Leech Chance" },
  }
  for _, p in ipairs(PAIRS) do
    local base = readPercentFromDesc(desc, p.base)
    local add  = readPercentFromDesc(desc, p.label)
    if base > 0 or add > 0 then
      local total = base + add
      desc = setDescPercent(desc, p.label, total)
      desc = removePercentLine(desc, p.base) -- deixa “uma coisa só”
    end
  end
  return desc
end

-- Check if item can be rolled
function rollCheck(item)
  local itemtype = ItemType(item:getId())
  local itemid = itemtype:getId()
  if table.contains(cannotroll, itemid) then
    return false
  end
  for _,v in pairs(stats) do
    if v.items and table.contains(v.items, itemid) then
      return true
    end
  end
  local weapontype = itemtype:getWeaponType()
  if weapontype > 0 then
    if itemtype:isStackable() then
      return false
    else
      return true
    end
  elseif itemtype:getArmor() > 0 then
    return true
  end
  return false
end

-- Roll a container or item
function rollRarity(container, forced)
  local tiers = {
    [1] = { prefix = 'rare',      chance = { [1] = 1000, [2] = 500  } },
    [2] = { prefix = 'epic',      chance = { [1] = 275,   [2] = 5000  } },
    [3] = { prefix = 'legendary', chance = { [1] = 100,   [2] = 10000 } },
  }
  local rares = 0
  local available_stats = {}
  local it_u = container
  local it_id = ItemType(it_u:getId())

  if it_u:isContainer() then
    local h = it_u:getItemHoldingCount()
    if h > 0 then
      local i = 1
      while i <= h do
        local bagitem = it_u:getItem(i - 1)
        if bagitem:isContainer() then
          h = h - bagitem:getItemHoldingCount()
        end
        local manualroll = forced or false
        local crares = rollRarity(bagitem, manualroll)
        rares = rares + crares
        i = i + 1
      end
    end
  else
    if not it_id:isStackable() then
      local wp = it_id:getWeaponType()
      if wp > 0 then
        if wp == WEAPON_SHIELD then
          table.insert(available_stats, stats[2])  -- Defense
          table.insert(available_stats, stats[30]) -- Shield Skill

        elseif wp == WEAPON_DISTANCE then
          table.insert(available_stats, stats[1])  -- Attack
          table.insert(available_stats, stats[6])  -- Range
          table.insert(available_stats, stats[10]) -- Crit Chance
          table.insert(available_stats, stats[29]) -- Distance Skill
          if it_u:getId() ~= 5907 then -- Slingshot
            table.insert(available_stats, stats[22]) -- Multi Shot
          end

        elseif wp == WEAPON_WAND then
          table.insert(available_stats, stats[21]) -- Spell Damage
          table.insert(available_stats, stats[33]) -- Max Mana
          table.insert(available_stats, stats[31]) -- Magic Level
          table.insert(available_stats, stats[38]) -- Mana Leech Chance (amount handled by core)

        elseif table.contains({WEAPON_SWORD, WEAPON_CLUB, WEAPON_AXE}, wp) then
          if wp == WEAPON_SWORD then
            table.insert(available_stats, stats[25])
          elseif wp == WEAPON_AXE then
            table.insert(available_stats, stats[26])
          else
            table.insert(available_stats, stats[27])
          end
          if it_id:getAttack() > 0 then
            table.insert(available_stats, stats[1])
          end
          if it_id:getSlotPosition() == 2096 then -- two-handed
            table.insert(available_stats, stats[2])
          end
          if it_id:getSlotPosition() == 48 then -- one-handed
            table.insert(available_stats, stats[3])
          end
          table.insert(available_stats, stats[10]) -- Crit Chance
          table.insert(available_stats, stats[36]) -- Life Leech Chance (amount handled by core)
        end
      else
        if it_id:getArmor() > 0 then
          table.insert(available_stats, stats[4]) -- Armor
        end
        local eq_id = it_id:getTransformEquipId()
        if eq_id > 0 then
          table.insert(available_stats, stats[9]) -- Time
        end
        local chargecount = it_id:getCharges()
        if chargecount > 0 and it_u.itemid ~= 2173 then
          if chargecount >= 50 then
            table.insert(available_stats, stats[8])
          else
            table.insert(available_stats, stats[7])
          end
        end
      end

      -- specifically targeted items
      for k,v in pairs(stats) do
        if v.items and table.contains(v.items, it_u.itemid) then
          table.insert(available_stats, stats[k])
        end
      end
    end
  end

  if #available_stats > 0 then
    local tier = 0
    local rarity = math.random(1, 10000)
    if type(forced) == "string" then
      for i = 1, #tiers do
        if forced == tiers[i].prefix then
          tier = i
        end
      end
    elseif forced == true then
      tier = math.random(1, #tiers)
    else
      for i = 1, #tiers do
        if rarity <= tiers[i].chance[1] then
          tier = i
        end
      end
    end

    if tier > 0 then
      local stats_used = {}
      for stat = 1, #tiers[tier].chance do
        if #available_stats > 0 then
          local roll = math.random(1, 10000)
          if stat == 1 then roll = tiers[tier].chance[stat] end
          if roll <= tiers[tier].chance[stat] then
            local selected_stat = math.random(1, #available_stats)
            table.insert(stats_used, available_stats[selected_stat])
            table.remove(available_stats, selected_stat)
          end
        end
      end

      if #stats_used > 0 then
        rares = rares + 1

        -- start from existing or base description
        local desc = it_u:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
        if not desc or desc == "" then
          local base = it_id:getDescription()
          desc = (base and base ~= "") and base or ""
        end

        for s = 1, #stats_used do
          local def = stats_used[s]
          local statmin, statmax
          if tiers[tier].prefix == "legendary" then
            statmin, statmax = def.attribute.legendary[1], def.attribute.legendary[2]
          elseif tiers[tier].prefix == "epic" then
            statmin, statmax = def.attribute.epic[1], def.attribute.epic[2]
          else
            statmin, statmax = def.attribute.rare[1], def.attribute.rare[2]
          end

          local roll = math.random(statmin, statmax)

          -- If this is a vanilla attribute, add to current (or base) instead of overwriting
          if def.base ~= nil then
            local current = getCurrentOrBase(it_u, def.base)
            it_u:setAttribute(def.base, current + roll)
          end

          -- Merge/update description line
          if def.value == "Static" then
            desc = mergeDescStatic(desc, def.attribute.name, roll)
          elseif def.value == "Percent" then
            desc = mergeDescPercent(desc, def.attribute.name, roll)
          elseif def.value == "Damage" then
            local minimumDmg = 1
            if def.attribute.name == "Enhanced Fire Damage" then
              minimumDmg = (roll - math.random(3,5))
            elseif def.attribute.name == "Enhanced Ice Damage" then
              minimumDmg = (roll - math.random(5,9))
            else
              minimumDmg = 1
            end
            if minimumDmg < 1 then minimumDmg = 1 end
            desc = mergeDescDamage(desc, def.attribute.name, minimumDmg, roll)
          elseif def.value == "Duration" then
            local minutesAdd = minutes(roll)
            -- mostra em minutos, mas também acumula no atributo nativo (já somado acima)
            desc = mergeDescStatic(desc, def.attribute.name, minutesAdd) -- exibe "+X minutes"
            desc = desc:gsub(esc(def.attribute.name) .. ": %+(%-?%d+)%]", def.attribute.name .. ": +%1 minutes]")
          end
        end

        -- Rarity prefix in article
        if it_id:getArticle() ~= "" then
          if tiers[tier].prefix == "epic" then
            it_u:setAttribute(ITEM_ATTRIBUTE_ARTICLE, "an " .. tiers[tier].prefix)
          else
            it_u:setAttribute(ITEM_ATTRIBUTE_ARTICLE, "a " .. tiers[tier].prefix)
          end
        else
          it_u:setAttribute(ITEM_ATTRIBUTE_ARTICLE, tiers[tier].prefix)
        end
		
		-- Une Base + Extra em uma linha só (crit/mana/life)
        desc = unifyBasePairs(desc)
		
        it_u:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, desc)
        rare_text = (tiers[tier].prefix:gsub("^%l", string.upper) .. "!")
      end
    end
  end

  return rares
end

-- Apply condition (equipped bonuses from description)
function rollCondition(player, item, slot)
 -- Lê valores "Base ..." só para referência, não viram bônus adicionais
  local itemDesc = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
  local baseCrit = readPercentFromDesc(itemDesc, "Base Crit Chance")
  local baseLife = readPercentFromDesc(itemDesc, "Base Life Leech")
  local baseMana = readPercentFromDesc(itemDesc, "Base Mana Leech")

  local baseByParam = {
    [CONDITION_PARAM_SPECIALSKILL_CRITICALHITCHANCE] = baseCrit,
    [CONDITION_PARAM_SPECIALSKILL_LIFELEECHCHANCE]   = baseLife,
    [CONDITION_PARAM_SPECIALSKILL_MANALEECHCHANCE]   = baseMana,
  }

  local attributes = {
    [1]  = { "%[" .. stats[25].attribute.name .. ": ", CONDITION_PARAM_SKILL_SWORD },        -- Sword Skill
    [2]  = { "%[" .. stats[26].attribute.name .. ": ", CONDITION_PARAM_SKILL_AXE },
    [3]  = { "%[" .. stats[27].attribute.name .. ": ", CONDITION_PARAM_SKILL_CLUB },
    [4]  = { "%[" .. stats[28].attribute.name .. ": ", CONDITION_PARAM_SKILL_MELEE },
    [5]  = { "%[" .. stats[29].attribute.name .. ": ", CONDITION_PARAM_SKILL_DISTANCE },
    [6]  = { "%[" .. stats[30].attribute.name .. ": ", CONDITION_PARAM_SKILL_SHIELD },
    [7]  = { "%[" .. stats[31].attribute.name .. ": ", CONDITION_PARAM_STAT_MAGICPOINTS },
    [8]  = { "%[" .. stats[32].attribute.name .. ": ", CONDITION_PARAM_STAT_MAXHITPOINTS },
    [9]  = { "%[" .. stats[33].attribute.name .. ": ", CONDITION_PARAM_STAT_MAXMANAPOINTS },
    [10] = { "%[" .. stats[34].attribute.name .. ": ", CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, percent = true, absolute = true },
    [11] = { "%[" .. stats[35].attribute.name .. ": ", CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, percent = true, absolute = true },
    [12] = { "%[" .. stats[10].attribute.name .. ": ",  CONDITION_PARAM_SPECIALSKILL_CRITICALHITCHANCE, percent = true }, -- Crit Chance
    [13] = { "%[" .. stats[36].attribute.name .. ": ", CONDITION_PARAM_SPECIALSKILL_LIFELEECHCHANCE,   percent = true }, -- Life Leech Chance
    [14] = { "%[" .. stats[38].attribute.name .. ": ", CONDITION_PARAM_SPECIALSKILL_MANALEECHCHANCE,   percent = true }, -- Mana Leech Chance
  }

  local itemDesc = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
  for k = 1,#attributes do
    local entry = attributes[k]
    if entry then
      local skillBonus = 0
      local attributeSearchValue = "%+(%d+)%]"
      if entry.percent then
        attributeSearchValue = "%+(%d+)%%%]"
        if entry.absolute then
          skillBonus = 100
        end
      end
      local attributeString = entry[1] .. attributeSearchValue
      if string.match(itemDesc, attributeString) ~= nil then
        local offset = (10 * k) + slot
        local value = tonumber(string.match(itemDesc, attributeString)) or 0
			-- Se for Crit/Life/Mana Leech *Chance*, remove a parte "Base ..." (do core)
			local maybeBase = baseByParam[entry[2]]
			if maybeBase then
			  value = math.max(0, value - maybeBase)
			end

		skillBonus = skillBonus + value
        if player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, offset) == nil then
          local condition = Condition(CONDITION_ATTRIBUTES)
          condition:setParameter(CONDITION_PARAM_SUBID, offset)
          condition:setParameter(CONDITION_PARAM_TICKS, -1)
          condition:setParameter(entry[2], skillBonus)
          player:addCondition(condition)
        else
          player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, offset)
        end
      end
    end
  end
end

function itemAttributes(player, item, slot, equip)
  if item:getArticle() ~= "" then
    if item:getArticle():find("rare") or item:getArticle():find("epic") or item:getArticle():find("legendary") then
      local appropriateSlot = false
      local slotType = ItemType(item.itemid):getSlotPosition()
      local raritySlots = {
        [CONST_SLOT_LEFT]     = {validPositions = {[1] = SLOTP_LEFT,[2] = SLOTP_RIGHT,[3] = SLOTP_TWO_HAND}},
        [CONST_SLOT_RIGHT]    = {validPositions = {[1] = SLOTP_LEFT,[2] = SLOTP_RIGHT,[3] = SLOTP_TWO_HAND}},
        [CONST_SLOT_HEAD]     = {validPositions = {[1] = SLOTP_HEAD}},
        [CONST_SLOT_NECKLACE] = {validPositions = {[1] = SLOTP_NECKLACE}},
        [CONST_SLOT_ARMOR]    = {validPositions = {[1] = SLOTP_ARMOR}},
        [CONST_SLOT_LEGS]     = {validPositions = {[1] = SLOTP_LEGS}},
        [CONST_SLOT_FEET]     = {validPositions = {[1] = SLOTP_FEET}},
        [CONST_SLOT_RING]     = {validPositions = {[1] = SLOTP_RING}}
      }
      if raritySlots[slot] ~= nil then
        if slot == CONST_SLOT_LEFT or slot == CONST_SLOT_RIGHT then
          local weapon = ItemType(item.itemid):getWeaponType()
          if weapon ~= WEAPON_NONE and weapon ~= WEAPON_AMMO then
            appropriateSlot = true
          end
        else
          for i = 1,#raritySlots[slot].validPositions do
            if bit.band(slotType, raritySlots[slot].validPositions[i]) ~= 0 then
              appropriateSlot = true
              break
            end
          end
        end
        if appropriateSlot then
          rollCondition(player, item, slot)
        end
      end
    end
  end
end
