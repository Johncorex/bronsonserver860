-- SAFE Spell (sem callbacks e sem argumentos "unsafe" no addEvent)
-- Mantém as mesmas áreas, efeitos e timings do script original.

-- ===================== ÁREAS (globais) =====================
AREAS = AREAS or {}

-- 0ms
AREAS.t0_xpl = createCombatArea({
  {1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1}
})

-- 400ms
AREAS.t4_fire = createCombatArea({
  {1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1}
})
AREAS.t4_xpl = createCombatArea({
  {1,0,0,0,0,0,0,0,0,0,0},
  {0,1,1,0,0,0,0,0,0,0,0},
  {0,0,0,1,1,0,0,0,0,0,0},
  {0,0,0,0,0,2,0,0,0,0,0},
  {0,0,0,0,0,0,1,1,0,0,0},
  {0,0,0,0,0,0,0,0,1,1,0},
  {0,0,0,0,0,0,0,0,0,0,1}
})

-- 800ms
AREAS.t8_fire = createCombatArea({
  {1,0,0,0,0,0,0,0,0,0,0},
  {0,1,1,0,0,0,0,0,0,0,0},
  {0,0,0,1,1,0,0,0,0,0,0},
  {0,0,0,0,0,2,0,0,0,0,0},
  {0,0,0,0,0,0,1,1,0,0,0},
  {0,0,0,0,0,0,0,0,1,1,0},
  {0,0,0,0,0,0,0,0,0,0,1}
})
AREAS.t8_xpl = createCombatArea({
  {1,0,0,0,0,0,0,0,0},
  {0,1,0,0,0,0,0,0,0},
  {0,0,1,0,0,0,0,0,0},
  {0,0,0,1,0,0,0,0,0},
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,0,2,0,0,0,0},
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,0,0,1,0,0,0},
  {0,0,0,0,0,0,1,0,0},
  {0,0,0,0,0,0,0,1,0},
  {0,0,0,0,0,0,0,0,1}
})

-- 1200ms
AREAS.t12_xpl = createCombatArea({
  {1},
  {1},
  {1},
  {1},
  {0},
  {2},
  {0},
  {1},
  {1},
  {1},
  {1}
})
AREAS.t12_fire = AREAS.t8_xpl  -- mesma matriz do bloco t8_xpl

-- 1600ms
AREAS.t16_fire = createCombatArea({
  {1},
  {1},
  {1},
  {1},
  {1},
  {2},
  {1},
  {1},
  {1},
  {1},
  {1}
})

-- 1700ms
AREAS.t17_xpl = createCombatArea({
  {0,0,0,0,0,0,1},
  {0,0,0,0,0,1,0},
  {0,0,0,0,0,1,0},
  {0,0,0,0,1,0,0},
  {0,0,0,0,1,0,0},
  {0,0,0,2,0,0,0},
  {0,0,1,0,0,0,0},
  {0,0,1,0,0,0,0},
  {0,1,0,0,0,0,0},
  {0,1,0,0,0,0,0},
  {1,0,0,0,0,0,0}
})

-- 2100ms
AREAS.t21_fire = AREAS.t17_xpl

-- 2200ms
AREAS.t22_xpl = createCombatArea({
  {0,0,0,0,0,0,0,0,0,0,1},
  {0,0,0,0,0,0,0,0,0,1,0},
  {0,0,0,0,0,0,0,0,1,0,0},
  {0,0,0,0,0,0,0,1,0,0,0},
  {0,0,0,0,1,2,1,0,0,0,0},
  {0,0,0,1,0,0,0,0,0,0,0},
  {0,0,1,0,0,0,0,0,0,0,0},
  {0,1,0,0,0,0,0,0,0,0,0},
  {1,0,0,0,0,0,0,0,0,0,0}
})

-- 2600ms
AREAS.t26_fire = AREAS.t22_xpl
AREAS.t26_xpl = createCombatArea({
  {1,1,1,1,0,2,0,1,1,1,1}
})

-- 3000ms
AREAS.t30_fire = createCombatArea({
  {1,1,1,1,1,2,1,1,1,1,1}
})

-- ===================== CONFIG POR ETAPA (globais) =====================
KEYCONF = KEYCONF or {
  -- key        dmgType                    effect
  t0_xpl   = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_EXPLOSIONAREA},
  t4_fire  = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE},
  t4_xpl   = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_EXPLOSIONAREA},
  t8_fire  = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE},
  t8_xpl   = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_EXPLOSIONAREA},
  t12_xpl  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_EXPLOSIONAREA},
  t12_fire = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE},
  t16_fire = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE},
  t17_xpl  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_EXPLOSIONAREA},
  t21_fire = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE},
  t22_xpl  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_EXPLOSIONAREA},
  t26_fire = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE},
  t26_xpl  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_EXPLOSIONAREA},
  t30_fire = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE},
}

-- ===================== EXECUÇÃO (GLOBAL) =====================
function waveSafe_run(key, casterId, sx, sy, sz)
  if not isCreature(casterId) then return end

  local conf = KEYCONF[key]; if not conf then return end
  local area = AREAS[key];   if not area then return end

  -- Dano padrão do seu script: -20 a -10 em todas as etapas
  local min, max = -1200, -800
  local fromPos = {x = sx, y = sy, z = sz}

  doAreaCombatHealth(casterId, conf.dtype, fromPos, area, min, max, conf.effect)
end

-- ===================== ENTRADA DA SPELL =====================
function onCastSpell(cid, var)
  local id = type(cid) == "number" and cid or cid:getId()
  local p = getCreaturePosition(id); if not p then return false end
  local sx, sy, sz = p.x, p.y, p.z

  -- imediata
  waveSafe_run("t0_xpl", id, sx, sy, sz)

  -- agendadas: só primitivos (string + números) => sem 'unsafe'
  addEvent(waveSafe_run,  400, "t4_fire",  id, sx, sy, sz)
  addEvent(waveSafe_run,  400, "t4_xpl",   id, sx, sy, sz)
  addEvent(waveSafe_run,  800, "t8_fire",  id, sx, sy, sz)
  addEvent(waveSafe_run,  800, "t8_xpl",   id, sx, sy, sz)
  addEvent(waveSafe_run, 1200, "t12_xpl",  id, sx, sy, sz)
  addEvent(waveSafe_run, 1200, "t12_fire", id, sx, sy, sz)
  addEvent(waveSafe_run, 1600, "t16_fire", id, sx, sy, sz)
  addEvent(waveSafe_run, 1700, "t17_xpl",  id, sx, sy, sz)
  addEvent(waveSafe_run, 2100, "t21_fire", id, sx, sy, sz)
  addEvent(waveSafe_run, 2200, "t22_xpl",  id, sx, sy, sz)
  addEvent(waveSafe_run, 2600, "t26_fire", id, sx, sy, sz)
  addEvent(waveSafe_run, 2600, "t26_xpl",  id, sx, sy, sz)
  addEvent(waveSafe_run, 3000, "t30_fire", id, sx, sy, sz)

  return true
end
