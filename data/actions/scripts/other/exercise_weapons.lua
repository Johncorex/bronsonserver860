---@ Create by Sarah Wesker | Tested Version: TFS 0.4
---@ list of training dummies.
local dummies = {
    [5787] = { skillRate = 20, skillSpeed = 1 },
    [5788] = { skillRate = 20, skillSpeed = 1 }
}

---@ Global training parameters of the system.
local staminaTries = 1 --# on minutes
local skillTries = 10 --# tries by blow
local skillSpent = function() return math.random(650, 750) end --# mana consumed by blow
local slotForUse = CONST_SLOT_LEFT

---@ list of weapons to train.
local weapons = {
    [7754] = { shootDistEffect = CONST_ANI_FIRE, skillType = SKILL_MAGLEVEL }, -- magicLevel Sor
    [7879] = { shootDistEffect = CONST_ANI_ENERGY, skillType = SKILL_MAGLEVEL }, -- magicLevel Sor
    [7753] = { shootDistEffect = CONST_ANI_FLAMMINGARROW, skillType = SKILL_DISTANCE }, -- distance
    [7878] = { shootDistEffect = CONST_ANI_FLASHARROW, skillType = SKILL_DISTANCE }, -- distance    	
    [7744] = { shootEffect = CONST_ME_BLOCKHIT, skillType = SKILL_SWORD }, -- sword
    [7869] = { shootEffect = CONST_ME_BLOCKHIT, skillType = SKILL_SWORD }, -- sword	
    [7750] = { shootEffect = CONST_ME_BLOCKHIT, skillType = SKILL_AXE }, -- axe
    [7875] = { shootEffect = CONST_ME_BLOCKHIT, skillType = SKILL_AXE }, -- axe	
    [7755] = { shootEffect = CONST_ME_BLOCKHIT, skillType = SKILL_CLUB }, -- club
    [7880] = { shootEffect = CONST_ME_BLOCKHIT, skillType = SKILL_CLUB } -- club
}

-- Global table to track training events (replaces missing functions)
if not EXERCISE_TRAINING then
    EXERCISE_TRAINING = {}
end

-- Helper functions to replace missing getPlayerExerciseTrain and setPlayerExerciseTrain
local function getPlayerExerciseTrain(cid)
    return EXERCISE_TRAINING[cid]
end

local function setPlayerExerciseTrain(cid, eventId)
    if eventId then
        EXERCISE_TRAINING[cid] = eventId
    else
        EXERCISE_TRAINING[cid] = nil
    end
    return true
end

---@ local training function.
local function exerciseDummyTrainEvent(params, weapon)
    if isPlayer(params.cid) then
        -- Simple validation - just check if player moved or changed weapon
        if getDistanceBetween(getCreaturePosition(params.cid), params.currentPos) > 0 then
            doPlayerSendTextMessage(params.cid, MESSAGE_EVENT_ADVANCE, "You moved from your training position.")
            return setPlayerExerciseTrain(params.cid, nil)
        end

        local item = getPlayerSlotItem(params.cid, slotForUse)
        local playerPosition = getCreaturePosition(params.cid)

        -- Check if player is still online
        if not isPlayer(params.cid) then
            return setPlayerExerciseTrain(params.cid, nil)
        end

        -- Check active train
        if getDistanceBetween(playerPosition, params.currentPos) == 0 and item.itemid == params.itemid then

            local weaponCharges = 0
            if item.uid > 0 then
                local itemObj = Item(item.uid)
                if itemObj and itemObj:hasAttribute(ITEM_ATTRIBUTE_CHARGES) then
                    weaponCharges = itemObj:getAttribute(ITEM_ATTRIBUTE_CHARGES)
                else
                    weaponCharges = getItemInfo(params.itemid).charges or 1000
                end
            end
            local reloadMs = 1000 * params.dummy.skillSpeed -- Fixed 2 second base attack speed
            
            if weaponCharges and weaponCharges >= 1 then
                -- Decrease charges using modern TFS syntax
                local itemObj = Item(item.uid)
                if itemObj and itemObj:hasAttribute(ITEM_ATTRIBUTE_CHARGES) then
                    itemObj:setAttribute(ITEM_ATTRIBUTE_CHARGES, weaponCharges - 1)
                end
                if weapon.shootDistEffect then 
                    doSendDistanceShoot(playerPosition, params.dummyPos, weapon.shootDistEffect) 
                end
                if weapon.shootEffect then 
                    doSendMagicEffect(params.dummyPos, weapon.shootEffect) 
                end
                
                if weapon.skillType == SKILL_MAGLEVEL then
                    doPlayerAddSpentMana(params.cid, (skillSpent() * params.dummy.skillRate) * 1.0) -- Fixed magic rate
                else
                    doPlayerAddSkillTry(params.cid, weapon.skillType, (skillTries * params.dummy.skillRate) * 1.0) -- Fixed skill rate
                end
                
                if weaponCharges <= 1 then
                    local itemObj = Item(item.uid)
                    if itemObj then
                        itemObj:remove()
                    end
                    doPlayerSendTextMessage(params.cid, MESSAGE_EVENT_ADVANCE, "Your exercise weapon has expired, therefore your training too.")
                    return setPlayerExerciseTrain(params.cid, nil)
                else
                    setPlayerExerciseTrain(params.cid, addEvent(exerciseDummyTrainEvent, reloadMs, params, weapon))
                end
                return true
            else
                local itemObj = Item(item.uid)
                if itemObj then
                    itemObj:remove()
                end
                doPlayerSendTextMessage(params.cid, MESSAGE_EVENT_ADVANCE, "Your exercise weapon has expired, therefore your training too.")
            end
        else
            doPlayerSendTextMessage(params.cid, MESSAGE_EVENT_ADVANCE, "You have finished your training.")
        end
    end
    return setPlayerExerciseTrain(params.cid, nil)
end

function onUse(cid, item, fromPos, target, toPos, isHotkey)
    local ammo = getPlayerSlotItem(cid, slotForUse)
    if ammo.uid ~= item.uid then
        return doPlayerSendCancel(cid, "The weapon must be located in your left hand.")
    end
    
    if not target then
        return doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
    end
    
    local playerPosition = getCreaturePosition(cid)
    if not getTileInfo(playerPosition).protection then
        return doPlayerSendCancel(cid, "You can only train in protection zone.")
    end
    
    local dummy = dummies[target.itemid]
    local weapon = weapons[item.itemid]
    if not weapon or not dummy then
        return doPlayerSendDefaultCancel(cid, RETURNVALUE_CANNOTUSETHISOBJECT)
    end
    
    local dummyPosition = {x = toPos.x, y = toPos.y, z = toPos.z}
    if getDistanceBetween(playerPosition, dummyPosition) > 6 then
        return doPlayerSendDefaultCancel(cid, RETURNVALUE_THEREISNOWAY)
    end
    
    if not getPlayerExerciseTrain(cid) then
        local params = {}
        params.cid = cid
        params.currentPos = playerPosition
        params.dummyPos = toPos
        params.itemid = item.itemid
        params.dummy = dummy
        params.dummyId = target.itemid
        exerciseDummyTrainEvent(params, weapon)
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You have started training with dummy.")
    else
        doPlayerSendCancel(cid, "You can not train")
    end
    return true
end