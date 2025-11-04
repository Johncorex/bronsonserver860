function onSay(cid, words, param)
    local player = Player(cid)
    if not player then return false end

    local text = {}
    local spells = {}

    for _, spell in ipairs(player:getInstantSpells()) do
        if spell.level ~= 0 then
            if spell.manapercent > 0 then
                spell.mana = spell.manapercent .. "%"
            end
            if spell.params > 0 then
                spell.words = spell.words .. " para"
            end
            spells[#spells + 1] = spell
        end
    end

    table.sort(spells, function(a, b) return a.level < b.level end)

    local prevLevel = -1
    for i, spell in ipairs(spells) do
        if prevLevel ~= spell.level then
            if i ~= 1 then
                text[#text+1] = "\n"
            end
            text[#text+1] = "Spells for Level " .. spell.level .. ":\n"
            prevLevel = spell.level
        end
        text[#text+1] = " " .. spell.words .. " - " .. spell.name .. " : " .. spell.mana .. "\n"
    end

    if #text == 0 then
        text[1] = "You don't know any spells yet."
    end

    player:showTextDialog(2175, table.concat(text))
    return true
end
