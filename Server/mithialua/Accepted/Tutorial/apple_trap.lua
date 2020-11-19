apple_trap = {
cast = function(mob)
	local aether = math.random(5, 8)

	if (target ~= nil and os.time() >= mob.registry["appletrapCastTime"] + aethers) then
		mob:sendAction(6, 20)
		mob:addNPC("apple_trap", mob.m, mob.x, mob.y, 0, 3600000, mob.mobID)
		mob.registry["appletrapCastTime"] = os.time()
		addSpotTrap(mob, mob.m, mobr.x, mob.y)
	end
end,

click = function(block, npc)
	local damage = 2000
	local apple = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_ITEM)
	local trapstacks = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_NPC)
	--local duration = 10000
	local owner = npc:getBlock(npc.owner)
	
	--if (owner == nil or block:hasDuration("apple_trap")) then
	--	return
	--end
	
	--damage = damage * owner.level

	if (block.blType == BL_PC) then
		if (block.state ~= 1) then
		--block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		for i = 1, #apple do
			if (apple[i].id == 36) then
				apple[i]:delete()
			end
		end
		block:playSound(702)
		block:sendAnimation(1, 0)
		--block:talk(0,"I just deleted 1 trap"..#trapstacks..".")
		damage = damage * #trapstacks
		block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		if (#trapstacks > 0) then
		for i = 1, #trapstacks do
			if (trapstacks[i].yname == "apple_trap") then
				trapstacks[i]:delete()
			end
		end
		end
		--block.attacker = owner.id
		--block:setDuration("apple_trap", duration)
		--ERRORS for some reason block:calcStat()
		--block:sendMinitext("A wicked apple has exploaded on you.")
		--removeTrap(npc)
		end
	end
end,

endAction = function(npc, owner)
	local apple = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_ITEM)
	for i = 1, #apple do
			if (apple[i].id == 36) then
				apple[i]:delete()
			end
	end
	removeTrap(npc)
end,

recast = function(block)

end,

uncast = function(block)

end
}