tutorial_witch = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

after_death = function(mob, attacker, block)

	for i = 1, #attacker.group do
		if (Player(attacker.group[i]).quest["path_choice_quest"] == 6) then
			Player(attacker.group[i]).quest["path_choice_quest"] = 7
		end
	end
	local spawn = { }
	mob:sendAnimationXY(149,mob.x,mob.y,1)
	spawn = mob:spawn(16,mob.x,mob.y,1)
	spawn.side = mob.side
	spawn:sendSide()
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
		return
	end

	tutorial_witch.unpara(mob)
	tutorial_witch.a_trap(mob, target)

	if(math.random(0,3) == 1) then
		tutorial_witch.heal(mob)
	end
	
	if (target.m == mob.m) then
		moved = tutorial_witch.zap(mob, target)
	end
	
	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
		mob.newMove = 250
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
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
		mob.returning = false
	end
end,

attack = function(mob, target)
	mob.state = MOB_ALIVE
	tutorial_witch.move(mob, target)
end,

zap = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local damage = math.random(55, 100)
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
			mob:talk(2,"*Cackles* Ehehehe!")
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

a_trap = function(mob, target)
	local aethers = math.random(2, 4)
	--local xrange = math.random(1, 15)
	--local yrange = math.random(4, 11)
	if (target ~= nil and os.time() >= mob.registry["appletrapCastTime"] + aethers) then
			if(math.random(0,6) == 0) then
			mob:talk(0,"Wicked Witch: Here deer-y HAVE A BITE!")
			end
		if (mob.side == 1) then
			local newX = mob.x + math.random(2, 4)
			local newY = mob.y
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
				if (passCheck == 0 and tileCheck == 986 and (newX >= 1 and newX <= 15) and (newY >= 4 and newY <= 11)) then
					mob:addNPC("apple_trap", mob.m, newX, newY, 0, 80000, 0)
					mob:sendAction(2, 20)
					mob:dropItemXY(36, 1, mob.m, newX, newY, 1)
				end
		elseif (mob.side == 3) then
			local newX = mob.x - math.random(2, 4)
			local newY = mob.y
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
				if (passCheck == 0 and tileCheck == 986 and (newX >= 1 and newX <= 15) and (newY >= 4 and newY <= 11)) then
					mob:addNPC("apple_trap", mob.m, newX, newY, 0, 80000, 0)
					mob:sendAction(2, 20)
					mob:dropItemXY(36, 1, mob.m, newX, newY, 1)
				end
		elseif (mob.side == 0) then
			local newX = mob.x
			local newY = mob.y - math.random(2, 4)
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
				if (passCheck == 0 and tileCheck == 986 and (newX >= 1 and newX <= 15) and (newY >= 4 and newY <= 11)) then
					mob:addNPC("apple_trap", mob.m, newX, newY, 0, 80000, 0)
					mob:sendAction(2, 20)
					mob:dropItemXY(36, 1, mob.m, newX, newY, 1)
				end
		elseif (mob.side == 2) then
			local newX = mob.x
			local newY = mob.y + math.random(2, 4)
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
				if (passCheck == 0 and tileCheck == 986 and (newX >= 1 and newX <= 15) and (newY >= 4 and newY <= 11)) then
					mob:addNPC("apple_trap", mob.m, newX, newY, 0, 80000, 0)
					mob:sendAction(2, 20)
					mob:dropItemXY(36, 1, mob.m, newX, newY, 1)
				end
		end
		mob.registry["appletrapCastTime"] = os.time()
		--addSpotTrap(mob, mob.m, mob.x, mob.y)
	end
end,

heal = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local healTargets = {} 
	local target = mob
	local heal = math.random(100, 150)
	
	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 117 or mobBlocks[i].mobID == 118)
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
	local aethers = math.random(2,5)
	
	if(os.time() >= mob.registry["zapCastTime"] + aethers) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 117 or mobBlocks[i].mobID == 118)
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