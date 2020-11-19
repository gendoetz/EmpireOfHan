voodoo_totem = {
on_healed = function(mob, healer)
	mob.attacker = healer.ID
	--mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob, attacker)
	if (attacker:hasDuration("amplify")) then
		local damagemod = attacker.damage * .3
		attacker.damage = attacker.damage + damagemod
	end
	
	mob.attacker = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,

after_death = function(mob, attacker)
	mob:sendAnimationXY(153,mob.x,mob.y+1,0)
	setObject(mob.m, mob.x, mob.y, 0)
	setObject(mob.m, mob.x, mob.y+1, 0)
	setObject(mob.m, mob.x+1, mob.y+1, 0)
	setObject(mob.m, mob.x-1, mob.y+1, 0)

	mob:playSound(712)
end,

on_spawn = function(mob)
	local lifetimer = 10
	local goodORbad = math.random(1, 2)
	local leftright = math.random(1, 2)
	mob.registry["totem_LR"] = leftright
	mob.registry["lifeduration"] = os.time() + lifetimer

	local objCheckright
	local passCheckright
	local objCheckleft
	local passCheckleft

	local objCheckon
	local passCheckon

	local randx = math.random(-4, 4)
	local randy = math.random(-4, 4)
						
	local objCheckright_ = getObject(mob.m, (mob.startX + randx)+1, (mob.startY + randy)+1)
	local passCheckright_ = getPass(mob.m, (mob.startX + randx)+1, (mob.startY + randy)+1)
	local objCheckmid_ = getObject(mob.m, (mob.startX + randx), (mob.startY + randy)+1)
	local passCheckmid_ = getPass(mob.m, (mob.startX + randx), (mob.startY + randy)+1)
	local objCheckleft_ = getObject(mob.m, (mob.startX + randx)-1, (mob.startY + randy)+1)
	local passCheckleft_ = getPass(mob.m, (mob.startX + randx)-1, (mob.startY + randy)+1)
	local objCheckon_ = getObject(mob.m, (mob.startX + randx), (mob.startY + randy))
	local passCheckon_ = getPass(mob.m, (mob.startX + randx), (mob.startY + randy))

	if (objCheckright_ == 0 and objCheckleft_ == 0 and objCheckmid_ == 0 and objCheckon_ == 0 and passCheckright_ == 0 and passCheckleft_ == 0 and passCheckmid_ == 0 and passCheckon_ == 0) then
		mob:warp(mob.m, mob.startX + randx, mob.startY + randy)
	end

	if (leftright == 1) then
		objCheckright = getObject(mob.m, mob.x+1, mob.y+1)
		passCheckright = getPass(mob.m, mob.x+1, mob.y+1)
		objCheckleft = getObject(mob.m, mob.x, mob.y+1)
		passCheckleft = getPass(mob.m, mob.x, mob.y+1)
	else
		objCheckright = getObject(mob.m, mob.x, mob.y+1)
		passCheckright = getPass(mob.m, mob.x, mob.y+1)
		objCheckleft = getObject(mob.m, mob.x-1, mob.y+1)
		passCheckleft = getPass(mob.m, mob.x-1, mob.y+1)
	end

		objCheckon = getObject(mob.m, mob.x, mob.y)
		passCheckon = getPass(mob.m, mob.x, mob.y)


	if (goodORbad == 1) then --good totems
		mob.registry["totem_type"] = math.random(1, 2)

		if (objCheckright == 0 and objCheckleft == 0 and passCheckright == 0 and passCheckleft == 0) then
			setObject(mob.m, mob.x, mob.y, 10818)
			if (mob.registry["totem_LR"] == 1) then
				setObject(mob.m, mob.x, mob.y+1, 12865)
				setObject(mob.m, mob.x+1, mob.y+1, 12866)
			else
				setObject(mob.m, mob.x-1, mob.y+1, 12865)
				setObject(mob.m, mob.x, mob.y+1, 12866)
			end
		end
	elseif (goodORbad == 2) then -- bad totems
		mob.registry["totem_type"] = math.random(3, 4)

		if (objCheckright == 0 and objCheckleft == 0 and passCheckright == 0 and passCheckleft == 0) then
			setObject(mob.m, mob.x, mob.y, 12906)
			if (mob.registry["totem_LR"] == 1) then
				setObject(mob.m, mob.x, mob.y+1, 12867)
				setObject(mob.m, mob.x+1, mob.y+1, 12868)
			else
				setObject(mob.m, mob.x-1, mob.y+1, 12867)
				setObject(mob.m, mob.x, mob.y+1, 12868)
			end
		end
	end

	mob:sendAnimationXY(85, mob.x, mob.y, 0)
	mob:playSound(96)
end,

