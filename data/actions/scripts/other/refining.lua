-- Refinamento (MVP)
-- Teto +15, apenas armas (axe/club/sword), safe até +3, sem downgrade/quebra.
-- Preview de requisitos/chance; catalisador opcional: Cristal Impecavel (8300) = sucesso 100%.

-- ==========================
-- CONFIGURACAO GERAL
-- ==========================
local REFINE = {
  anvil = {
    aid = 46001,               -- ActionID da bigorna (coloque na bigorna no mapa)
    itemIds = { }              -- (opcional) ids de bigorna; se vazio, usa só aid
  },
  hammerIds = { 2422 },        -- AJUSTE para o itemid do seu "iron hammer"

  -- Vocacao: restringe a partir da id 18 até 20; bonus de vocacao (aditivo em %)
  allowedVocations = { [18]=true, [19]=true, [20]=true, [0]=true },
  vocationBonus    = { [19]=3, [20]=6 },

  -- Itens base usados nas receitas (apelidos)
  items = {
    minerioDeFerro    = 5880,  -- minério de ferro (iron ore )
	ligaDeFerro       = 5887,  -- liga de ferro ( royal piece of steel)
    blocoFerroBruto   = 5892,  -- grande bloco de ferro bruto (huge chunk of crude iron)
    carvao            = 10609, -- carvao (lump of dirt)
	carvaoFundido     = 8299,  -- carvao fundido (glimering soil)
    mithrilFrag       = 5889,  -- fragmento de mithril (piece of draconian steel)
    cristalImpecavel  = 8300,  -- catalisador OPCIONAL (100% sucesso se usado)
  },

  -- ---------- Organizacao por TIPO (extensível) ----------
  types = {},

  -- Overrides por ITEM específico
  itemOverrides = {},

  -- BONUS de ATK por nivel de refino
  bonus = {
    attackPerLevel = 1,  -- +1 de ATK por nivel (ex.: +15 => +15 ATK)
  },

  -- Comportamento de falha
  behavior = {
    downgradeOnFail = true, -- se falhar, cair -1 nivel
    downgradeFloor  = 3,    -- nunca cai abaixo de +3 (mude pra 0 se quiser cair até +0)
  },
}

-- ==========================
-- UPGRADES DE MATERIAIS NA BIGORNA
-- (fora da tabela REFINE!)
-- ==========================
local MATERIAL_UPGRADES = {
  -- 100x minério de ferro (5880) -> 1x liga de ferro (5887)
  [REFINE.items.minerioDeFerro] = { need = 100, outId = 5887, outCount = 1, nome = "liga de ferro" },

  -- 100x carvão (10609) -> 1x carvão fundido (8299)
  [REFINE.items.carvao] = { need = 100, outId = 8299, outCount = 1, nome = "carvao fundido" },
}

