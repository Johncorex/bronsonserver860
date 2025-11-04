function onSay(player, words, param)
  local DEBUG = (param and param:lower():find("debug")) and true or false

  -- ===== helpers =====
  local function esc(s) return (s:gsub("([%%%(%)%[%]%.%+%-%*%?%^%$])","%%%1")) end
  local function add(tbl,k,v) tbl[k]=(tbl[k] or 0)+(v or 0) end
  
	-- soma apenas valores FLAT em brackets (ignora quando houver '%')
	local function sumBracketFlatOnly(desc, label)
	  local d = (desc or ""):lower()
	  local lbl = label:lower()
	  local patt = "%[%s*" .. esc(lbl) .. "%s*:%s*([^%]]-)%]"  -- captura o conteudo apos "Label:"
	  local total = 0
	  for inner in d:gmatch(patt) do
		if not inner:find("%%") then
		  local num = inner:match("%+?(%d+)")
		  if num then total = total + tonumber(num) end
		end
	  end
	  return total
	end

  -- [% label :: +N% ] (tolerante a : ou :: e espacos) -> iterar numeros
  local function iterBracketPercentCI(desc, label, fnEach)
    local d = (desc or ""):lower()
    local lbl = label:lower()
    local patt = "%[%s*" .. esc(lbl) .. "%s*:+%s*%+?(%d+)%%%s*%]"
    for num in d:gmatch(patt) do
      fnEach(tonumber(num))
    end
  end

  -- por item: soma valores UNICOS entre varios labels equivalentes (evita duplicar 10% duas vezes)
  local function sumSpecialUnique(desc, labels)
    local seen = {}
    local total = 0
    for _,lbl in ipairs(labels) do
      iterBracketPercentCI(desc, lbl, function(v)
        if not seen[v] then
          seen[v] = true
          total = total + v
        end
      end)
    end
    return total
  end

  -- [% label :: +N ... ] (nao exige %) -> soma (ex: Regen +N / Ts)
  local function sumBracketNumberCI(desc, label)
    local d = (desc or ""):lower()
    local lbl = label:lower()
    local patt = "%[%s*" .. esc(lbl) .. "%s*:+%s*%+?(%d+)[^%]]-%]"
    local total = 0
    for num in d:gmatch(patt) do total = total + tonumber(num) end
    return total
  end

  -- primeiro inteiro depois do label em brackets
  local function readBracketStatic(desc,label)
    local m = (desc or ""):match("%["..esc(label)..":%s*%+?(%d+)[^%]]-%]")
    return tonumber(m) or 0
  end
  local function readBracketStaticAny(desc, labels)
    for _,lbl in ipairs(labels) do
      local v = readBracketStatic(desc, lbl)
      if v ~= 0 then return v end
    end
    return 0
  end

  -- [Enhanced X Damage: A-B]
  local function readBracketDamage(desc,label)
    local a,b=(desc or ""):match("%["..esc(label)..":%s*(%d+)%-(%d+)%]")
    return tonumber(a) or 0, tonumber(b) or 0
  end

  -- pega 1o cabecalho "( ... )"
  local function firstHeader(desc) return (desc or ""):match("%b()") or "" end

  -- header: Atk/Def/ExtraDef (ex: "(Atk:24, Def:21 +2)")
  local function readHeaderAtkDef(desc)
    local h = firstHeader(desc):lower()
    local atk = tonumber(h:match("atk%s*:%s*(%d+)")) or 0
    local def = tonumber(h:match("def%s*:%s*(%d+)")) or 0
    local ex  = 0
    local afterDef = h:match("def%s*:%s*%d+([^%)]*)") or ""
    local plus = afterDef:match("%+%s*(%d+)")
    if plus then ex = tonumber(plus) or 0 end
    return atk, def, ex
  end

  -- header: speed flat "(speed +15)" ou "(speed: +15)"
  local function readHeaderSpeed(desc)
    local h = firstHeader(desc):lower()
    local v = tonumber(h:match("speed%s*:?%s*%+?(%d+)%f[^%d]")) or 0
    return v
  end

  -- ===== Resistencias (Protection + Resistance) =====
  local ELEMENTS = { "Fire","Ice","Energy","Earth","Death","Holy","Physical" }
  local NAME_TO_KEY = { fire="Fire", ice="Ice", energy="Energy", earth="Earth", death="Death", holy="Holy", physical="Physical" }

  -- [Protection: (fire:+16%), ...]  /  [Protection fields: (...)]
  local function parseProtectionList(desc, label, acc)
    local d = (desc or ""):lower()
    local lbl = label:lower()
    for inner in d:gmatch("%[%s*"..esc(lbl).."%s*:%s*(.-)%]") do
      for name, val in inner:gmatch("([%a]+)%s*:%s*([+%-]?%d+)%%") do
        local key = NAME_TO_KEY[name]
        if key then acc[key] = (acc[key] or 0) + tonumber(val) end
      end
    end
  end

  -- [Protection All: +Z%]  /  [Protection all fields: +Z%]
  local function applyProtectionAll(desc, label, acc)
    local d = (desc or ""):lower()
    local lbl = label:lower()
    for val in d:gmatch("%[%s*"..esc(lbl).."%s*:%s*%+?([%-%d]+)%%%s*%]") do
      local z = tonumber(val) or 0
      if z ~= 0 then
        for _,Name in ipairs(ELEMENTS) do
          acc[Name] = (acc[Name] or 0) + z
        end
      end
    end
  end

  -- [Fire Resistance: +N%] etc
  local function parseElementResistance(desc, acc)
    for _,Name in ipairs(ELEMENTS) do
      local d = (desc or ""):lower()
      local lbl = (Name .. " Resistance"):lower()
      local patt = "%[%s*" .. esc(lbl) .. "%s*:+%s*%+?(%d+)%%%s*%]"
      for num in d:gmatch(patt) do
        acc[Name] = (acc[Name] or 0) + tonumber(num)
      end
    end
  end

  -- ===== acumuladores =====
  local T = {
    -- specials
    crit = 0, life = 0, mana = 0,

    -- resistencias (Protection + Resistance + fields somados)
    resist = {Fire=0, Ice=0, Energy=0, Earth=0, Death=0, Holy=0, Physical=0},

    -- atributos/skills
    attack=0, defense=0, extraDefense=0, armor=0,
    skillSword=0, skillAxe=0, skillClub=0, skillMelee=0, skillDist=0, skillShield=0, magicLevel=0,

    -- hp/mp
    maxHealth=0, maxMana=0, maxHealthPct=0, maxManaPct=0,
    hpRegen=0, mpRegen=0,

    -- speed
    speedFlat=0,

    -- enhanced damages
    enh={ Fire={min=0,max=0}, Ice={min=0,max=0}, Energy={min=0,max=0} },
  }

  local CHECK_SLOTS = {
    CONST_SLOT_HEAD, CONST_SLOT_NECKLACE, CONST_SLOT_ARMOR,
    CONST_SLOT_RIGHT, CONST_SLOT_LEFT, CONST_SLOT_LEGS,
    CONST_SLOT_FEET, CONST_SLOT_RING, CONST_SLOT_AMMO
  }

  local LBL_CRIT = {"Crit Chance","Critical Hit Chance","critical hit chance","critical chance"}
  local LBL_LIFE = {"Life Leech","Life Leech Chance","life leech","life leech chance","Hitpoints Leech Chance","hitpoints leech chance"}
  local LBL_MANA = {"Mana Leech","Mana Leech Chance","mana leech","mana leech chance","Manapoints Leech Chance","manapoints leech chance"}

  for _,slot in ipairs(CHECK_SLOTS) do
    local it = player:getSlotItem(slot)
    if it then
      local desc = it:getDescription() or ""

      -- specials (somar valores UNICOS por item para evitar duplicar o mesmo 10% escrito de 2 jeitos)
      T.crit = T.crit + sumSpecialUnique(desc, LBL_CRIT)
      T.life = T.life + sumSpecialUnique(desc, LBL_LIFE)
      T.mana = T.mana + sumSpecialUnique(desc, LBL_MANA)

      -- resistencias = Protection (hit) + Protection fields + Resistance + All/all fields
      parseProtectionList(desc, "Protection", T.resist)
      parseProtectionList(desc, "Protection fields", T.resist)
      applyProtectionAll(desc, "Protection All", T.resist)
      applyProtectionAll(desc, "Protection all fields", T.resist)
      parseElementResistance(desc, T.resist)

	  -- speed (brackets flat + header)

	  T.speedFlat    = T.speedFlat + sumBracketFlatOnly(desc, "Speed")
	  T.speedFlat    = T.speedFlat + sumBracketFlatOnly(desc, "Movement Speed")
	  T.speedFlat    = T.speedFlat + readHeaderSpeed(desc)

      -- regen (numero antes do "/ Ts")
      T.hpRegen = T.hpRegen + sumBracketNumberCI(desc, "Health Regen")
      T.hpRegen = T.hpRegen + sumBracketNumberCI(desc, "Health Regeneration")
      T.hpRegen = T.hpRegen + sumBracketNumberCI(desc, "HP Regen")

      T.mpRegen = T.mpRegen + sumBracketNumberCI(desc, "Mana Regen")
      T.mpRegen = T.mpRegen + sumBracketNumberCI(desc, "Mana Regeneration")
      T.mpRegen = T.mpRegen + sumBracketNumberCI(desc, "MP Regen")

      -- atributos base (brackets) + header (Atk/Def/Extra)
      add(T,"attack",       readBracketStatic(desc,"Attack"))
      add(T,"defense",      readBracketStatic(desc,"Defense"))
      add(T,"extraDefense", readBracketStatic(desc,"Extra Defense"))
      add(T,"armor",        readBracketStatic(desc,"Armor"))

      local hatk,hdef,hex = readHeaderAtkDef(desc)
      add(T,"attack", hatk); add(T,"defense", hdef); add(T,"extraDefense", hex)

      -- skills + ML
      add(T,"skillSword",   readBracketStatic(desc,"Sword Skill"))
      add(T,"skillAxe",     readBracketStatic(desc,"Axe Skill"))
      add(T,"skillClub",    readBracketStatic(desc,"Club Skill"))
      add(T,"skillMelee",   readBracketStatic(desc,"Melee Skills"))
      add(T,"skillDist",    readBracketStatic(desc,"Distance Skill"))
      add(T,"skillShield",  readBracketStatic(desc,"Shield Skill"))
      add(T,"magicLevel",   readBracketStatic(desc,"Magic Level"))

      -- max stats
      add(T,"maxHealth",    readBracketStatic(desc,"Max Health"))
      add(T,"maxMana",      readBracketStatic(desc,"Max Mana"))
      -- percentuais (garante que so % contam aqui)
      local d = (desc or ""):lower()
      for num in d:gmatch("%[%s*max%s*health%s*:%s*%+?(%d+)%%%s*%]") do T.maxHealthPct = T.maxHealthPct + tonumber(num) end
      for num in d:gmatch("%[%s*max%s*mana%s*:%s*%+?(%d+)%%%s*%]")   do T.maxManaPct   = T.maxManaPct   + tonumber(num) end

      -- enhanced
      local fmin,fmax = readBracketDamage(desc,"Enhanced Fire Damage")
      local imin,imax = readBracketDamage(desc,"Enhanced Ice Damage")
      local emin,emax = readBracketDamage(desc,"Enhanced Energy Damage")
      T.enh.Fire.min   = T.enh.Fire.min   + fmin ; T.enh.Fire.max   = T.enh.Fire.max   + fmax
      T.enh.Ice.min    = T.enh.Ice.min    + imin ; T.enh.Ice.max    = T.enh.Ice.max    + imax
      T.enh.Energy.min = T.enh.Energy.min + emin ; T.enh.Energy.max = T.enh.Energy.max + emax
    end
  end

  -- ===== output =====
  local lines = {}
  table.insert(lines, ("== Stats de %s =="):format(player:getName()))
  table.insert(lines, ("Critico: %d%%"):format(T.crit))
  table.insert(lines, ("Life Leech: %d%%"):format(T.life))
  table.insert(lines, ("Mana Leech: %d%%"):format(T.mana))

  -- speed
  if T.speedFlat ~= 0 then
    local parts = {}
    if T.speedFlat ~= 0 then table.insert(parts, ("+%d"):format(T.speedFlat)) end
    table.insert(lines, ("Speed: %s"):format(table.concat(parts, " & ")))
  end

  -- resistencias (Protection + Resistance + fields somados)
  do
    local parts = {}
    for _,Name in ipairs(ELEMENTS) do
      local v = T.resist[Name] or 0
      if v ~= 0 then table.insert(parts, ("%s %d%%"):format(Name, v)) end
    end
    if #parts>0 then table.insert(lines, "Resistencias -> " .. table.concat(parts, " | ")) end
  end

  -- atributos base
  local baseParts={}
  if T.attack>0 then table.insert(baseParts,("Attack +%d"):format(T.attack)) end
  if T.defense>0 then table.insert(baseParts,("Defense +%d"):format(T.defense)) end
  if T.extraDefense>0 then table.insert(baseParts,("Extra Def +%d"):format(T.extraDefense)) end
  if T.armor>0 then table.insert(baseParts,("Armor +%d"):format(T.armor)) end
  if #baseParts>0 then table.insert(lines, table.concat(baseParts," | ")) end

  -- skills & ML
  local skillParts={}
  if T.skillSword  > 0 then table.insert(skillParts, ("Sword +%d"):format(T.skillSword)) end
  if T.skillAxe    > 0 then table.insert(skillParts, ("Axe +%d"):format(T.skillAxe)) end
  if T.skillClub   > 0 then table.insert(skillParts, ("Club +%d"):format(T.skillClub)) end
  if T.skillMelee  > 0 then table.insert(skillParts, ("Melee +%d"):format(T.skillMelee)) end
  if T.skillDist   > 0 then table.insert(skillParts, ("Distance +%d"):format(T.skillDist)) end
  if T.skillShield > 0 then table.insert(skillParts, ("Shield +%d"):format(T.skillShield)) end
  if T.magicLevel  > 0 then table.insert(skillParts, ("Magic Level +%d"):format(T.magicLevel)) end
  if #skillParts>0 then table.insert(lines, "Skills -> " .. table.concat(skillParts, " | ")) end

  -- hp/mp
  local hpmpParts = {}
  if T.maxHealth   > 0 then table.insert(hpmpParts, ("Max Health +%d"):format(T.maxHealth)) end
  if T.maxMana     > 0 then table.insert(hpmpParts, ("Max Mana +%d"):format(T.maxMana)) end
  if T.maxHealthPct> 0 then table.insert(hpmpParts, ("Max Health +%d%%"):format(T.maxHealthPct)) end
  if T.maxManaPct  > 0 then table.insert(hpmpParts, ("Max Mana +%d%%"):format(T.maxManaPct)) end
  if T.hpRegen     > 0 or T.mpRegen > 0 then
    table.insert(hpmpParts, ("Regen HP +%d"):format(T.hpRegen))
    table.insert(hpmpParts, ("Regen MP +%d"):format(T.mpRegen))
  end
  if #hpmpParts > 0 then table.insert(lines, table.concat(hpmpParts, " | ")) end

  -- enhanced
  local function enhLine(name,t) if (t.min+t.max)>0 then table.insert(lines,("Enhanced %s Damage: %d-%d"):format(name,t.min,t.max)) end end
  enhLine("Fire",T.enh.Fire); enhLine("Ice",T.enh.Ice); enhLine("Energy",T.enh.Energy)

  player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, table.concat(lines, "\n"))
  return true
end
