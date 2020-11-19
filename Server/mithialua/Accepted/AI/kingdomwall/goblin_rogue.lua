goblin_rogue = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	local pcTargetsAround = getTargetsAround(mob, BL_PC)
	local mobTargetsAround = getTargetsAround(mob, BL_MOB)
	local target = mob:getBlock(mob.target)
	local chance = math.random(100000)
	local targetFound = false
	
	if (not mob.paralyzed and mob.sleep == 1) then
		if (target ~= nil and #pcTargetsAround > 0) then
			for i = 1, #pcTargetsAround do
				if (pcTargetsAround[i].ID == target.ID and chance <= 30000) then
					targetFound = true
					canAmbush(mob, target)
					break
				end
			end
		end
		
		if (target ~= nil and not targetFound and #mobTargetsAround > 0) then
			for i = 1, #mobTargetsAround do
				if (mobTargetsAround[i].ID == target.ID and chance <= 30000) then
					targetFound = true
					canAmbush(mob, target)
					break
				end
			end
		end
		
		if (not targetFound and #pcTargetsAround > 0) then
			for i = 1, #pcTargetsAround do
				if (pcTargetsAround[i].ID == attacker.ID and chance <= 30000) then
					targetFound = true
					canAmbush(mob, attacker)
					break
				end
			end
		end
		
		if (not targetFound and #mobTargetsAround > 0) then
			for i = 1, #mobTargetsAround do
				if (mobTargetsAround[i].ID == attacker.ID and chance <= 30000) then
					canAmbush(mob, attacker)
					break
				end
			end
		end
	end
	
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	local chance = math.random(100000)
	
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	local pcTargetsAround = getTargetsAround(mob, BL_PC)
	local mobTargetsAround = getTargetsAround(mob, BL_MOB)
	local ambushChance = math.random(100000)
	local targetFound = false
	
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	if (#pcTargetsAround > 0) then
		for i = 1, #pcTargetsAround do
			if (pcTargetsAround[i].ID == target.ID and ambushChance <= 15000) then
				targetFound = true
				canAmbush(mob, target)
				break
			end
		end
	end
	
	if (not targetFound and #mobTargetsAround > 0) then
		for i = 1, #mobTargetsAround do
			if (mobTargetsAround[i].ID == target.ID and ambushChance <= 15000) then
				canAmbush(mob, target)
				break
			end
		end
	end
	
	mob_ai_basic.attack(mob, target)
end
}