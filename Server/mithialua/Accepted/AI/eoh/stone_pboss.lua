stone_pboss = {
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
		return
	end

	stone_pboss.unpara(mob)
	
	if (target.m == mob.m) then
		moved = stone_pboss.zap(mob, target)
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
	stone_pboss.move(mob, target)
end,

zap = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local damage = math.random(200, 270)
	local aethers = math.random(2, 3)
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
			if(math.random(0,6) == 0) then
			mob:talk(2,"Stone Gremlin: Mogre do gren za vet!")
			end
		if (rangeCheck and target ~= nil and distance(mob, target) <= range
			and os.time() >= mob.registry["zapCastTime"] + aethers) then
			--mob:sendAction(6, 40)
			mob:playSound(33)
			target:sendAnimation(176, 0)
			mob:sendAnimation(176, 0)
			target.attacker = mob.ID
			mob:addHealthExtend(damage, 0, 0, 0, 0, 0)
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