t1_seamstress = {
click = async(function(player,npc)
	local t = {graphic = convertGraphic(11, "monster"), color = 2}
	local rabbit = {graphic = convertGraphic(21, "monster"), color = 28}
	local opts = {"Buy", "Sell", "A missing necklace..."}
	local optsbuy = {"Simple Clothes", "Garbs (Mage)", "Skirts (Mage)", "Robes (Poet)", "Gowns (Poet)"}
	local menuOption
	local menuOptionBuy
	local menuOptionSell

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("I have the finest garments, take a look and see! Hehe!", opts)
	
	if (menuOption == "Buy") then
		menuOptionBuy = player:menuString("What kind of object would you like to buy?", optsbuy)
		
		if (menuOptionBuy == "Simple Clothes") then
			player:buyExtend("What do you wish to buy?", {26, 27, 28, 29})
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
	elseif(menuOption=="A missing necklace...") then
			if (player.quest["P_mnecklace"] == 0) then
				player:dialogSeq({t, "Oh dear... oh dear me...",
				t, "I'm sorry.. I've lost my necklace and it was very special to me, it was a gift from my mother. *Yina's eyes tear up*",
				rabbit, "All I can remember is a few days back, I was on the path from the imperial city back to Pinyan when I saw an obsidian rabbit!",
				rabbit, "I tripped and fell, and my necklace came unfastened.. and... no one will believe me that the rabbit took it!",
				rabbit, "The witch has the wildlife enchanted, I know she does.. and she means to take my precious necklace!  The last I saw was the rabbit headed towards the eastern woods..."}, 1)
				player.quest["P_mnecklace"] = 1
			elseif (player.quest["P_mnecklace"] == 1) then
				if (player:hasItem("t_lost_necklace", 1) == true) then
					player:dialogSeq({t, "You found it!!!  I cannot believe you actually found it!"}, 1)
					player:removeItem("t_lost_necklace", 1)
						player:addGold(800)
						player:giveXP(7500)
						onCalcTNL(player)
						player:msg(8, "Rewards:\nGold: 800\nExp: 7500", player.ID)
						player.quest["P_mnecklace"] = 2
				else
					player:dialogSeq({rabbit, "All I know is that rabbit took my necklace, I am not crazy.. and he headed to the eastern woods!"}, 1)
				end
			elseif (player.quest["P_mnecklace"] == 2) then
				player:dialogSeq({t, "Thank you so much for recovering my necklace!"}, 1)
			end
		
	end
end)
}

t1_smith = {
click = async(function(player,npc)
	local t = {graphic = convertGraphic(6, "monster"), color = 10}
	local opts = {"Buy", "Sell", "Repair Item", "Repair All"}
	local optsbuy = {"Helms", "Simple Armors", "Mails (Warrior)", "Mail Dresses (Warrior)", "Armors (Rogue)", "Armor Dresses (Rogue)"}
	local menuOption
	local menuOptionBuy
	local menuOptionSell

		--if (player.quest["P_rareflower"] <= 3) then
				table.insert(opts,"A rare flower...")
		--end

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("I have the strongest armors! HA!", opts)
	
	if (menuOption == "Buy") then
		menuOptionBuy = player:menuString("What kind of object would you like to buy?", optsbuy)
		if (menuOptionBuy == "Helms") then
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
		player:sellExtend("What do you wish to sell?", {14, 15, 16, 17, 22, 23, 24, 25, 80, 81, 82, 83, 88, 89, 90, 91, 96, 97, 98, 99, 104, 105, 106, 107, 184, 185, 186, 187, 112, 113, 114, 115, 116, 187, 258, 250, 251, 252, 253})
	elseif(menuOption=="Repair Item") then
		player:repairExtend(t)
	elseif(menuOption=="Repair All") then
		player:repairAll(player,npc)
	elseif (menuOption == "A rare flower...") then
		if (player.quest["P_rareflower"] == 0) then
		player:dialogSeq({t, "Say fella, my name is Dobak, you wouldnt happen to be the adventuring type eh?  You look like you would have enough heart to take on my task...",
		t, "I'm a little rough around the edges, but I have a soft side, HA!  Matter of fact is, the village seamstress Yina... well, why dont we just skip the mushy stuff.",
		t, "The eastern woods have become too dangerous, but theres a rare flower that grows there.  If you can bring that back to me there's some good gold in it for ya!"}, 1)
		player.quest["P_rareflower"] = 1
		elseif (player.quest["P_rareflower"] == 1) then
		player:dialogSeq({t, "The eastern woods have become too dangerous, but theres a rare flower that grows there.  If you can bring that back to me there's some good gold in it for ya!"}, 1)
		elseif (player.quest["P_rareflower"] == 2) then
		player:dialogSeq({t, "The flower!  What a champ!  Here take this gold, thanks for your help."}, 1)
		player:addGold(600)
		player:giveXP(7500)
		onCalcTNL(player)
		player:msg(8, "Rewards:\nGold: 600\nExp: 7500", player.ID)
		player.quest["P_rareflower"] = 3
		elseif (player.quest["P_rareflower"] == 3) then
		player:dialogSeq({t, "Thanks again for your help."}, 1)
		end
	end
end)
}

