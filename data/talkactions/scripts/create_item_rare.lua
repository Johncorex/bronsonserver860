-- /i <raridade?> <nome do item>[, atributo1, atributo2, ...]
-- Ex.: /i legendary fire axe, attack +9, life leech chance 17%, crit chance 12%, fire 10-20
-- Ex.: /i epic demon helmet
-- Requer: rollRarity(item, "<tier>") disponível (teu sistema de raridade).

local VANILLA_MAP = {
  attack            = ITEM_ATTRIBUTE_ATTACK,
  defense           = ITEM_ATTRIBUTE_DEFENSE,
  ["extra defense"] = ITEM_ATTRIBUTE_EXTRADEFENSE,
  armor             = ITEM_ATTRIBUTE_ARMOR,
}

local BRACKET_LABELS = {
  -- percentuais
  ["crit chance"]          = {label = "Crit Chance",          percent = true},
  ["critical chance"]      = {label = "Crit Chance",          percent = true},
  ["life leech chance"]    = {label = "Life Leech Chance",    percent = true},
  ["mana leech chance"]    = {label = "Mana Leech Chance",    percent = true},
  ["spell damage"]         = {label = "Spell Damage",         percent = true},
  ["stun chance"]          = {label = "Stun Chance",          percent = true},
  ["mana shield"]          = {label = "Mana Shield",          percent = true},
  ["physical resistance"]  = {label = "Physical Resistance",  percent = true},
  ["fire resistance"]      = {label = "Fire Resistance",      percent = true},
  ["ice resistance"]       = {label = "Ice Resistance",       percent = true},
  ["energy resistance"]    = {label = "Energy Resistance",    percent = true},
  ["earth resistance"]     = {label = "Earth Resistance",     percent = true},
  ["death resistance"]     = {label = "Death Resistance",     percent = true},

  -- estáticos
  attack                   = {label = "Attack"},
  defense                  = {label = "Defense"},
  ["extra defense"]        = {label = "Extra Defense"},
  armor                    = {label = "Armor"},
  ["multi shot"]           = {label = "Multi Shot"},
  ["sword skill"]          = {label = "Sword Skill"},
  ["axe skill"]            = {label = "Axe Skill"},
  ["club skill"]           = {label = "Club Skill"},
  ["melee skills"]         = {label = "Melee Skills"},
  ["distance skill"]       = {label = "Distance Skill"},
  ["shield skill"]         = {label = "Shield Skill"},
  ["magic level"]          = {label = "Magic Level"},
  ["max health"]           = {label = "Max Health"},
  ["max mana"]             = {label = "Max Mana"},

  -- aliases curtos
  ["atk"]                  = {label = "Attack"},
  ["def"]                  = {label = "Defense"},
  ["extradef"]             = {label = "Extra Defense"},
  ["arm"]                  = {label = "Armor"},
  ["crit"]                 = {label = "Crit Chance", percent = true},
  ["life leech"]           = {label = "Life Leech Chance", percent = true},
  ["mana leech"]           = {label = "Mana Leech Chance", percent = true},
}

local RARITIES = { rare = "rare", epic = "epic", legendary = "legendary" }

-- ===== Helpers =====
local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end
local function split(str, sep)
  local t = {}
  for chunk in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(t, trim(chunk))
  end
  return t
end
local function parseAmount(s)
  -- aceita "+9", "9", "17%", "+17 %"
  local num = s:match("([+-]?%d+)%s*%%")
  if num then return tonumber(num), true end
  num = s:match("([+-]?%d+)")
  return tonumber(num or 0), false
end

-- Detecta se a chave é um dos elementos (fire/ice/energy) com vários sinônimos
local function detectElementKey(keyLower)
  local k = keyLower
  k = k:gsub("dano", "damage")
       :gsub("dmg", "damage")
       :gsub("^enhanced%s+", "")
       :gsub("^enh%s+", "")
       :gsub("%s+", " ")

  if k == "fire" or k == "fire damage" then return "Fire"
  elseif k == "ice" or k == "ice damage" then return "Ice"
  elseif k == "energy" or k == "energy damage" then return "Energy"
  end
  return nil
