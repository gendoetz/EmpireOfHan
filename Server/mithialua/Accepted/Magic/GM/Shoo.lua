shoo = {
cast=function(player,target)
	if(target.blType==BL_PC) then
		target:sendMinitext(player.name .." sends you away.")
		target:sendAnimationXY(143, target.x, target.y, 1)
		player:sendAction(6,35)
		player:playSound(73)
		target:warp(25,26,5)
		Delirium.cast(player, target)
	end             
end,

requirements=function(player)

end       
}