ground_item_spawns = {

--MAKE Kapok
click = async(function(player, npc)

		player:talk(0,"Test")

end),

action = function(npc)
		--repeat
		local k_branches = npc:getObjectsInMap(77, BL_ITEM)

		local kbranchnum = 0
		if (#k_branches > 0) then
			for i = 1, #k_branches do
				if (k_branches[i].id == 416) then
				kbranchnum = kbranchnum + 1
				end
			end
		end
		if (kbranchnum <= 20) then
		local ranx = math.random(33, 54)
		local rany = math.random(59, 74)
			local tileCheck = getTile(77, ranx, rany)
			if(tileCheck == 43) then
				npc:dropItemXY(416, 1, 77, ranx, rany, 0)
			end
		end
		--until (kbranchnum >= 15)
end,
}