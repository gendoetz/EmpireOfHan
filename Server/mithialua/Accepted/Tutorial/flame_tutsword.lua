flame_tutsword = {
on_hit = function(player,target)
	player:playSound(349)
	target:sendAnimation(46)
end
}