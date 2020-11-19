tsugua_boss = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

after_death = function(mob, attacker, block)
	--[[local spawn = { }
	spawn = mob:spawn(209,mob.x,mob.y,1)
	local plusx
	local pluxy
	local x
	local y

		for i = 1, 5 do

			plusx = math.random(-4, 4)
			plusy = math.random(-4, 4)

			if((mob.x + plusx) < 0 )then
				plusx = 0
			end
			if((mob.x + plusx) > mob.xmax) then
				plusx = 0
			end

			if((mob.y + plusy) < 0) then
				plusy = 0
			end
			if((mob.y + plusy) > mob.ymax) then
				plusy = 0
			end
				x = (mob.x + plusx)
				y = (mob.y + plusy)
				mobCheck = mob:getObjectsInCell(mob.m, x, y, BL_MOB)
				pcCheck = mob:getObjectsInCell(mob.m, x, y, BL_PC)

			if (getPass(mob.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0) then
				mob:dropItemXY(280, 1, mob.m, mob.x + plusx, mob.y + plusy)
			end

		end
	--mob:dropItemXY(280, 1, mob.m, mob.x, mob.y, attacker.id)

	for i = 1, #attacker.group do
		if (not Player(attacker.group[i]):hasLegend("the_dark_sorcerer2015")) then
			Player(attacker.group[i]):addLegend("Defended the Empire against the Dark Sorcerer. "..curT(), "the_dark_sorcerer2015", 1, 16)
		end
	end--]]

end,

on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	tsugua_boss.zap(mob, target)
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	tsugua_boss.zap(mob, target)
	mob_ai_basic.attack(mob, target)
end,

zap = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local damage = (target.maxHealth * .25)
	local aethers = math.random(2, 8)
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
			mob:playSound(39)

			for i = 1, #target.group do
				if (Player(target.group[i]).m == mob.m and Player(target.group[i]).state ~= 1) then
					Player(target.group[i]):sendAnimation(354, 0)
					Player(target.group[i]).attacker = mob.ID
					Player(target.group[i]):removeHealthExtend(damage, 1, 1, 1, 1, 0)
				end
			end

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

tsugua_boss_death = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
	mob:talk(1,"Tsugua: Ahahaha you think you can defeat me so easily?!")
	mob.registry["death_count"] = os.time()
end,

on_attacked = function(mob, attacker)
end,

move = function(mob, target)
	local aethers = 3
	
	if (os.time() >= mob.registry["death_count"] + aethers) then
		mob:sendAnimationXY(377, mob.x, mob.y)
		mob:playSound(60)
		mob:sendAnimationXY(393, mob.x, mob.y)
		mob:removeHealthWithoutDamageNumbers(mob.health)
	end
end,

attack = function(mob, target)
	local aethers = 3

	if (os.time() >= mob.registry["death_count"] + aethers) then
		mob:sendAnimationXY(377, mob.x, mob.y)
		mob:playSound(60)
		mob:sendAnimationXY(393, mob.x, mob.y)
		mob:removeHealthWithoutDamageNumbers(mob.health)
	end
end
}