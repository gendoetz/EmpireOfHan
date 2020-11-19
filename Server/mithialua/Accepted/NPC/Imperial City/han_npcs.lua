han_seamstress = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local kapok = {graphic = convertGraphic(2456, "item"), color = 15}
	local opts = {"Buy", "Sell"}
	local optsbuy = {"Simple Clothes", "Garbs (Mage)", "Skirts (Mage)", "Robes (Poet)", "Gowns (Poet)"}
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

han_smith = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local opts = {"Buy", "Sell", "Repair Item", "Repair All"}
	local optsbuy = {"Tools","Weapons", "Helms", "Simple Armors", "Mails (Warrior)", "Mail Dresses (Warrior)", "Armors (Rogue)", "Armor Dresses (Rogue)"}
	local menuOption
	local menuOptionBuy
	local menuOptionSell
	
	if (player.quest["broken_em_weapon"] >= 1) then
		table.insert(opts,"The Emerald Weapons of Lore")
	end

	if (player.quest["weapon95_uncurse"] == 1) then
		table.insert(opts,"A cursed weapon...")
	end

	if (player.quest["warrior_65armor"] == 5 or player.quest["rogue_65armor"] == 5) then
		if (player:hasItem("65quest_metal", 1) == true) then
		
		else
		player:dialogSeq({t, "Come for that metal did you.. yeah I have it somewhere...",
		t, "*Bando narrows his eyes at you* This wasn't easy to forge ya know, hope you intend to pay my times worth, 10,000 gold coins..."}, 1)
		local newChoice=player:menuString("Do you have enough?",{"Yes","No"})
			if(newChoice == "Yes") then
					if(player.money >= 10000) then
						player.money = player.money - 10000
						player:sendStatus()
						player:dialogSeq({t, "Seems we understand eachother. Good!"}, 1)
						player:addItem("65quest_metal", 1)
					else
						player:dialogSeq({t,"You do not have the money.. this a joke?"})
					end
			else
				player:dialogSeq({t, "No skin off my back buddy..."}, 1)
			end
		end
	end

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("Finest armors in the kingdom right here.", opts)
	
	if (menuOption == "Buy") then
		menuOptionBuy = player:menuString("What kind of object would you like to buy?", optsbuy)

		if (menuOptionBuy == "Tools") then
			player:buyExtend("What do you wish to buy?", {178, 188, 40094, 40105, 40325, 40090, 40086, 40098, 40333})
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
	elseif (menuOption == "A cursed weapon...") then
		if (player.quest["weapon95_uncurse"] == 1) then
		player:dialogSeq({t, "Cursed weapon? Hell.. I don't deal with no curses, don't even try to repair something like that in my shop, out with you!",
				t, "What do I look like? I told yeh I don't deal with curses, maybe ask one of them brainy scholars or something..."}, 1)
		end
	elseif (menuOption == "The Emerald Weapons of Lore") then
		if(player.quest["broken_em_weapon"] == 1) then
			if (player:hasItem("broken_ew1", 1) == true or player:hasItem("broken_ew2", 1) == true or player:hasItem("broken_ew3", 1) == true or player:hasItem("broken_ew4", 1) == true) then
				player:dialogSeq({t, "Well... I haven't seen a weapon of this quality and craftsmanship in quite some time, it does look like it is in rough shape though. The Emerald Weapons were said to have been infused with the lifeforce of the wielder themself.",
				t, "It seems that you have discovered one that has been though quite a lot in it's life. These weapons were once said to be as much alive as the artisan that employed their powers, so it is no surprise that this weapon looks degraded and crumbled.",
				t, "Tell you what.. I'll help you to repair this weapon but I will need a bit of supplies from you, this won't be an easy task. These great weapons will only grow in power as you grow and become more adept.",
				t, "In time you will be required to make greater sacrifices to improve the weapon. I will start you off with the basics of my knowledge in repairing the primary form."}, 1)
				player.quest["broken_em_weapon"] = 2
				player:dialogSeq({t, "First, bring to me the materials I need to repair the weapon. I require (25) Emerald Fragments, (10) Emerald Chunks, (20) Tiger's Tooth. Once you have these items we may continue."}, 1)
			end
		elseif(player.quest["broken_em_weapon"] == 2) then
			if (player:hasItem("emerald_frag", 25) == true and player:hasItem("emerald_chunk", 10) == true and player:hasItem("tigers_tooth", 20) == true) then
			player:dialogSeq({t, "It seems you have managed to gather the items I require. To continue I will need the broken weapon and the materials."}, 1)
			local menuOption = player:menuString("Are you ready to hand over the items?", {"Yes", "No"})
				if (menuOption == "Yes") then
					if (player:hasItem("emerald_frag", 25) == true and player:hasItem("emerald_chunk", 10) == true and player:hasItem("tigers_tooth", 20) == true and player:hasItem("broken_ew1", 1) == true) then
						player:removeItem("emerald_frag", 25, 9)
						player:removeItem("emerald_chunk", 10, 9)
						player:removeItem("tigers_tooth", 20, 9)
						player:removeItem("broken_ew1", 1, 9)
						player:addItem("stage1_ew1", 1, 10000, player.ID)
						player.quest["broken_em_weapon"] = 3
						player:dialogSeq({t, "I must say.. I am quite the master of weapon repair. Return to me when you have gained greater insight and I will help you to unlock your weapon's potential further."}, 1)
					elseif (player:hasItem("emerald_frag", 25) == true and player:hasItem("emerald_chunk", 10) == true and player:hasItem("tigers_tooth", 20) == true and player:hasItem("broken_ew2", 1) == true) then
						player:removeItem("emerald_chunk", 10, 9)
						player:removeItem("tigers_tooth", 20, 9)
						player:removeItem("broken_ew2", 1, 9)
						player:addItem("stage1_ew2", 1, 10000, player.ID)
						player.quest["broken_em_weapon"] = 3
						player:dialogSeq({t, "I must say.. I am quite the master of weapon repair. Return to me when you have gained greater insight and I will help you to unlock your weapon's potential further."}, 1)
					elseif (player:hasItem("emerald_frag", 25) == true and player:hasItem("emerald_chunk", 10) == true and player:hasItem("tigers_tooth", 20) == true and player:hasItem("broken_ew3", 1) == true) then
						player:removeItem("emerald_chunk", 10, 9)
						player:removeItem("tigers_tooth", 20, 9)
						player:removeItem("broken_ew3", 1, 9)
						player:addItem("stage1_ew3", 1, 10000, player.ID)
						player.quest["broken_em_weapon"] = 3
						player:dialogSeq({t, "I must say.. I am quite the master of weapon repair. Return to me when you have gained greater insight and I will help you to unlock your weapon's potential further."}, 1)
					elseif (player:hasItem("emerald_frag", 25) == true and player:hasItem("emerald_chunk", 10) == true and player:hasItem("tigers_tooth", 20) == true and player:hasItem("broken_ew4", 1) == true) then
						player:removeItem("emerald_chunk", 10, 9)
						player:removeItem("tigers_tooth", 20, 9)
						player:removeItem("broken_ew4", 1, 9)
						player:addItem("stage1_ew4", 1, 10000, player.ID)
						player.quest["broken_em_weapon"] = 3
						player:dialogSeq({t, "I must say.. I am quite the master of weapon repair. Return to me when you have gained greater insight and I will help you to unlock your weapon's potential further."}, 1)
					end
				elseif (menuOption == "No") then
					--player.quest["broken_em_weapon"] = 3
				end
			else
			player:dialogSeq({t, "Bring to me the materials I need to repair the weapon. I require (25) Emerald Fragments, (10) Emerald Chunks, (20) Tiger's Tooth. Once you have these items we may continue."}, 1)
			end
		elseif(player.quest["broken_em_weapon"] == 3) then
			player:dialogSeq({t, "You must get stronger if I am to help you further."}, 1)
			player.quest["broken_em_weapon"] = 0
		end
	end
