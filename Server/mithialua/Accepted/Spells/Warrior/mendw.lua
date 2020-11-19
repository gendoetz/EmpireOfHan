mendw = {
cast = function(player)
	local heal = 130
	local magicCost = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	player:sendAnimation(5, 0)
	player.magic = player.magic - magicCost
	player.attacker = player.ID
	player:playSound(708)
	player:addHealthExtend(heal, 0, 0, 0, 0, 0)
	player:sendStatus()
	player:sendAction(6, 40)
end,

requirements = function(player)
	local level = 18
	local items = {}
	local itemAmounts = {}
	local description = {"Mend restores weak health to yourself.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}

mendw2 = {
cast = function(player)
	local heal = 200
	local magicCost = 80
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	player:sendAnimation(5, 0)
	player.magic = player.magic - magicCost
	player.attacker = player.ID
	player:playSound(708)
	player:addHealthExtend(heal, 0, 0, 0, 0, 0)
	player:sendStatus()
	player:sendAction(6, 40)
end,

requirements = function(player)
	local level = 45
	local items = {}
	local itemAmounts = {}
	local description = {"Mend II restores moderate health to yourself.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}

mendw3 = {
cast = function(player)
	local heal = 350
	local magicCost = 150
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	player:sendAnimation(5, 0)
	player.magic = player.magic - magicCost
	player.attacker = player.ID
	player:playSound(708)
	player:addHealthExtend(heal, 0, 0, 0, 0, 0)
	player:sendStatus()
	player:sendAction(6, 40)
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Mend III restores greater health to yourself.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}