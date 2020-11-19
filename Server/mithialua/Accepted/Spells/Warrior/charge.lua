charge_to = {
cast = function(player, target)
	local aether = 90000
	local magicCost = 350
	local distance = 6
	local damage = (player.maxHealth * 0.25)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.id == target.id) then
		player:sendMinitext("You cannot use charge on yourself.")
		return
	end
	
	if (target.blType == BL_MOB and target.mobID == 100) then
		player:sendMinitext("Your target is not elligible for that skill.")
		return
	end

	if (target ~= nil) then
		if(target.blType == BL_MOB and target.protection == 1) then
			return
		end
	end

	if (player.m == 518 or player.m == 585) then
		player:sendMinitext("That doesn't work here.")
		return
	end

			if not (math.abs(player.x - target.x) > 1 or math.abs(player.y - target.y) > 1) then
				player:sendMinitext("Your are too close to your target.")
				return
			end
	if (target.blType == BL_MOB) then
		if (distanceSquare(player, target, distance)) then
			player:sendAnimationXY(285, player.x, player.y, 1)
			player:setAether("charge_to", aether)
			player.magic = player.magic - magicCost
			player.health = player.health - (damage/2)
			player:sendStatus()
			player:sendMinitext("You use Charge.")
			canAmbush(player, target)
			player:playSound(90)
			target:sendAnimation(331)
			target.attacker=player.ID
			player:swing()
			target:removeHealthExtend(damage, 0, 1, 1, 1, 0)
		end
	elseif (target.blType == BL_PC and player:canPK(target)) then
		if (distanceSquare(player, target, distance)) then
			player:sendAnimationXY(285, player.x, player.y, 1)
			player:setAether("charge_to", aether)
			player.magic = player.magic - magicCost
			player.health = player.health - (damage/2)
			player:sendStatus()
			player:sendMinitext("You use Charge.")
			canAmbush(player, target)
			player:playSound(90)
			target:sendAnimation(331)
			target.attacker=player.ID
			player:swing()
			target:removeHealthExtend(damage, 0, 1, 1, 1, 0)
		end
	end
end,

requirements = function(player)
	local level = 28
	local items = {}
	local itemAmounts = {}
	local description = {"Charge rushes you to a target and causes damage to them on impact. You will also suffer recoil damage."}
	return level, items, itemAmounts, description
end
}
