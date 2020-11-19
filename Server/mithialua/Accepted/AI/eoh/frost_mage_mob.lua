frost_mage_mob = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

after_death = function(mob, attacker, block)
	mob:sendAnimationXY(149,mob.x,mob.y,1)
end,

on_spawn = function(mob)
	--mob.side = 2
	--mob:sendSide()
end,

on_attacked = function(mob, attacker)
	--local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local rangeCheck = false
	local shield_aethers = math.random(21, 25)
	

	if (mob:hasDuration("ice_shield")) then
		if (mob.registry["magic_shielded"] > 0) then
			mob:sendAnimation(99)
			if (mob.registry["magic_shielded"] > attacker.damage) then
					mob.registry["magic_shielded"] = mob.registry["magic_shielded"] - attacker.damage
					attacker.damage = 0
					--attacker:sendMinitext("Ice Shield: "..mob.registry["magic_shielded"]..".")
					--attacker:sendMinitext("Mana: "..mob.magic..".")
			else
					attacker.damage = attacker.damage - mob.registry["magic_shielded"]
					mob.registry["magic_shielded"] = 0
			end
		end
	end

	if (not mob.paralyzed and mob.sleep == 1) then
		--if (#mobBlocks > 0) then
		--	for i = 1, #mobBlocks do
		--		if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].owner == 0 or mobBlocks[i].mobID == 117 or mobBlocks[i].mobID == 118)) then
		--			rangeCheck = true
		--			break
		--		end
		--	end
		--end
		
		if (attacker.critChance ~= 0 and ((attacker.x == mob.x and (attacker.y == mob.y + 1 or attacker.y == mob.y - 1))
		or (attacker.y == mob.y and (attacker.x == mob.x + 1 or attacker.x == mob.x - 1))) and not rangeCheck) then
			RunAway(mob, attacker)
		end
	end

	if (mob.magic >= 1000) then
		if (os.time() >= mob.registry["frost_shieldCastTime"] + shield_aethers) then
			mob.registry["frost_shieldCastTime"] = os.time()
			frost_mage_mob.ice_shield_cast(mob)
		end
	end
	
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	local found
	local moved = false
	local oldside = mob.side
	local checkmove = math.random(0,10)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob:sendAction(6, 40)
		mob:sendAnimation(10)
		mob:playSound(34)--13
		mob.paralyzed = false
		mob.sleep = 1
		--mob:flushDuration(5)
		return
	end
	mob_ai_basic.move(mob)
	frost_mage_mob.unpara(mob)

	if(math.random(0,3) == 1) then
		frost_mage_mob.heal(mob)
	end
	
	if (target.m == mob.m) then
		moved = frost_mage_mob.zap(mob, target)
		moved = frost_mage_mob.avalanche_cast(mob, target)
	end
	
	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
		mob.newMove = 250
		mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end

	if (mob.returning == true) then
		found = toStart(mob, mob.startX, mob.startY)
		
	else
		if (mob.target > 0) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
		end
	
		if (mob.state ~= MOB_HIT and mob.owner == 0 and not moved) then
			if (checkmove >= 4) then
				mob.side = math.random(0, 3)
				mob:sendSide()
				if (mob.side == oldside) then
					mob:move()
				end
			else
				mob:move()
			end
		end
	end
	
	if (found == true) then
		mob.newMove = 0
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
end,

attack = function(mob, target)
	mob.state = MOB_ALIVE
	frost_mage_mob.move(mob, target)
end,

ice_shield_cast = function(mob, target)
	if (not mob:hasDuration("ice_shield")) then
		local shield = ((mob.maxMagic  / 2) * .02) * (mob.will / 3)

		local dura = 20000
		local aether = 65000
			
		mob:sendAction(6,35)
		mob:playSound(71)
		mob:setDuration("ice_shield", dura)

		--if (player.dmgShield < (player.maxHealth * 0.75)) then
		--	player.dmgShield = math.floor(player.dmgShield + (will / 5))
		--end
		mob.registry["magic_shielded"] = shield
		mob:sendAnimation(99)--56 66 90 98 110 251 295 323
	end
