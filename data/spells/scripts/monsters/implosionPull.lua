-- SAFE Spell: sem callbacks e sem argumentos "unsafe" no addEvent
-- Mantém as mesmas áreas, efeitos e timings do script original.

-- ===================== ÁREAS (namespaced) =====================
SMHF_AREAS = {}

-- 0ms (smoke)
SMHF_AREAS.k0_smoke = createCombatArea({
  {1,1,1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,2,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1,1,1}
})

-- 200ms (smoke)
SMHF_AREAS.k2_smoke = createCombatArea({
  {1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,1},
  {1,0,0,0,2,0,0,0,1},
  {1,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1}
})

-- 400ms (smoke)
SMHF_AREAS.k4_smoke = createCombatArea({
  {1,1,1,1,1,1,1},
  {1,0,0,0,0,0,1},
  {1,0,0,0,0,0,1},
  {1,0,0,2,0,0,1},
  {1,0,0,0,0,0,1},
  {1,0,0,0,0,0,1},
  {1,1,1,1,1,1,1}
})

-- 600ms (smoke)
SMHF_AREAS.k6_smoke = createCombatArea({
  {1,1,1,1,1},
  {1,0,0,0,1},
  {1,0,2,0,1},
  {1,0,0,0,1},
  {1,1,1,1,1}
})

-- 800ms (smoke)
SMHF_AREAS.k8_smoke = createCombatArea({
  {1,1,1},
  {1,2,1},
  {1,1,1}
})

-- 1000ms (HellFire)
SMHF_AREAS.k10_hell = createCombatArea({ {3} })

-- 1200ms (HellFire)
SMHF_AREAS.k12_hell = createCombatArea({
  {0,1,0},
  {1,2,1},
  {0,1,0}
})

-- 1500ms (HellFire + fireAttack)
SMHF_AREAS.k15_hell = createCombatArea({
  {0,0,1,0,0},
  {0,1,0,1,0},
  {1,0,2,0,1},
  {0,1,0,1,0},
  {0,0,1,0,0}
})
SMHF_AREAS.k15_fatk = createCombatArea({ {3} })

-- 1800ms (HellFire)
SMHF_AREAS.k18_hell = createCombatArea({
  {0,0,0,1,0,0,0},
  {0,0,1,0,1,0,0},
  {0,1,0,0,0,1,0},
  {1,0,0,2,0,0,1},
  {0,1,0,0,0,1,0},
  {0,0,1,0,1,0,0},
  {0,0,0,1,0,0,0}
})

-- 2100ms (HellFire)
SMHF_AREAS.k21_hell = createCombatArea({
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,1,0,0,0,1,0,0},
  {0,1,0,0,0,0,0,1,0},
  {1,0,0,0,2,0,0,0,1},
  {0,1,0,0,0,0,0,1,0},
  {0,0,1,0,0,0,1,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,0,0,1,0,0,0,0}
})

-- 2500ms (fireAttack)
SMHF_AREAS.k25_fatk = createCombatArea({
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,1,0,0,0,1,0,0},
  {0,1,0,0,0,0,0,1,0},
  {1,0,0,0,2,0,0,0,1},
  {0,1,0,0,0,0,0,1,0},
  {0,0,1,0,0,0,1,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,0,0,1,0,0,0,0}
})

-- 3100ms (smoke)
SMHF_AREAS.k31_smoke = SMHF_AREAS.k25_fatk

-- ===================== CONFIG POR KEY (dtype/effect/dano) =====================
SMHF_KEYCONF = {
  -- smoke (POFF + físico)
  k0_smoke  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_POFF,        min = -20,  max = -19},
  k2_smoke  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_POFF,        min = -40,  max = -39},
  k4_smoke  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_POFF,        min = -80,  max = -79},
  k6_smoke  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_POFF,        min = -150,  max = -149},
  k8_smoke  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_POFF,        min = -300,  max = -299},
  k31_smoke = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_POFF,        min = -20,  max = -10},

  -- HellFire (HITBYFIRE + fogo) 1200~1600
  k10_hell  = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE,   min = -1600, max = -1500},
  k12_hell  = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE,   min = -1500, max = -1400},
  k15_hell  = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE,   min = -1400, max = -1300},
  k18_hell  = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE,   min = -1300, max = -1200},
  k21_hell  = {dtype = COMBAT_FIREDAMAGE,     effect = CONST_ME_HITBYFIRE,   min = -1100, max = -1000},

  -- fireAttack (FIREATTACK + físico)
  k15_fatk  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_FIREATTACK,  min = -100,  max = -90},
  k25_fatk  = {dtype = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_FIREATTACK,  min = -100,  max = -90},
}

