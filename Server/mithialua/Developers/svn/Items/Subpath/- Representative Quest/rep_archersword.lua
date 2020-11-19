rep_archersword = {
on_swing = async(function(player)

	player:playSound(341)	
	player:sendAction(1,25)

	local mathRand = math.random(1,5)	

	if (player.m == 74 and player.x >= 0 and player.y >= 26 and (player.x <= 18 and player.y <= 39)) then
		if (mathRand == 3) then
			if (player:hasSpace("rep_archerhoney", 1) == true) then
				player:addItem("rep_archerhoney", 1)
				player:playSound(350)
			else
				player:sendMinitext("You are full of Raw Honey already.")
			end
		else
			player:sendMinitext("You swing in attempt to look for honey.")
		end
	else
		player:dialogSeq({"None of the trees around here seem to have any honey."}, 1)		
	end	

end),

}