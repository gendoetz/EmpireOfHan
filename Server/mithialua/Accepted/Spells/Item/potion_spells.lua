regen1 = {
cast = function(player)
	--local aether = 120000
	local duration = 20000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasDuration("regen1")) then
		player:sendMinitext("That potion is already in effect.")
		return
	end
	
	player:sendAction(7, 20)
	--player:setAether("regenerate", aether)
	player:setDuration("regen1", duration)
	player:playSound(28)
	player:sendAnimation(21, 0)
	player:sendStatus()
	player:sendMinitext("Your vita begins to regenerate.")
end,

while_cast = function(player)
	player:addHealth2(50)
end,
}

refresh1 = {
cast = function(player)
	--local aether = 120000
	local duration = 20000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasDuration("refresh1")) then
		player:sendMinitext("That potion is already in effect.")
		return
	end
	
	player:sendAction(7, 20)
	--player:setAether("regenerate", aether)
	player:setDuration("refresh1", duration)
	player:playSound(28)
	player:sendAnimation(20, 0)
	player:sendStatus()
	player:sendMinitext("Your mana begins to regenerate.")
end,

while_cast = function(player)
	player:addMagic(50)
end,
}