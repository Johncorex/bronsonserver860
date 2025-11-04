function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- Verifica se o item clicado é a fonte (UID 29769)
    if itemEx.uid == 29769 then
        doSendMagicEffect(posit,CONST_ME_SMALLCLOUDS)
        return true
    end
end