move = function(mob, target)
	local range = 4
	local playsoundonce = 0

			local objCheckon = getObject(mob.m, mob.x, mob.y)
			if (objCheckon == 0) then
				--respawn!
				
				if (mob.registry["totem_type"] == 1 or mob.registry["totem_type"] == 2) then
					setObject(mob.m, mob.x, mob.y, 10818)
					if (mob.registry["totem_LR"] == 1) then
						setObject(mob.m, mob.x, mob.y+1, 12865)
						setObject(mob.m, mob.x+1, mob.y+1, 12866)
					else
						setObject(mob.m, mob.x-1, mob.y+1, 12865)
						setObject(mob.m, mob.x, mob.y+1, 12866)
					end
				else
					setObject(mob.m, mob.x, mob.y, 12906)
					if (mob.registry["totem_LR"] == 1) then
						setObject(mob.m, mob.x, mob.y+1, 12867)
						setObject(mob.m, mob.x+1, mob.y+1, 12868)
					else
						setObject(mob.m, mob.x-1, mob.y+1, 12867)
						setObject(mob.m, mob.x, mob.y+1, 12868)
					end
				end
			end

	if (mob.registry["totem_type"] == 1) then --1 or 2 = good HEAL
		if (os.time() > (mob.registry["lifeduration"]-5)) then
			local pcBlocks = mob:getObjectsInArea(BL_PC)
			if (#pcBlocks > 0) then
				for i = 1, #pcBlocks do
					
					if ((distance(mob, pcBlocks[i]) <= range)) then
								playsoundonce = 1
								pcBlocks[i]:sendAnimation(5, 0)
								pcBlocks[i].attacker = pcBlocks[i].ID
								pcBlocks[i]:addHealthExtend((pcBlocks[i].maxHealth*.01), 0, 0, 0, 0, 0)
					end
				end
			end
			if (playsoundonce == 1) then
				mob:playSound(708)
				playsoundonce = 0
			end
		end
	end

	if (mob.registry["totem_type"] == 2) then --1 or 2 = good BOLSTER

		local pcBlocks = mob:getObjectsInArea(BL_PC)
		if (#pcBlocks > 0) then
			for i = 1, #pcBlocks do
				
				if ((distance(mob, pcBlocks[i]) <= range) and not pcBlocks[i]:hasDuration("totem_bolster")) then
							playsoundonce = 1
							pcBlocks[i]:sendAnimation(117, 0)
							pcBlocks[i]:setDuration("totem_bolster", 10000)
							pcBlocks[i].speed = 55
							pcBlocks[i]:calcStat()
							pcBlocks[i]:updateState()
				end
			end
		end
		if (playsoundonce == 1) then
			mob:playSound(28)
			playsoundonce = 0
		end

	end

	if (mob.registry["totem_type"] == 3) then --3 or 4 = bad SLOW

		local pcBlocks = mob:getObjectsInArea(BL_PC)
		if (#pcBlocks > 0) then
			for i = 1, #pcBlocks do
				
				if ((distance(mob, pcBlocks[i]) <= range) and not pcBlocks[i]:hasDuration("totem_slow")) then
							--playsoundonce = 1
							pcBlocks[i]:sendAnimation(258, 0)
							pcBlocks[i]:setDuration("totem_slow", 10000)
							pcBlocks[i].speed = 160
							pcBlocks[i].attackSpeed = pcBlocks[i].attackSpeed * 2
							pcBlocks[i]:calcStat()
							pcBlocks[i]:updateState()
				end
			end
		end
		--if (playsoundonce == 1) then
		--	mob:playSound(74)
		--	playsoundonce = 0
		--end

	end

	if (mob.registry["totem_type"] == 4) then --3 or 4 = bad HINDRANCE

		local pcBlocks = mob:getObjectsInArea(BL_PC)
		if (#pcBlocks > 0) then
			for i = 1, #pcBlocks do
				
				if ((distance(mob, pcBlocks[i]) <= range) and not pcBlocks[i]:hasDuration("hindrance3")) then
							playsoundonce = 1
							pcBlocks[i]:sendAnimation(53, 0)
							pcBlocks[i]:setDuration("hindrance3", 10000)
							pcBlocks[i]:calcStat()
				end
			end
		end
		if (playsoundonce == 1) then
			mob:playSound(43)
			playsoundonce = 0
		end

	end


		if (os.time() > mob.registry["lifeduration"]) then
			if (mob.registry["totem_type"] == 1 or mob.registry["totem_type"] == 2) then --1 or 2 = good
				mob.registry["lifeduration"] = os.time() + 10
				local damage = (mob.maxHealth * .05)
				mob:removeHealth(damage)
				mob:sendHealth(0, 0)
			end
		end

end,

attack = function(mob, target)
	voodoo_totem.move(mob, target)
end,
}

totem_slow = {
while_cast = function(block)
	block:sendAnimation(258, 0)
end,

recast = function(block)
	block.speed = 160
	block.attackSpeed = block.attackSpeed * 2
	--block:updateState()
	--block:sendStatus()
end,

uncast = function(block)
	if (block.blType == BL_PC) then
		if(not block:hasDuration("totem_bolster")) then
			block.speed = 80
		end
		block:updateState()
		block:sendStatus()
		block:calcStat()
	end
end,
}

totem_bolster = {
while_cast = function(block)
	block:sendAnimation(321, 0)
end,

recast = function(block)
	block.speed = 55
	block.deduction = block.deduction - .25
	--block.attackSpeed = block.attackSpeed * 2
	--block:updateState()
	--block:sendStatus()
end,

uncast = function(block)
	if (block.blType == BL_PC) then
		if(not block:hasDuration("totem_slow")) then
			block.speed = 80
		end
		block:updateState()
		block:sendStatus()
		block:calcStat()
	end
end,
}