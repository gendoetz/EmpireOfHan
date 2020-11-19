haste = {
cast = function(player)
	local aether = 30000
	local duration = 10000
	local magicCost = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	player:sendMinitext("Haste is being reworked, please be patient.")

	--[[if (player:hasDuration("haste")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setDuration("haste", duration)
	player:setAether("haste", aether)
	player:sendAnimation(332, 0)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You cast Haste.")]]
end,

recast = function(player)
	player.attackSpeed = player.attackSpeed * .3
end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 8
	local items = {}
	local itemAmounts = {}
	local description = {"Haste is an ability that will quicken you for a short duration."}
	return level, items, itemAmounts, description
end
}