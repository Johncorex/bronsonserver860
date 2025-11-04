		function onUse(cid, item, fromPosition, itemEx, toPosition)
		local posit = {x=1574,y=479,z=7}
		if getPlayerPremiumDays(cid) > 0 then
			doTeleportThing(cid, posit, FALSE)
			doSendMagicEffect(posit,CONST_ME_SMALLCLOUDS)
			return true
		else
			doPlayerSendCancel(cid,"Somente jogadores VIP podem entrar aqui.")
			return true
		end
        end