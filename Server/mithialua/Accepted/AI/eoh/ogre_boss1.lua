ogre_boss1 = {
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
	end

	if (mob.registry["clobberTime"] > 0 and target ~= nil) then
		ogre_boss1.clobber(mob, target)
		return
	end

	if(target ~= nil and target.state == 1) then
		target:setThreat(0)
		return
	end

	mob_ai_basic.move(mob, target)

	if(math.random(0,5) == 1 and mob.registry["clobberTime"] == 0 and target ~= nil) then
		--ogre_boss1.clobber(mob)
		mob.registry["clobberTime"] = os.time()
		if (mob.mobID == 166) then
		mob:talk(2,"Grukor: *Begins to wind up a large attack*")
		else
		mob:talk(2,"Guiruk: *Begins to wind up a large attack*")
		end
	end

end,

clobber = function(mob, target)
local unleashtime = 4

if(os.time() >= mob.registry["clobberTime"] + unleashtime and mob.registry["clobberTime"] ~= 0) then

	local playerBlocks = mob:getObjectsInArea(BL_PC)
	local range = 2
	local damage = 50000

		if (#playerBlocks > 0) then
					mob:sendAction(1, 40)
					mob:playSound(369)
					mob:playSound(2)
			for i = 1, #playerBlocks do
				if (distance(mob, playerBlocks[i]) <= range) then
					if (playerBlocks[i].state ~= 1) then
						playerBlocks[i]:sendAnimation(305, 0)
						playerBlocks[i].attacker = mob.ID
						--playerBlocks[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						playerBlocks[i]:die()
						playerBlocks[i]:updateState()
					end
				end
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

	if(math.random(0,5) == 1 and mob.registry["clobberTime"] == 0 and target ~= nil) then
		--ogre_boss1.clobber(mob)
		mob.registry["clobberTime"] = os.time()
		if (mob.mobID == 166) then
		mob:talk(2,"Grukor: *Begins to wind up a large attack*")
		else
		mob:talk(2,"Guiruk: *Begins to wind up a large attack*")
		end
	end

	if (mob.registry["clobberTime"] > 0) then
		ogre_boss1.clobber(mob, target)
		return
	end

	ogre_boss1.clobber(mob, target)
	
	mob_ai_basic.attack(mob, target)
	mob:flank()
end
}