-- ====== CONFIG DO PULL (ajuste o alcance se quiser) ======
local PULL_RANGE_X, PULL_RANGE_Y = 8, 6  -- raio de busca (x/y)

-- Puxa players 1 tile em direção ao boss
function SMHF_pullPlayersToward(casterId, sx, sy, sz)
  local center = {x = sx, y = sy, z = sz}
  -- pega só players, no mesmo piso; ajuste multifloor se quiser
  local specs = getSpectators(center, false, true, PULL_RANGE_X, PULL_RANGE_Y)
  if type(specs) ~= "table" then return end

  for i = 1, #specs do
    local pid = specs[i]
    if pid ~= casterId and isPlayer(pid) then
      local ppos = getCreaturePosition(pid)
      if ppos and (ppos.z == sz) and not (ppos.x == sx and ppos.y == sy) then
        local dx, dy = sx - ppos.x, sy - ppos.y
        local dir
        -- escolhe o eixo com maior distância para aproximar 1 tile
        if math.abs(dx) >= math.abs(dy) then
          if dx > 0 then dir = EAST elseif dx < 0 then dir = WEST end
        else
          if dy > 0 then dir = SOUTH elseif dy < 0 then dir = NORTH end
        end
        if dir then
          doMoveCreature(pid, dir)  -- respeita colisão; se bloqueado, não move
        end
      end
    end
  end
end

-- ===================== EXECUÇÃO (GLOBAL & SAFE) =====================
function SMHF_run(key, casterId, sx, sy, sz)
  if not isCreature(casterId) then return end
  if key == "k0_smoke" then
    SMHF_pullPlayersToward(casterId, sx, sy, sz)
  end
  if key == "k2_smoke" then
    SMHF_pullPlayersToward(casterId, sx, sy, sz)
  end
  local conf = SMHF_KEYCONF[key]; if not conf then return end
  local area = SMHF_AREAS[key];   if not area then return end

  local fromPos = {x = sx, y = sy, z = sz}
  doAreaCombatHealth(casterId, conf.dtype, fromPos, area, conf.min, conf.max, conf.effect)
end

-- ===================== ENTRADA DA SPELL =====================
function onCastSpell(cid, var)
  local id = type(cid) == "number" and cid or cid:getId()
  local p = getCreaturePosition(id); if not p then return false end
  local sx, sy, sz = p.x, p.y, p.z

  -- imediata
  SMHF_run("k0_smoke", id, sx, sy, sz)

  -- agendadas: apenas strings/números (sem unsafe)
  addEvent(SMHF_run,  200, "k2_smoke", id, sx, sy, sz)
  addEvent(SMHF_run,  400, "k4_smoke", id, sx, sy, sz)
  addEvent(SMHF_run,  600, "k6_smoke", id, sx, sy, sz)
  addEvent(SMHF_run,  800, "k8_smoke", id, sx, sy, sz)
  addEvent(SMHF_run, 1000, "k10_hell", id, sx, sy, sz)
  addEvent(SMHF_run, 1200, "k12_hell", id, sx, sy, sz)
  addEvent(SMHF_run, 1500, "k15_hell", id, sx, sy, sz)
  addEvent(SMHF_run, 1500, "k15_fatk", id, sx, sy, sz)
  addEvent(SMHF_run, 1800, "k18_hell", id, sx, sy, sz)
  addEvent(SMHF_run, 2100, "k21_hell", id, sx, sy, sz)
  addEvent(SMHF_run, 2500, "k25_fatk", id, sx, sy, sz)
  addEvent(SMHF_run, 3100, "k31_smoke", id, sx, sy, sz)
  return true
end
