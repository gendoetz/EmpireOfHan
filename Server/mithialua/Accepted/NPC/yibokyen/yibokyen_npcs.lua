yibokyen_seamstress = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local kapok = {graphic = convertGraphic(2456, "item"), color = 15}
	local opts = {"Buy", "Sell"}
	local optsbuy = {"Simple Clothes","Northern Garments", "Garbs (Mage)", "Skirts (Mage)", "Robes (Poet)", "Gowns (Poet)"}
	local menuOption
	local menuOptionBuy
	local menuOptionSell


	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("How may I help you traveler?", opts)
	
	if (menuOption == "Buy") then
		menuOptionBuy = player:menuString("What kind of clothing would you like to buy?", optsbuy)
		
		if (menuOptionBuy == "Simple Clothes") then
			player:buyExtend("What do you wish to buy?", {26, 27, 28, 29})
		elseif (menuOptionBuy == "Northern Garments") then
			player:buyExtend("It is a bit chilly in the north, need something warm?", {463, 464, 465, 466, 467, 468, 469, 470, 471, 472})
		elseif (menuOptionBuy == "Garbs (Mage)") then
			player:buyExtend("What do you wish to buy?", {18, 84, 92, 100, 108, 254})
		elseif (menuOptionBuy == "Skirts (Mage)") then
			player:buyExtend("What do you wish to buy?", {19, 85, 93, 101, 109, 255})
		elseif (menuOptionBuy == "Robes (Poet)") then
			player:buyExtend("What do you wish to buy?", {20, 86, 94, 102, 110, 256})
		elseif (menuOptionBuy == "Gowns (Poet)") then
			player:buyExtend("What do you wish to buy?", {21, 87, 95, 103, 111, 257})
		end
	elseif (menuOption == "Sell") then
		player:sellExtend("What do you wish to sell?", {18, 19, 20, 21, 26, 27, 28, 29, 24, 25, 84, 85, 86, 87, 92, 93, 94, 95, 100, 101, 102, 103, 108, 109, 110, 111, 254, 255, 256, 257})
	end
end),

say=function(player,npc)
	local ibuylist = {18, 19, 20, 21, 26, 27, 28, 29, 24, 25, 84, 85, 86, 87, 92, 93, 94, 95, 100, 101, 102, 103, 108, 109, 110, 111, 254, 255, 256, 257}
	local ibuylistprice = {}
	local s = player.speech

	local mobG = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.dialogType = 0
	player.npcGraphic = mobG.graphic
	player.npcColor = mobG.color

	if (string.match(string.lower(s), "buy all my") ~= nil or string.match(string.lower(s), "buy my") ~= nil) then
		player:sellSpeech(npc, s, ibuylist)
	end

	if (string.match(string.lower(s), "what do you buy") ~= nil)then

		for i = 1, #ibuylist do
			
			table.insert(ibuylistprice,Item(ibuylist[i]).sell)

		end

		local temp=player:buy("The list of items I will buy are:",ibuylist,ibuylistprice,{},{})
	end

end,
}

yibokyen_smith = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local opts = {"Buy", "Sell", "Repair Item", "Repair All"}
	local optsbuy = {"Tools","Weapons", "Helms", "Simple Armors", "Mails (Warrior)", "Mail Dresses (Warrior)", "Armors (Rogue)", "Armor Dresses (Rogue)"}
	local menuOption
	local menuOptionBuy
	local menuOptionSell
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("Armors, weapons, which is it you need?", opts)
	
	if (menuOption == "Buy") then
		menuOptionBuy = player:menuString("What kind of object would you like to buy?", optsbuy)

		if (menuOptionBuy == "Tools") then
			player:buyExtend("What do you wish to buy?", {178, 188})
		elseif (menuOptionBuy == "Weapons") then
			player:buyExtend("What do you wish to buy?", {184, 185, 186, 187})
		elseif (menuOptionBuy == "Helms") then
			player:buyExtend("What do you wish to buy?", {112, 113, 114, 115, 116, 258})
		elseif (menuOptionBuy == "Simple Armors") then
			player:buyExtend("What do you wish to buy?", {22, 23, 24, 25})
		elseif (menuOptionBuy == "Mails (Warrior)") then
			player:buyExtend("What do you wish to buy?", {14, 80, 88, 96, 104, 250})
		elseif (menuOptionBuy == "Mail Dresses (Warrior)") then
			player:buyExtend("What do you wish to buy?", {15, 81, 89, 97, 105, 251})
		elseif (menuOptionBuy == "Armors (Rogue)") then
			player:buyExtend("What do you wish to buy?", {16, 82, 90, 98, 106, 252})
		elseif (menuOptionBuy == "Armor Dresses (Rogue)") then
			player:buyExtend("What do you wish to buy?", {17, 83, 91, 99, 107, 253})
		end
	elseif (menuOption == "Sell") then
		player:sellExtend("What do you wish to sell?", {14, 15, 16, 17, 22, 23, 24, 25, 80, 81, 82, 83, 88, 89, 90, 91, 96, 97, 98, 99, 104, 105, 106, 107, 184, 185, 186, 112, 113, 114, 115, 116, 187, 258, 250, 251, 252, 253})
	elseif(menuOption=="Repair Item") then
		player:repairExtend(t)
	elseif(menuOption=="Repair All") then
		player:repairAll(player,npc)
	end
end),

say=function(player,npc)
	local ibuylist = {14, 15, 16, 17, 22, 23, 24, 25, 80, 81, 82, 83, 88, 89, 90, 91, 96, 97, 98, 99, 104, 105, 106, 107, 184, 185, 186, 112, 113, 114, 115, 116, 187, 258, 250, 251, 252, 253}
	local s = player.speech

	if (string.match(string.lower(s), "buy all my") ~= nil or string.match(string.lower(s), "buy my") ~= nil) then
		player:sellSpeech(npc, s, ibuylist)
	end
end,
}