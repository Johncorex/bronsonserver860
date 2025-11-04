-- forge_hammer.lua
-- Usa Iron Hammer (2422) na bigorna 1486 (AID 46002) para converter pilhas do tile.
-- 100x 5880 -> 1x 5887 ; 100x 10609 -> 1x 8299

local ANVIL_ID       = 1484
local ANVIL_ACTIONID = 46002
local HAMMER_ID      = 2422 -- Iron Hammer

local EFFECT_PLAYER_OK = CONST_ME_MAGIC_GREEN
local EFFECT_TILE_OK   = CONST_ME_HITAREA
local EFFECT_FAIL      = CONST_ME_POFF

local RECIPES = {
  [5880]  = { need = 100, out = 5887, label = "liga de ferro" },
  [10609] = { need = 100, out = 8299, label = "carvao fundido" },
}

local function countOnTile(tile)
  local counts = {}
  local items = tile:getItems() or {}
  for _, it in ipairs(items) do
    local id = it:getId()
    if RECIPES[id] then
      counts[id] = (counts[id] or 0) + (it:getCount() or 1)
    end
  end
  return counts
end

local function removeFromTile(tile, itemId, amount)
  if amount <= 0 then return 0 end
  local removed = 0
  local items = tile:getItems() or {}
  for _, it in ipairs(items) do
    if removed >= amount then break end
    if it:getId() == itemId then
      local stack = it:getCount()
      local take = math.min(stack, amount - removed)
      if take > 0 then
        if it:remove(take) then
          removed = removed + take
        end
      end
    end
  end
  return removed
end

function onUse(player, hammer, fromPos, target, toPos, isHotkey)
  -- Confere se é Iron Hammer usado na bigorna correta
  if hammer.itemid ~= HAMMER_ID then
    return false
  end
  if not target or target.itemid ~= ANVIL_ID or target.actionid ~= ANVIL_ACTIONID then
    player:sendCancelMessage("Use o martelo na bigorna correta.")
    toPos:sendMagicEffect(EFFECT_FAIL)
    return true
  end

  local tile = Tile(toPos)
  if not tile then
    player:sendCancelMessage("Nao foi possivel acessar o tile.")
    toPos:sendMagicEffect(EFFECT_FAIL)
    return true
  end

  -- 1) Contabiliza materiais no tile
  local totals = countOnTile(tile)

  -- 2) Calcula quantos lotes por receita
  local batchesMade = {}
  local totalBatchesAll = 0
  for id, info in pairs(RECIPES) do
    local have = totals[id] or 0
    local batches = math.floor(have / info.need)
    if batches > 0 then
      batchesMade[id] = batches
      totalBatchesAll = totalBatchesAll + batches
    end
  end

  if totalBatchesAll == 0 then
    player:sendCancelMessage("Nao ha materiais suficientes na bigorna.")
    toPos:sendMagicEffect(EFFECT_FAIL)
    return true
  end

  -- 3) Remove do tile o necessario e cria resultados
  for id, batches in pairs(batchesMade) do
    local info = RECIPES[id]
    local need = batches * info.need
    local removed = removeFromTile(tile, id, need)
    if removed < need then
      -- Falha parcial improvavel (concorrencia). Ajusta batches pra removido real.
      batches = math.floor(removed / info.need)
    end
    if batches > 0 then
      -- Cria resultados no tile da bigorna
      Game.createItem(info.out, batches, toPos)
    end
  end

  -- 4) Feedback
  player:getPosition():sendMagicEffect(EFFECT_PLAYER_OK)
  toPos:sendMagicEffect(EFFECT_TILE_OK)

  -- Mensagem resumida
  local parts = {}
  for id, b in pairs(batchesMade) do
    if b > 0 then
      table.insert(parts, string.format("%dx %s", b, RECIPES[id].label))
    end
  end
  if #parts > 0 then
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Conversao concluida: " .. table.concat(parts, ", ") .. ".")
  end

  return true
end
