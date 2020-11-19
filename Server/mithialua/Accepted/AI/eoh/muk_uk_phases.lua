mukuk_p1 = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

after_death = function(mob, attacker, block)
	local chancefor = math.random(0, 1)
	mob:sendAnimationXY(378, mob.x, mob.y)
	mob:playSound(92)

	if (chancefor == 0) then
		mob:spawn(218,mob.x,mob.y,1)
	else
		mob:spawn(219,mob.x,mob.y,1)
	end
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.sleep = 1
		mob.paralyzed = false
		return
	end

	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	mob_ai_basic.attack(mob, target)
end
}

mukuk_caster = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.sleep = 1
		mob.paralyzed = false
		return
	end

	mukuk_caster.zap(mob, target)
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.sleep = 1
		mob.paralyzed = false
		return
	end

	mukuk_caster.zap(mob, target)
	mob_ai_basic.attack(mob, target)
end,

zap = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local damage = (target.maxHealth * .25)
	local aethers = math.random(2, 10)
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
		if (rangeCheck and target ~= nil and distance(mob, target) <= range
			and os.time() >= mob.registry["zapCastTime"] + aethers) then
			mob:sendAction(6, 40)
			mob:playSound(21)

			--if (#target.group > 0) then
			local i = math.random(#target.group)
			--else
			--	local this_target = 0
			--end

			--for i = 1, #target.group do
				if (Player(target.group[i]).m == mob.m and Player(target.group[i]).state ~= 1) then
					Player(target.group[i]):sendAnimation(335, 0)
					Player(target.group[i]).attacker = mob.ID
					Player(target.group[i]):removeHealthExtend(damage, 1, 1, 1, 1, 0)
				end
			--end

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

end
}

mukuk_fighter = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.sleep = 1
		mob.paralyzed = false
		return
	end

	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.sleep = 1
		mob.paralyzed = false
		return
	end

	mob_ai_basic.attack(mob, target)
end
}