t1_alchemist = {
click = async(function(player,npc)
	local t = {graphic = convertGraphic(7, "monster"), color = 8}
	local opts = {"Buy", "Sell", "Important research..."}
	local optsbuy = {"Potions", "Alchemy Materials"}
	local menuOption
	local menuOptionBuy
	local menuOptionSell
				--table.insert(opts,"A rare flower...")
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("Potions are my specialty!", opts)
	
	if (menuOption == "Buy") then
		menuOptionBuy = player:menuString("What kind of object would you like to buy?", optsbuy)
		
		if (menuOptionBuy == "Potions") then
			if (player.quest["P_research"] == 2) then
				player:buyExtend("What do you wish to buy?", {41, 42})
			else
				player:buyExtend("What do you wish to buy?", { })
			end
		elseif (menuOptionBuy == "Alchemy Materials") then
			player:buyExtend("What do you wish to buy?", { })
		end
	elseif (menuOption == "Sell") then
		player:sellExtend("What do you wish to sell?", {41, 42, 43, 37})
	elseif (menuOption == "Important research...") then
		if (player.quest["P_research"] == 0) then
		player:dialogSeq({t, "Oh, hello... I'm sure you're wondering why I have no potions or wares for sale... to be honest I've just been too busy researching ways to counteract the corruption of the wildlife.",
		t, "Say.. you look like a strong one, perhaps you would be willing to help?",
		t, "If you are already headed to the eastern Pinyan woods this task is perfect for you!  I need the tainted antlers from the corrupted deer!  It seems they are being twisted by the witches magic.",
		t, "If you bring me 20 Tainted Antlers I'll reward you, and I'll even have time to stock some potions!"}, 1)
		player.quest["P_research"] = 1
		elseif (player.quest["P_research"] == 1) then
				if (player:hasItem("tainted_antlers", 20) == true) then
					player:dialogSeq({t, "Stupendous!  These will work quite nicely!"}, 1)
					player:removeItem("tainted_antlers", 20)
						player:addGold(600)
						player:giveXP(7500)
						onCalcTNL(player)
						player:msg(8, "Rewards:\nGold: 600\nExp: 7500", player.ID)
						player.quest["P_research"] = 2
				else
					player:dialogSeq({t, "If you bring me 20 Tainted Antlers from the eastern Pinyan woods I'll reward you, and I'll even have time to stock some potions!"}, 1)
				end
		elseif (player.quest["P_research"] == 2) then
		player:dialogSeq({t, "Thanks again for your help, I have my work cut out for me.  Take a look at the potions I have in stock!"}, 1)
		end
	end
end)
}