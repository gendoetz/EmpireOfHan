hide = {
cast = function(player, target)
	local duration = 180000
	
	if (not player:canCast(1, 1, 1) or player.state == 2) then
		player:sendMinitext("You are already hidden.")
		return
	end
	
	if (player:hasDuration("invisible")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	player:sendAction(6, 20)
	player:playSound(718)
	--player:sendAnimation(21, 0)
	player:sendMinitext("You cast Hide.")
	player:setDuration("hide", duration)
	player.state = 2
	player:updateState()
	player:sendAction(6, 35)
	player:calcStat()
end,

while_cast_250 = function(player)
	if (player.state ~= 2) then
		player:setDuration("hide", 0)
	end
end,

on_hit_while_cast = function(player)
	if(player.state == 2) then
		player.state = 0
		player:setDuration("hide", 0)
	end
	
	player:updateState()
end,

--on_takedamage_while_cast  = function(player)
--if(player.state == 2) then
--		player.state = 0
--	end
--	
--	player:updateState()
--end,

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
	local description = {"Hide allows you to lurk in the shadows. Hide does not increase damage and will remove if you do swing damage."}
	return level, items, itemAmounts, description
end
}