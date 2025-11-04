function onUse(cid, item, fromPosition, itemEx, toPosition)
	
if getPlayerLevel(cid) <= 14 then			 
doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE,"Apenas level 15 tem essa habilidade!")
			return TRUE
		end	

doCreateItem(2677, 8, fromPosition)
	
doTransformItem(item.uid, 2786)


	doDecayItem(item.uid)
	
return true
end
