base_stone = {
	use = function(player)
		local stone_b = {graphic = convertGraphic(2133, "item"), color = 0}
		local stone_w = {graphic = convertGraphic(2131, "item"), color = 2}
		local stone_r = {graphic = convertGraphic(2131, "item"), color = 25}
		local stone_m = {graphic = convertGraphic(2132, "item"), color = 0}
		local stone_p = {graphic = convertGraphic(2138, "item"), color = 11}

		if(player.state==1) then
			player:sendMinitext("Spirits can't do that")
			return
		end

		if (player.m == 77 and player.x <= 40 and player.y <= 46 and player.baseClass == 1) then
			player:sendMinitext("A stone force swirls around you...")
			player:removeItem("base_stone",1)
			player:addItem("w_stone", 1)
			player:dialogSeq({stone_w, "You stare into the distance and swear you could see the visage of a mysterious Warrior wearing powerful garments."}, 1)
		elseif (player.m == 37 and (player.y >= 5 and player.y <= 13) and (player.x >= 42 and player.x <= 50) and player.baseClass == 2) then
		player:sendMinitext("A windy force swirls around you...")
			player:removeItem("base_stone",1)
			player:addItem("r_stone", 1)
			player:dialogSeq({stone_r, "You stare into the distance and swear you could see the visage of a mysterious Rogue wearing powerful garments."}, 1)
		elseif (player.m == 74 and player.y >= 128 and (player.x >= 34 and player.x <= 56) and player.baseClass == 3) then
		player:sendMinitext("A fiery force swirls around you...")
			player:removeItem("base_stone",1)
			player:addItem("m_stone", 1)
			player:dialogSeq({stone_m, "You stare into the distance and swear you could see the visage of a mysterious Mage wearing powerful garments."}, 1)
		elseif (player.m == 74 and player.y == 66 and (player.x >= 82 and player.x <= 86) and player.baseClass == 4) then
		player:sendMinitext("A watery force swirls around you...")
			player:removeItem("base_stone",1)
			player:addItem("p_stone", 1)
			player:dialogSeq({stone_p, "You stare into the distance and swear you could see the visage of a mysterious Poet wearing powerful garments."}, 1)
		else
			player:dialogSeq({stone_b, "The stone does nothing."}, 1)
		end
	end
}