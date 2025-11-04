-- Click-to-convert com proporcao 100:1

local CONV = {
    -- 8299 <-> 10609
    [8299]  = {toId = 10609, need = 1, give = 100},   -- 100x 8299 -> 1x 10609
    [10609] = {toId = 8299,  need = 100,   give = 1}, -- 1x   10609 -> 100x 8299

    -- 5880 <-> 5887
    [5880]  = {toId = 5887,  need = 100, give = 1},   -- 100x 5880 -> 1x 5887
    [5887]  = {toId = 5880,  need = 1,   give = 100}, -- 1x   5887 -> 100x 5880
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local rule = CONV[item.itemid]
    if not rule then
        return false
    end

    -- Para itens empilhaveis, item.type e a quantidade (1..100). Para nao-empilhaveis, retorna 0.
    local count = (item.type and item.type > 0) and item.type or 1

    -- Exigimos a quantidade exata (100 ou 1, conforme regra)
    if count ~= rule.need then
        local needName = ItemType(item.itemid):getName()
        player:sendCancelMessage("Precisa de " .. rule.need .. "x " .. needName .. " para converter.")
        return true
    end

    -- Converte no mesmo slot:
    -- - Se destino for empilhavel, define a pilha com 'give' (ex.: 100).
    -- - Se destino nao for empilhavel, 'give' = 1 (ignorado para nao-empilhaveis).
    item:transform(rule.toId, rule.give)
    return true
end
