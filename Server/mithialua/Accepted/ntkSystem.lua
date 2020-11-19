powerBoard = function(player,target)
	if(player.registry["carnagehost"] == 0) then
		player:sendMinitext("You may not call for powerboards on this map.")
		return
	end
	if(target~=nil) then
		if(player.pbColor==60 or player.pbColor==61 or player.pbColor==63 or player.pbColor==65 or player.pbColor==0 or player.gmLevel==99) then
			target.armorColor=player.pbColor
			target:updateState()
		end
	end
	player:powerBoard()
	--use player.pbColor for the color to change
	--also, set the armorColor yourself, and udpate their state
end

walkPause = function(player,target)
	if (player:hasDuration("refresh_pause") or player.paralyzed == true) then
		return
	end
	player:setDuration("refresh_pause", 1000)
	player.paralyzed = true
end

refresh_pause = {
recast = function(block)
	block.paralyzed = true
end,

uncast = function(block)
	block.paralyzed = false
end
}