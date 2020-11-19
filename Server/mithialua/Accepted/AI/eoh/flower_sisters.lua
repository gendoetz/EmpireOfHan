flower_sister1 = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

after_death = function(mob, attacker, block)

end,

on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
end,

on_attacked = function(mob, attacker)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local rangeCheck = false
	
	if (not mob.paralyzed and mob.sleep == 1) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].owner == 0 or mobBlocks[i].mobID == 117 or mobBlocks[i].mobID == 118)) then
					rangeCheck = true
					break
				end
			end
		end
		
		if (attacker.critChance ~= 0 and ((attacker.x == mob.x and (attacker.y == mob.y + 1 or attacker.y == mob.y - 1))
		or (attacker.y == mob.y and (attacker.x == mob.x + 1 or attacker.x == mob.x - 1))) and not rangeCheck) then
			RunAway(mob, attacker)
		end
	end
	
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	local found
	local moved = false
	local oldside = mob.side
	local checkmove = math.random(0,10)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob:sendAction(6, 40)
		mob:sendAnimation(10)
		mob:playSound(34)--13
		mob.paralyzed = false
		return
	end

	flower_sister1.unpara(mob)

	if(math.random(0,1) == 1) then
		flower_sister1.heal(mob)
	end
	
	--if (target.m == mob.m) then
	--	moved = flower_sister1.zap(mob, target)
	--end
	
	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
		mob.newMove = 250
		mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end

	if (mob.returning == true) then
		found = toStart(mob, mob.startX, mob.startY)
		
	else
		if (mob.target > 0) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
		end
	
		if (mob.state ~= MOB_HIT and mob.owner == 0 and not moved) then
			if (checkmove >= 4) then
				mob.side = math.random(0, 3)
				mob:sendSide()
				if (mob.side == oldside) then
					mob:move()
				end
			else
				mob:move()
			end
		end
	end
	
	if (found == true) then
		mob.newMove = 0
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
end,

attack = function(mob, target)
	mob.state = MOB_ALIVE
	flower_sister1.move(mob, target)
end,

heal = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local healTargets = {} 
	local target = mob
	local heal = math.random(2500, 4000)
	
	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 149 or mobBlocks[i].mobID == 150)
			and mobBlocks[i].health ~= mobBlocks[i].maxHealth) then
				table.insert(healTargets, mobBlocks[i])
			end
		end
	end
	
	if (#healTargets > 0) then
		for i = 1, #healTargets do
			if (healTargets[i].health / healTargets[i].maxHealth < target.health / target.maxHealth) then
				target = healTargets[i]
			end
		end
	end
	
	if(mob.registry["sequence"] < 0) then
		target.attacker = mob.ID
		mob:sendAction(6, 40)
		target:sendAnimation(5)
		mob:playSound(708)
		target:addHealthExtend(heal, 0, 0, 0, 0, 0)
		mob.registry["sequence"] = mob.registry["sequence"] + 1
		
		if(target.health >= (target.maxHealth - 200)) then
			mob.registry["sequence"] = 0
		end
	end
	
	if (target.health <= (target.maxHealth - target.maxHealth/3)) then
		mob.registry["sequence"] = -math.random(1,2)
	end

end,


unpara = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local target = mob
	local aethers = math.random(1,3)
	
	if(os.time() >= mob.registry["zapCastTime"] + aethers) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 149 or mobBlocks[i].mobID == 150)
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

flower_sister2 = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

after_death = function(mob, attacker, block)

end,

on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
end,

on_attacked = function(mob, attacker)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local rangeCheck = false
	
	if (not mob.paralyzed and mob.sleep == 1) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].owner == 0 or mobBlocks[i].mobID == 117 or mobBlocks[i].mobID == 118)) then
					rangeCheck = true
					break
				end
			end
		end
		
		if (attacker.critChance ~= 0 and ((attacker.x == mob.x and (attacker.y == mob.y + 1 or attacker.y == mob.y - 1))
		or (attacker.y == mob.y and (attacker.x == mob.x + 1 or attacker.x == mob.x - 1))) and not rangeCheck) then
			RunAway(mob, attacker)
		end
	end
	
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	local found
	local moved = false
	local oldside = mob.side
	local checkmove = math.random(0,10)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob:sendAction(6, 40)
		mob:sendAnimation(10)
		mob:playSound(34)--13
		mob.paralyzed = false
		return
	end

	flower_sister2.transform(mob, target)

	if (target.m == mob.m) then
		moved = flower_sister2.zap(mob, target)
	end
	
	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
		mob.newMove = 250
		mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end

	if (mob.returning == true) then
		found = toStart(mob, mob.startX, mob.startY)
		
	else
		if (mob.target > 0) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
		end
	
		if (mob.state ~= MOB_HIT and mob.owner == 0 and not moved) then
			if (checkmove >= 4) then
				mob.side = math.random(0, 3)
				mob:sendSide()
				if (mob.side == oldside) then
					mob:move()
				end
			else
				mob:move()
			end
		end
	end
	
	if (found == true) then
		mob.newMove = 0
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
end,

