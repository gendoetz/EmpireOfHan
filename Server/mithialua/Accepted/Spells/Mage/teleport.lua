teleport = {
cast = function(player, target)
	local aether = 90000
	local magicCost = 250
	local distance = 7
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.id == target.id) then
		player:sendMinitext("You can't cast this on yourself.")
		return
	end
	
	if (target.blType == BL_MOB and target.mobID == 100) then
		player:sendMinitext("Your target is not elligible for that skill.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end

	if (player.m == 518 or player.m == 585) then
		player:sendMinitext("That doesn't work here.")
		return
	end
	
	if (distanceSquare(player, target, distance)) then
		player:sendAction(6, 20)
		player:sendAnimationXY(279, player.x, player.y, 1)
		player:setAether("teleport", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Teleport.")
		canAmbush(player, target)
		player:playSound(84)
		player:sendAnimation(279)
		player.side = 2
		player:sendSide()
	end
end,

requirements = function(player)
	local level = 70
	local items = {}
	local itemAmounts = {}
	local description = {"Teleport moves you across space to appear next to a target."}
	
	return level, items, itemAmounts, description
end
}