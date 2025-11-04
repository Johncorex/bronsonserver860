-- Saque do banco para moedas na mochila (ou no chao se faltar espaco) - formato legado onSay
-- Config
local REQUIRE_PZ = false         -- true = so permite em PZ
local REQUIRE_PREMIUM = true     -- true = somente premium pode usar

local COIN = { gold = 2148, plat = 2152, cryst = 2160 }

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

    param = (param or ""):gsub("%s+", "")
    if param == "" then
        player:sendCancelMessage("Uso: !sacar <quantia>|all|tudo")
        return false
    end

    local amount
    local lower = param:lower()
    if lower == "all" or lower == "tudo" then
        amount = player:getBankBalance()
    else
        amount = math.floor(tonumber(param) or 0)
    end

    if amount <= 0 then
        player:sendCancelMessage("Quantia invalida.")
        return false
    end

    local bank = player:getBankBalance()
    if amount > bank then
        player:sendCancelMessage("Voce nao tem gold suficiente no banco.")
        return false
    end

    -- Quebra em moedas
    local c = math.floor(amount / 10000)
    local r = amount % 10000
    local p = math.floor(r / 100)
    local g = r % 100

    local pos = player:getPosition()

    local function give(id, count)
        if count <= 0 then return end
        local ok = player:addItem(id, count)
        if not ok then
            Game.createItem(id, count, pos) -- fallback no chao
        end
    end

    give(COIN.cryst, c)
    give(COIN.plat, p)
    give(COIN.gold, g)

    player:setBankBalance(bank - amount)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
        "Voce sacou %d gold: +%d crystal, +%d platinum, +%d gold.",
        amount, c, p, g
    ))
    pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
    return true
end
