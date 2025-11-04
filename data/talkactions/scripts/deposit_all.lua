-- Deposita TODAS as moedas da mochila no banco (formato legado onSay)
-- Config
local REQUIRE_PZ = false         -- true = so permite em PZ
local REQUIRE_PREMIUM = true     -- true = somente premium pode usar

local COIN = { gold = 2148, plat = 2152, cryst = 2160 }
local VALUE = { [2148] = 1, [2152] = 100, [2160] = 10000 }

local function inPZ(player)
    local tile = Tile(player:getPosition())
    return tile and tile:hasFlag(TILESTATE_PROTECTIONZONE)
end

local function hasPremium(player)
    if player.isPremium then
        return player:isPremium()
    elseif player.getPremiumDays then
        return player:getPremiumDays() > 0
    end
    return true -- fallback: se o servidor nao usa premium, libera
end

function onSay(player, words, param)
    if REQUIRE_PREMIUM and not hasPremium(player) then
        player:sendCancelMessage("Apenas contas premium podem usar este comando.")
        return false
    end

    if REQUIRE_PZ and not inPZ(player) then
        player:sendCancelMessage("Voce precisa estar em Protection Zone.")
        return false
    end

    local g = player:getItemCount(COIN.gold)
    local p = player:getItemCount(COIN.plat)
    local c = player:getItemCount(COIN.cryst)

    local total = (g * VALUE[COIN.gold]) + (p * VALUE[COIN.plat]) + (c * VALUE[COIN.cryst])
    if total == 0 then
        player:sendCancelMessage("Voce nao possui moedas.")
        return false
    end

    if g > 0 then player:removeItem(COIN.gold, g) end
    if p > 0 then player:removeItem(COIN.plat, p) end
    if c > 0 then player:removeItem(COIN.cryst, c) end

    player:setBankBalance(player:getBankBalance() + total)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Voce depositou %d gold no banco.", total))
    return true
end