-- ==========================
-- TIERS GENERICOS PARA ARMAS (sword/axe/club)
local DEFAULT_WEAPON_TIERS = {
  [1]  = { chance = 100, req = { {REFINE.items.minerioDeFerro,30},  {REFINE.items.carvao,50},                                         {REFINE.items.blocoFerroBruto,1} } },
  [2]  = { chance = 100, req = { {REFINE.items.minerioDeFerro,60},  {REFINE.items.carvao,75},                                         {REFINE.items.blocoFerroBruto,1} } },
  [3]  = { chance = 100, req = { {REFINE.items.minerioDeFerro,90},  {REFINE.items.carvao,100},                                        {REFINE.items.blocoFerroBruto,1} } },
  [4]  = { chance = 90,  req = { {REFINE.items.minerioDeFerro,100}, {REFINE.items.carvaoFundido,1},                                   {REFINE.items.blocoFerroBruto,1} } },
  [5]  = { chance = 85,  req = { {REFINE.items.ligaDeFerro,1},      {REFINE.items.carvaoFundido,1}, {REFINE.items.carvao,50},         {REFINE.items.blocoFerroBruto,1} } },
  [6]  = { chance = 80,  req = { {REFINE.items.ligaDeFerro,2},      {REFINE.items.carvaoFundido,2},                                   {REFINE.items.blocoFerroBruto,1} } },
  [7]  = { chance = 70,  req = { {REFINE.items.ligaDeFerro,2},      {REFINE.items.carvaoFundido,2},                                   {REFINE.items.blocoFerroBruto,1} } },
  [8]  = { chance = 60,  req = { {REFINE.items.ligaDeFerro,2},      {REFINE.items.carvaoFundido,2}, {REFINE.items.carvao,60},         {REFINE.items.blocoFerroBruto,1} } },
  [9]  = { chance = 50,  req = { {REFINE.items.ligaDeFerro,3},      {REFINE.items.carvaoFundido,3},                                   {REFINE.items.blocoFerroBruto,1}, {REFINE.items.mithrilFrag,1} } },
  [10] = { chance = 40,  req = { {REFINE.items.ligaDeFerro,3},      {REFINE.items.carvaoFundido,3},                                   {REFINE.items.blocoFerroBruto,1}, {REFINE.items.mithrilFrag,1} } },
  [11] = { chance = 35,  req = { {REFINE.items.ligaDeFerro,3},      {REFINE.items.carvaoFundido,4},                                   {REFINE.items.blocoFerroBruto,1}, {REFINE.items.mithrilFrag,1} } },
  [12] = { chance = 30,  req = { {REFINE.items.ligaDeFerro,4},      {REFINE.items.carvaoFundido,4},                                   {REFINE.items.blocoFerroBruto,1}, {REFINE.items.mithrilFrag,1} } },
  [13] = { chance = 25,  req = { {REFINE.items.ligaDeFerro,4},      {REFINE.items.carvaoFundido,4},                                   {REFINE.items.blocoFerroBruto,1}, {REFINE.items.mithrilFrag,1} } },
  [14] = { chance = 20,  req = { {REFINE.items.ligaDeFerro,4},      {REFINE.items.carvaoFundido,5},                                   {REFINE.items.blocoFerroBruto,1}, {REFINE.items.mithrilFrag,1} } },
  [15] = { chance = 10,  req = { {REFINE.items.ligaDeFerro,5},      {REFINE.items.carvaoFundido,5},                                   {REFINE.items.blocoFerroBruto,1}, {REFINE.items.mithrilFrag,1} } },
}

REFINE.types.sword = { maxLevel = 15, safeLevel = 3, tiers = DEFAULT_WEAPON_TIERS }
REFINE.types.axe   = { maxLevel = 15, safeLevel = 3, tiers = DEFAULT_WEAPON_TIERS }
REFINE.types.club  = { maxLevel = 15, safeLevel = 3, tiers = DEFAULT_WEAPON_TIERS }

-- ===== APIs para extender =====
local function getConfigForItem(it)
  local id = it:getId()
  local ov = REFINE.itemOverrides[id]
  if ov then return ov end
  local tkey = nil
  do
    local t = ItemType(id)
    if t and t.getWeaponType then
      local wt = t:getWeaponType()
      if wt == 1 then tkey = "sword" end
      if wt == 2 then tkey = "club"  end
      if wt == 3 then tkey = "axe"   end
    end
  end
  if tkey and REFINE.types[tkey] then return REFINE.types[tkey] end
  return nil
end

-- BONUS OPCIONAL por skill club
local CLUB_BONUS = {
  enabled = true,
  perPoint = 0.07,
  maxBonus = 10,
}

-- ==========================
-- HELPERS
-- ==========================
local function inList(list, v)
  for i = 1, #list do if list[i] == v then return true end end
  return false
end

local function isAnvilTile(pos)
  local tile = Tile(pos)
  if not tile then return false end
  -- checa por AID em qualquer item do tile
  for i = 0, tile:getThingCount() - 1 do
    local th = tile:getThing(i)
    if th and th:isItem() then
      if th.getActionId and th:getActionId() == REFINE.anvil.aid then
        return true
      end
      if #REFINE.anvil.itemIds > 0 then
        local id = th:getId()
        if inList(REFINE.anvil.itemIds, id) then return true end
      end
    end
  end
  return false
end

-- Persistencia do nivel de refino
local function getRefLvl(it)
  if it.getCustomAttribute and it:getCustomAttribute("refLvl") then
    local v = it:getCustomAttribute("refLvl")
    if type(v) == "number" then return v end
  end
  local desc = it:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
  local n = desc:match("Refino %+(%d+)")
  return n and tonumber(n) or 0
end

