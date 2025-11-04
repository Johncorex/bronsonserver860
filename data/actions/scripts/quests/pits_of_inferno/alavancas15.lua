local text = {
  [1]='primeira',[2]='segunda',[3]='terceira',[4]='quarta',[5]='quinta',
  [6]='sexta',[7]='setima',[8]='oitava',[9]='nona',[10]='decima',
  [11]='decima primeira',[12]='decima segunda',[13]='decima terceira',[14]='decima quarta',[15]='decima quinta'
}

local stonePositions = {
  Position(1423, 672, 12),
  Position(1424, 672, 12)
}

-- CONFIG DE UIDs
local FIRST_UID     = 6608    -- primeira da sequência
local LAST_SEQ_UID  = 6622    -- última da sequência (antes da final)
local FINAL_UID     = 6623    -- alavanca final
local TOTAL_SEQ     = (LAST_SEQ_UID - FIRST_UID + 1) -- 14 (mantendo seu layout atual)

local STORAGE_LEVERS = 10000  -- storage global do contador
local REVERT_MS = 20 * 60 * 1000 -- 20 minutos

local function createStones()
  for i = 1, #stonePositions do
    local stone = Tile(stonePositions[i]):getItemById(1304)
    if not stone then
      Game.createItem(1304, 1, stonePositions[i])
    end
  end
  Game.setStorageValue(STORAGE_LEVERS, 0)
end

local function revertLever(position)
  local leverItem = Tile(position):getItemById(1946)
  if leverItem then
    leverItem:transform(1945)
  end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
  if item.itemid ~= 1945 then
    return false
  end

  -- contador sempre numérico
  local leverCount = Game.getStorageValue(STORAGE_LEVERS)
  if leverCount == nil or leverCount < 0 then
    leverCount = 0
  end

  -- Alavancas da sequência (corretas)
  if item.uid >= FIRST_UID and item.uid <= LAST_SEQ_UID then
    local number = item.uid - FIRST_UID + 1 -- FIRST_UID=1, ... LAST_SEQ_UID=TOTAL_SEQ
    if leverCount + 1 ~= number then
      -- Puxou na ordem errada: só avisa, não vira a alavanca e não mexe no contador
      player:say('Voce puxou a alavanca errada. Procure a proxima!', TALKTYPE_MONSTER_SAY)
      return true
    end

    -- Correta: avança contador, dá mensagem, vira a alavanca e agenda retorno em 20 min
    Game.setStorageValue(STORAGE_LEVERS, number)

    local label = text[number] or (tostring(number) .. 'a')
    player:say('Voce puxou a ' .. label .. ' alavanca. Corra e encontre a proxima!', TALKTYPE_MONSTER_SAY, false, player, toPosition)

    item:transform(1946)
    addEvent(revertLever, REVERT_MS, toPosition)
    return true
  end

  -- Alavanca final
  if item.uid == FINAL_UID then
    if leverCount ~= TOTAL_SEQ then
      player:say('A ultima alavanca ainda nao quer descer...', TALKTYPE_MONSTER_SAY)
      return true
    end

    -- Remove as pedras e agenda recriacao em 20 min
    for i = 1, #stonePositions do
      local stone = Tile(stonePositions[i]):getItemById(1304)
      if stone then
        stone:remove()
        stonePositions[i]:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
      end
    end

    addEvent(createStones, REVERT_MS)

    item:transform(1946)
    addEvent(revertLever, REVERT_MS, toPosition)
    return true
  end

  -- Qualquer outra alavanca com esse script
  return false
end
