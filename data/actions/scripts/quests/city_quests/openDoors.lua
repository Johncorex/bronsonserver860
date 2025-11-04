-- data/scripts/actions/key_range_doors.lua --

function onUse(cid, item, fromPosition, target, toPosition)
  local aid = item.actionid
  -- 1) so chaves e portas de 2001 a 2036, e actionid da chave == da porta
  if aid >= 2001 and aid <= 2056 and target.actionid == aid then

    -- 2) verifica se a porta eh exatamente o itemid que voce quer abrir
    if target.itemid == 5733 then
      -- transforma porta fechada (5734) em porta aberta (5733)
      doTransformItem(target.uid, 5734)
      return true
    end

  end

  return false
end
