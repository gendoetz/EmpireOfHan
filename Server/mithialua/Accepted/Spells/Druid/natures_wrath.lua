natures_wrath = {
cast = function(player, target)
	local aether = 25000
	local damage = (player.level * 5) + (player.will * 5) * 10
	
		local enspiritCheck = player:magicDamageMod_enspirit(damage)

		damage = enspiritCheck
	
	local threat
	local magicCost = (.02 * player.maxMagic)
	
	if (not player:canCast(1, 1, 0)) then
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
	
	if (target.blType == BL_MOB) then
			target:sendAnimation(196, 1)
			player:sendMinitext("You cast Nature's Wrath.")
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
			
			if (#player.group > 1) then
				target:setGrpDmg(player.ID, threat)
			else
				target:setIndDmg(player.ID, threat)
			end
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		
	elseif (target.blType == BL_PC) then
			player:sendMinitext("You cast Nature's Wrath.")
	end

		--multihitcode
	local targets = getTargetsAroundDiamond(target, BL_MOB)
		for i = 1, #targets do
			targets[i].attacker = player.ID
			threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(targets[i].ID, threat)
			if (#player.group > 1) then
				targets[i]:setGrpDmg(player.ID, threat)
			else
				targets[i]:setIndDmg(player.ID, threat)
			end			
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			targets[i]:sendAnimation(196, 0)
		end

	if (target.blType == BL_MOB or (#targets > 0 and target.blType == BL_PC)) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("natures_wrath", aether)
		player:playSound(47)
		player:sendAction(6, 20)
	end
end,

requirements = function(player)
	local level = 85
	local items = {}
	local itemAmounts = {}
	local description = {"Nature's Wrath is a strong nature attack on a group of targets. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}