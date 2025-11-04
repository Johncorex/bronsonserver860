-- TalkAction !bless para checar blessings do jogador
local blessings = {
    [1] = "Spiritual Shielding",
    [2] = "Embrace of the World",
    [3] = "Fire of the Suns",
    [4] = "Spark of the Phoenix",
    [5] = "Wisdom of Solitude",
    [6] = "Twist of Fate",
    [7] = "Guardians of Fate",
    [8] = "Heart of the Mountain"
}

function onSay(player, words, param)
    if not player then
        return true
    end
    
    local playerName = player:getName()
    local blessStatus = {}
    local blessCount = 0
    
    -- Verifica cada blessing de forma segura
    for i = 1, 8 do
        local status, result = pcall(function()
            return player:hasBlessing(i)
        end)
        
        local name = blessings[i] or "Blessing "..i
        if status and result then
            table.insert(blessStatus, "sim "..name)
            blessCount = blessCount + 1
        else
            table.insert(blessStatus, "nao "..name)
        end
    end
    
    -- Monta a mensagem final
    local message = "=== "..playerName.."'s Blessings ===\n"..
                    table.concat(blessStatus, "\n")..
                    "\n\nTotal: "..blessCount.."/8 blessings"
    
    -- Exibe em uma janela de diálogo
    player:popupFYI(message)
    return true
end