end),

say=function(player,npc)
	local ibuylist = {14, 15, 16, 17, 22, 23, 24, 25, 80, 81, 82, 83, 88, 89, 90, 91, 96, 97, 98, 99, 104, 105, 106, 107, 184, 185, 186, 112, 113, 114, 115, 116, 187, 258, 250, 251, 252, 253}
	local s = player.speech

	if (string.match(string.lower(s), "buy all my") ~= nil or string.match(string.lower(s), "buy my") ~= nil) then
		player:sellSpeech(npc, s, ibuylist)
	end
end,

emerald_weapon = async(function(player)
		local chest = {graphic = convertGraphic(809, "monster"), color = 0}
		local weap1 = {graphic = convertGraphic(3171, "item"), color = 19}
		local weap2 = {graphic = convertGraphic(3174, "item"), color = 0}
		local weap3 = {graphic = convertGraphic(3168, "item"), color = 0}
		local weap4 = {graphic = convertGraphic(3165, "item"), color = 0}
		player.npcGraphic = chest.graphic
		player.npcColor = chest.color
		player.dialogType = 0
			player:dialogSeq({chest, "*You notice a chest emitting a faint green light. The sound of a tiger's roar startles you and you quickly pull at the chest lid.*",
			chest, "*The chest does not budge, you wonder if the chest is sealed with magic as there appears to be no lock.*",
			chest, "*You hear a second booming tiger roar and muster all of your strength, the chest opens just enough for you to squeeze in your other arm.*",
			chest, "*Your body trembles as you struggle to hold the chest open.* ((Quickly you must choose which do you grab?!))"}, 1)
			local opts = {"What feels like a decorated staff", "What feels like a long staff", "What feels like a straight sword", "What feels like a curved sword"}
			local menuOption
			menuOption = player:menuString("What will you grab?", opts)
				if (menuOption == "What feels like a decorated staff") then
				player:dialogSeq({weap1, "*You grab ahold of the item and and quickly pull it from the chest. It looks to be a weapon but it is broken and tarnished. Maybe the smith in Han could repair it for you.*"}, 1)
				player:addItem("broken_ew1", 1)
				elseif (menuOption == "What feels like a long staff") then
				player:dialogSeq({weap2, "*You grab ahold of the item and and quickly pull it from the chest. It looks to be a weapon but it is broken and tarnished. Maybe the smith in Han could repair it for you.*"}, 1)
				player:addItem("broken_ew2", 1)
				elseif (menuOption == "What feels like a straight sword") then
				player:dialogSeq({weap3, "*You grab ahold of the item and and quickly pull it from the chest. It looks to be a weapon but it is broken and tarnished. Maybe the smith in Han could repair it for you.*"}, 1)
				player:addItem("broken_ew4", 1)
				elseif (menuOption == "What feels like a curved sword") then
				player:dialogSeq({weap4, "*You grab ahold of the item and and quickly pull it from the chest. It looks to be a weapon but it is broken and tarnished. Maybe the smith in Han could repair it for you.*"}, 1)
				player:addItem("broken_ew3", 1)
				end
			player.quest["broken_em_weapon"] = 1
end)
}