end,

zap = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local damage = math.random(mob.minDam, mob.maxDam)
	local aethers = math.random(2, 3)
	local range = 10
	
	--frost_mage_mob.ice_shield_cast(mob)
	--mob:talk(2,"zaptime: "..mob.registry["zapCastTime"].." wither aethers "..mob.registry["zapCastTime"] + aethers.." os time: "..os.time())

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (distance(mob, mobBlocks[i]) <= range) then
					rangeCheck = true
					break
				end
			end
		end
			if(math.random(0,6) == 0) then
			mob:talk(2,"**Stares at you with a piercing chill**")
			end
		if (rangeCheck and target ~= nil and distance(mob, target) <= range
			and os.time() >= mob.registry["zapCastTime"] + aethers) then

			--target:setDuration("avalanche",10000)
			--target.registry["counter_avalanche"] = 1

			mob:sendAction(6, 40)
			mob:playSound(46)
			target:sendAnimation(24, 0)
			target.attacker = mob.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
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

end,

avalanche_cast = function(mob, target)
	local aethers = math.random(20, 25)
	local range = 10
	local rangeCheck = false
	--local ava_targets = mob:getObjectsInArea(BL_PC)
	--local heal = math.random(100, 150)

	if (#target.group > 0 and os.time() >= mob.registry["avaCastTime"] + aethers) then
		local rand_targ = math.random(#target.group)

			if (distance(mob, Player(target.group[rand_targ])) <= range) then
				rangeCheck = true
			end

			if(rangeCheck == true) then
				if(not Player(target.group[rand_targ]):hasDuration("avalanche")) then
					mob:sendAction(6, 40)
					Player(target.group[rand_targ]):setDuration("avalanche",10000)
					Player(target.group[rand_targ]).registry["counter_avalanche"] = 1
					Player(target.group[rand_targ]):playSound(60)
					
					mob.registry["avaCastTime"] = os.time()
				end
			end

	end
		--return
	--end
end,

heal = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local healTargets = {} 
	local target = mob
	local heal = math.random(100, 150)
	
	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 117 or mobBlocks[i].mobID == 118)
			and mobBlocks[i].health ~= mobBlocks[i].maxHealth) then
				table.insert(healTargets, mobBlocks[i])
			end
		end
	end
	
	if (#healTargets > 0) then
		for i = 1, #healTargets do
			if (healTargets[i].health / healTargets[i].maxHealth < target.health / target.maxHealth) then
				target = healTargets[i]
			end
		end
	end
	
	if(mob.registry["sequence"] < 0) then
		target.attacker = mob.ID
		mob:sendAction(6, 40)
		target:sendAnimation(5)
		mob:playSound(708)
		target:addHealthExtend(heal, 0, 0, 0, 0, 0)
		mob.registry["sequence"] = mob.registry["sequence"] + 1
		
		if(target.health >= (target.maxHealth - 200)) then
			mob.registry["sequence"] = 0
		end
	end
	
	if (target.health <= (target.maxHealth - target.maxHealth/3)) then
		mob.registry["sequence"] = -math.random(1,2)
	end

end,


unpara = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local target = mob
	local aethers = math.random(2,5)
	
	if(os.time() >= mob.registry["zapCastTime"] + aethers) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 117 or mobBlocks[i].mobID == 118)
				and mobBlocks[i].paralyzed == true) then
					target = mobBlocks[i]
					target:sendAnimation(10)
					target.paralyzed = false
					return
				end
			end
		end

	end
end
}

