rampage = {
cast = function(player)
	local duration = 600000
	local magicCost = 75
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("rampage")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 35)
	player:setDuration("rampage", duration)
	player:sendAnimation(57, 0)
	player:playSound(72)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You cast Rampage.")
end,

recast = function(player)
	player.flank = true
	player.backstab = true
	--player.rage = player.rage + .15
end,

uncast = function(player)
	player.flank = false
	player.backstab = false
end,

requirements = function(player)
	local level = 15
	local items = {}
	local itemAmounts = {}
	local description = {"Rampage grants the ability to strike enemies all around you increasing your damage output considerably."}
	return level, items, itemAmounts, description
end
}