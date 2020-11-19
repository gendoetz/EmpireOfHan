recover = {
cast = function(player)
	local heal = 150
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
	local level = 8
	local items = {}
	local itemAmounts = {}
	local description = {"Recover restores weak health to yourself.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}

recover2 = {
cast = function(player)
	local heal = 250
	local magicCost = 125
	
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
	local level = 22
	local items = {}
	local itemAmounts = {}
	local description = {"Recover II restores minor health to yourself.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}

recover3 = {
cast = function(player)
	local heal = 350
	local magicCost = 200
	
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
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Recover III restores moderate health to yourself.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}

recover4 = {
cast = function(player)
	local heal = 450
	local magicCost = 250
	
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
	local level = 85
	local items = {}
	local itemAmounts = {}
	local description = {"Recover IV restores greater health to yourself.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}