iguard_1 = {
click = async(function(player, npc)
	local npcT = {graphic = 0, color = 0}
	local menuOptions = {}
	local corruptdeer = {graphic = convertGraphic(89, "monster"), color = 15}
	
	player.npcGraphic = npcT.graphic
	player.npcColor = npcT.color
	player.dialogType = 1

	if (player.state == 1) then
		player.state = 0
		player.health = player.maxHealth
		player.magic = player.maxMagic
		player:updateState()
		player:sendStatus()
		npc:talk(0, "Imperial Guard: You are lucky I am a battle medic...")
		return
	end
	
	if (player.quest["path_choice_quest"] == 0) then
		player:dialogSeq({npcT, "Halt!  Why are you in these woods?  These woods have been deemed unsafe for townsfolk. *You hand the guard the imperial pass*",
		npcT, "A pass from Gihan?  You don't look like you are from around here, a peasant still by the looks of it.  I cannot allow you entry into Pinyan.",
		npcT, "Perhaps if you could prove yourself loyal to the empress, I could arrange passage for you.",
		corruptdeer, "A wicked witch has corrupted the woods surrounding Pinyan, her powers continue to grow.  She has cursed the wildlife twisting them into dark creatures to do her bidding.",
		npcT, "Prove yourself worthy by putting down these poor corrupted souls and prove your devotion by gaining insight ((Obtain level 5 and kill 10 wildlife)), and I will allow you to proceed."}, 1)
		player.quest["path_choice_quest"] = 1

	elseif (player.quest["path_choice_quest"] == 1) then
		if (player.registry["corruption_killcount"] >= 10 and player.level >= 5) then
			player:dialogSeq({npcT, "It looks like you have helped to fell enough of the corrupted beasts.  You are still young and lack direction.",
			npcT, "You may proceed into Pinyan, from here travel north to the Temple of the Guardians and speak with the priestess.  If you are to remain in these lands, you must devote yourself to a path."}, 1)
			player.quest["path_choice_quest"] = 2
		else
			player:dialogSeq({corruptdeer, "Prove yourself worthy!  The corruption will spread without your help..."}, 1)
		end
	elseif (player.quest["path_choice_quest"] == 2) then
			player:dialogSeq({npcT, "You are still young and lack direction.",
			npcT, "You may proceed into Pinyan, from here travel north to the Temple of the Guardians and speak with the priestess.  If you are to remain in these lands, you must devote yourself to a path."}, 1)
	elseif (player.quest["path_choice_quest"] >= 4) then
			player:dialogSeq({npcT, "You look stronger, continue your training!"}, 1)
	end
end)
}

path_guide = {
click = async(function(player, npc)
	local npcT = {graphic = convertGraphic(3, "monster"), color = 5}
	local npcW = {graphic = convertGraphic(74, "monster"), color = 8}
	local npcR = {graphic = convertGraphic(74, "monster"), color = 8}
	local npcM = {graphic = convertGraphic(74, "monster"), color = 8}
	local npcP = {graphic = convertGraphic(74, "monster"), color = 8}

	
	player.npcGraphic = npcT.graphic
	player.npcColor = npcT.color
	player.dialogType = 0

	if (player.state == 1) then
		player.state = 0
		player.health = player.maxHealth
		player.magic = player.maxMagic
		player:updateState()
		player:sendStatus()
		npc:talk(0, "Melah: Good as new.. maybe you should be more careful next time.")
		return
	end
	
	if (player.quest["path_choice_quest"] == 2) then
		player:dialogSeq({npcT, "Welcome to the Temple of the Guardians young one, my name is Melah.  Here is where you may choose your destiny.",
		npcT, "Our lands beyond the borders of the city can be harsh and unforgiving.  There are four paths you may choose from, and as you strengthen these paths further branch into subpaths.",
		npcT, "Each trainer can tell you a little about the path they follow and help you to choose.  Be warned, your choice is final.",
		npcT, "Trainers will provide you with starting spells and bestow upon you garments for their path, but they cannot teach you more advanced secrets.  For this you must travel to the path halls in the Imperial City.",
		npcT, "As for me, I will grant you a spell called Gateway.  It allows you to employ the magic of the winds to quickly move about the city.  Do not abuse this power.",
		npcT, "Now speak with the trainers, then talk to me once more when you have chosen."}, 1)
			if (player:canLearnSpell("gateway_new"))  then
				player:addSpell("gateway_new")
			end
		player.quest["path_choice_quest"] = 3
	elseif (player.quest["path_choice_quest"] == 3) then
		player:dialogSeq({npcT, "Now speak with the trainers, then talk to me once more when you have chosen."}, 1)
	elseif (player.quest["path_choice_quest"] == 4) then
		player:dialogSeq({npcT, "Ahh, a wise choice "..player.name..", I am sure this path will suit you well.  Your legend begins!",}, 1)
		player:dialogSeq({npcT, "Here, take these provisions.",}, 1)

		player:dialogSeq({npcT, "You will need to restore yourself with consumables until you grow in knowledge.  The inn keeper offers a variety of items that will help you on your journey.",
		npcT, "Pinyan is north of the Imperial City, you may venture into the city now if you wish but the villagers and people around Pinyan could use some help.  Talk with General Dahn just south of here.",
		npcT, "One more thing!  Should you die you may now have a spirit healer repair your silver thread, visit them in the main city. ((You may now use Silver Thread in the F1 Menu))"}, 1)
			player:addItem("pinyan_soju", 2)
			player:addItem("pinyan_soba", 2)
			player:removeLegendbyName("pathchoice")
			if (player.baseClass == 1) then
			player:addLegend("Devoted to the path of the Warrior. "..curT(), "pathchoice", 19, 16)
			elseif (player.baseClass == 2) then
			player:addLegend("Devoted to the path of the Rogue. "..curT(), "pathchoice", 23, 16)
			elseif (player.baseClass == 3) then
			player:addLegend("Devoted to the path of the Mage. "..curT(), "pathchoice", 27, 16)
			elseif (player.baseClass == 4) then
			player:addLegend("Devoted to the path of the Poet. "..curT(), "pathchoice", 31, 16)
			end
		player.quest["path_choice_quest"] = 5
	elseif (player.quest["path_choice_quest"] == 5) then
		player:dialogSeq({npcT, "General Dahn is south of the temple, he is training soldiers; talk with him and good luck young one!"}, 1)
	elseif (player.quest["path_choice_quest"] == 6) then
		player:dialogSeq({npcT, "Hello "..player.name..", have you come to visit me? *Smiles warmly*"}, 1)
	end
end),

give_supplies = function(player, npc)
	local npcT = {graphic = convertGraphic(3, "monster"), color = 5}
	player.npcGraphic = npcT.graphic
	player.npcColor = npcT.color
	player.dialogType = 0

	if (player.quest["path_choice_quest"] == 4) then
		player:dialogSeq({npcT, "Ahh, a wise choice "..player.name..", I am sure this path will suit you well.  Your legend begins!",
		npcT, "Here, take these provisions.",
		npcT, "You will need to restore yourself with consumables until you grow in knowledge.  The inn keeper offers a variety of items that will help you on your journey.",
		npcT, "Pinyan is north of the Imperial City, you may venture into the city now if you wish but the villagers and people around Pinyan could use some help.  Talk with General Dahn just south of here.",
		npcT, "One more thing!  Should you die you may now have a spirit healer repair your silver thread, visit them in the main city. ((You may now use Silver Thread in the F1 Menu))"}, 1)
			player:addItem("pinyan_soju", 2)
			player:addItem("pinyan_soba", 2)
			player:removeLegendbyName("pathchoice")
			if (player.baseClass == 1) then
			player:addLegend("Devoted to the path of the Warrior. "..curT(), "pathchoice", 19, 16)
			elseif (player.baseClass == 2) then
			player:addLegend("Devoted to the path of the Rogue. "..curT(), "pathchoice", 23, 16)
			elseif (player.baseClass == 3) then
			player:addLegend("Devoted to the path of the Mage. "..curT(), "pathchoice", 27, 16)
			elseif (player.baseClass == 4) then
			player:addLegend("Devoted to the path of the Poet. "..curT(), "pathchoice", 31, 16)
			end
		player.quest["path_choice_quest"] = 5
	elseif (player.quest["path_choice_quest"] == 5) then
		player:dialogSeq({npcT, "General Dahn is south of the temple, he is training soldiers; talk with him and good luck young one!"}, 1)
	elseif (player.quest["path_choice_quest"] == 6) then
		player:dialogSeq({npcT, "Hello "..player.name..", have you come to visit me? *Smiles warmly*"}, 1)
	end
end
}

