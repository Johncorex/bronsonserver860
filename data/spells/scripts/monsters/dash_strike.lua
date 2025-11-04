-- DASH STRIKE (FAST + SMOKE TRAIL)
-- Avança até 7 SQMs na direção do alvo. Se colidir: 2000 de dano + stun (paralyze 2s).
-- Visual: fumaça (SMALLCLOUDS) a cada passo.
-- Padrão SAFE: addEvent só com primitivos; recria objetos dentro do callback.

-- ===== Config =====
local MAX_STEPS      = 10          -- distância do dash
local STEP_DELAY_MS  = 20          -- menor = mais rápido (20~35 fica bem fluido)
local TRAIL_EFFECT   = CONST_ME_SMOKE
local HIT_EFFECT     = CONST_ME_EXPLOSIONHIT
local USE_TELEPORT_FALLBACK = true -- atravessa bloqueio se não der pra mover

-- ===== Helpers =====
local function dirTo(fromPos, toPos)
  local dx, dy = toPos.x - fromPos.x, toPos.y - fromPos.y
  if math.abs(dx) > math.abs(dy) then
    return (dx > 0) and EAST or WEST
  else
    return (dy > 0) and SOUTH or NORTH
  end
end

local function stepFrom(pos, dir)
  local nx, ny = pos.x, pos.y
  if dir == NORTH then ny = ny - 1
  elseif dir == SOUTH then ny = ny + 1
  elseif dir == EAST  then nx = nx + 1
  elseif dir == WEST  then nx = nx - 1
  end
  return {x = nx, y = ny, z = pos.z}
end

local function sameTile(a, b)
  return a.x == b.x and a.y == b.y and a.z == b.z
end

local function isWalkable(pos)
  local tile = Tile(pos)
  if not tile then return false end
  if tile:hasFlag(TILESTATE_BLOCKSOLID) then return false end
  if tile:getCreatureCount() > 0 then return false end
  return tile:getGround() ~= nil
end

-- ===== Hit / Stun =====
local function dashStrike_applyHit(caster, target)
  if not caster or not target then return end
  doTargetCombatHealth(caster, target, COMBAT_PHYSICALDAMAGE, -500, -800, HIT_EFFECT)

  -- “Stun” = paralyze forte por 2s
  local stun = Condition(CONDITION_PARALYZE)
  stun:setParameter(CONDITION_PARAM_TICKS, 2000)
  stun:setParameter(CONDITION_PARAM_SPEED, -800)
  target:addCondition(stun)

  -- já tem HIT_EFFECT no dano; opcional: efeito extra
  -- target:getPosition():sendMagicEffect(CONST_ME_POFF)
end

-- ===== Loop =====
function dashStrike_run(casterId, targetId, stepsLeft)
  local caster = Creature(casterId)
  local target = Creature(targetId)
  if not caster or not target then return end

  local cpos = caster:getPosition()
  local tpos = target:getPosition()
  if not cpos or not tpos or cpos.z ~= tpos.z then return end
  if stepsLeft <= 0 then return end

  -- Efeito de rastro no tile atual
  cpos:sendMagicEffect(TRAIL_EFFECT)

  local dir = dirTo(cpos, tpos)
  local nextPos = stepFrom(cpos, dir)

  -- colisão no próximo passo?
  if sameTile(nextPos, tpos) then
    dashStrike_applyHit(caster, target)
    return
  end

  -- tenta mover; fallback teleporta (opcional)
  local moved = false
  if doMoveCreature then
    moved = doMoveCreature(casterId, dir)
  end
  if (not moved) and USE_TELEPORT_FALLBACK and isWalkable(nextPos) then
    caster:teleportTo(Position(nextPos.x, nextPos.y, nextPos.z), true)
    moved = true
  end

  if not moved then
    -- parede/obstáculo: termina o dash
    return
  end

  -- Efeito de rastro também no tile recém-ocupado (mais “visível”)
  caster:getPosition():sendMagicEffect(TRAIL_EFFECT)

  addEvent(dashStrike_run, STEP_DELAY_MS, casterId, targetId, stepsLeft - 1)
end

function onCastSpell(creature, var)
  local target = creature:getTarget()
  if not target then return false end
  addEvent(dashStrike_run, 0, creature:getId(), target:getId(), MAX_STEPS)
  return true
end
