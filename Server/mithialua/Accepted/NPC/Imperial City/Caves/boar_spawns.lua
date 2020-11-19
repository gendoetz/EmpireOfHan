boar_spawns = {
click = async(function(player, npc)
local traps = npc:getObjectsInMap(55, BL_NPC)
			if (#traps > 0) then
				for i = 1, #traps do
					if (traps[i].yname ~= "boar_spawns") then
						--removeTrap(traps[i])
						traps[i]:delete()
					end
				end
			end
			player:sendMinitext("You deleted all traps!")
end),

action = function(npc)
	local boarnests = npc:getObjectsInMap(55, BL_NPC)
	local mobscount = npc:getObjectsInMap(55, BL_MOB)
	local countnests = 0
	local countmobs = 0

		for i = 1, #boarnests do
			if (boarnests[i].yname == "boar_nest_loc") then
			countnests = (countnests + 1)
			end
		end
		for i = 1, #mobscount do
			if (mobscount[i].yname == "boars_main") then
			countmobs = (countmobs + 1)
			end
		end
		if (countmobs <= 50) then
			if (countnests <= 5) then

				for i =1, 5 do
					local newX = math.random(0, npc.xmax)
					local newY = math.random(0, npc.ymax)
					local passCheck = getPass(55, newX, newY)
					local tileCheck = getTile(55, newX, newY)
					if (passCheck == 0 and (tileCheck == 905 or tileCheck == 986)) then
						npc:addNPC("boar_nest_loc", 55, newX, newY, 0, 80000, 0)
						addSpotTrap(npc, 55, newX, newY)
					end
				end

			end
		end

end
}

boar_nest_loc = {
click = function(block, npc)
	local mobscount = npc:getObjectsInMap(55, BL_MOB)
	local countmobs = 0
		for i = 1, #mobscount do
			if (mobscount[i].yname== "boars_main") then
			countmobs = (countmobs + 1)
			end
		end
		if (countmobs >= 60) then
		npc:delete()
		--removeTrap(npc)
		return
		end

	if (block.blType == BL_PC) then
		if (block.state ~= 1) then
		block:playSound(703)
		block:sendAnimation(16, 0)
		--Spawns
			local passCheck = getPass(55, npc.x+1, npc.y)
			local tileCheck = getTile(55, npc.x+1, npc.y)
			if (passCheck == 0 and (tileCheck == 905 or tileCheck == 986)) then
				npc:spawn(39, npc.x+1, npc.y, 1)
			else
				npc:spawn(39, npc.x, npc.y, 1)
			end

			local passCheck = getPass(55, npc.x-1, npc.y)
			local tileCheck = getTile(55, npc.x-1, npc.y)
			if (passCheck == 0 and (tileCheck == 905 or tileCheck == 986)) then
				npc:spawn(39, npc.x-1, npc.y, 1)
			else
				npc:spawn(39, npc.x, npc.y, 1)
			end

			local passCheck = getPass(55, npc.x, npc.y+1)
			local tileCheck = getTile(55, npc.x, npc.y+1)
			if (passCheck == 0 and (tileCheck == 905 or tileCheck == 986)) then
				npc:spawn(39, npc.x, npc.y+1, 1)
			else
				npc:spawn(39, npc.x, npc.y, 1)
			end

			local passCheck = getPass(55, npc.x, npc.y-1)
			local tileCheck = getTile(55, npc.x, npc.y-1)
			if (passCheck == 0 and (tileCheck == 905 or tileCheck == 986)) then
				npc:spawn(39, npc.x, npc.y-1, 1)
			else
				npc:spawn(39, npc.x, npc.y, 1)
			end
			--AddMotherBoar
			local momrandspot = math.random(1, 4)
			if (momrandspot == 1) then
				local passCheck = getPass(55, npc.x+1, npc.y-1)
				local tileCheck = getTile(55, npc.x+1, npc.y-1)
				if (passCheck == 0 and (tileCheck == 905 or tileCheck == 986)) then
					npc:spawn(40, npc.x+1, npc.y-1, 1)
				else
					npc:spawn(40, npc.x, npc.y, 1)
				end
			elseif (momrandspot == 2) then
				local passCheck = getPass(55, npc.x-1, npc.y+1)
				local tileCheck = getTile(55, npc.x-1, npc.y+1)
				if (passCheck == 0 and (tileCheck == 905 or tileCheck == 986)) then
					npc:spawn(40, npc.x-1, npc.y+1, 1)
				else
					npc:spawn(40, npc.x, npc.y, 1)
				end
			elseif (momrandspot == 3) then
				local passCheck = getPass(55, npc.x-1, npc.y-1)
				local tileCheck = getTile(55, npc.x-1, npc.y-1)
				if (passCheck == 0 and (tileCheck == 905 or tileCheck == 986)) then
					npc:spawn(40, npc.x-1, npc.y-1, 1)
				else
					npc:spawn(40, npc.x, npc.y, 1)
				end
			elseif (momrandspot == 4) then
				local passCheck = getPass(55, npc.x+1, npc.y+1)
				local tileCheck = getTile(55, npc.x+1, npc.y+1)
				if (passCheck == 0 and (tileCheck == 905 or tileCheck == 986)) then
					npc:spawn(40, npc.x+1, npc.y+1, 1)
				else
					npc:spawn(40, npc.x, npc.y, 1)
				end
			end

		removeTrap(npc)
		--npc:delete()
		block:sendMinitext("You stumble upon a boar nest!")
	end
	end
end
}