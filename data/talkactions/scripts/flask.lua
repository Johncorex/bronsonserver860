local vials = {7634, 7635, 7636} -- IDs das flasks que serão removidas

function removePlayerVials(cid)
    local player = Player(cid)
    if not player then
        return
    end

    if player:getStorageValue(FLASK_REMOVER_STORAGE) < 1 then
        return
    end

    for i = 1, #vials do
        local vial = vials[i]
        local count = player:getItemCount(vial)
        if count > 0 then
            player:removeItem(vial, count)
        end
    end

    addEvent(removePlayerVials, 1000, player:getId())
end

function onSay(player, words, param)
    if player:getStorageValue(FLASK_REMOVER_STORAGE) < 1 then
        player:setStorageValue(FLASK_REMOVER_STORAGE, 1)
        player:sendCancelMessage("Flask Ativado.")
        removePlayerVials(player:getId())
    else
        player:setStorageValue(FLASK_REMOVER_STORAGE, 0)
        player:sendCancelMessage("Flask Desativado.")
    end

    return false
end
