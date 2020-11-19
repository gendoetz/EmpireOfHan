bash = {
cast = function(player)
	local mobTargets = {}
	local pcTargets = {}
	local aether = 5000--22000
	local duration = 5000
	local damage = (player.maxHealth * 0.25) + (player.might * 15)
	local missing2 = damage * 2
	local threat
	local healthCost = (player.health * .03)
	local magicCost = (.02 * player.maxMagic)
	local recoilgraphic = 0

	--local baseDamage1 = 2 + (player.might * 2) + player.grace
	--local finalDamage1
	
		--local weaponDamage1 = math.floor(mathRandom(player.minDam / 2, player.maxDam / 2, 1000) + mathRandom(player.minDam / 2, player.maxDam / 2, 1000))
		
		--baseDamage1 = baseDamage1 * player.fury
		--weaponDamage1 = weaponDamage1 * player.enchant
		--finalDamage1 = (baseDamage1 + weaponDamage1) * player.rage * player.invis

	--damage = damage + (finalDamage1 * 24) + missing2
	
	if (player.registry["recoil_damagestored"] > 1) then
		damage = damage + player.registry["recoil_damagestored"]
		recoilgraphic = 246
	end

	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < healthCost) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player.side == 0) then
		mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1]}
	elseif (player.side == 1) then
		mobTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
	elseif (player.side == 2) then
		mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
	elseif (player.side == 3) then
		mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}
	end

	local mobTargetsFinal = {}
	local pcTargetsFinal = {}

	for i = 1, 3 do
		if (mobTargets[i] ~= nil) then
			if(mobTargets[i].protection ~= 1) then
				table.insert(mobTargetsFinal, mobTargets[i])
			end
		end
	end

	for i = 1, 3 do
		if (pcTargets[i] ~= nil) then
			if (player:canPK(pcTargets[i])) then
				table.insert(pcTargetsFinal, pcTargets[i])
			end
		end
	end

	if (#mobTargetsFinal == 0 and #pcTargetsFinal == 0) then
		player:sendMinitext("You cannot use this attack without a target in front of you.")
		return
	end
	
	player:sendAction(1, 20)
	player:setAether("bash", aether)
	player:sendMinitext("You use Bash.")
	player:playSound(10)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player.registry["recoil_damagestored"] = 1
	player:sendStatus()

	if ((#mobTargetsFinal + #pcTargetsFinal) == 3) then
		damage = damage / 3
	elseif ((#mobTargetsFinal + #pcTargetsFinal) == 2) then
		damage = damage / 2
	elseif ((#mobTargetsFinal + #pcTargetsFinal) == 1) then
		damage = damage
	end
			
	for i = 1, 3 do
		if (mobTargetsFinal[i] ~= nil) then
			mobTargetsFinal[i].attacker = player.ID
			threat = mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobTargetsFinal[i].ID, threat)
			
			if (#player.group > 1) then
				mobTargetsFinal[i]:setGrpDmg(player.ID, threat)
			else
				mobTargetsFinal[i]:setIndDmg(player.ID, threat)
			end
				if not (mobTargetsFinal[i]:hasDuration("bash")) then
					mobTargetsFinal[i]:setDuration("bash", duration)
					--mobTargets[i].snare = true
				end

				if (recoilgraphic == 246) then
					mobTargetsFinal[i]:sendAnimation(246, 0)
				end
			mobTargetsFinal[i]:sendAnimation(300, 0)
			mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTargetsFinal[i]:sendAnimationXY(300, mobTargetsFinal[i].x, mobTargetsFinal[i].y, 0)
		elseif (pcTargetsFinal[i] ~= nil) then
				if (recoilgraphic == 246) then
					pcTargetsFinal[i]:sendAnimation(246, 0)
				end
			pcTargetsFinal[i]:sendAnimation(300, 0)
			
			if (player:canPK(pcTargetsFinal[i])) then

				if not (pcTargetsFinal[i]:hasDuration("bash")) then
					pcTargetsFinal[i]:setDuration("bash", 5000)
					pcTargetsFinal[i]:calcStat()
				end
				
				pcTargetsFinal[i].attacker = player.ID
				pcTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				pcTargetsFinal[i]:sendMinitext(player.name.." bashes you.")
				pcTargetsFinal[i]:sendAnimationXY(300, pcTargetsFinal[i].x, pcTargetsFinal[i].y, 0)
			end
		end
	end
end,

recast = function(block)
	--block.snare = true
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		--block.snare = false
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Bash is a weak attack that targets three foes in front of you."}
	return level, items, itemAmounts, description
end
}

bash2 = {
on_learn = function(player)
	if (player:hasSpell("bash")) then
		player:removeSpell("bash")
	end
	
	player.registry["learned_bash"] = 1
end,

cast = function(player)
	local mobTargets = {}
	local pcTargets = {}
	local aether = 5000--22000
	local duration = 5000
	local damage = (player.maxHealth * 0.3) + (player.might * 20)
	local missing2 = damage * 2
	local threat
	local healthCost = (player.health * .03)
	local magicCost = (.02 * player.maxMagic)
	local recoilgraphic

	--local baseDamage1 = 2 + (player.might * 2) + player.grace
	--local finalDamage1
	
		--local weaponDamage1 = math.floor(mathRandom(player.minDam / 2, player.maxDam / 2, 1000) + mathRandom(player.minDam / 2, player.maxDam / 2, 1000))
		
		--baseDamage1 = baseDamage1 * player.fury
		--weaponDamage1 = weaponDamage1 * player.enchant
		--finalDamage1 = (baseDamage1 + weaponDamage1) * player.rage * player.invis

	--damage = damage + (finalDamage1 * 24) + missing2

	if (player.registry["recoil_damagestored"] > 1) then
		damage = damage + player.registry["recoil_damagestored"]
		recoilgraphic = 246
	end
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < healthCost) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player.side == 0) then
		mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1]}
	elseif (player.side == 1) then
		mobTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
	elseif (player.side == 2) then
		mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
	elseif (player.side == 3) then
		mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}
	end

	local mobTargetsFinal = {}
	local pcTargetsFinal = {}

	for i = 1, 3 do
		if (mobTargets[i] ~= nil) then
			if(mobTargets[i].protection ~= 1) then
				table.insert(mobTargetsFinal, mobTargets[i])
			end
		end
	end

	for i = 1, 3 do
		if (pcTargets[i] ~= nil) then
			if (player:canPK(pcTargets[i])) then
				table.insert(pcTargetsFinal, pcTargets[i])
			end
		end
	end

	if (#mobTargetsFinal == 0 and #pcTargetsFinal == 0) then
		player:sendMinitext("You cannot use this attack without a target in front of you.")
		return
	end
	
	player:sendAction(1, 20)
	player:setAether("bash2", aether)
	player:sendMinitext("You use Bash.")
	player:playSound(10)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player.registry["recoil_damagestored"] = 1
	player:sendStatus()

	if ((#mobTargetsFinal + #pcTargetsFinal) == 3) then
		damage = damage / 3
	elseif ((#mobTargetsFinal + #pcTargetsFinal) == 2) then
		damage = damage / 2
	elseif ((#mobTargetsFinal + #pcTargetsFinal) == 1) then
		damage = damage
	end
			
	for i = 1, 3 do
		if (mobTargetsFinal[i] ~= nil) then
			mobTargetsFinal[i].attacker = player.ID
			threat = mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobTargetsFinal[i].ID, threat)
			
			if (#player.group > 1) then
				mobTargetsFinal[i]:setGrpDmg(player.ID, threat)
			else
				mobTargetsFinal[i]:setIndDmg(player.ID, threat)
			end
				if not (mobTargetsFinal[i]:hasDuration("bash")) then
					mobTargetsFinal[i]:setDuration("bash", duration)
					--mobTargets[i].snare = true
				end

				if (recoilgraphic == 246) then
					mobTargetsFinal[i]:sendAnimation(246, 0)
				end
			mobTargetsFinal[i]:sendAnimation(300, 0)
			mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTargetsFinal[i]:sendAnimationXY(300, mobTargetsFinal[i].x, mobTargetsFinal[i].y, 0)
		elseif (pcTargetsFinal[i] ~= nil) then
				if (recoilgraphic == 246) then
					pcTargetsFinal[i]:sendAnimation(246, 0)
				end
			pcTargetsFinal[i]:sendAnimation(300, 0)
			
			if (player:canPK(pcTargetsFinal[i])) then

				if not (pcTargetsFinal[i]:hasDuration("bash")) then
					pcTargetsFinal[i]:setDuration("bash", 5000)
					pcTargetsFinal[i]:calcStat()
				end
				
				pcTargetsFinal[i].attacker = player.ID
				pcTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				pcTargetsFinal[i]:sendMinitext(player.name.." bashes you.")
				pcTargetsFinal[i]:sendAnimationXY(300, pcTargetsFinal[i].x, pcTargetsFinal[i].y, 0)
			end
		end
	end
end,

recast = function(block)
	--block.snare = true
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		--block.snare = false
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 31
	local items = {}
	local itemAmounts = {}
	local description = {"Bash II is a strong attack that targets three foes in front of you and does damage with an added snare (monster only)."}
	return level, items, itemAmounts, description
end
}

bash3 = {
on_learn = function(player)
	if (player:hasSpell("bash")) then
		player:removeSpell("bash")
	end
	player.registry["learned_bash"] = 1

	if (player:hasSpell("bash2")) then
		player:removeSpell("bash2")
	end
	player.registry["learned_bash2"] = 1
end,

cast = function(player)
	local mobTargets = {}
	local pcTargets = {}
	local aether = 5000--22000
	local duration = 12000
	local damage = (player.maxHealth * .35) + (player.might * 25)
	local missing2 = damage * 2
	local threat
	local healthCost = (player.health * .03)
	local magicCost = (.02 * player.maxMagic)
	local recoilgraphic

	--local baseDamage1 = 2 + (player.might * 2) + player.grace
	--local finalDamage1
	
		--local weaponDamage1 = math.floor(mathRandom(player.minDam / 2, player.maxDam / 2, 1000) + mathRandom(player.minDam / 2, player.maxDam / 2, 1000))
		
		--baseDamage1 = baseDamage1 * player.fury
		--weaponDamage1 = weaponDamage1 * player.enchant
		--finalDamage1 = (baseDamage1 + weaponDamage1) * player.rage * player.invis

	--damage = damage + (finalDamage1 * 24) + missing2

	if (player.registry["recoil_damagestored"] > 1) then
		damage = damage + player.registry["recoil_damagestored"]
		recoilgraphic = 246
	end
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < healthCost) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player.side == 0) then
		mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1]}
	elseif (player.side == 1) then
		mobTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
	elseif (player.side == 2) then
		mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
	elseif (player.side == 3) then
		mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
		pcTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}
	end

	local mobTargetsFinal = {}
	local pcTargetsFinal = {}

	for i = 1, 3 do
		if (mobTargets[i] ~= nil) then
			if(mobTargets[i].protection ~= 1) then
				table.insert(mobTargetsFinal, mobTargets[i])
			end
		end
	end

	for i = 1, 3 do
		if (pcTargets[i] ~= nil) then
			if (player:canPK(pcTargets[i])) then
				table.insert(pcTargetsFinal, pcTargets[i])
			end
		end
	end

	if (#mobTargetsFinal == 0 and #pcTargetsFinal == 0) then
		player:sendMinitext("You cannot use this attack without a target in front of you.")
		return
	end
	
	player:sendAction(1, 20)
	player:setAether("bash3", aether)
	player:sendMinitext("You use Bash.")
	player:playSound(10)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player.registry["recoil_damagestored"] = 1
	player:sendStatus()

	if ((#mobTargetsFinal + #pcTargetsFinal) == 3) then
		damage = damage / 3
	elseif ((#mobTargetsFinal + #pcTargetsFinal) == 2) then
		damage = damage / 2
	elseif ((#mobTargetsFinal + #pcTargetsFinal) == 1) then
		damage = damage
	end
			
	for i = 1, 3 do
		if (mobTargetsFinal[i] ~= nil) then
			mobTargetsFinal[i].attacker = player.ID
			threat = mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobTargetsFinal[i].ID, threat)
			
			if (#player.group > 1) then
				mobTargetsFinal[i]:setGrpDmg(player.ID, threat)
			else
				mobTargetsFinal[i]:setIndDmg(player.ID, threat)
			end
				if not (mobTargetsFinal[i]:hasDuration("bash")) then
					mobTargetsFinal[i]:setDuration("bash", duration)
					--mobTargets[i].snare = true
				end

				if (recoilgraphic == 246) then
					mobTargetsFinal[i]:sendAnimation(246, 0)
				end
			mobTargetsFinal[i]:sendAnimation(300, 0)
			mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTargetsFinal[i]:sendAnimationXY(300, mobTargetsFinal[i].x, mobTargetsFinal[i].y, 0)
		elseif (pcTargetsFinal[i] ~= nil) then
				if (recoilgraphic == 246) then
					pcTargetsFinal[i]:sendAnimation(246, 0)
				end
			pcTargetsFinal[i]:sendAnimation(300, 0)
			
			if (player:canPK(pcTargetsFinal[i])) then

				if not (pcTargetsFinal[i]:hasDuration("bash")) then
					pcTargetsFinal[i]:setDuration("bash", 5000)
					pcTargetsFinal[i]:calcStat()
				end
				
				pcTargetsFinal[i].attacker = player.ID
				pcTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				pcTargetsFinal[i]:sendMinitext(player.name.." bashes you.")
				pcTargetsFinal[i]:sendAnimationXY(300, pcTargetsFinal[i].x, pcTargetsFinal[i].y, 0)
			end
		end
	end
end,

recast = function(block)
	--block.snare = true
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		--block.snare = false
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Bash III is a strong attack that targets three foes in front of you and does damage with an added snare (monster only)."}
	return level, items, itemAmounts, description
end
}