local function setRefLvl(it, lvl)
  if it.setCustomAttribute then
    it:setCustomAttribute("refLvl", lvl)
  end
  local desc = it:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
  desc = desc:gsub("%s*Refino %+[0-9]+", "")
  if lvl > 0 then
    if desc ~= "" and not desc:match("\n$") then desc = desc .. "\n" end
    desc = desc .. ("Refino +%d"):format(lvl)
  end
  it:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, desc)
end

local function fmtReqList(req)
  local parts = {}
  for i = 1, #req do
    local id, c = req[i][1], req[i][2]
    parts[#parts+1] = ("%dx %s"):format(c, ItemType(id):getName())
  end
  return table.concat(parts, ", ")
end

local function hasAllRequirements(player, req)
  for i = 1, #req do
    local id, need = req[i][1], req[i][2]
    if player:getItemCount(id) < need then
      return false
    end
  end
  return true
end

local function missingRequirements(player, req)
  local miss = {}
  for i = 1, #req do
    local id, need = req[i][1], req[i][2]
    local have = player:getItemCount(id)
    if have < need then
      miss[#miss+1] = { id = id, need = need, have = have }
    end
  end
  return miss
end

local function consumeRequirements(player, req)
  for i = 1, #req do
    local id, need = req[i][1], req[i][2]
    if need > 0 then
      if not player:removeItem(id, need) then
        return false
      end
    end
  end
  return true
end

local function computeChance(baseChance, player)
  local chance = baseChance
  if CLUB_BONUS.enabled then
    local club = (player.getSkillLevel and player:getSkillLevel(SKILL_CLUB)) or 0
    local bonus = math.min(CLUB_BONUS.maxBonus, club * CLUB_BONUS.perPoint)
    chance = chance + bonus
  end
  local vocId = (player:getVocation() and player:getVocation():getId()) or 0
  local vbonus = (REFINE.vocationBonus and REFINE.vocationBonus[vocId]) or 0
  chance = chance + vbonus
  if chance > 100 then chance = 100 end
  if chance < 0   then chance = 0   end
  return chance
end

-- Catalisador opcional no tile da bigorna
local function findItemOnTile(pos, itemId)
  local tile = Tile(pos)
  if not tile then return nil end
  for i = 0, tile:getThingCount() - 1 do
    local th = tile:getThing(i)
    if th and th:isItem() and th:getId() == itemId then
      return th
    end
  end
  return nil
end

-- conta quantas unidades de um itemId existem no TILE
local function countItemOnTile(pos, itemId)
  local tile = Tile(pos)
  if not tile then return 0, {} end
  local total = 0
  local stacks = {}
  for i = 0, tile:getThingCount() - 1 do
    local th = tile:getThing(i)
    if th and th:isItem() and th:getId() == itemId then
      local c = th.getCount and th:getCount() or 1
      total = total + c
      stacks[#stacks+1] = th
    end
  end
  return total, stacks
end

-- consome 'amount' unidades de um itemId do TILE (varrendo multiplas pilhas)
local function consumeFromTile(pos, itemId, amount)
  local need = amount
  local _, stacks = countItemOnTile(pos, itemId)
  for i = 1, #stacks do
    local st = stacks[i]
    local have = st.getCount and st:getCount() or 1
    if have >= need then
      st:remove(need)
      return true
    else
      st:remove(have)
      need = need - have
    end
  end
  return false
end


-- ====== BONUS DE ATK REAL POR NIVEL ======

-- Base ancorada no nível 0 e cacheada em "refBaseAtk".
-- Nunca deixa a base crescer por causa do próprio refino; só por mudança nominal do item
-- (tipo ou [Attack:+X]) ou quando lvl==0 e o ATK atual for maior.
local function getBaseAttack(it)
							   
														 
																						
																						
  local t = ItemType(it:getId())
  local typeAtk = (t and t.getAttack and t:getAttack()) or 0
  local curAtk  = (it.getAttribute and it:getAttribute(ITEM_ATTRIBUTE_ATTACK)) or 0
  local desc    = (it.getAttribute and it:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)) or ""
  local bracketAtk = tonumber(desc:match("%[Attack: %+(%d+)%]")) or 0

  local per = (REFINE.bonus and REFINE.bonus.attackPerLevel) or 0
  local lvl = (getRefLvl and (tonumber(getRefLvl(it)) or 0)) or 0

  local nominalBase = math.max(typeAtk + bracketAtk, typeAtk)
  local derivedBase = curAtk - math.floor(per * lvl)
  if derivedBase < 0 then derivedBase = 0 end

  local cached = it.getCustomAttribute and it:getCustomAttribute("refBaseAtk")
  if type(cached) == "number" and cached > 0 then
																		   
    local newCache = cached
    if nominalBase > newCache then
      newCache = nominalBase
    elseif lvl == 0 and derivedBase > newCache then
      newCache = derivedBase
    end
    if newCache ~= cached and it.setCustomAttribute then
      it:setCustomAttribute("refBaseAtk", newCache)
    end
    return newCache
  end

									   
  local init = (lvl == 0) and math.max(nominalBase, derivedBase) or nominalBase
  if it.setCustomAttribute then
    it:setCustomAttribute("refBaseAtk", init)
  end
  return init
end

-- aplica ATK = base + (attackPerLevel * lvl) para sword/club/axe
local function applyRefStats(it, lvl)
  local t = ItemType(it:getId())
  if not (t and t.getWeaponType) then return nil end
  local wt = t:getWeaponType()
  if wt ~= 1 and wt ~= 2 and wt ~= 3 then return nil end -- 1=sword, 2=club, 3=axe

  local per = (REFINE.bonus and REFINE.bonus.attackPerLevel) or 0
  if per <= 0 then return nil end

  local base = getBaseAttack(it) -- base consolidada e cacheada
  local newAtk = base + math.floor(per * lvl)
  if it.setAttribute then
    it:setAttribute(ITEM_ATTRIBUTE_ATTACK, newAtk)
  end
  return newAtk, base, wt
end

-- ==========================
-- LOGICA PRINCIPAL
-- ==========================
function onUse(player, hammer, fromPosition, target, toPosition, isHotkey)
  -- valida martelo
  local hid = hammer:getId()
  local okHammer = false
  for i = 1, #REFINE.hammerIds do if REFINE.hammerIds[i] == hid then okHammer = true break end end
  if not okHammer then
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Use um martelo apropriado na bigorna.")
    return true
  end

  -- valida alvo e bigorna
  if not target or not target:isItem() then
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bata o martelo no item sobre a bigorna.")
    return true
  end
  if not isAnvilTile(toPosition) then
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Coloque o item sobre a bigorna para refinar.")
    return true
  end

  -- se o jogador estiver clicando diretamente no CRISTAL (quando ele esta por cima do item),
  -- avisa para colocar o cristal por baixo e bloqueia o refino
  if target:getId() == REFINE.items.cristalImpecavel then
    player:sendTextMessage(MESSAGE_STATUS_WARNING, "Coloque o cristal impecavel por baixo do item a ser refinado.")
    return true
  end

  -- (extra) se o topo do tile for o cristal e voce clicou na arma por baixo, tambem bloqueia
  do
    local tile = Tile(toPosition)
    local topUse = tile and tile.getTopUseItem and tile:getTopUseItem() or nil
    if topUse and topUse:isItem() and topUse:getId() == REFINE.items.cristalImpecavel and topUse ~= target then
      player:sendTextMessage(MESSAGE_STATUS_WARNING, "Coloque o cristal impecavel por baixo do item a ser refinado.")
      return true
    end
  end

  -- === UPGRADE DE MATERIAIS (apenas item de materia-prima no tile) ===
  do
    local up = MATERIAL_UPGRADES[target:getId()]
    if up then
      local total, _ = countItemOnTile(toPosition, target:getId())
      if total < up.need then
        player:sendTextMessage(MESSAGE_STATUS_WARNING,
          string.format("Precisa de pelo menos %dx %s sobre a bigorna (voce tem %d).",
            up.need, ItemType(target:getId()):getName(), total))
        return true
      end

      if consumeFromTile(toPosition, target:getId(), up.need) then
        Game.createItem(up.outId, up.outCount or 1, toPosition)
        toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
          string.format("Sucesso! Voce refinou %dx %s em %dx %s.",
            up.need, ItemType(target:getId()):getName(),
            up.outCount or 1, ItemType(up.outId):getName()))
      else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Falha ao consumir materiais no tile.")
      end
      return true
    end
  end

  -- vocacoes permitidas (miner 18–20 e 0)
  local vocId = (player:getVocation() and player:getVocation():getId()) or 0
  if not (REFINE.allowedVocations and REFINE.allowedVocations[vocId]) then
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas as promotions de miner podem refinar.")
    return true
  end

  -- obtem config por item/tipo
  local cfg = getConfigForItem(target)
  if not cfg then
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Este tipo de item ainda nao suporta refino.")
    return true
  end

  local cur = getRefLvl(target)
  if cur >= (cfg.maxLevel or 15) then
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ("Este item ja esta no maximo (+%d)."):format(cfg.maxLevel or 15))
    return true
  end

  local nextLvl = cur + 1
  local tiers = cfg.tiers or {}
  local tier = tiers[nextLvl]
  if not tier then
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nao ha configuracao de refino para este nivel.")
    return true
  end

  -- catalisador opcional sobre a bigorna
  local catalystOnTile = findItemOnTile(toPosition, REFINE.items.cristalImpecavel)

  -- preview
  local baseChance = (nextLvl <= (cfg.safeLevel or 0)) and 100 or (tier.chance or 100)
  local chance = catalystOnTile and 100 or computeChance(baseChance, player)
  local previewReq = fmtReqList(tier.req or {})
  if catalystOnTile and nextLvl > (cfg.safeLevel or 0) then
    player:sendTextMessage(MESSAGE_INFO_DESCR,
      ("Proximo: +%d | Chance: 100%% (Cristal Impecavel) | Precisa: %s")
        :format(nextLvl, previewReq))
  else
    player:sendTextMessage(MESSAGE_INFO_DESCR,
      ("Proximo: +%d | Chance: %d%% | Precisa: %s | Opcional: 1x %s para 100%%")
        :format(nextLvl, chance, previewReq, ItemType(REFINE.items.cristalImpecavel):getName()))
  end

  -- checagem de materiais (sem catalisador, ja que e opcional)
  if not hasAllRequirements(player, tier.req or {}) then
    local miss = missingRequirements(player, tier.req or {})
    for i = 1, #miss do
      local m = miss[i]
      player:sendTextMessage(MESSAGE_STATUS_WARNING,
        ("Falta: %dx %s (voce tem %d)")
          :format(m.need, ItemType(m.id):getName(), m.have))
    end
    return true
  end

  -- consome requisitos base
  if not consumeRequirements(player, tier.req or {}) then
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Falha ao consumir materiais.")
    return true
  end

  -- se houver catalisador sobre a bigorna e nao estivermos em nivel safe, consome e garante 100%
  local usedCatalyst = false
  if catalystOnTile and nextLvl > (cfg.safeLevel or 0) then
    catalystOnTile:remove(1)
    usedCatalyst = true
    chance = 100
  end

  -- rolagem (com downgrade configuravel)
  if math.random() * 100.0 <= chance then
    setRefLvl(target, nextLvl)

    local newAtk, baseAtk, wt = applyRefStats(target, nextLvl)

    if newAtk then
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
        string.format("Refino aplicado: base=%d -> novo Atk=%d (lvl=%d)", baseAtk or -1, newAtk or -1, nextLvl))
    else
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_YELLOW,
        "Aviso: este item nao foi reconhecido como sword/club/axe, bonus de Atk nao aplicado.")
    end

    toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
    if usedCatalyst then
      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ("Sucesso garantido pelo Cristal Impecavel! O item agora esta +%d."):format(nextLvl))
    else
      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ("Sucesso! O item agora esta +%d."):format(nextLvl))
    end
  else
    toPosition:sendMagicEffect(CONST_ME_POFF)
    toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)

    local doDowngrade = REFINE.behavior and REFINE.behavior.downgradeOnFail
    local floor       = (REFINE.behavior and REFINE.behavior.downgradeFloor) or 0

    if doDowngrade and cur > floor then
      local old = cur
      local newLvl = math.max(cur - 1, floor)

      setRefLvl(target, newLvl)
      local newAtk, baseAtk = applyRefStats(target, newLvl)

      player:sendTextMessage(
        MESSAGE_EVENT_ADVANCE,
        ("Falhou! O item perdeu 1 nivel: +%d -> +%d."):format(old, newLvl)
      )

      if newAtk then
        player:sendTextMessage(
          MESSAGE_STATUS_CONSOLE_BLUE,
          string.format("Atk ajustado: base=%d -> novo Atk=%d (lvl=%d)", baseAtk or -1, newAtk or -1, newLvl)
        )
      end
    else
      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Falhou, mas o item nao foi danificado.")
    end
  end

  return true
end
