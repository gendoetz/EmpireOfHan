frostfire = {
cast = function(player, target)
	local aether = 30000
	local damage = (player.magic * 1.8)
	local threat
	local healthCost = (player.health * .2)
	local magicCost = player.magic - 500
	local minHealth = 3000
	local minMagic = 3000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < minHealth or player.health - healthCost <= 0) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < minMagic) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("frostfire", aether)
		player:playSound(85)
		--target:sendAnimation(169, 0)
		target:sendAnimation(182, 0)
		target:sendAnimation(104, 0)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Frostfire.")
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
		player:setAether("frostfire", aether)
		player:playSound(85)
		--target:sendAnimation(169, 0)
		target:sendAnimation(182, 0)
		target:sendAnimation(104, 0)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Frostfire.")
		target.attacker = player.ID
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		target:sendMinitext(player.name.." casts Frostfire on you.")
	end
end,

requirements = function(player)
	local level = 99
	local items = {}
	local itemAmounts = {}
	local description = {"Frostfire is a massive attack that hits with both schools of magic."}
	return level, items, itemAmounts, description
end
}