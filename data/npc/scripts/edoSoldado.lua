function onThingMove(creature, thing, oldpos, oldstackpos)

end

function onCreatureAppear(creature)

end

function onCreatureDisappear(cid, pos)

end

function onCreatureTurn(creature)

end

function onCreatureChangeOutfit(creature)

end
 
function onCreatureSay(cid, type, msg)

end

function onThink()

cx, cy, cz = selfGetPosition()
randmove = math.random(1,80)

if cy <= 980 then
randmove = 3
elseif cy >= 988 then
randmove = 4
elseif cx <= 1062 then
randmove = 1
elseif cx >= 1068 then
randmove = 2
end

if randmove == 1 then
nx = cx + 1
elseif randmove == 2 then
nx = cx - 1
elseif randmove == 3 then
ny = cy + 1
elseif randmove == 4 then
ny = cy - 1
elseif randmove >= 5 then
nx = cx
ny = cy
end

moveToPosition(nx, ny, cz)

end
