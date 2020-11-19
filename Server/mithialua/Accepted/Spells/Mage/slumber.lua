slumber = {
cast = function(player, target)
	local aether = 35000
	local duration = 7000
	local magicCost = 250
	local dist = 1
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (target:hasDuration("slumber")) then
		player:sendMinitext("This target is already asleep.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
			if (target.blType == BL_MOB) then
				player:sendAction(6, 20)
				player:setAether("slumber", aether)
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendMinitext("You cast Slumber.")
				player:playSound(86)

				target:sendAnimation(88, 0)
				target:setDuration("slumber", duration)
				target.sleep = target.sleep + .3
			end
	
			if (target.blType == BL_PC and player:canPK(target)) then
				player:sendAction(6, 20)
				player:setAether("slumber", aether)
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendMinitext("You cast Slumber.")
				player:playSound(86)

				target:sendAnimation(88, 0)
				target:setDuration("slumber", duration)
				target:calcStat()
				target:sendMinietxt(player.name.." casts slumber on you.")
			end
end,

while_cast = function(block)
	if (block.sleep == 1) then
		block:setDuration("slumber", 0)
	else
		block:sendAnimation(2, 0)
	end
end,

recast = function(player)
	player.sleep = player.sleep + .3
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		if (block.sleep - .3 < 1) then
			block.sleep = 1
		else
			block.sleep = block.sleep - .3
		end
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 55
	local items = {}
	local itemAmounts = {}
	local description = {"Slumber causes an enemy to fall asleep, more damage will be taken on the next hit and the enemy will wake up."}
	
	return level, items, itemAmounts, description
end
}