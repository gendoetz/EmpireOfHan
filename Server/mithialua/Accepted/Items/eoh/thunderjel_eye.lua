thunderjel_eye = {
use = function(player)
	if (player.state == 1) then
		player:sendMinitext("Spirits can't use this item")
		return
	elseif (player.state == 3) then
		player:sendMinitext("You can not do this right now")
		return
	end
	
	local eye = {graphic = convertGraphic(1612, "item"), color = 0}

	if (player:hasItem("thunderjel_eye",1)) then
		player:sendAnimation(3,1)
		player:removeItem("thunderjel_eye",1)
		player:sendAction(6,60)
		player:playSound(702)


		local randomspoil = math.random(3)
		if (randomspoil == 1) then
			player:addItem("pe_lwater", 1)
		elseif (randomspoil == 2) then
			player:addItem("voodoo_handcaster", 1)
		elseif (randomspoil == 3) then
			player:addItem("voodoo_handfighter", 1)
		end
		player:dialogSeq({eye, "*You hold Thunderjel's eye in your hands, slime dripping from your fingers. You squeeze and push your thumbs into the eye.*"}, 0)
	end

end
}