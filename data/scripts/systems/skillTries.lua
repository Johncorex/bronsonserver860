local configBands = {
    [8850] = { -- item id que reduz skill tries
        reduceFactor = 0.5 -- Reduz pela metade (50%)
    }
}

local ec = EventCallback

ec.onGainSkillTries = function(self, skill, tries)
    -- Verifica se está segurando o item nas mãos
    local leftItem = self:getSlotItem(CONST_SLOT_LEFT)
    local rightItem = self:getSlotItem(CONST_SLOT_RIGHT)
    local itemId = leftItem and leftItem:getId() or rightItem and rightItem:getId()

    if itemId and configBands[itemId] then
        tries = math.floor(tries * configBands[itemId].reduceFactor) -- Reduz pela metade
    end

    return tries
end

ec:register(1)