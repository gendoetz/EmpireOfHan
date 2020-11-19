serpent_boss = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	serpent_boss.glare(mob)
	serpent_boss.poison(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	serpent_boss.poison(mob)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.paralyzed = false
		mob.sleep = 1
	end

	serpent_boss.glare(mob, target)
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	serpent_boss.glare(mob)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.paralyzed = false
		mob.sleep = 1
	end

	mob_ai_basic.attack(mob, target)
end,

after_death = function(mob, attacker)

end,

glare = function(mob, target)
	if (target == nil) then
		return
	end
	if (target.state == 1) then
		return
	end
	if (mob.registry["glare"] > os.time()) then
		return
	end
	if (target.blType ~= BL_PC) then
		return
	end
	local damage = math.random(10, 150)
	damage = damage + math.floor(target.maxMagic * 0.015)
	damage = damage + math.ceil(target.magic * 0.0218)
	
	target:removeMagic(damage)
	target.attacker = mob.ID
	target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	target:sendAnimation(88)
	if (target.blType == BL_PC) then
		target:sendMinitext("Your will weakens as you stare into their eyes.")
	end
	if not (target:hasDuration("serpent_poison")) then
		target:setDuration("serpent_poison", 10000)
	end
	
	mob:sendAction(6, 40)
	mob:playSound(86)
	mob.registry["glare"] = os.time() + 8
end,

poison = function(mob, target)
	if (target == nil) then
		return
	end
	if (target.state == 1) then
		return
	end

	if (mob.registry["poison"] > os.time()) then
		return
	end
	local damage = math.random(150, 225)
	damage = damage + target.baseHealth * 0.07
	damage = damage + target.health * 0.03
	--[[
	if (target:hasDuration("turtle_shell") == true or target.deduction == -1) then
		damage = damage / (math.random(25, 50) / 10)
	end]]--
	target.attacker = mob.ID
	target:removeHealthExtend(damage, 1, 0, 1, 1, 0)
	target:sendAnimation(84)
	
	if (target.blType == BL_PC) then
		target:sendMinitext("You feel the corrosion down to your soul.")
	end
	mob:playSound(13)
	mob:sendAction(6, 40)
	mob.registry["poison"] = os.time() + math.random(3, 5)
end,
}

serpent_poison = {
while_cast = function(player)
	local damage = 20
	
	player.attacker = player.ID
	player:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	player:sendAnimation(1)
end
}