end

-- Lê "10-20" ou "15" (vira 10-15 por padrão)
local function parseMinMax(val)
  local a, b = val:match("([+-]?%d+)%s*%-%s*([+-]?%d+)")
  if a and b then
    a, b = tonumber(a), tonumber(b)
    if a > b then a, b = b, a end
    return math.max(0, a), math.max(0, b)
  end
  local single = val:match("([+-]?%d+)")
  if single then
    local maxv = math.max(0, tonumber(single))
    local minv = math.max(0, maxv - 5)
    return minv, maxv
  end
  return nil, nil
end

local function appendDescription(item, lines)
  local itype = ItemType(item:getId())
  local baseDesc = itype:getDescription()
  local current = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
  local payload = table.concat(lines, "\n")

  if current ~= "" then
    item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, current .. "\n" .. payload)
  elseif baseDesc ~= "" then
    item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, baseDesc .. "\n\n" .. payload)
  else
    item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "\n" .. payload)
  end
end

local function setVanillaIfApplies(item, keyLower, amount)
  local attrConst = VANILLA_MAP[keyLower]
  if not attrConst then return end
  local itype = ItemType(item:getId())
  local base = 0
  if attrConst == ITEM_ATTRIBUTE_ATTACK then base = itype:getAttack()
  elseif attrConst == ITEM_ATTRIBUTE_DEFENSE then base = itype:getDefense()
  elseif attrConst == ITEM_ATTRIBUTE_EXTRADEFENSE then base = itype:getExtraDefense()
  elseif attrConst == ITEM_ATTRIBUTE_ARMOR then base = itype:getArmor()
  end
  if base and base > 0 then
    item:setAttribute(attrConst, base + amount)
  end
end

local function buildBracketLine(keyLower, amount, isPercent)
  local spec = BRACKET_LABELS[keyLower]
  if not spec then return nil end
  if spec.percent or isPercent then
    return string.format("[%s: +%d%%]", spec.label, amount)
  else
    return string.format("[%s: +%d]", spec.label, amount)
  end
end

