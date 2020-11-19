undead_captain1 = {
on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
end,

on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.paralyzed = false
		mob.sleep = 1
	end

	if (mob.registry["clobberTime"] > 0 and target ~= nil) then
		undead_captain1.clobber(mob, target)
		return
	end

	if(target ~= nil and target.state == 1) then
		target:setThreat(0)
		return
	end

	mob_ai_basic.move(mob, target)

	undead_captain1.clobber(mob, target)

	local playerBlocks = mob:getObjectsInArea(BL_PC)
	local range = 1
	local inrange = 1

	if (#playerBlocks > 0) then
		for i = 1, #playerBlocks do
				if (distance(mob, playerBlocks[i]) <= range) then
					inrange = 2
				end
		end

		if(math.random(0,5) == 1 and mob.registry["clobberTime"] == 0 and target ~= nil and inrange == 2) then
			--undead_captain1.clobber(mob)
			mob.registry["clobberTime"] = os.time()
			mob:talk(2,"Captain Bartolomeo: *Swipes his blade at you calling forth the undead...*")
		end
	end

end,

clobber = function(mob, target)
local unleashtime = 2
local mobBlocks

if(os.time() >= mob.registry["clobberTime"] + unleashtime and mob.registry["clobberTime"] ~= 0) then

	local playerBlocks = mob:getObjectsInArea(BL_PC)
	local range = 1
	local damage = 2500
	local facePCsame

		if (#playerBlocks > 0) then
					mob:sendAction(1, 500)
					mob:playSound(35)
			for i = 1, #playerBlocks do
				if (distance(mob, playerBlocks[i]) <= range) then
					
					if (playerBlocks[i].state ~= 1) then
						playerBlocks[i]:sendAnimation(60, 0)
						playerBlocks[i].attacker = mob.ID
						--playerBlocks[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						playerBlocks[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						mobBlocks = mob:getObjectsInSameMap(BL_MOB)
						if (#mobBlocks > 15) then
							mob.registry["clobberTime"] = 0
							return
						end
						mob:playSound(79)
						playerBlocks[i]:spawn(176, playerBlocks[i].x, playerBlocks[i].y, 1)
						facePCsame = mob:getObjectsInCell(playerBlocks[i].m, playerBlocks[i].x, playerBlocks[i].y, BL_MOB)
						facePCsame[1].side = playerBlocks[i].side
						facePCsame[1]:sendSide()
					end
				end
			end
		end
	mobBlocks = mob:getObjectsInSameMap(BL_MOB)
	
	for i = 1, #mobBlocks do
		if (mobBlocks[i].mobID == 176 and mobBlocks[i].owner == 0) then
			mobBlocks[i].owner = mob.ID
		end
	end

	mob.registry["clobberTime"] = 0
	return
end

end,

attack = function(mob, target)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.paralyzed = false
	end

	local playerBlocks = mob:getObjectsInArea(BL_PC)
	local range = 1
	local inrange = 1

	if (#playerBlocks > 0) then
		for i = 1, #playerBlocks do
				if (distance(mob, playerBlocks[i]) <= range) then
					inrange = 2
				end
		end

		if(math.random(0,5) == 1 and mob.registry["clobberTime"] == 0 and target ~= nil and inrange == 2) then
			--undead_captain1.clobber(mob)
			mob.registry["clobberTime"] = os.time()
			mob:talk(2,"Captain Bartolomeo: *Swipes his blade at you calling forth the undead...*")
		end
	end

	if (mob.registry["clobberTime"] > 0) then
		undead_captain1.clobber(mob, target)
		return
	end

	undead_captain1.clobber(mob, target)
	
	mob_ai_basic.attack(mob, target)
end
}