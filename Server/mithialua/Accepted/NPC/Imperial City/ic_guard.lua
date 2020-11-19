ic_guard = {
click = async(function(player, npc)
	local npcT = {graphic = 0, color = 0}
	--local menuOptions = {}
	--local corruptdeer = {graphic = convertGraphic(89, "monster"), color = 15}
	
	player.npcGraphic = npcT.graphic
	player.npcColor = npcT.color
	player.dialogType = 1


	local opts = {"Points of Interest", "Imperial Bounty", "Imperial Standing"}
	local poi = {"The Imperial Palace", "", "Warrior Guild", "Rogue Guild", "Mage Guild", "Poet Guild", "", "Alchemist", "Arena", "Chapel", "Cook/Butcher", "Lanyu's Inn", "Jail", "Jeweler", "Messenger", "Salon", "", "East Shaman", "West Shaman", "", "Smith" , "Mining & Smelting", "Seamstress", "Cloth Crafting & Gathering", "", "Crystal Fox Cave (Lv10 - Lv15)", "Cancel"}
	local menuOption
	local menuOptionpoi


	menuOption = player:menuString("What do you need?", opts)
	if (menuOption == "Points of Interest") then
		menuOptionpoi = player:menuString("Points of interest are locations within these walls, what do you need help finding?", poi)
		if (menuOptionpoi == "The Imperial Palace") then
			player:dialogSeq({npcT, "Imperial Palace of Han\nLocated at: ((60, 112))"}, 1)
		elseif (menuOptionpoi == "Crystal Fox Cave (Lv10 - Lv15)") then
			player:dialogSeq({npcT, "Crystal Fox Cave\nLocated at: ((77, 25))"}, 1)
		elseif (menuOptionpoi == "Warrior Guild") then
			player:dialogSeq({npcT, "Warrior Guild\nLocated at: ((15, 14))"}, 1)
		elseif (menuOptionpoi == "Rogue Guild") then
			player:dialogSeq({npcT, "Rogue Guild\nLocated at: ((29, 69))"}, 1)
		elseif (menuOptionpoi == "Mage Guild") then
			player:dialogSeq({npcT, "Mage Guild\nLocated at: ((125, 19))"}, 1)
		elseif (menuOptionpoi == "Poet Guild") then
			player:dialogSeq({npcT, "Poet Guild\nLocated at: ((118, 74))"}, 1)
		elseif (menuOptionpoi == "East Shaman") then
			player:dialogSeq({npcT, "East Shaman\nLocated at: ((121, 50))"}, 1)
		elseif (menuOptionpoi == "West Shaman") then
			player:dialogSeq({npcT, "West Shaman\nLocated at: ((9, 115))"}, 1)
		elseif (menuOptionpoi == "Alchemist") then
			player:dialogSeq({npcT, "Alchemist\nLocated at: ((90, 82))"}, 1)
		elseif (menuOptionpoi == "Arena") then
			player:dialogSeq({npcT, "Arena\nLocated at: ((93, 24))"}, 1)
		elseif (menuOptionpoi == "Chapel") then
			player:dialogSeq({npcT, "Chapel\nLocated at: ((25, 43))"}, 1)
		elseif (menuOptionpoi == "Cook/Butcher") then
			player:dialogSeq({npcT, "Cook/Butcher\nLocated at: ((92, 44))"}, 1)
		elseif (menuOptionpoi == "Lanyu's Inn") then
			player:dialogSeq({npcT, "Lanyu's Inn\nLocated at: ((73, 54))"}, 1)
		elseif (menuOptionpoi == "Jail") then
			player:dialogSeq({npcT, "Jail\nLocated at: ((134, 106))"}, 1)
		elseif (menuOptionpoi == "Jeweler") then
			player:dialogSeq({npcT, "Jeweler\nLocated at: ((81, 85))"}, 1)
		elseif (menuOptionpoi == "Messenger") then
			player:dialogSeq({npcT, "Messenger\nLocated at: ((61, 54))"}, 1)
		elseif (menuOptionpoi == "Salon") then
			player:dialogSeq({npcT, "Salon\nLocated at: ((40, 84))"}, 1)
		elseif (menuOptionpoi == "Smith") then
			player:dialogSeq({npcT, "Smith\nLocated at: ((79, 68))"}, 1)
		elseif (menuOptionpoi == "Mining & Smelting") then
			player:dialogSeq({npcT, "Mining & Smelting\nLocated at: ((88, 69))"}, 1)
		elseif (menuOptionpoi == "Seamstress") then
			player:dialogSeq({npcT, "Seamstress\nLocated at: ((60, 74))"}, 1)
		elseif (menuOptionpoi == "Cloth Crafting & Gathering") then
			player:dialogSeq({npcT, "Cloth Crafting & Gathering\nLocated at: ((66, 78))"}, 1)
		elseif (menuOptionpoi == "Cancel") then
			player:dialogSeq({npcT, "Cloth Crafting & Gathering\nLocated at: ((66, 78))"}, 1)
		end
	elseif (menuOption == "Imperial Bounty") then
		imperialguard_bounty.click(player, npc)
	elseif (menuOption == "Imperial Standing") then
		player:dialogSeq({npcT, "Your current Imperial Standing is at: "..player.registry["imperial_standing"]}, 1)
	end

end)
}