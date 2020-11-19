wind_spirit_boss = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	wind_spirit_boss.windstrike(mob)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.paralyzed = false
		mob.sleep = 1
	end

	wind_spirit_boss.windstrike(mob, target)
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	wind_spirit_boss.windstrike(mob, target)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.paralyzed = false
		mob.sleep = 1
	end

	mob_ai_basic.attack(mob, target)
end,

after_death = function(mob, attacker)

end,

windstrike = function(mob, target)
	if (target == nil) then
		return
	end
	if (target.state == 1) then
		return
	end
	if (mob.registry["windstrike"] > os.time()) then
		return
	end
	if (target.blType ~= BL_PC) then
		return
	end
	local damage = math.random(500, 1000)
	
		if (target.m == mob.m) then
			canPush(mob, target)
			target:sendAnimation(15)
			mob:playSound(93)
			target.attacker = mob.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mob.registry["windstrike"] = os.time() + 3
		end
end
}