-- ===== Principal =====
function onSay(player, words, param)
-- Verificação de grupo GOD (groupId 6)
    if player:getGroup():getId() < 6 then
        player:sendCancelMessage("You need GOD access to use this command.")
        return false
    end
    
    if param == "" then
        player:sendCancelMessage("Command param required. Usage: /i <itemid[,count]>")
        return false
    end

  if param == "" then
    player:sendCancelMessage("Uso: /i <rarity?> <item name>[, atributo, ...]\nEx.: /i legendary fire axe, attack +9, life leech chance 17%, crit chance 12%, fire 10-20")
    return false
  end

  local raw = param
  local rarity, rest = raw:match("^(%S+)%s+(.+)$")
  rarity = rarity and rarity:lower() or nil

  local forcedRarity = RARITIES[rarity] and rarity or nil
  local afterRarity  = forcedRarity and rest or raw

  -- item name é até a primeira vírgula (ou fim)
  local itemPart, attrsPart = afterRarity:match("^([^,]+),%s*(.+)$")
  itemPart  = trim(itemPart or afterRarity)
  attrsPart = attrsPart and trim(attrsPart) or nil

  -- resolve item
  local itype = ItemType(itemPart)
  if not itype or itype:getId() == 0 then
    player:sendCancelMessage("Item não encontrado: " .. itemPart)
    return false
  end

  local item = Game.createItem(itype:getId(), 1)
  if not item then
    player:sendCancelMessage("Falha ao criar o item.")
    return false
  end

  -- marca raridade e rola automático se não houver atributos manuais
  if forcedRarity then
    item:setAttribute(ITEM_ATTRIBUTE_ARTICLE, forcedRarity) -- "rare"/"epic"/"legendary"
    if not attrsPart and type(rollRarity) == "function" then
      rollRarity(item, forcedRarity)
    end
  end

  -- atributos manuais
  if attrsPart then
    local lines = {}
    for _,chunk in ipairs(split(attrsPart, ",")) do
      local key, val = chunk:match("^(.-)%s+([%+%-%d%%%s%-%/]+)$")
      if not key or not val then key = chunk; val = "" end
      key = trim((key or ""):lower())
      val = trim(val or "")

      -- normalizações
      key = key:gsub("^critical$", "crit")
               :gsub("^critico$", "crit")
               :gsub("^vida leech", "life leech")
               :gsub("^mana leech", "mana leech")
               :gsub("^extra def$", "extra defense")
               :gsub("^melee$", "melee skills")
               :gsub(" +", " ")

      -- 1) Enhanced Elemental Damage? (fire/ice/energy com vários sinônimos)
      local elem = detectElementKey(key)
      if elem then
        local mn, mx = parseMinMax(val)
        if mn and mx then
          table.insert(lines, string.format("[Enhanced %s Damage: %d-%d]", elem, mn, mx))
        else
          player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Formato inválido para "..elem.." (use 10-20 ou número único). Ignorado.")
        end
      else
        -- 2) Atributos "normais" (colchetes)
        local amount, isPercent = parseAmount(val)
        if amount == 0 and val ~= "" then
          -- não conseguiu ler número; tenta heurísticas ainda assim
        end

        local labelSpec = BRACKET_LABELS[key]
        if labelSpec then
          if labelSpec.percent then isPercent = true end
          local line = buildBracketLine(key, amount, isPercent)
          if line then table.insert(lines, line) end
          setVanillaIfApplies(item, key, amount) -- atualiza vanilla se couber
        else
          -- Heurísticas comuns / aliases extras
          if key == "attack" or key == "atk" then
            table.insert(lines, string.format("[Attack: +%d]", amount))
            setVanillaIfApplies(item, "attack", amount)
          elseif key == "defense" or key == "def" then
            table.insert(lines, string.format("[Defense: +%d]", amount))
            setVanillaIfApplies(item, "defense", amount)
          elseif key == "extra defense" or key == "extradef" then
            table.insert(lines, string.format("[Extra Defense: +%d]", amount))
            setVanillaIfApplies(item, "extra defense", amount)
          elseif key == "armor" or key == "arm" then
            table.insert(lines, string.format("[Armor: +%d]", amount))
            setVanillaIfApplies(item, "armor", amount)
          elseif key == "crit" or key == "crit chance" or key == "critical chance" then
            table.insert(lines, string.format("[Crit Chance: +%d%%]", amount))
          elseif key == "life leech" or key == "life leech chance" then
            table.insert(lines, string.format("[Life Leech Chance: +%d%%]", amount))
          elseif key == "mana leech" or key == "mana leech chance" then
            table.insert(lines, string.format("[Mana Leech Chance: +%d%%]", amount))
          elseif key == "multi shot" then
            table.insert(lines, string.format("[Multi Shot: +%d]", amount))
          elseif key == "spell damage" then
            table.insert(lines, string.format("[Spell Damage: +%d%%]", amount))
          elseif key == "stun chance" then
            table.insert(lines, string.format("[Stun Chance: +%d%%]", amount))
          elseif key == "mana shield" then
            table.insert(lines, string.format("[Mana Shield: +%d%%]", amount))
          else
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Atributo desconhecido: "..key.." (ignorado).")
          end
        end
      end
    end

    if #lines > 0 then
      appendDescription(item, lines)
    end
  end

  -- entregar ao player
  local ret = player:addItemEx(item, true)
  if ret ~= RETURNVALUE_NOERROR then
    item:moveTo(player:getPosition())
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Inventário cheio; item dropado no chão.")
  end

  player:sendTextMessage(MESSAGE_INFO_DESCR, "Item criado: " .. itype:getName() .. (forcedRarity and (" ("..forcedRarity..")") or "") .. ".")
  return true
end
