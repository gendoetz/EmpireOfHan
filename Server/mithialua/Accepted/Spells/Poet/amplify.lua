amplify = {
cast = function(player, target)
	local aether = 240000
	local duration = 240000
	local magicCost = player.maxMagic / 10
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target:hasDuration("amplify")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (target.blType == BL_MOB) then
		player:sendMinitext("You can't cast that on that target.")
		return
	elseif (target.blType == BL_PC) then
	player:sendAction(6, 20)
	target:setDuration("amplify", duration)
	player:setAether("amplify", aether)
	player:playSound(77)
	target:sendAnimation(346, 0)
	player.magic = player.magic - magicCost
	target:sendStatus()
	player:sendMinitext("You cast Amplify.")
	target:sendMinitext(player.name.." amplifies your power.")
	end
	
end,

recast = function(player)
	--player.maxMagic = player.maxMagic + 1000
	--player.registry["amplify_mind"] = 3.30
end,

uncast = function(player)
	--player.registry["amplify_mind"] = 1
	--player:calcStat()
end,

requirements = function(player)
	local level = 15
	local items = {}
	local itemAmounts = {}
	local description = {"Increases the power of your target by focusing your mind into their body. To learn this spell you must sacrifice (1) Stone Doll Husk and 200 gold coins."}
	return level, items, itemAmounts, description
end
}