solace = {
cast = function(player, target)
	local heal = 150
	local magicCost = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That cannot save them now.")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Solace.")
	player:playSound(98)
	target:sendAnimation(66, 0)
	target.attacker = player.ID
	target:addHealthExtend(heal, 0, 0, 0, 0, 0)
	target:sendMinitext(player.name.." casts Solace on you.")
end,

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Solace is a weak healing spell that allows you to heal others. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}

solace2 = {
cast = function(player, target)
	local heal = 350
	local magicCost = 110
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That cannot save them now.")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Solace II.")
	player:playSound(98)
	target:sendAnimation(66, 0)
	target.attacker = player.ID
	target:addHealthExtend(heal, 0, 0, 0, 0, 0)
	target:sendMinitext(player.name.." casts Solace II on you.")
end,

requirements = function(player)
	local level = 20
	local items = {}
	local itemAmounts = {}
	local description = {"Solace is a minor strength healing spell that allows you to heal others. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}

solace3 = {
cast = function(player, target)
	local heal = 700
	local magicCost = 150
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That cannot save them now.")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Solace III.")
	player:playSound(98)
	target:sendAnimation(66, 0)
	target.attacker = player.ID
	target:addHealthExtend(heal, 0, 0, 0, 0, 0)
	target:sendMinitext(player.name.." casts Solace III on you.")
end,

requirements = function(player)
	local level = 45
	local items = {}
	local itemAmounts = {}
	local description = {"Solace is a moderate strength healing spell that allows you to heal others. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}

solace4 = {
cast = function(player, target)
	local heal = 1400
	local magicCost = 180
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That cannot save them now.")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Solace IV.")
	player:playSound(98)
	target:sendAnimation(66, 0)
	target.attacker = player.ID
	target:addHealthExtend(heal, 0, 0, 0, 0, 0)
	target:sendMinitext(player.name.." casts Solace IV on you.")
end,

requirements = function(player)
	local level = 80
	local items = {}
	local itemAmounts = {}
	local description = {"Solace is a greater healing spell that allows you to heal others. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}