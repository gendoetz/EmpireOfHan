rep_elementalist = {
use = async(function(player)
	local spiritFire = {graphic = convertGraphic(655, "monster"), color = 0}
	local spiritWater = {graphic = convertGraphic(656, "monster"), color = 0}
	local spiritEarth = {graphic = convertGraphic(657, "monster"), color = 0}
	local spiritWind = {graphic = convertGraphic(654, "monster"), color = 0}
	local baseItem =  {graphic = convertGraphic(1715, "item"), color = 0}

	if (player.state == 1) then
		player:sendMinitext("Spirits can't do that")
		return
	elseif (player.state == 3) then
		player:sendMinitext("You cannot use this item while mounted.")
		return
	end

	if (player.m == 37) then
		if (player.x >= 29 and player.y >= 3 and (player.x <= 61 and player.y <= 20)) then
			if (player.registry["rQ_elementalistT4"] == 1) then
				player:dialogSeq({spiritWind, "The Wind Spirit has left already."}, 1)
			elseif (player.registry["rQ_elementalistT4"] == 0) then
				player:sendMinitext("A strong current brushes against you..")
				player:sendAnimation(397,1)
				player:dialogSeq({spiritWind, "You catch a glimpse of a Wind Spirit.\n\nShe notices you as she leaves, leaving you with a small token of her affection."}, 1)
				player.registry["rQ_elementalistT4"] = player.registry["rQ_elementalistT4"] + 1
				player.quest["rQ_Elementalist"] = player.quest["rQ_Elementalist"] + 1
			end
		else
			player:dialogSeq({baseItem, "You feel you're near a spirit.."}, 1)
		end
	elseif (player.m == 74) then
		if (player.x >= 35 and player.y >= 120 and (player.x <= 55 and player.y <= 145)) then
			if (player.registry["rQ_elementalistT1"] == 1) then
				player:dialogSeq({spiritFire, "The Fire Spirit has left already."}, 1)
			elseif (player.registry["rQ_elementalistT1"] == 0) then
				player:sendMinitext("A spiral of flame encircles you..")
				player:sendAnimation(413,1)
				player:dialogSeq({spiritFire, "You catch a glimpse of a Fire Spirit.\n\nShe notices you as she leaves, leaving you with a small token of her affection."}, 1)
				player.registry["rQ_elementalistT1"] = player.registry["rQ_elementalistT1"] + 1
				player.quest["rQ_Elementalist"] = player.quest["rQ_Elementalist"] + 1
			end
		else
			player:dialogSeq({baseItem, "You feel you're near a spirit.."}, 1)
		end

	elseif (player.m == 77) then
		if (player.x >= 0 and player.y >= 45 and (player.x <= 19 and player.y <= 52)) then
			if (player.registry["rQ_elementalistT3"] == 1) then
				player:dialogSeq({spiritEarth, "The Earth Spirit has left already."}, 1)
			elseif (player.registry["rQ_elementalistT3"] == 0) then
				player:sendMinitext("Vines begin to encase you from the ground..")
				player:sendAnimation(399,1)
				player:dialogSeq({spiritEarth, "You catch a glimpse of a Earth Spirit.\n\nShe notices you as she leaves, leaving you with a small token of her affection."}, 1)
				player.registry["rQ_elementalistT3"] = player.registry["rQ_elementalistT3"] + 1
				player.quest["rQ_Elementalist"] = player.quest["rQ_Elementalist"] + 1
			end
		else
			player:dialogSeq({baseItem, "You feel you're near a spirit.."}, 1)
		end

	elseif (player.m == 176) then
		if (player.x >= 9 and player.y >= 26 and (player.x <= 16 and player.y <= 41)) then
			if (player.registry["rQ_elementalistT2"] == 1) then
				player:dialogSeq({spiritWater, "The Water Spirit has left already."}, 1)

			elseif (player.registry["rQ_elementalistT2"] == 0) then
				player:sendMinitext("A droplet of water falls on your head..")
				player:sendAnimation(402,1)
				player:dialogSeq({spiritWater, "You catch a glimpse of a Water Spirit.\n\nShe notices you as she leaves, leaving you with a small token of her affection."}, 1)
				player.registry["rQ_elementalistT2"] = player.registry["rQ_elementalistT2"] + 1
				player.quest["rQ_Elementalist"] = player.quest["rQ_Elementalist"] + 1
			end
		else
			player:dialogSeq({baseItem, "You feel you're near a spirit.."}, 1)
		end

	end
end),

}