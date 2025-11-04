local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end

local config = {
    attackRadius = {x = 7, y = 5, targetDistance = 2, walkDistance = 7},
    strCastle   = 190,
    attackMonster = {value = true, ignore = {"Rat", "Cave Rat"}, ignoreSummon = true},
    damageValue = {min = 10, max = 20}
}

local targetId = 0
local masterPosition

-- Assuming you have a function to check if a position is in the ZONE_PROTECTION
local function isInProtectionZone(position)
    -- Implement your ZONE_PROTECTION check logic here
    -- return true if the position is within the protection zone, false otherwise
    return false
end

function Creature.isAttackable(self)
    if not self:isNpc() then
        local position = self:getPosition()

        -- Check if the player is in the protection zone
        if self:isPlayer() and not self:getGroup():getAccess() then
            if isInProtectionZone(position) then
                return false
            end

            if self:getStorageValue(config.strCastle) < 0 then
                return true
            end
        end

        if self:isMonster() and config.attackMonster.value then
            local master = self:getMaster()
            if (config.attackMonster.ignoreSummon and master and not master:isPlayer()) or not isInArray(config.attackMonster.ignore, self:getName()) then
                return true
            end
        end
    end

    return false
end

function Npc.searchTarget(self)
    local attackRadius = config.attackRadius
    for _, spectator in ipairs(Game.getSpectators(self:getPosition(), false, false, attackRadius.x, attackRadius.x, attackRadius.y, attackRadius.y)) do
        if spectator:isAttackable() then
            targetId = spectator:getId()
        end
    end
end

function onThink()
    local npc = Npc()
    local target = Creature(targetId)

    if not target then
        npc:searchTarget()
        return
    end

    local npcPosition = npc:getPosition()
    local targetPosition = target:getPosition()
    local offsetX = npcPosition.x - targetPosition.x
    local offsetY = npcPosition.y - targetPosition.y

    local radius = config.attackRadius
    if math.abs(offsetX) > radius.x or math.abs(offsetY) > radius.y then
        npc:searchTarget()
        return
    end

    if npcPosition:getDistance(masterPosition) >= radius.walkDistance then
        npcPosition:sendMagicEffect(CONST_ME_TELEPORT)
        npc:teleportTo(masterPosition)
        return
    end

    local npcId = npc:getId()
    doTargetCombatHealth(npcId, targetId, COMBAT_FIREDAMAGE, -config.damageValue.min, -config.damageValue.max, CONST_ME_HITBYFIRE)
    npcPosition:sendDistanceEffect(targetPosition, CONST_ANI_FIRE)
    doNpcSetCreatureFocus(targetId)
    npcHandler:onThink()                    
end

function onCreatureAppear(self)
    if self == Npc() and not masterPosition then
        masterPosition = self:getPosition()
    end
       
    npcHandler:onCreatureAppear(self)         
end
