echo_of_weakness = {
cast = function(player)
	local mobBlocks = player:getObjectsInArea(BL_MOB)
	local aether = 180000
	local duration = 120000
	local magicCost = 500
	
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
		player:setAether("echo_of_weakness", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You play Echo of Weakness.")
		player:playSound(26)
	
		for i = 1, #mobBlocksFinal do
			if (mobBlocksFinal[i].state ~= 1 and not mobBlocksFinal[i]:hasDuration("hindrance3") and mobBlocksFinal[i].summon == false) then
				mobBlocksFinal[i]:sendAnimation(79, 0)
				mobBlocksFinal[i]:setDuration("hindrance3", duration)
				mobBlocksFinal[i].deduction = mobBlocksFinal[i].deduction + .35
				--mobBlocksFinal[i].snare = true
			end
		end
	end
end,

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"A song that weakens enemies within range."}
	
	return level, items, itemAmounts, description
end
}