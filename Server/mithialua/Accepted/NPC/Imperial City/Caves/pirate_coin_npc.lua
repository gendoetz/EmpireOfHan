pirate_coin_npc = {
click = async(function(player, npc)
	local t = {graphic = convertGraphic(160,"monster"),color=9}
	local opts = {}

	player.npcGraphic=t.graphic
	player.npcColor=t.color
	player.dialogType = 0

	table.insert(opts,"Pirate Grog (5 coins)")
	table.insert(opts,"Seaweed Stew (3 coins)")

	if(#opts ~= 0) then
		local menuOption=player:menuString("I'll trade you some of my grog or delicious stews for pirate coins mate, hohoho. What'dya say?", opts)
		if(menuOption=="Pirate Grog (5 coins)") then
			if (player:hasItem("pirate_coin", 5) == true) then
				player:removeItem("pirate_coin", 5)
				player:addItem("pirate_drink1", 1)
			else
				player:dialogSeq({t, "You don't have enough coins!"}, 1)
			end
		elseif(menuOption=="Seaweed Stew (3 coins)") then
			if (player:hasItem("pirate_coin", 3) == true) then
				player:removeItem("pirate_coin", 3)
				player:addItem("pirate_food1", 1)
			else
				player:dialogSeq({t, "You don't have enough coins!"}, 1)
			end
		end
	end
end),
}