function onUse(cid, item, fromPosition, itemEx, toPosition)

	if item.itemid == 2091 and item.actionid == 666 and itemEx.uid == 1300 then
		local posit = {x=516,y=544,z=8}
		
		doTeleportThing(cid, posit, FALSE)
		
		doSendMagicEffect(posit,CONST_ME_SMALLCLOUDS)
		return true
	end
	
	--joga pro andar de cima
	if item.itemid == 2091 and item.actionid == 3050 and itemEx.uid == 1410 then
		doRemoveItem(item.uid)
		local posit = {x=toPosition.x, y=toPosition.y, z=(toPosition.z-1)}
		doTeleportThing(cid, posit, FALSE)
		
		doSendMagicEffect(posit,CONST_ME_SMALLCLOUDS)
		return true
	end
	
	if item.itemid == 2091 and item.actionid == 3070 and itemEx.uid == 6109 then
		doRemoveItem(item.uid)
		local posit = {x=1305, y=1359, z=1}
		doTeleportThing(cid, posit, FALSE)
		
		doSendMagicEffect(posit,CONST_ME_SMALLCLOUDS)
		return true
	end
	
	if item.itemid == 2091 and item.actionid == 3080 and itemEx.uid == 7872 then
		doRemoveItem(item.uid)
		local posit = {x=715, y=1573, z=8}
		doTeleportThing(cid, posit, FALSE)
		
		doSendMagicEffect(posit,CONST_ME_SMALLCLOUDS)
		return true
	end
	
	if item.itemid == 2091 and item.actionid == 3090 and itemEx.uid == 2887 then
		doRemoveItem(item.uid)
		local posit = {x=366, y=1087, z=7}
		doTeleportThing(cid, posit, FALSE)
		
		doSendMagicEffect(posit,CONST_ME_SMALLCLOUDS)
		return true
	end
	
	return true
end
