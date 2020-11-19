invisible = {
cast = function(player, target)
	local duration = 20000
	local aether = 40000
	
	if (not player:canCast(1, 1, 1)) then
		return
	end
	
	if (player:hasDuration("invisible")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("hide")) then
		player:flushDurationNoUncast(2030, 2030)
	end
	
	player:sendAction(6, 20)
	player:playSound(718)
	--player:sendAnimation(21, 0)
	player:sendMinitext("You cast Invisible.")
	player:setAether("invisible", aether)
	player:setDuration("invisible", duration)
	player.state = 2
	player:updateState()
	player:sendAction(6, 35)
	player:calcStat()
end,

while_cast_250 = function(player)
	if (player.state ~= 2) then
		player:setDuration("invisible", 0)
	end
end,

--on_hit_while_cast = function(player)
--	if(player.state == 2) then
--		player.state = 0
--	end
--	
--	player:updateState()
--end,

--on_takedamage_while_cast  = function(player)
--if(player.state == 2) then
--		player.state = 0
--	end
--	
--	player:updateState()
--end,

recast = function(player)
	--player.invis = player.invis + 6
	player.invis = player.invis + 3
end,

uncast = function(player)
	if(player.state == 2) then
		player.state = 0
	end
	
	player:updateState()
	player:calcStat()
end,

requirements = function(player)
	local level = 28
	local items = {}
	local itemAmounts = {}
	local description = {"Invisible allows you to hide in the shadows and increases damage dealt. Invisible will only last a short duration but will not remove when doing damage."}
	return level, items, itemAmounts, description
end
}