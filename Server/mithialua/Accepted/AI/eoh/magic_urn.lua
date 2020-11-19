magic_urn = {
on_spawn = function(mob)
	local hasMoved = false
	
	if(mob.m == 529) then
		repeat
			local newX = math.random(3, 13)
			local newY = math.random(30, 47)
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
			local mobCheck = mob:getObjectsInCell(mob.m, newX, newY, BL_MOB)		
			
			if (passCheck == 0 and #mobCheck == 0 and tileCheck == 1572) then
				mob:warp(mob.m, newX, newY)
				hasMoved = true
			end
		until hasMoved
	end	
end,

on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

move = function(mob, target)
	if (mob.paralyzed == true) then
		mob:sendAnimation(10)
		mob.paralyzed = false
		mob:playSound(34)
	end

	if (target ~= nil and target.m == mob.m) then
		magic_urn.crumble_attack(mob, target)
		magic_urn.urn_paralysis(mob, target)
	end
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

attack = function(mob, target)
	mob.state = MOB_ALIVE
	magic_urn.move(mob, target)
end,

crumble_attack = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local damage = math.random(130, 170)
	local aethers = math.random(2, 3)
	local range = 3
	
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
			and os.time() >= mob.registry["zapCastTime"] + aethers) then
			mob:playSound(45)
			mob:sendAnimation(16, 0)
			target:sendAnimation(138, 0)
			target.attacker = mob.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mob.registry["zapCastTime"] = os.time()
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

urn_paralysis = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local aethers = math.random(14, 25)
	local range = 1
	
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
			mob:playSound(75)
			mob:sendAnimation(16, 0)
			target:sendAnimation(91, 9)
			target.attacker = mob.ID
			target:setDuration("paralysis", 10000)
			target.paralyzed = true
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