attack = function(mob, target)
	mob.state = MOB_ALIVE
	flower_sister2.move(mob, target)
end,

zap = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local damage = math.random(1000, 2000)
	local aethers = math.random(2, 3)
	local range = 20
	
	--mob:talk(2,"zaptime: "..mob.registry["zapCastTime"].." wither aethers "..mob.registry["zapCastTime"] + aethers.." os time: "..os.time())

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (distance(mob, mobBlocks[i]) <= range) then
					rangeCheck = true
					break
				end
			end
		end
			if(math.random(0,6) == 0) then
			--mob:talk(2,"*Cackles* Ehehehe!")
			end
		if (rangeCheck and target ~= nil and distance(mob, target) <= range
			and os.time() >= mob.registry["zapCastTime"] + aethers) then
			mob:sendAction(6, 40)
			mob:playSound(701)
			target:sendAnimation(27, 0)
			target.attacker = mob.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			FindCoords(mob, target)
			mob.registry["zapCastTime"] = os.time()
			return true
		elseif (rangeCheck) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= range) then
					rangeCheck = false
					break
				end
			end
			
			if (rangeCheck) then
				FindCoords(mob, mobBlocks[math.random(#mobBlocks)])
				return true
			end
		end

end,

transform = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local aethers = math.random(14, 25)
	local range = 10
	
	--mob:talk(2,"zaptime: "..mob.registry["zapCastTime"].." wither aethers "..mob.registry["zapCastTime"] + aethers.." os time: "..os.time())

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (distance(mob, mobBlocks[i]) <= range) then
					rangeCheck = true
					break
				end
			end
		end

		if (rangeCheck and target ~= nil and distance(mob, target) <= range
			and os.time() >= mob.registry["paraCastTime"] + aethers and target.paralyzed == false) then
			
			if(target.state == 0) then
				mob:playSound(77)
				mob:sendAnimation(16, 0)
				target:setDuration("transformation", 10000)
				target:sendMinitext("You were transformed!")     
				target.state = 4
				target.disguise = 50
				target.registry["morphedanimal"] = target.disguise
				target.disguiseColor = 1
				target:sendStatus()
				target:updateState()
				target.paralyzed = true
			end
			
			mob.registry["paraCastTime"] = os.time()
			return true
		elseif (rangeCheck) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= range) then
					rangeCheck = false
					break
				end
			end
			
		end

end,
}

transformation = {
uncast=function(player)
	player:sendMinitext("You have returned to normal.")
	player.registry["morphedanimal"] = 0
		if (player.state ~= 1) then
			player.state = 0
		end
	player.disguise = 0
	player.paralyzed = false
	player:sendAnimation(2)
	player:sendStatus()
	player:updateState()
end
}

flower_sister3 = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	flower_sister3.regen(mob)
	flower_sister3.throw(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	flower_sister3.regen(mob)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.paralyzed = false
		mob.sleep = 1
	end

	flower_sister3.throw(mob, target)


	local mobBlocks = mob:getObjectsInSameMap(BL_MOB)
	local ownedMobs = 0
	local maxOwnedMobs = 2
	
	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mobBlocks[i].owner == mob.ID) then
				ownedMobs = ownedMobs + 1
			end
		end
	end
	
	if (ownedMobs < maxOwnedMobs) then
		for i = 1, 4 do
			local spawnMob = 151
			local spawnedMob
			local x
			local y
			
			repeat
				x = mob.x + math.random(0, 1)
				y = mob.y + math.random(0, 1)
			until ((x > 0 or y > 0) and getPass(mob.m, x, y) == 0 and (x < mob.xmax and y < mob.ymax))
			
			spawnedMob = mob:spawn(spawnMob, x, y, 1)[1]
			spawnedMob.owner = mob.ID
		end
	end
	
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	flower_sister3.regen(mob)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.paralyzed = false
		mob.sleep = 1
	end

	mob_ai_basic.attack(mob, target)
end,

after_death = function(mob, attacker)

end,

regen = function(mob)
	if (mob.paralyzed or mob.sleep ~= 1 or mob.registry["regen"] > os.time()) then
		return
	end
	
	local amt = 18 + math.random(3)

	if (mob.health < mob.maxHealth) then
		if (mob.health + amt >= mob.maxHealth) then
			mob.health = mob.maxHealth
		else
			mob.health = mob.health + amt
		end
	end
	mob.registry["regen"] = os.time() + 1
end,

throw = function(mob, target)
	if (mob.registry["throw"] > os.time() or math.random(100) < 5) then
		return
	end
	if (target == nil) then
		local pcBlocks = mob:getObjectsInArea(BL_PC)
		if (#pcBlocks > 0) then
			target = pcBlocks[math.random(#pcBlocks)]
		end
	end
	
	local damage = 1100 + math.random(-7, 13)
	mob:throw(target.x, target.y, 4117, 0, 1)
	target.attacker = mob.ID
	target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	mob.registry["throw"] = os.time() + 8
end
}