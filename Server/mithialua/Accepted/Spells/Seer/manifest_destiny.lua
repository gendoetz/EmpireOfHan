manifest_destiny = {
cast = function(player)
	local aether = 300000
	local duration = 60000
	local magicCost = 500
	local destiny = math.random(1,2)
	
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
	
	--Destiny #1
	if (destiny == 1) then
		local mobBlocks = player:getObjectsInArea(BL_MOB)
		if (#mobBlocks > 0) then
			player:sendAction(6, 20)
			player:setAether("manifest_destiny", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You cast Manifest Destiny.")
			player:playSound(73)
		
			for i = 1, #mobBlocks do
				if (mobBlocks[i].state ~= 1 and not mobBlocks[i]:hasDuration("freeze") and mobBlocks[i].summon == false) then
						mobBlocks[i]:sendAnimation(52, 0)
						mobBlocks[i]:setDuration("freeze", duration, 0, 1)
						mobBlocks[i].paralyzed = true
				end
			end
		end
	end

	--Destiny #2
	if (destiny == 2) then
			player:playSound(75)
			player:sendAction(6, 20)
			player:setAether("manifest_destiny", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You cast Manifest Destiny.")
			for i = 1, #player.group do
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m and distance(player, Player(player.group[i])) <= 7 and not Player(player.group[i]):hasDuration("manifest_destiny")) then
					Player(player.group[i]):sendAnimation(18, 0)
					Player(player.group[i]):setDuration("manifest_destiny", 60000, player.id, 1)
					Player(player.group[i]):calcStat()
					Player(player.group[i]):sendMinitext(""..player.name.." manifests your destiny.")
				end
			end
	end

end,

uncast = function(player)
	player:calcStat()
end,

recast = function(player)
	player.deduction = player.deduction - .20
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Manifest Destiny has a chance to protect your allies or stop foes in their tracks depending on your fate."}
	return level, items, itemAmounts, description
end
}