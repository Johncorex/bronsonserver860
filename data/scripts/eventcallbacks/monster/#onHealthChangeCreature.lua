local eventCallback = EventCallback

function eventCallback.onSpawn(creature, position, startup, artificial)
    -- Registra apenas para monstros
    if creature:isMonster() then
        creature:registerEvent("monsterHealthChange") -- Substitua pelo nome do seu evento
    end
    return true
end

-- Registra o callback com prioridade adequada
eventCallback:register(-666)