spirit_dance_monitor = {
click = async(function(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.dialogType = 0
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	--player:addItem("echo_charm", 1, 0, 2, "Echo: Mage")

	--player:addItem("r50q2", 1, 0, 2, "", 1)
	--player:addItem("r50q2", 1, 0, 2, "")
	--player:addItem("r50q2", 1, 0, 2)
	--player:spawn(300, player.x, player.y, 1) -- if this is not a code with player in the content, npc:spawn, block:spawn etc. ID of monster is 300 for bard player clone
	--player_cloneCreate.setup(player) -- ( ) contains the target you want to make a clone of.
	--npc.actionTime = 30000

	--npc:addNPC("frost_SpiritDance", player.m, player.x, player.y, 4000, 80000)
	local ritual_maps = {581, 582, 583, 584, 585, 586, 587}
	for i = 1, #ritual_maps do
			--Check for Players

					local get_summoned = npc:getObjectsInMap(ritual_maps[i], BL_NPC)
					if (#get_summoned ~= 0) then
						for i = 1, #get_summoned do
							get_summoned[i]:delete()
						end
					end

	end

	player:dialogSeq({t, "This monitor is spawning rituals in the Ice Palace."}, 1)
	--mob:warp(mob.startM, mob.startX, mob.startY)
end),

action = function(npc)
	--npc:talk(0, "Ritual: "..npc.actionTime)
	--npc:addNPC("frost_SpiritDance", 1001, math.random(4, 11), math.random(9, 10), 4000, 80000)
	local ritual_maps = {581, 582, 583, 584, 585, 586, 587}
	local ritual_mapsx1 = {5, 7, 8, 12, 10, 8, 9}
	local ritual_mapsy1 = {17, 8, 4, 16, 8, 5, 10}
	local ritual_mapsx2 = {18, 32, 11, 27, 14, 12, 19}
	local ritual_mapsy2 = {25, 10, 39, 24, 22, 19, 15}
	local sums = 0

	for i = 1, #ritual_maps do
		--Check for Players
		local players = npc:getObjectsInMap(ritual_maps[i], BL_PC)
			if (#players >= 1) then
				local get_summoned = npc:getObjectsInMap(ritual_maps[i], BL_MOB)
				if (#get_summoned ~= 0) then
					for i = 1, #get_summoned do
						if (get_summoned[i].mobID == 220 or get_summoned[i].mobID == 231) then
							sums = sums + 1
						end
					end
					if(sums <= 1) then
						local randx = math.random(ritual_mapsx1[i], ritual_mapsx2[i])
						local randy = math.random(ritual_mapsy1[i], ritual_mapsy2[i])
						npc:addNPC("frost_SpiritDance", ritual_maps[i], randx, randy, 4000, 80000)
						--local npcget = npc:getObjectsInCell(ritual_maps[i], randx, randy, BL_NPC)[1]
						--npcget.subType = 0
						--npcget.look = 1
					end
				end
			end
	end

end,

endAction = function(npc, player)
	npc:delete()
end
}

--[[pinyan_rab = {
click = async(function(player, mob)
	local t = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
	player.dialogType = 0
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	--player:addItem("echo_charm", 1, 0, 2, "Echo: Mage")
	--player:spawn(300, player.x, player.y, 1) -- if this is not a code with player in the content, npc:spawn, block:spawn etc. ID of monster is 300 for bard player clone
	--player_cloneCreate.setup(player) -- ( ) contains the target you want to make a clone of.
	--mob:setPermSpawn(mob.mobID, 25, 25, 0)
	player:dialogSeq({t, "Test."..mob.mobID}, 1)
	--mob:warp(mob.startM, mob.startX, mob.startY)
end)	
}--]]

frost_SpiritDance = {
action = function(npc)
	--local fourdancers = 0
	local bikibiki = 6
	local callspirits = npc:getObjectsInArea(BL_MOB)

	--npc:talk(0, "Ritual: "..npc.actionTime)
	--if (os.time() > npc.registry["bikibiki"] + bikibiki) then
	--	npc:delete()
	--end

		for i = 1, #callspirits do
			if(callspirits[i].yname == "frost_spiritdancers") then
				--if (callspirits[i].registry["summon_ritual"] == 1) then
					--fourdancers = fourdancers + 1
				--else
					--callspirits[i]:talk(0, "Ritual!"..npc.actionTime)
				if (callspirits[i].registry["summon_ritual"] == 0) then
					callspirits[i].owner = npc.ID
					callspirits[i].target = npc.ID
					callspirits[i].registry["summon_ritual"] = 1
					--fourdancers = fourdancers + 1
				end
			end
			--if (fourdancers >= 4) then
			--	return
			--end
		end

	local upspirit = npc:getObjectsInCell(npc.m, npc.x, npc.y - 1, BL_MOB)
	local rightspirit = npc:getObjectsInCell(npc.m, npc.x + 1, npc.y, BL_MOB)
	local downspirit = npc:getObjectsInCell(npc.m, npc.x, npc.y + 1, BL_MOB)
	local leftspirit = npc:getObjectsInCell(npc.m, npc.x - 1, npc.y, BL_MOB)

	if (#upspirit > 0) then
		upspirit[1].registry["summon_ritual"] = upspirit[1].registry["summon_ritual"] + 1
	end
	if (#rightspirit > 0) then
		rightspirit[1].registry["summon_ritual"] = rightspirit[1].registry["summon_ritual"] + 1
	end
	if (#downspirit > 0) then
		downspirit[1].registry["summon_ritual"] = downspirit[1].registry["summon_ritual"] + 1
	end
	if (#leftspirit > 0) then
		leftspirit[1].registry["summon_ritual"] = leftspirit[1].registry["summon_ritual"] + 1
	end

	if (#upspirit > 0 and #rightspirit > 0 and #downspirit > 0 and #leftspirit > 0) then
		npc:sendAnimationXY(427, npc.x, npc.y - 1, 0)
		npc:sendAnimationXY(427, npc.x + 1, npc.y, 0)
		npc:sendAnimationXY(427, npc.x, npc.y + 1, 0)
		npc:sendAnimationXY(427, npc.x - 1, npc.y, 0)

		npc:sendAnimationXY(360, npc.x, npc.y, 3)
		if (upspirit[1].registry["summon_ritual"] >= 4 and rightspirit[1].registry["summon_ritual"] >= 4 and downspirit[1].registry["summon_ritual"] >= 4 and leftspirit[1].registry["summon_ritual"] >= 4) then
		--make this happen a few times before spawning
		

			leftspirit[1]:playSound(40)
			leftspirit[1]:playSound(64)
			npc:sendAnimationXY(99, npc.x, npc.y, 0)

			local randMob = math.random(1, 2)
			if (randMob == 1) then
				npc:spawn(220, npc.x, npc.y, 1)
			else
				npc:spawn(231, npc.x, npc.y, 1)
			end

			--Set all spirits back to normal
			local callspirits = npc:getObjectsInArea(BL_MOB)
				for i = 1, #callspirits do
					if(callspirits[i].yname == "frost_spiritdancers") then

						if (callspirits[i].registry["summon_ritual"] >= 1) then
							callspirits[i].owner = 0
							callspirits[i].target = 0
							callspirits[i].registry["summon_ritual"] = 0
						end
					end
				end
			--Set action high until npcdelete like normal
			npc.actionTime = 80000
		end

	end

end,

endAction = function(npc)
	npc:delete()
end,
}

frost_spiritdancers = {
on_spawn = function(mob)
	mob.side = math.random(0,3)
	mob:sendSide()
end,

on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	if (mob.registry["summon_ritual"] >= 2) then
		attacker.damage = 0
		return
	end

	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)

	if (mob.owner ~= 0) then
		local block = mob:getBlock(mob.owner)
		if (block ~= nil) then
			target = block
			mob.target = mob.owner
		end
		if (block == nil) then
			--mob:talk(0, "My owner has disappeared!")
			mob.registry["summon_ritual"] = 0
			--mob:warp(mob.startM, mob.startX, mob.startY)
			mob.owner = 0
			mob.target = 0
		end
	end

	if (mob.owner == 0) then
		mob.registry["summon_ritual"] = 0
			--mob:warp(mob.startM, mob.startX, mob.startY)
			mob.owner = 0
			mob.target = 0
	end

	if (mob.registry["summon_ritual"] >= 2) then
		mob.side = math.random(0,3)
		mob:sendSide()
		mob:talk(2, "Biki biki biki biki")
		mob:sendAnimation(425, 0)
		return
	end

	if (mob.registry["summon_ritual"] == 1 and mob.owner ~= 0) then
		SummonFindCoords(mob, target)
		return
	end
	mob_ai_basic.move(mob, target)
end,

summon_ritual = function(mob, target)

end,

attack = function(mob, target)
	mob_ai_basic.attack(mob, target)
end
}

snape = {
on_spawn = function(mob)

local newX = math.random(-3, 3)
local newY = math.random(-3, 3)
local passCheck = getPass(mob.m, mob.startX + newX, mob.startY + newY)
local tileCheck = getTile(mob.m, mob.startX + newX, mob.startY + newY)
local mobCheck = mob:getObjectsInCell(mob.m, mob.startX + newX, mob.startY + newY, BL_MOB)

	if ((mob.startX + newX) > mob.xmax) then
		newX = 0
	end
	if ((mob.startY + newY) > mob.ymax) then
		newY = 0
	end

	if ((mob.startX + newX) < 0) then
		newX = 0
	end

	if ((mob.startY + newY) < 0) then
		newY = 0
	end

	if (passCheck == 0 and #mobCheck == 0 and tileCheck == 27991) then
		mob:warp(mob.m, mob.startX + newX, mob.startY + newY)
	end

	mob.side = math.random(0,3)
	mob:sendSide()
end,

on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	mob_ai_basic.attack(mob, target)
end
}