imperial_general_1 = {
click = async(function(player, npc)
	local npcT = {graphic = convertGraphic(63, "monster"), color = 9}
	local menuOptions = {}
	
	player.npcGraphic = npcT.graphic
	player.npcColor = npcT.color
	player.dialogType = 0
	
	if (player.quest["path_choice_quest"] == 5) then
		player:dialogSeq({npcT, "*Grumbles* You look like a twig.  I could snap you in two with a flick of my finger!",
		npcT, "So you killed some corrupted wildlife?  You better believe those were the puny ones, the eastern woods have 'em slaying my best soldiers left and right.",
		npcT, "If you think you have what it takes, be my guest.. I ain't expectin' much outta you.",
		npcT, "That damn witch is hiding out east yonder in her hut, you'll be needin' to be crafty though.",
		npcT, "Travel down the road east here, past the village center.  The path will continue into the woods, her hut is just a ways north from there.",
		npcT, "Talk to some of the villagers they may have requests, most have feared entering the eastern woods since the witch has corrupted 'em.",
		npcT, "If you manage to deal with the witch, come see me--I wont be holdin' my breath though."}, 1)
		player.quest["path_choice_quest"] = 6

	elseif (player.quest["path_choice_quest"] >= 6) then
	local opts = {"The Witch", "Corruption of the Pinyan Woods"}
	local menuOption
	menuOption = player:menuString("What is it you want?", opts)
	if (menuOption == "The Witch") then
		if (player.quest["path_choice_quest"] == 6) then
		player:dialogSeq({npcT, "Have you taken care of the witch yet?"}, 1)
		elseif (player.quest["path_choice_quest"] == 7) then
			player:dialogSeq({npcT, "Well.. I'll be a monkey in a banana growin' place.. er whatever. I can't believe you actually pulled it off. Here, take this gold for your troubles."}, 1)
			--npcT, "I have another task for you now that you have proven your strength.",
						player:addGold(600)
						player:giveXP(7500)
						onCalcTNL(player)
						player:msg(8, "Rewards:\nGold: 600\nExp: 7500", player.ID)
						player.quest["path_choice_quest"] = 8
						player:addLegend("Culled the corruption of the Pinyan woods. "..curT(), "pinyan_witch", 130, 16)
		elseif (player.quest["path_choice_quest"] == 8) then
			player:dialogSeq({npcT, "The inn keeper in Han may need your assistance, she's always goin' on bout some spooks any time I pay a visit!"}, 1)
		end
	elseif (menuOption == "Corruption of the Pinyan Woods") then
	player:dialogSeq({npcT, "You have killed: "..player.registry["corruption_killcount"].." corrupted wildlife."}, 1)
	end
	end
end)
}