talisman_of_knowledge = {
	use = async(function(player)
		local talisman = {graphic = convertGraphic(2592,"item"), color = 0}

		local check = player.registry["lastshiningexperienceuse"]

		if (player.level < 99) then
			player:sendMinitext("You are too young to understand the knowledge contained.")
			return
		end

		if(player.exp > 3000000000) then
			player:sendMinitext("You cannot use this item when you are carrying more than 3 billion experience.")
			return
		end
		player:dialogSeq({talisman,"**The runes inscribed on the talisman fill you with a sudden burst of great knowledge.**"},1)
			
		if(player.exp > 3000000000) then
			player:sendMinitext("You cannot use this item when you are carrying more than 3 billion experience.")
			return
		end
		if(player:hasItem("talisman_of_knowledge", 1) ~= true) then
			player:sendMinitext("You seem to have lost your item.")
			return
		end

		player:removeItem("talisman_of_knowledge", 1)
		player.exp = player.exp + 500000000
		player:sendStatus()
	end)
}