han_alchemist = {
click = async(function(player,npc)
	local t = {graphic = convertGraphic(7, "monster"), color = 9}
	local opts = {"Buy", "Sell", "A sketchy shipment..."}
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
		player:sellExtend("What do you wish to sell?", {41, 42, 43, 37, 56, 406, 407, 177, 165, 412, 411, 40049, 40050, 151, 163, 164, 191, 162, 427, 428, 285, 484, 492})
	elseif (menuOption == "A sketchy shipment...") then
		if (player.quest["sketchy_shipment"] == 0) then
				player:dialogSeq({t, "Oh hey there, you look like you have some free time! Well.. what I mean is you look like the type... uh, rather I need your help with something!",
				t, "Its probably better you not ask questions.. Just go over to the storehouse just a bit south-east of here.. I'm expecting another rare alchemy shipment to come in; seek out a man by the name of Jerris."}, 1)
				player.quest["sketchy_shipment"] = 1
		elseif (player.quest["sketchy_shipment"] == 1) then
				player:dialogSeq({t, "The shipment is probably stored in the storehouse just south-east of here..."}, 1)
		elseif (player.quest["sketchy_shipment"] == 2) then
				player:dialogSeq({t, "Bahaha *ahem* yeah.. I knew this wasn't going to be easy, well I hate to make you do this, but really there's no other way.. just trust me!",
					t, "Put on this disguise and talk to the door guard again.. I'm sure you'll get in this time, when you are in the back room just talk to Jerris, and be careful you don't wanna get stuck doing anything sketchy!"}, 1)
				player.quest["sketchy_shipment"] = 3
				player:addItem("disguise_pack", 1)
		elseif (player.quest["sketchy_shipment"] == 3) then
			if(player:hasItem("disguise_pack", 1) == true) then
				player:dialogSeq({t, "Go on now, go back and talk to the door guard, we don't have all day!"}, 1)
			else
				player:dialogSeq({t, "Did you loose the disguise? ... these aren't easy to put together.. don't lose it or its coming out of your reward!"}, 1)
				player:addItem("disguise_pack", 1)
			end
		elseif (player.quest["sketchy_shipment"] == 4) then
			player:dialogSeq({t, "Fantastic! Just what I needed.. *Dunby takes the shipment from you*",
				t, "Hey, being an alchemist isn't easy.. on top of having to handle strange and dangerous materials you end up having to do whatever it takes for the ingredients to powerful potions..",
				t, "Thanks for the assistance, here take this as a reward."}, 1)
						player:removeItem("disguise_pack", 1, 9)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player:addGold(3000)
						player:giveXP(60000)
						onCalcTNL(player)
						player:msg(8, "Rewards:\nGold: 3000\nExp: 60000\nImperial Standing: +1", player.ID)
						player.quest["sketchy_shipment"] = 5
		elseif (player.quest["sketchy_shipment"] == 5) then
			player:dialogSeq({t, "Like I said.. being an alchemist you'll do some sketchy things.. thanks again!"}, 1)
		end
	end
end),

say=function(player,npc)
	local ibuylist = {41, 42, 43, 37, 56, 406, 407, 177, 165, 412, 411, 40049, 40050, 151, 163, 164, 191, 162, 427, 428, 285, 484, 492}
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

sketchyshipQuest = {
click = async(function(player,npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local opts = {"A sketchy shipment..."}
	local menuOption

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	menuOption = player:menuString("What is it you want?", opts)
	
	if (menuOption == "A sketchy shipment...") then
		if (player.quest["sketchy_shipment"] == 0) then
				player:dialogSeq({t, "You sound like that annoying alchemist, that is what he's always wantin'"}, 1)
		elseif (player.quest["sketchy_shipment"] == 1) then
				player:dialogSeq({t, "You got nothin' Jerris is interested in bub!",
				t, "Go waste someone elses time..."}, 1)
				player.quest["sketchy_shipment"] = 2
		elseif (player.quest["sketchy_shipment"] == 2) then
				player:dialogSeq({t, "You got nothin' Jerris is interested in bub!",
				t, "Go waste someone elses time..."}, 1)
		elseif (player.quest["sketchy_shipment"] == 3) then
			if (player:hasDuration("disguise_quest")) then
				player:dialogSeq({t, "*Whistles* Now that's what I'm talking about.. Jerris may be able to use talent like that.. go right in babe!"}, 1)
				player:warp(175, 7, 12)
			else
				player:dialogSeq({t, "Didn't I tell you to scram!?"}, 1)
			end
		elseif (player.quest["sketchy_shipment"] == 4) then
			player:dialogSeq({t, "Don't look at me.. I just guard the door..."}, 1)
		elseif (player.quest["sketchy_shipment"] == 5) then
			player:dialogSeq({t, "*Hums to himself*"}, 1)
		end
	end
end),
}

sketchyshipQuest2 = {
click = async(function(player,npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local opts = {"A sketchy shipment..."}
	local menuOption
	local choice

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	menuOption = player:menuString("The glitsy glamourous life is one afforded to only the most beautiful, like moi!", opts)
	
	if (menuOption == "A sketchy shipment...") then
		if (player.quest["sketchy_shipment"] == 3) then
				player:dialogSeq({t, "Bwah! Who let you in here? You aint even that pretty, and you smell like a toad...",
					t, "Me oh my, what is this world coming to! Why are there no beautiful women that can compare to my beauty.. WHAT A TRAVESTY!!",
					t, "Why do you insist on torturing my eyeballs? Speak up!"}, 1)
				choice = player:menuString("What is it what want?", {"I'm here to pick up a shipment...", "I'm here for some hanky panky and gold!"})
				if (choice == "I'm here to pick up a shipment...") then
					player:dialogSeq({t, "Thats it? Here, just take it--tell that good-for-nothing man I don't want to handle his unmentionables anymore... I MEAN HIS SKETCHY SHIPMENTS..!",
						t, "*You quickly stuff the shipment in your pocket and realize you better leave.* ((This item will not show in inventory.))"}, 1)
						player.quest["sketchy_shipment"] = 4
				else
					player:dialogSeq({t, "Honey.. you aint worth a single coin, maybe you should try a different line of work.. shoo now!"}, 1)
				end
		elseif (player.quest["sketchy_shipment"] == 4) then
				player:dialogSeq({t, "Get out of my sight!"}, 1)
		end
	end
end),
}

han_gemcutter = {
click = async(function(player,npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local opts = {"Buy", "Sell",}
	local optsbuy = {"Potions", "Alchemy Materials"}
	local menuOption
	local menuOptionBuy
	local menuOptionSell

	--if (player.quest["roof_hole"] == 2 and player.quest["path_choice_quest"] == 7) then
	--table.insert(opts, "A cracked gem...")
	--end

	if(player.quest["event_quest1"] == 0) then
		--table.insert(opts, "Dark Matter")
	end
				--table.insert(opts,"A rare flower...")
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString2("Gems, gold, and precious minerals.. everything I've ever wanted!", opts)
	
	if (menuOption == "Buy") then
		player:buyExtend("What do you wish to buy?", {40022, 40023, 40024})
		--menuOptionBuy = player:menuString("What kind of object would you like to buy?", optsbuy)
		
		--[[if (menuOptionBuy == "Potions") then
			if (player.quest["P_research"] == 2) then
				player:buyExtend("What do you wish to buy?", { })
			else
				player:buyExtend("What do you wish to buy?", { })
			end
		elseif (menuOptionBuy == "Alchemy Materials") then
			player:buyExtend("What do you wish to buy?", { })
		end--]]
	elseif (menuOption == "Sell") then
		player:sellExtend("What do you wish to sell?", {55, 408, 149, 150})
	elseif (menuOption == "Dark Matter") then
		player:dialogSeq({t, "Yes.. this dark matter the citizens have been discovering is quite the problem.. it bends the magics between the realm of darkness and our own...",
		t, "Perhaps we can work together to neutralize this dark energy. Bring me ten of each of the totem stones discovered in the dark realm, and this dark matter and I will see what I can do..."}, 1)
				if (player:hasItem("dark_matter_e", 1) == true and player:hasItem("warrior_sevent", 10) == true and player:hasItem("rogue_sevent", 10) == true and player:hasItem("mage_sevent", 10) == true and player:hasItem("poet_sevent", 10) == true) then
					player:dialogSeq({t, "Excellent, let us see if I can meld the energies of these stones and the dark matter. *Pongi focuses on fusing the stones, hammering away at a golden band*"}, 1)
					player:removeItem("warrior_sevent", 10)
					player:removeItem("rogue_sevent", 10)
					player:removeItem("mage_sevent", 10)
					player:removeItem("poet_sevent", 10)
					player:removeItem("dark_matter_e", 1)
					player:addItem("darkm_ring", 1)
					player.quest["event_quest1"] = 1
					player:dialogSeq({t, "There we go.. Working with such a dark and powerful material seems to have taken a lot out of me... I don't think I could make you another."}, 1)
				else
					player:dialogSeq({t, "Venture into the dark realm and bring back what we need to continue..."}, 1)
				end
	elseif (menuOption == "A cracked gem...") then
		if (player.quest["H_crackedgem"] == 0) then
		player:dialogSeq({t, "Hello "..player.name..". I heard you to would be coming to visit me. We are thankful you made it out of the witch's forest alive.",
		t, "I am in need of some assistance. Vina has sent me a whisper advising that the gem in her necklace had been chipped.",
		t, "The crystalline foxes in northern Han love to horde the gemstones they find. They dig them up and then attach them to their necks.",
		t, "Return to me once you have collected 5 Rough Kyanite so that I may cut a new gem for Vina's necklace. ((The foxes can be found at 78, 25))."}, 1)
		player.quest["H_crackedgem"] = 1
		elseif (player.quest["H_crackedgem"] == 1) then
				if (player:hasItem("rough_kyanite", 5) == true) then
					player:dialogSeq({t, "Thank you for gathering this Rough Kyanite. Please go grab my Chisel from the chest downstairs so that I may begin to work."}, 1)
					player:removeItem("rough_kyanite", 5)
					player.quest["H_crackedgem"] = 2
				else
					player:dialogSeq({t, "Return to me once you have collected 5 Rough Kyanite so that I may cut a new gem for Vina's necklace. ((The foxes can be found at 78, 25))."}, 1)
				end
		elseif (player.quest["H_crackedgem"] == 2 or player.quest["H_crackedgem"] == 4) then
				if (player:hasItem("gem_chisel", 1) == true) then

					player:dialogSeq({t, "I heard a commotion down there. Are you okay?",
					t,"Gem thieves you say? Well I'm glad you took care of them and are safe.  I don't know what I would have done without your help! Thank you for getting my Chisel.",
					t,"Here, take this necklace as a reward, it has a few flaws but I think you can put it to good use. I will have Vina's necklace delivered to her once I fix it."}, 1)
					player:removeItem("gem_chisel", 1)
						player:addGold(200)
						player:giveXP(15000)
						onCalcTNL(player)
						player:addItem("kyanite_neck1", 1)
						player:msg(8, "Rewards:\nGold: 200\nExp: 15000\nFlawed Kyanite Necklace", player.ID)
					player.quest["H_crackedgem"] = 5
				else
					player:dialogSeq({t, "Are you having trouble finding my Chisel? It's in the chest downtairs."}, 1)
				end
		elseif (player.quest["H_crackedgem"] == 5) then
		player:dialogSeq({t, "Feel free to come back and visit me any time. I heard that the butcher needs some help. Maybe you should visit him..."}, 1)
		end
	end
end),

say=async(function(player,npc)
	local ibuylist = {55, 408, 149, 150}
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

	if (string.match(string.lower(s), "what do you sell") ~= nil)then
		player:buyExtend("What do you wish to buy?", {40022, 40023, 40024})
	end
	
end),

spawn_ninjas = async(function(player)
	if (player.quest["H_crackedgem"] == 2) then
		local chest = {graphic = convertGraphic(809, "monster"), color = 0}
		local ninjanumber = 0
		local mobBlocks = player:getObjectsInSameMap(BL_MOB)
				if (#mobBlocks > 0) then
					for i = 1, #mobBlocks do
						ninjanumber = ninjanumber + 1
					end
				end
		if (ninjanumber >= 1) then
					return
		else
			player:dialogSeq({chest, "*You give the chest a try but it seems to be stuck.. suddenly you hear a noise behind you...*"}, 1)
			repeat
			player:spawn(505, math.random(4, 13), math.random(4, 9), 1)
			ninjanumber = ninjanumber + 1
			until (ninjanumber == 11)
			player:spawn(506, math.random(4, 13), math.random(4, 9), 1)
		--[[repeat
		local checkninjas = player:getObjectsInSameMap(BL_MOB)
		local checkninjasalive = 0
		--local applenumber = 0
		if (#checkninjas > 0) then
			for i = 1, #checkninjas do
				if (checkninjas[i].id == 505) then
				checkninjasalive = checkninjasalive + 1
				end
			end
		end
		if (checkninjasalive <= 10) then
		player:spawn(516, math.random(4, 13), math.random(4, 9), 1)
		end
		until (checkninjasalive == 11)
		--]]
		end
	end
	local chisel = {graphic = convertGraphic(3289, "item"), color = 18}
	if (player.quest["H_crackedgem"] == 3) then
		player:dialogSeq({chisel, "*You try the chest again and it opens, you grab the Chisel.*"}, 1)
		player:addItem("gem_chisel", 1)
		player.quest["H_crackedgem"] = 4
	end

end)

}

gem_thief2 = {

after_death = function(mob, player)
	if (player.quest["H_crackedgem"] == 2) then
		player.quest["H_crackedgem"] = 3
	end
		--[[local mobBlocks = player:getObjectsInSameMap(BL_MOB)
			if (#mobBlocks > 0) then
				for i = 1, #mobBlocks do
					mobBlocks[i]:delete()
				end
			end
			player:dialogSeq({apple, "Spawn complete."}, 1)
			--]]
end

}

han_butcher = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local opts = {"Buy", "Sell"}
	local menuOption
	local menuOptionBuy
	local menuOptionSell

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("What do you need puny one?", opts)
	
	if (menuOption == "Buy") then
		player:buyExtend("What do you need?", {2, 3, 40047})
	elseif (menuOption == "Sell") then
		player:sellExtend("What will you sell me?", {2, 3, 413, 40047, 40048, 284})
	end
end)
}
