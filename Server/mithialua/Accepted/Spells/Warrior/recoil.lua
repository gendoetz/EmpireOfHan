recoil = {
cast = function(player)
	local duration = 30000
	local aether = 0--300000
	local magicCost = 1000
	player.registry["recoil_damagestored"] = 1
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("recoil")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setAether("recoil", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You use Recoil.")
	player:setDuration("recoil", duration)
	player:playSound(78)
	player:sendAnimation(72, 0)
end,

uncast = function(player)
	player:sendMinitext("Recoil ends.")
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Recoil is an ability that when used will build up damage reserve from attacks taken. Your next Bash or Decimate skills will do increased damage."}
	return level, items, itemAmounts, description
end
}

recoil2 = {
on_learn = function(player)
	if (player:hasSpell("recoil")) then
		player:removeSpell("recoil")
	end
	
	player.registry["learned_recoil"] = 1
end,

cast = function(player)
	local duration = 30000
	local aether = 0--300000
	local magicCost = 1000
	player.registry["recoil_damagestored"] = 1
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("recoil2")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setAether("recoil2", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You use Recoil II.")
	player:setDuration("recoil2", duration)
	player:playSound(78)
	player:sendAnimation(72, 0)
end,

uncast = function(player)
	player:sendMinitext("Recoil ends.")
end,

requirements = function(player)
	local level = 55
	local items = {}
	local itemAmounts = {}
	local description = {"Recoil is an ability that when used will build up damage reserve from attacks taken. Your next Bash or Decimate skills will do increased damage."}
	return level, items, itemAmounts, description
end
}