tutorial_gihan = {
click = async(function(player, npc)
	local npcT = {graphic = convertGraphic(81, "monster"), color = 4}
	local npcW = {graphic = convertGraphic(74, "monster"), color = 8}
	local armor = {graphic = convertGraphic(119, "item"), color = 0}
	local rabbit = {graphic = convertGraphic(21, "monster"), color = 35}
	local sword = {graphic = convertGraphic(2, "item"), color = 4}
	local flamebird = {graphic = convertGraphic(887, "monster"), color = 0}
	local droplet = {graphic = convertGraphic(854, "monster"), color = 130}
	local dropletking = {graphic = convertGraphic(854, "monster"), color = 126}
	local flamesword = {graphic = convertGraphic(2, "item"), color = 20}
	
	player.npcGraphic = npcT.graphic
	player.npcColor = npcT.color
	player.dialogType = 0


	if (player.state == 1) then
		player:dialogSeq({npcT, "You look a little... pale.. maybe you should talk to my wife inside."}, 1)
	end

	
	if (player.sex == 1) then
		local armor = {graphic = convertGraphic(179, "item"), color = 0}
	end
	
	if (player.quest["tutorial"] == 0) then
		player:dialogSeq({npcT, "Huh? Oh it's not very often we get strangers around these parts.",
		armor, "What happened to your clothes?",
		npcW, "Why don't you go inside and talk to my wife Rin, she'll give you some clothes, then come back out and see me when you are decent."}, 1)
		player.quest["tutorial"] = 1

	elseif (player.quest["tutorial"] == 1) then
		player:dialogSeq({npcW, "Go talk to Rin inside."}, 1)
	elseif (player.quest["tutorial"] == 2) then
			player:dialogSeq({npcT, "Those clothes fit you well.  My name is Gihan.",
			npcT, "What brings you to Northern Pinyan Shore?",
			npcT, "You don't remember much... I figured that would be the case.  It looks like you came in with some of the wreckage of a warship...",
			npcT, "...I won't push the matter, but the truth is we could use a little help.",
			sword, "Here, take this sword.  Lets get you trained a bit first.",
			rabbit, "Go hunt some rabbits and gather up some meat, about 5 should do it then go talk to Rin.  ((Spacebar will swing your weapon.  Press ',' to pick up items.))"}, 1)
			
			player.quest["tutorial"] = 3
			player:addItem("woodentut_sword", 1)
			
	elseif (player.quest["tutorial"] == 5) then
			player:dialogSeq({npcT, "I can see you are becoming stronger.  These lands are not always safe and you will need to hone your skills to survive.  I have a task if you are up to it.",
			npcT, "A while back the village to the south-east fell under attack to the fire spirits.  Flame-enchanted birds have started to make their way into the Pinyan wilderness from the ruins of the village.",
			npcT, "Your task is to help drive them back into the village and bring to me an essence of flame to prove your success!"}, 1)
			player.quest["tutorial"] = 6

	elseif (player.quest["tutorial"] == 6) then
		if (player:hasItem("flame_essence", 1) == true) then
			player:dialogSeq({npcT, "Great!  It looks like you succeeded in driving back the birds.  We will need that essense of flame to forge you a blade of fire.  The foes you are after cannot be damaged by normal means.",
			droplet, "The droplets reside in the cave to the north-east and have become an increasing nuissance.  Droplets are drawn to shiny things: gold, jewels, and precious metal--they are thieves in nature!",
			dropletking, "They are led by a king and his henchmen.  Any man who dare face them without the proper weapon will surely fall.",
			npcT, "Take this axe and travel to the grove located just south-west of here in a small nook in the forest.  There exists a rare tree called the Taowood tree, cut from it some wood and bring it back to me. 5 logs should work."}, 1)
			player:addItem("simple_axe", 1)

			player.quest["tutorial"] = 7
			player:removeItem("flame_essence", 1)
		else
			player:dialogSeq({npcT, "Please help drive the flame-enchanted birds back into the village to the south east."}, 1)
		end
	elseif (player.quest["tutorial"] == 7) then
		if (player:hasItem("taowood_log", 5) == true) then
			player:dialogSeq({npcT, "It looks like you found some very fine wood, give me a moment to carve your blade and then I will enchant it.",
			npcT, "*Gihan expertly crafts a blade from the wood and lights it aflame with the Essense of Fire.*",
			flamesword, "There.  Be careful this blade is no simple weapon--it has the power and fury of flame within scorching the wood at its core.  You are now prepared to take on the droplet king.",
			dropletking, "This is the last task I will ask of you.  Head north east into the cave and slay the droplet king.  Return to me when the task is complete, I will know when you have succeeded."}, 1)
			--local axe = player:getEquippedItem(EQ_WEAP)
			--if (axe ~= nil and axe.id == 10) then
			--	player.takeoffid = axe.id
			--	player:takeOff()
			--end
			player:removeItem("taowood_log", 5)
			--player:removeItem("simple_axe", 1)
			player:addItem("flame_tutsword", 1)
			player.quest["tutorial"] = 8
		else
			player:dialogSeq({npcT, "The Taowood trees are in the grove to the south-west."}, 1)
		end
	elseif (player.quest["tutorial"] == 8) then
		player:dialogSeq({dropletking, "You still have yet to slay the droplet king it appears."}, 1)
	elseif (player.quest["tutorial"] == 9) then
		if (player:hasItem("flame_tutsword", 1) == true) then
		player:removeItem("flame_tutsword", 1)
		player.quest["tutorial"] = 10
		player:dialogSeq({npcT, "Remarkable!  Finally Rin and I can rest peacefully knowing that our home is safe.  You have our thanks!",
		npcT, "As a traveler new to our lands you should journey south to the temple of the guardians.  When you arrive in the Village of Pinyan head north and speak with the priestess, here you may choose a path to follow.",
		npcT, "There has been an increased presence of imperial guards, so they will likely find you suspicious.  You should give them this. *Gihan hands you an imperial pass.*",
		npcT, "Take the clearing directly south of here. ((25, 32))  Good luck on your journey, and visit us again sometime!"}, 1)
		else
		player:dialogSeq({npcT, "You must take off the weapon your are holding and show me the blood of the creature fresh on the blade.  ((Remove your weapon with Shift T, and W and then talk again.))"}, 1)
		end
	elseif (player.quest["tutorial"] == 10) then
		player:dialogSeq({npcT, "As a traveler new to our lands you should journey south to the temple of the guardians.  When you arrive in the Village of Pinyan head north and speak with the priestess, here you may choose a path to follow.",
		npcT, "There has been an increased presence of imperial guards, so they will likely find you suspicious.  You should give them this. *Gihan hands you an imperial pass.*",
		npcT, "Take the clearing directly south of here. ((25, 32))  Good luck on your journey, and visit us again sometime!"}, 1)
	end
end)
}

