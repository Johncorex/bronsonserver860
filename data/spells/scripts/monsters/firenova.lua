-- Fire Nova (seguro: sem callbacks e sem passar userdata/tables no addEvent)

-- ===================== ÁREAS (globais) =====================
AREAS = {}

AREAS.c0  = createCombatArea({
  {0,1,0},
  {1,2,1},
  {0,1,0}
})

AREAS.c3  = createCombatArea({
  {1,0,1},
  {0,2,0},
  {1,0,1}
})

AREAS.c5s = AREAS.c0

AREAS.c6  = createCombatArea({
  {0,1,1,1,0},
  {1,0,0,0,1},
  {1,0,2,0,1},
  {1,0,0,0,1},
  {0,1,1,1,0}
})

AREAS.c8s = AREAS.c3

AREAS.c9  = createCombatArea({
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,1,0,0,0,0,0,1,0},
  {1,0,0,0,2,0,0,0,1},
  {0,1,0,0,0,0,0,1,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,0,0,1,0,0,0,0}
})

AREAS.c11s = AREAS.c6

AREAS.c14s = createCombatArea({
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,1,1,1,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,1,0,0,0,0,0,1,0},
  {1,1,0,0,2,0,0,1,1},
  {0,1,0,0,0,0,0,1,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,1,1,1,0,0,0},
  {0,0,0,0,1,0,0,0,0}
})

-- ===================== PROJETÉIS (globais) =====================
EMIT = {}
EMIT.c0 = {CONST_ANI_FIRE, 0,1, 1,0, -1,0, 0,-1}
EMIT.c3 = {CONST_ANI_FIRE, 1,1, 1,-1, -1,-1, -1,1}
EMIT.c6 = {CONST_ANI_FIRE, 2,1, 2,0, 2,-1, 1,2, 0,2, -1,2, -2,1, -2,0, -2,-1, 1,-2, 0,-2, -1,-2, -2}
EMIT.c9 = {CONST_ANI_FIRE, 3,1, 4,0, 3,-1, -3,1, -4,0, -3,-1, 1,3, 0,4, -1,3, 1,-3, 0,-4, -1,-3}

-- ===================== EXECUÇÃO (GLOBAL) =====================
function fireNova_run(key, casterId, sx, sy, sz)
  -- garante que o caster ainda existe
  if not isCreature(casterId) then return end

  local area = AREAS[key]
  if not area then return end

  -- etapas de fumaça usam físico + poff; demais usam fogo + explosionhit
  local smoke = (key == "c5s" or key == "c8s" or key == "c11s" or key == "c14s")
  local dtype = smoke and COMBAT_PHYSICALDAMAGE or COMBAT_FIREDAMAGE
  local effect = smoke and CONST_ME_POFF or CONST_ME_EXPLOSIONHIT
  local min, max = (smoke and -550 or -700), (smoke and -800 or -900)

  local fromPos = {x = sx, y = sy, z = sz}

  -- dano em área (sem callbacks)
  doAreaCombatHealth(casterId, dtype, fromPos, area, min, max, effect)

  -- projéteis (se houver)
  local emit = EMIT[key]
  if emit then
    local proj = emit[1]
    local i = 2
    while i < #emit do
      doSendDistanceShoot(fromPos, {x = sx - emit[i], y = sy - emit[i+1], z = sz}, proj)
      i = i + 2
    end
  end
end

-- ===================== ENTRADA DA SPELL =====================
function onCastSpell(cid, var)
  -- em alguns forks 'cid' é objeto; sempre converte para id numérico
  local id = type(cid) == "number" and cid or cid:getId()

  local p = getCreaturePosition(id)
  if not p then return false end
  local sx, sy, sz = p.x, p.y, p.z

  -- chamada imediata
  fireNova_run("c0", id, sx, sy, sz)
  -- agendadas: apenas tipos primitivos (string + números) => sem 'unsafe'
  addEvent(fireNova_run,  300, "c3",   id, sx, sy, sz)
  addEvent(fireNova_run,  500, "c5s",  id, sx, sy, sz)
  addEvent(fireNova_run,  600, "c6",   id, sx, sy, sz)
  addEvent(fireNova_run,  800, "c8s",  id, sx, sy, sz)
  addEvent(fireNova_run,  900, "c9",   id, sx, sy, sz)
  addEvent(fireNova_run, 1100, "c11s", id, sx, sy, sz)
  addEvent(fireNova_run, 1400, "c14s", id, sx, sy, sz)
  return true
end
