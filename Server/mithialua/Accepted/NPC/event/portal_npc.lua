portal_npc = {
action = function(npc)
	local hiddenkeys = npc:getObjectsInSameMap(BL_NPC)
	local countkeys = 0

		for i = 1, #hiddenkeys do
			if (hiddenkeys[i].yname == "warp_portal") then
			countkeys = (countkeys + 1)
			end
		end

	if (countkeys <= 8) then
		repeat

		local hiddenkeys = npc:getObjectsInSameMap(BL_NPC)
		local countkeys = 0

		for i = 1, #hiddenkeys do
			if (hiddenkeys[i].yname == "warp_portal") then
			countkeys = (countkeys + 1)
			end
		end

			local newX = math.random(5, 139)
			local newY = math.random(16, 139)
			local passCheck = getPass(npc.m, newX, newY)
			local tileCheck = getTile(npc.m, newX, newY)
			if (passCheck == 0 and (tileCheck == 64 or tileCheck == 457)) then
				npc:addNPC("warp_portal", npc.m, newX, newY, 500, 80000, 0)
			end
		until (countkeys == 9)
	end
--npc:warp(33, 33, 41)

end
}

warp_portal = {
click = function(block, npc)
	if (block.blType == BL_PC) then
		if (block.state ~= 1 and block.level >= 50) then
			block:playSound(60)
			block:sendAnimationXY(393, block.x, block.y)
			block:warp(200, block.x, block.y)
			block:sendAnimation(393, 0)
			block:sendMinitext("You feel your spirit pulled from your body.")
			npc:delete()
		end
	end
end,

action = function(npc)
	npc:sendAnimationXY(377, npc.x, npc.y, 5)
end
}