tutorial_rin = {
click = async(function(player, npc)
	local npcT = {graphic = convertGraphic(81, "monster"), color = 4}
	local npcW = {graphic = convertGraphic(74, "monster"), color = 8}
	local armor = {graphic = convertGraphic(119, "item"), color = 0}
	local rabbit = {graphic = convertGraphic(21, "monster"), color = 35}
	
	player.npcGraphic = npcW.graphic
	player.npcColor = npcW.color
	player.dialogType = 0
	
	if (player.sex == 1) then
		local armor = {graphic = convertGraphic(179, "item"), color = 0}
	end

	if (player.state == 1) then
		player.state = 0
		player.health = player.maxHealth
		player.magic = player.maxMagic
		player:updateState()
		player:sendStatus()
		npc:talk(0, "Rin: Good as new.. maybe you should be more careful next time.")
		return
	end
	
	if (player.quest["tutorial"] == 1) then
		player:dialogSeq({npcW, "Well... You look a little worse for wear. Here, take these clothes, they are a little worn but they should do for now.",
		armor, "((Go to your inventory with the 'i' button and then press 'u' followed by whatever letter the clothes are in or double click on them with the mouse to put them on.))",
		npcT, "You should go talk more with Gihan, we've had a bit of trouble lately here and we could use a little help!"}, 1)
		player.quest["tutorial"] = 2
			if (player.sex == 0) then
				player:addItem("peasant_clothesM", 1)
			else
				player:addItem("peasant_clothesF", 1)
			end

	elseif (player.quest["tutorial"] == 3) then
		if (player:hasItem("rabbit_meat", 5) == true) then
			player:dialogSeq({npcW, "Great rabbit stew again... *sigh*",
			npcW, "Gihan may have you training in the art of combat but there is magic you can learn that will help serve you in your adventures.  I can teach you how to recover your own wounds.",
			npcW, "If you can gather 10 acorns and 5 more rabbit meat, I will bestow upon you this ability."}, 1)
			
			player:removeItem("rabbit_meat", 5)
			player.quest["tutorial"] = 4
		else
			player:dialogSeq({npcW, "I thought you were going to do some training?  You can find rabbits below the hill."}, 1)
		end
	elseif (player.quest["tutorial"] == 4) then
		if (player:hasItem("rabbit_meat", 5) == true) and (player:hasItem("acorn", 10) == true) then
			player:dialogSeq({npcW, "Perfect.  Now I will help fuse the essence of healing knowledge into your soul.",
			npcW, "*Rin grabs hold of your arm and head and chants something.",
			npcW, "Use this ability wisely, you may need it sooner than you think!",
			npcT, "Gihan was asking for you, maybe you can give him a hand again.  We have been having trouble with monsters in the area."}, 1)
			
			player:addSpell("soothe")	
			player:removeItem("rabbit_meat", 5)
			player:removeItem("acorn", 10)

			player.quest["tutorial"] = 5
		else
			player:dialogSeq({rabbit, "I'm still waiting for those rabbit meats and acorns."}, 1)
		end
	elseif (player.quest["tutorial"] == 5) then
		player:dialogSeq({npcT, "Go talk with Gihan, he said he needs your assistance."}, 1)
	end
end)
}