electrum = {
cast = function(player, target)
	local aether = 30000
	local duration = 15000
	local damage = (player.level * 3) + (player.will * 6)
	local threat
	local healthCost = (.005 * player.maxHealth)
	local magicCost = (player.will * 3)
	local minHealth = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < minHealth or player.health - healthCost <= 0) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end

	if (target:hasDuration("electrum") or target:hasDuration("electrum2") or target:hasDuration("electrum3")) then
		player:sendMinitext("A version of this spell is already cast.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("electrum", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(66)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(33, 1)
			player:sendMinitext("You cast Electrum.")
			target:setDuration("electrum", duration, player.id)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("electrum", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(66)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(33, 1)
			player:sendMinitext("You cast Electrum.")
			target:setDuration("electrum", duration, player.id)
			target:sendMinitext(player.name.." envelopes you in an electrical storm.")
		--end
	end
end,

while_cast = function(block, caster)
	--local damage = (caster.will + 10)
	local threat
	local damage
	--local fivecasts = 0
	--caster.registry["fivecasts"] = 0

	if (block.m ~= caster.m) then
		block:setDuration("electrum", 0, caster.id)
	end

	block:sendAnimation(33, 0)
	block.attacker = caster.ID
	damage = (caster.level * 3) + (caster.will * 6)
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)


	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.ID, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.ID, threat)
		else
			block:setIndDmg(caster.ID, threat)
		end
	end
end,

requirements = function(player)
	local level = 12
	local items = {}
	local itemAmounts = {}
	local description = {"Electrum is a nature element attack that hits a foe repeatedly. To learn this spell you must sacrifice (1) Gold Acorn, (5) Rough Kyanite, and 100 gold coins."}
	return level, items, itemAmounts, description
end
}

electrum2 = {
on_learn = function(player)
	if (player:hasSpell("electrum")) then
		player:removeSpell("electrum")
	end
	
	player.registry["electrum"] = 1
end,

cast = function(player, target)
	local aether = 30000
	local duration = 15000
	local damage = (player.level * 4) + (player.will * 7)
	local threat
	local healthCost = (.005 * player.maxHealth)
	local magicCost = (player.will * 3)
	local minHealth = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < minHealth or player.health - healthCost <= 0) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end

	if (target:hasDuration("electrum") or target:hasDuration("electrum2") or target:hasDuration("electrum3")) then
		player:sendMinitext("A version of this spell is already cast.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("electrum2", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(66)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(12, 0)
			player:sendMinitext("You cast Electrum II.")
			target:setDuration("electrum2", duration, player.id)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("electrum2", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(66)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(12, 0)
			player:sendMinitext("You cast Electrum II.")
			target:setDuration("electrum2", duration, player.id)
			target:sendMinitext(player.name.." envelopes you in an electrical storm.")
		--end
	end
end,

while_cast = function(block, caster)
	--local damage = (caster.will + 10)
	local threat
	local damage
	--local fivecasts = 0
	--caster.registry["fivecasts"] = 0

	if (block.m ~= caster.m) then
		block:setDuration("electrum2", 0, caster.id)
	end

	block:sendAnimation(12, 0)
	block.attacker = caster.ID
	damage = (caster.level * 4) + (caster.will * 7)
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)



	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.ID, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.ID, threat)
		else
			block:setIndDmg(caster.ID, threat)
		end
	end
end,

requirements = function(player)
	local level = 35
	local items = {}
	local itemAmounts = {}
	local description = {"Electrum is a nature element attack that hits a foe repeatedly. To learn this spell you must sacrifice (1) Gold Acorn, (5) Rough Kyanite, and 100 gold coins."}
	return level, items, itemAmounts, description
end
}

electrum3 = {
on_learn = function(player)
	if (player:hasSpell("electrum")) then
		player:removeSpell("electrum")
	end
	
	player.registry["electrum"] = 1

	if (player:hasSpell("electrum2")) then
		player:removeSpell("electrum2")
	end
	
	player.registry["learned_electrum2"] = 1
end,

cast = function(player, target)
	local aether = 30000
	local duration = 15000
	local damage = (player.level * 5) + (player.will * 8)
	local threat
	local healthCost = (.005 * player.maxHealth)
	local magicCost = (player.will * 3)
	local minHealth = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < minHealth or player.health - healthCost <= 0) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end

	if (target:hasDuration("electrum") or target:hasDuration("electrum2") or target:hasDuration("electrum3")) then
		player:sendMinitext("A version of this spell is already cast.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("electrum3", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(66)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(12, 0)
			target:sendAnimation(33, 0)
			player:sendMinitext("You cast Electrum III.")
			target:setDuration("electrum3", duration, player.id)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("electrum3", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(66)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(12, 0)
			target:sendAnimation(33, 0)
			player:sendMinitext("You cast Electrum III.")
			target:setDuration("electrum3", duration, player.id)
			target:sendMinitext(player.name.." envelopes you in an electrical storm.")
		--end
	end
end,

while_cast = function(block, caster)
	--local damage = (caster.will + 10)
	local threat
	local damage = (caster.level * 5) + (caster.will * 8)
	--local fivecasts = 0
	--caster.registry["fivecasts"] = 0

		local enspiritCheck = caster:magicDamageMod_enspirit(damage)

		damage = enspiritCheck

	if (block.m ~= caster.m) then
		block:setDuration("electrum3", 0, caster.id)
	end

	block:sendAnimation(12, 0)
	block:sendAnimation(33, 0)
	block.attacker = caster.ID
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)

	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.ID, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.ID, threat)
		else
			block:setIndDmg(caster.ID, threat)
		end
	end
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Electrum is a nature element attack that hits a foe repeatedly. To learn this spell you must sacrifice (1) Gold Acorn, (5) Rough Kyanite, and 100 gold coins."}
	return level, items, itemAmounts, description
end
}