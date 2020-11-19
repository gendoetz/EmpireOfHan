deflect = {
cast = function(player)
	local aether = 180000
	local duration = 25000
	local magicCost = (player.magic * .17)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.pvp == 1) then
		player:sendMinitext("Your honor forbids this skill in combat of this manner.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("deflect")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setAether("deflect", aether)
	player:setDuration("deflect", duration)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:playSound(78)
	player:sendAnimation(325, 0)
	player:sendAnimation(376, 0)
	player:sendMinitext("You cast Deflect.")
end,

requirements = function(player)
	local level = 40
	local items = {}
	local itemAmounts = {}
	local description = {"Deflect causes a portion of the damage you take to be deflected back at an attacker."}
	return level, items, itemAmounts, description
end
}