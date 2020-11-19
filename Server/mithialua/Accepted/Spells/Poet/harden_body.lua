harden_body = {
cast = function(player)
	local duration = 12000
	local aether = 5000
	local magicCost = 1000
	local shield = player.maxMagic / 2

	if (player.pvp == 1) then
		aether = 15000
	end
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("harden_body")) then
		player:sendMinitext("That spell is already protecting you.")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Harden Body.")
	player:setDuration("harden_body", duration)
	--
	player.registry["magic_shielded"] = shield
	--player.dmgShield = 1000
	player:playSound(80)
	player:sendAnimation(87, 0)
end,

uncast = function(player)
	player:sendMinitext("Harden Body fades from you.")
end,

requirements = function(player)
	local level = 70
	local items = {}
	local itemAmounts = {}
	local description = {"Harden Body turns your skin to stone and prevents all sources of damage for a short duration."}
	return level, items, itemAmounts, description
end
}