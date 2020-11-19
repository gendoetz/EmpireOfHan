melt_mind = {
cast = function(player, target)
	local aether = 12000
	local damage = (.02 * player.health) * (player.will / 10)
	
	local threat
	local healthCost = (.02 * player.maxHealth)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < healthCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("melt_mind", aether)
		player.magic = player.magic + damage
		player.health = player.health - healthCost
		player:sendStatus()
		player:playSound(33)

			target:sendAnimation(101, 1)
			player:sendAnimation(333, 1)
			player:sendMinitext("You cast Melt Mind.")
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
			
			if (#player.group > 1) then
				target:setGrpDmg(player.ID, threat)
			else
				target:setIndDmg(player.ID, threat)
			end
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("melt_mind", aether)
		player.magic = player.magic + damage
		player.health = player.health - healthCost
		player:sendStatus()
		player:playSound(33)

			target:sendAnimation(101, 1)
			player:sendAnimation(333, 1)
			player:sendMinitext("You cast Melt Mind.")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." casts Melt Mind on you.")
	end
end,

requirements = function(player)
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Melt Mind is a spell that sacrafices some of your health to do a mental strike on a target that will restore a small amount of mana to you."}
	return level, items, itemAmounts, description
end
}