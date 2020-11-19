dream_hymm = {
cast = function(player)
	local mobBlocks = player:getObjectsInArea(BL_MOB)
	local aether = 300000
	local duration = 10000
	local magicCost = 1000
	
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

	local mobBlocksFinal = {}

	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mobBlocks[i].protection ~= 1) then
				table.insert(mobBlocksFinal, mobBlocks[i])
			end
		end
	end
	
	if (#mobBlocksFinal > 0) then
		player:sendAction(22, 60)
		if (player.y ~= 0) then
			player:sendAnimationXY(197, player.x, player.y -1, 0)
		end
		player:setAether("dream_hymm", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You play Dream Hymm.")
		player:playSound(75)
	
		for i = 1, #mobBlocksFinal do
			if (mobBlocksFinal[i].state ~= 1 and mobBlocksFinal[i]:hasDuration("dream_hymm") == false and mobBlocksFinal[i].summon == false) then
				mobBlocksFinal[i]:sendAnimation(88, 0)
				mobBlocksFinal[i]:setDuration("dream_hymm", duration)
				mobBlocksFinal[i].sleep = mobBlocksFinal[i].sleep + .3
			end
		end
	end
end,

while_cast = function(block)
	if (block.sleep == 1) then
		if (block:hasDuration("dream_hymm")) then
			block:setDuration("dream_hymm", 0)
		end
	else
		block:sendAnimation(324, 0)
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
	end
end,

requirements = function(player)
	local level = 95
	local items = {}
	local itemAmounts = {}
	local description = {"A song that lulls all nearby enemies to sleep."}
	
	return level, items, itemAmounts, description
end
}