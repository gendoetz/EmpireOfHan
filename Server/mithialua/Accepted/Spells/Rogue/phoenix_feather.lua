phoenix_feather = {
cast = function(player)
	local aether = 180000
	local duration = 20000
	local magicCost = 250
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("phoenix_feather")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:playSound(504)
	player:sendAnimation(165, 1)
	player:setAether("phoenix_feather", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("phoenix_feather", duration)
	player:sendMinitext("You cast Phoenix Feather.")
end,

before_death_while_cast = function(player)
	local duration = 60000
	local heal = (player.maxHealth * .1)
	

	player:playSound(82)
	player:sendAnimationXY(94, player.x, player.y, 1)
	player:setDuration("phoenix_feather", 0)
	player:setDuration("phoenix_feather_shield", 5000)
	player.attacker = player.ID
	player:addHealthExtend(heal, 0, 0, 0, 0, 1)

		player:setDuration("sneak", 10000, 0, 1)
		player.state = 2
		player:updateState()
		player:calcStat()
end,

requirements = function(player)
	local level = 70
	local items = {}
	local itemAmounts = {}
	local description = {"Phoenix Feather protects you from death damage and grants you a heightened invisibility where your attacks will be more potent for a short time."}
	return level, items, itemAmounts, description
end
}

phoenix_feather_shield = {
cast = function(player)

end
}