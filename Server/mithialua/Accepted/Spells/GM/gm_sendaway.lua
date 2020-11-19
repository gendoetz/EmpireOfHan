gm_sendaway = {
cast=function(player,target)
	if(player.ID==2 or player.ID==96) then
		if(target.blType==BL_PC) then
			target:sendMinitext(player.name .." sends you away.")
			target:sendAnimationXY(143, target.x, target.y, 1)
			player:sendAction(6,35)
			player:playSound(73)
			target:warp(25,26,5)
			confusion.cast(player, target)
		end
	else
		player:sendMinitext("You are too weak and feable to cast this spell.")
	end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Send Away sends a player to the Pinyan Inn with confusion applied. Use to dismiss unruly players as a warning."}
	return level, items, itemAmounts, description
end   
}