avalanche = {
cast = function(player, target)
	local aether = 2000
	local duration = 8000
	local damage = 500--player.level + (player.will*2)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (target:hasDurationID("avalanche", player.id)) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("avalanche", aether)
		player:sendStatus()
		player:playSound(370)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(46, 1)
			target:setDuration("avalanche", duration, player.id)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("avalanche", aether)
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(46, 1)
			target:setDuration("avalanche", duration, player.id)
		--end
	end
end,

while_cast = function(block, caster)
	block.registry["counter_avalanche"] = block.registry["counter_avalanche"] + 1
	block:sendAnimation(359, 0)

	if (block.registry["counter_avalanche"] == 7) then
		local damage = 5000
		local block_dam = 5000
		local targets = {}

		block:playSound(48)
		block:sendAnimation(187, 0)
		block:removeHealthExtend(block_dam, 1, 1, 1, 1, 0)
		targets = getTargetsAroundPhase(block, BL_PC, 1)

		block:sendAnimationXY(25, block.x, block.y - 1, 1)
		block:sendAnimationXY(25, block.x + 1, block.y, 1)
		block:sendAnimationXY(25, block.x, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 1, block.y, 1)

		if (#targets > 0) then

			for i = 1, #targets do
				if (targets[i].blType == BL_PC) then
					targets[i].attacker = block.ID		
					targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
					targets[i]:sendAnimation(187, 0)
				end
			end
		end

	end

	if (block.registry["counter_avalanche"] == 8) then
		local damage = 5000
		local block_dam = 5000
		local targets = {}

		block:playSound(48)
		block:sendAnimation(187, 0)
		block:removeHealthExtend(block_dam, 1, 1, 1, 1, 0)
		targets = getTargetsAroundPhase(block, BL_PC, 2)

		block:sendAnimationXY(25, block.x, block.y - 2, 1)
		block:sendAnimationXY(25, block.x + 2, block.y, 1)
		block:sendAnimationXY(25, block.x, block.y + 2, 1)
		block:sendAnimationXY(25, block.x - 2, block.y, 1)

		block:sendAnimationXY(25, block.x + 1, block.y - 1, 1)
		block:sendAnimationXY(25, block.x + 1, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 1, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 1, block.y - 1, 1)

		if (#targets > 0) then

			for i = 1, #targets do
				if (targets[i].blType == BL_PC) then
					targets[i].attacker = block.ID		
					targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
					targets[i]:sendAnimation(187, 0)
				end
			end
		end

	end

	if (block.registry["counter_avalanche"] == 9) then
		local damage = 5000
		local block_dam = 5000
		local targets = {}

		block:playSound(48)
		block:sendAnimation(187, 0)
		block:removeHealthExtend(block_dam, 1, 1, 1, 1, 0)
		targets = getTargetsAroundPhase(block, BL_PC, 3)

		block:sendAnimationXY(25, block.x, block.y - 3, 1)
		block:sendAnimationXY(25, block.x + 3, block.y, 1)
		block:sendAnimationXY(25, block.x, block.y + 3, 1)
		block:sendAnimationXY(25, block.x - 3, block.y, 1)

		block:sendAnimationXY(25, block.x + 1, block.y - 2, 1)
		block:sendAnimationXY(25, block.x + 1, block.y + 2, 1)
		block:sendAnimationXY(25, block.x - 1, block.y + 2, 1)
		block:sendAnimationXY(25, block.x - 1, block.y - 2, 1)

		block:sendAnimationXY(25, block.x + 2, block.y - 1, 1)
		block:sendAnimationXY(25, block.x + 2, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 2, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 2, block.y - 1, 1)

		if (#targets > 0) then

			for i = 1, #targets do
				if (targets[i].blType == BL_PC) then
					targets[i].attacker = block.ID		
					targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
					targets[i]:sendAnimation(187, 0)
				end
			end
		end
		block:setDuration("avalanche", 0)

	end
end,

uncast = function(player)
	--player:sendAnimation(133, 0)
	--player:sendMinitext("Your mana stops regenerating.")
end,
}