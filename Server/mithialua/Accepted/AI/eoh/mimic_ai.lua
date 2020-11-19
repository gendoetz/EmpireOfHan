mimic_maker = {
action = function(npc)
	--npc:talk(0, "mimic: "..npc.actionTime)
	--npc:addNPC("frost_SpiritDance", 1001, math.random(4, 11), math.random(9, 10), 4000, 80000)
	local mimic_maps = {504, 506, 508, 509}
	local mimic_mapsx1 = {8, 2, 25, 21}
	local mimic_mapsy1 = {16, 9, 7, 9}
	--local mimic_mapsx2 = {14, 14}
	--local mimic_mapsy2 = {12, 12}
	--local sums = 0

	for i = 1, #mimic_maps do
		--Check for Players
		local players = npc:getObjectsInMap(mimic_maps[i], BL_PC)
			--if (#players >= 1) then
				local get_mimics = npc:getObjectsInMap(mimic_maps[i], BL_NPC)
				if (#get_mimics == 0) then
						local randx = mimic_mapsx1[i]--math.random(mimic_mapsx1[i], mimic_mapsx2[i])
						local randy = mimic_mapsy1[i]--math.random(mimic_mapsy1[i], mimic_mapsy2[i])
						npc:addNPC("mimic_gfx", mimic_maps[i], randx, randy, 1000, 0, 0, "Library Treasure Chest")
						local mimic = npc:getObjectsInCell(mimic_maps[i], randx, randy, BL_NPC)[1]
						mimic.subType = 0
						mimic.look = 154
						mimic.lookColor = 5

						local blockPC = npc:getObjectsInMap(mimic_maps[i], BL_PC)
						if (#blockPC > 0) then
								for i = 1, #blockPC do
									blockPC[i]:refresh()
								end
						end
				end
			--end
	end

	--npc:talk(0, "done: "..npc.actionTime)
end,
}

mimic_ai = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	if (attacker:hasDuration("amplify")) then
		local damagemod = attacker.damage * .3
		attacker.damage = attacker.damage + damagemod
	end
	
	mob.attacker = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,

move = function(mob, target)
	--mob:talk(2,"zaptime: "..mob.registry["zapCastTime"].." wither aethers "..mob.registry["zapCastTime"] + aethers.." os time: "..os.time())
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
				--mob:attack(target.ID)
				mob.state = MOB_HIT
				--mob:talk(2,"Target Acquired")
			end
	mimic_ai.doom(mob, target)
	--mob:talk(2,"Move")
end,

attack = function(mob, target)
	--mob:talk(2,"Doom")
	

	if(target) then
		if(mob:moveIntent(target.ID) == 1) then
			--mob:flank()
			mob:attack(target.ID)
			mob:sendAnimationXY(300, target.x, target.y, 0)
		end
	end

	mimic_ai.doom(mob, target)

end,

on_spawn = function(mob)
	--local getMimic_npc = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_NPC)

	--if (#getMimic_npc > 0) then
	--	for i = 1, #getMimic_npc do
	--		getMimic_npc[i]:delete()
	--	end
	--end
	--__REMOVE THIS UPPER PART__


	--mob:addNPC("mimic_gfx", mob.m, mob.x, mob.y, 1000)
	--local mimic = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_NPC)[1]
	--local blockPC = mob:getObjectsInArea(BL_PC)
	--if (#blockPC > 0) then
	--		mimic.subType = 0
	--		mimic.look = 154
	--		mimic.lookColor = 5
	--		for i = 1, #blockPC do
	--			blockPC[i]:refresh()
	--		end
	--end
end,

after_death = function(mob, attacker)
	local getMimic_npc = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_NPC)
	local mimic

	if (#getMimic_npc > 0) then
		for i = 1, #getMimic_npc do
			getMimic_npc[i].look = 2000
			mimic = getMimic_npc[i]
			break
			--getMimic_npc[i]:delete()
		end
	end

	local blockPC = mob:getObjectsInArea(BL_PC)
	if (#blockPC > 0) then
			for i = 1, #blockPC do
				blockPC[i]:refresh()
			end
	end
	if (mimic ~= nil) then
		mimic:delete()
	end
end,

doom = function(mob, target)

	local aethers = math.random(5, 6)

	if (target ~= nil and os.time() >= mob.registry["zapCastTime"] + aethers) then

		local mobBlocks = mob:getObjectsInArea(BL_PC)
		local rangeCheck = false
		local duration = 15000
		local damage = (target.maxHealth * .25)
		
		local range = 10
		local doomTargets = {}
		local doomselected

		local doomchest1 = mob:getObjectsInCell(mob.m, mob.x-1, mob.y, BL_PC)[1]
		local doomchest2 = mob:getObjectsInCell(mob.m, mob.x+1, mob.y, BL_PC)[1]
		local doomchest3 = mob:getObjectsInCell(mob.m, mob.x, mob.y+1, BL_PC)[1]

			for i = 1, #target.group do
				if (Player(target.group[i]).m == mob.m and Player(target.group[i]).state ~= 1) then
					table.insert(doomTargets, Player(target.group[i]))
				end
			end

			if (doomchest1 ~= nil) then
				if (#doomTargets > 0) then
					for i = 1, #doomTargets do
						if (doomTargets[i].ID == doomchest1.ID) then
							table.remove(doomTargets, i)
							break
						end
					end
				end
			end

			if (doomchest2 ~= nil) then
				if (#doomTargets > 0) then
					for i = 1, #doomTargets do
						if (doomTargets[i].ID == doomchest2.ID) then
							table.remove(doomTargets, i)
							break
						end
					end
				end
			end

			if (doomchest3 ~= nil) then
				if (#doomTargets > 0) then
					for i = 1, #doomTargets do
						if (doomTargets[i].ID == doomchest3.ID) then
							table.remove(doomTargets, i)
							break
						end
					end
				end
			end

			if (#doomTargets > 0) then
				for i = 1, #doomTargets do
					if (doomTargets[i]:hasDuration("doom")) then
						table.remove(doomTargets, i)
					end

				end
			end

			if (doomchest1 == nil) then
				if (#doomTargets > 0) then
					doomselected = math.random(#doomTargets)
					doomchest1 = doomTargets[doomselected]
					table.remove(doomTargets, doomselected)
					doomchest1:warp(mob.m, mob.x-1, mob.y)
				end
			end

			if (doomchest2 == nil) then
				if (#doomTargets > 0) then
					doomselected = math.random(#doomTargets)
					doomchest2 = doomTargets[doomselected]
					table.remove(doomTargets, doomselected)
					doomchest2:warp(mob.m, mob.x+1, mob.y)
				end
			end

			if (doomchest3 == nil) then
				if (#doomTargets > 0) then
					doomselected = math.random(#doomTargets)
					doomchest3 = doomTargets[doomselected]
					table.remove(doomTargets, doomselected)
					doomchest3:warp(mob.m, mob.x, mob.y+1)
				end
			end

			if (#doomTargets > 0) then
				mob:sendAnimation(201, 0)
			end

			--if ((doomchest1 ~= nil and not doomchest1:hasDuration("doom")) or (doomchest2 ~= nil and not doomchest2:hasDuration("doom")) or (doomchest3 ~= nil and not doomchest3:hasDuration("doom"))) then
			--	mob:playSound(81)
			--end

			if (doomchest1 ~= nil) then
				if (doomchest1.state ~= 1) then
					if (not doomchest1:hasDuration("doom")) then
						mob:playSound(81)
						doomchest1:sendAnimation(354, 0)
						doomchest1:setDuration("doom", duration)
					end
				end
			end
			if (doomchest2 ~= nil) then
				if (doomchest2.state ~= 1) then
					if (not doomchest2:hasDuration("doom")) then
						mob:playSound(81)
						doomchest2:sendAnimation(354, 0)
						doomchest2:setDuration("doom", duration)
					end
				end
			end
			if (doomchest3 ~= nil) then
				if (doomchest3.state ~= 1) then
					if (not doomchest3:hasDuration("doom")) then
						mob:playSound(81)
						doomchest3:sendAnimation(354, 0)
						doomchest3:setDuration("doom", duration)
					end
				end
			end

			mob.registry["zapCastTime"] = os.time()
	end
end,

singletarget = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local damage = math.random(200, 270)
	local aethers = math.random(2, 3)
	local range = 20
	local zaptarget
	
	--mob:talk(2,"zaptime: "..mob.registry["zapCastTime"].." wither aethers "..mob.registry["zapCastTime"] + aethers.." os time: "..os.time())

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (distance(mob, mobBlocks[i]) <= range) then
					rangeCheck = true
					target = mobBlocks[i]
					break
				end
			end
		end
		if (rangeCheck and target ~= nil and distance(mob, target) <= range
			and os.time() >= mob.registry["zapCastTime"] + aethers) then
			--mob:playSound(363)
			target:sendAnimation(143, 0)
			target.attacker = mob.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			FindCoords(mob, target)
			mob.registry["zapCastTime"] = os.time()
			return true
		end

end,

unpara = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local target = mob
	local aethers = math.random(2,5)
	
	if(os.time() >= mob.registry["zapCastTime"] + aethers) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 214 or mobBlocks[i].mobID == 215)
				and mobBlocks[i].paralyzed == true) then
					target = mobBlocks[i]
					target:sendAnimation(10)
					target.paralyzed = false
					return
				end
			end
		end

	end
end
}

mimic_gfx = {
action = function(npc)
	local mobCounterpart = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_MOB)[1]

	if (mobCounterpart ~= nil) then
		if (mobCounterpart.state == 4) then
			npc:sendAnimation(16, 0)
			if (npc.side == 1) then
				npc.side = 0
			else
				npc.side = 1
			end
			
		else
			npc.side = 0
		end
		npc:sendSide()
	end
end,
}

doom = {
while_cast = function(block)
	local dura = block:durationAmount("doom")
	local damage = dura / 1000
	--block:talk(2,"test")

	--block:talk(2,"Zippy Zap from:"..caster.ID)
	block.attacker = block.ID
	block:sendAnimation(14, 0)
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
end,

uncast = function(block)
	block:playSound(81)
	block:sendAnimation(353, 0)
	block:sendMinitext("Doom causes you death.")
	block:die()
end,
}

lib_chest_key = {
use = async(function(player)
	local chest = {graphic = convertGraphic(154, "monster"), color = 5}
	local facingchest = getTargetFacing(player, BL_NPC)
	local facingmimic = getTargetFacing(player, BL_MOB)

	player.npcGraphic = chest.graphic
	player.npcColor = chest.color
	player.dialogType = 0

	if (facingmimic ~= nil) then
		player:dialogSeq({chest, "You cannot unlock this, it's a Mimic!!"}, 0)
		return
	end

		if (facingchest ~= nil) then
			if (facingchest.yname == "mimic_gfx") then
				player:sendMinitext("You discover a Mimic!")
				player:removeItem("lib_chest_key", 1)
				--player:dialog("You unlock the chest and find an item hidden inside.", chest)
				player:spawn(245, facingchest.x, facingchest.y, 1)
				local chest_attack = player:getObjectsInCell(facingchest.m, facingchest.x, facingchest.y, BL_MOB)[1]
				chest_attack.attacker = player.ID
				chest_attack.target = player.ID
			end
		end

end)
}