booger_test = {
on_healed = function(mob, healer)
	mob:talk(1,"Value: "..mob.mrespawnfunc)
	healer.damage = 0
end,
}

elder_spirit_tree = {
on_healed = function(mob, healer)
	if (mob.health >= 500 and mob.registry["treegrowth"] == 0) then
		setObject(74, 58, 102, 18412)
		mob.registry["treegrowth"] = 1
	end
	if (mob.health >= 800 and mob.registry["treegrowth"] == 1) then
		setObject(74, 58, 101, 18413)
		mob.registry["treegrowth"] = 2
	end
	if (mob.health >= 1200 and mob.registry["treegrowth"] == 2) then
		setObject(74, 58, 100, 18410)
		setObject(74, 57, 100, 18409)
		setObject(74, 59, 100, 18411)
		mob.registry["treegrowth"] = 3
		mob.registry["lifeduration"] = os.time() + 10
		if(healer.class==12) then
		mob.mapRegistry["druidentrance"] = 1
		end
		if(healer.class==4) then
			healer.registry["join_Druid"] = 1
		end
	end
	--healer:sendMinitext("Ethereal calling.")
	--mob.attacker = healer.ID
	if(mob.registry["treegrowth"] ~= 3) then
		mob:sendHealth(healer.damage, healer.critChance)
	end
	--healer.damage = 0
end,

on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
	mob.health = 10
		setObject(74, 58, 102, 0)
		setObject(74, 58, 101, 0)
		setObject(74, 58, 100, 0)
		setObject(74, 57, 100, 0)
		setObject(74, 59, 100, 0)
	mob.registry["lifeduration"] = 0
end,

on_attacked = function(mob,attacker)
elder_spirit_tree.move(mob, target)
end,

attack = function(mob, target)
elder_spirit_tree.move(mob, target)
end,

move = function(mob, target)
	if (mob.registry["lifeduration"] ~= 0 and mob.registry["lifeduration"] <= os.time() and mob.registry["treephase"] == 0) then
	mob.registry["treephase"] = 1
	end
	if (mob.registry["treephase"] > 0) then
	mob.health = mob.health - 100
	mob:sendHealth(0, 0)
	end
	if (mob.health <= 1100 and mob.registry["treephase"] == 1) then
		mob:talk(1,"*The Elder Spirit Tree creaks and shudders*")
		setObject(74, 58, 100, 0)
		setObject(74, 57, 100, 0)
		setObject(74, 59, 100, 0)
		mob.mapRegistry["druidentrance"] = 0
		mob.registry["treephase"] = 2
	end
	if (mob.health <= 800 and mob.registry["treephase"] == 2) then
		setObject(74, 58, 101, 0)
		mob.registry["treephase"] = 3
		mob:talk(1,"*The Elder Spirit Tree creaks and shudders*")
	end
	if (mob.health <= 500 and mob.registry["treephase"] == 3) then
		mob.registry["lifeduration"] = 0
		mob.health = 10
		setObject(74, 58, 102, 0)
		mob:talk(1,"*The Elder Spirit Tree creaks and shudders*")
		mob.registry["treephase"] = 0
		mob.registry["treegrowth"] = 0
	end
end,

regen = function(mob)
	if (mob.paralyzed or mob.sleep ~= 1 or mob.registry["regen"] > os.time()) then
		return
	end
	
	local amt = 1 + math.random(2)

	if (mob.health < mob.maxHealth) then
		if (mob.health + amt >= mob.maxHealth) then
			mob.health = mob.maxHealth
		else
			mob.health = mob.health + amt
		end
	end
	mob.registry["regen"] = os.time() + 1
end
}