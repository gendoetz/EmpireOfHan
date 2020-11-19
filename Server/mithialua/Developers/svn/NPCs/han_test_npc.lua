han_test_npc = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local kapok = {graphic = convertGraphic(2456, "item"), color = 15}
	local opts = {"Buy", "Sell"}
	local optsbuy = {"Simple Clothes", "Garbs (Mage)", "Frocks (Mage)", "Mantles (Poet)", "Dresses (Poet)", "Waistcoats (Rogue)", "Blouses (Rogue)"}
	local menuOption
	local menuOptionBuy
	local menuOptionSell

	table.insert(opts,"A hole in the roof...")

	if (player.quest["mage_65armor"] == 5 or player.quest["poet_65armor"] == 5) then
		if (player:hasItem("65quest_cloth", 1) == true) then
		
		else
		player:dialogSeq({t, "You must be here for that elemental cloth... hmm... now where did I put it!",
		t, "Oh! Here we are! *Yaki grabs the cloth from a box on the shelf and gives it a good shake, folding it neatly.* That'll be 10,000 gold coins!"}, 1)
		local newChoice=player:menuString("Then we have a deal? *Yaki grins anxiously*",{"Yes","No"})
			if(newChoice == "Yes") then
					if(player.money >= 10000) then
						player.money = player.money - 10000
						player:sendStatus()
						player:dialogSeq({t, "Thanks, here ya go!"}, 1)
						player:addItem("65quest_cloth", 1)
					else
						player:dialogSeq({t,"You do not have the money you trying to scam me?"})
					end
			else
				player:dialogSeq({t, "Fine then, guess I'll just create a garment for myself."}, 1)
			end
		end
	end

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("Are you looking to buy garments for your path?", opts)
	
	if (menuOption == "Buy") then
		menuOptionBuy = player:menuString("What kind of clothing would you like to buy?", optsbuy)
		
		if (menuOptionBuy == "Simple Clothes") then
			player:buyExtend("What do you wish to buy?", {27, 26, 28, 29, 24, 25, 246, 247, 248, 249})
		elseif (menuOptionBuy == "Garbs (Mage)") then
			player:buyExtend("What do you wish to buy?", {18, 84, 92, 100, 108, 254})
		elseif (menuOptionBuy == "Frocks (Mage)") then
			player:buyExtend("What do you wish to buy?", {19, 85, 93, 101, 109, 255})
		elseif (menuOptionBuy == "Mantles (Poet)") then
			player:buyExtend("What do you wish to buy?", {20, 86, 94, 102, 110, 256})
		elseif (menuOptionBuy == "Dresses (Poet)") then
			player:buyExtend("What do you wish to buy?", {21, 87, 95, 103, 111, 257})
		elseif (menuOptionBuy == "Waistcoats (Rogue)") then
			player:buyExtend("What do you wish to buy?", {16, 82, 90, 98, 106, 252})
		elseif (menuOptionBuy == "Blouses (Rogue)") then
			player:buyExtend("What do you wish to buy?", {17, 83, 91, 99, 107, 253})
		end
	elseif (menuOption == "Sell") then
		player:sellExtend("What do you wish to sell?", {18, 19, 20, 21, 26, 27, 28, 29, 24, 25, 84, 85, 86, 87, 92, 93, 94, 95, 100, 101, 102, 103, 108, 109, 110, 111, 246, 247, 248, 249, 254, 255, 256, 257})
	elseif(menuOption=="A hole in the roof...") then
			if (player.quest["roof_hole"] == 0) then
				player:dialogSeq({t, "Kapok branches! I need kapok branches quick! No time to waste dear my roof has a hole and its going to storm!",
				kapok, "*Yaki taps her foot* Whatcha waiting for! Kapok trees are in Seong Lowlands, near the shore! Just 10 should do!"}, 1)
				player.quest["roof_hole"] = 1
			elseif (player.quest["roof_hole"] == 1) then
				if (player:hasItem("k_branch", 10) == true) then
					player:dialogSeq({t, "You're a doll! Nothing is worse than wet smelly cloth! Blech!"}, 1)
					player:removeItem("k_branch", 10)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player:addGold(1800)
						player:giveXP(30000)
						onCalcTNL(player)
						player:msg(8, "Rewards:\nGold: 1800\nExp: 30000\nImperial Standing: +1", player.ID)
						player.quest["roof_hole"] = 2
				else
					player:dialogSeq({kapok, "Kapok trees are in Seong Lowlands, near the shore! Just 10 should do! Now shoo! Quickly!"}, 1)
				end
			elseif (player.quest["roof_hole"] == 2) then
				player:dialogSeq({t, "Thanks hun!"}, 1)
			end
		
	end
end)
}
