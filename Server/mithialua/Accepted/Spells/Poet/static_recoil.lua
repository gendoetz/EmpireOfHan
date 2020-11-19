static_recoil = {
cast = function(player)
	local duration = 30000
	local aether = 40000
	local magicCost = 500
	player.registry["static_recoil"] = 6
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("static_recoil")) then
		player:sendMinitext("That spell is already protecting you.")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Harden Body.")
	player:setDuration("static_recoil", duration)
	player:playSound(76)
	if (player.y ~= 0) then
		player:sendAnimationXY(186, player.x, player.y -1, 0)
	end
end,

uncast = function(player)
	player:sendMinitext("Static Recoil fades from you.")
end,

requirements = function(player)
	local level = 70
	local items = {}
	local itemAmounts = {}
	local description = {"Static Recoil is an electrical shield that will stun attackers for a short duration. Static Recoil has 5 charges of energy once cast."}
	return level, items, itemAmounts, description
end
}

paralysis = {
uncast = function(block)
	block.paralyzed = false
end,
}