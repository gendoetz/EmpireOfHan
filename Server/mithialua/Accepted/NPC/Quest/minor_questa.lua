minor_questa_old = {
click = function(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local monster = {}
	local grantExp = 0
	local grantGold = 5000
	local repQuestTimer = 21600 -- 11 hours

	if (player.level < 99) then
		grantExp = player.level * 5000
	elseif (player.level == 99) then
		grantExp = (player.maxHealth + (player.maxMagic * 2)) * 10
	end
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if (player.registry["minor_questaTimer"] > os.time()) then
		player:dialogSeq({t, "You will need to wait roughly "..(math.ceil((player.registry["minor_questaTimer"] - os.time())/10800)).." more day(s) before you can take on a quest."}, 1)
		return
	end

		if (player.registry["minorQuestTarget"] == 0 or player.registry["minorQuestTarget"] == 1) then
			local menuOption = player:menuString("You seem like a capable adventurer, would you be interested in a minor quest?", {"Yes", "No"})
				if (menuOption == "Yes") then

				-- WARNING do not use SpawnID 1-10 to insert into amobData, these ids will be used for quest completion storage

					local quest_mobs = {} -- Table for randomized quest mob, put common mob spawns to start if you would like
					local amobData = {}

					if (player.level >= 10) then
						amobData = {336, 372, 421, 420}-- Agate Fox, Lapis Lazuli Fox, Sapphire Ninetails, Spinel Ninetails

						for k,v in ipairs(amobData) do
							table.insert(quest_mobs, v)
						end 
					end
					if (player.level >= 20) then
						amobData = {551, 563, 562, 600} -- Obsidian Bat, Heat Bat, Lava Bat

						for k,v in ipairs(amobData) do
							table.insert(quest_mobs, v)
						end 
					end
					if (player.level >= 30) then
						amobData = {619, 694, 691, 738, 869, 858} -- Stone Dolls & Bees

						for k,v in ipairs(amobData) do
							table.insert(quest_mobs, v)
						end 
					end
					if (player.level >= 40) then
						amobData = {1154, 1376, 1321, 1037, 1146} -- Poring and Boars

						for k,v in ipairs(amobData) do
							table.insert(quest_mobs, v)
						end 
					end
					if (player.level >= 50) then
						amobData = {1723, 1785, 1799, 1797, 1794, 1804, 1809, 1632, 1456, 1458, 1437} -- Haunted and Kalbog

						for k,v in ipairs(amobData) do
							table.insert(quest_mobs, v)
						end 
					end
					if (player.level >= 60) then
						amobData = {1914, 1887, 200, 2099, 2260} -- Tigers and Snakes

						for k,v in ipairs(amobData) do
							table.insert(quest_mobs, v)
						end 
					end
					if (player.level >= 70) then
						amobData = {2329, 2379, 2451, 2566, 2567} -- Flowers and Volcano

						for k,v in ipairs(amobData) do
							table.insert(quest_mobs, v)
						end 
					end
					if (player.level >= 80) then
						amobData = {2613, 2579, 2818, 2800} -- Tower and Wall

						for k,v in ipairs(amobData) do
							table.insert(quest_mobs, v)
						end 
					end
					if (player.level >= 90) then
						amobData = {3020, 3043, 3020, 3043, 3134, 3313, 3318, 3191, 3515, 3547} -- Ogre and Pirates

						for k,v in ipairs(amobData) do
							table.insert(quest_mobs, v)
						end 
					end

					player.registry["minorQuestTarget"] = quest_mobs[math.random(#quest_mobs)]
					player.registry["minorQuestTarget_MobID"] = Mob(player.registry["minorQuestTarget"]).mobID
					player:addLegend("On a quest to slay the "..Mob(player.registry["minorQuestTarget"]).name..".", "minor_questa_slay", 5, 128)

					monster = {graphic = convertGraphic(Mob(player.registry["minorQuestTarget"]).look, "monster"), color = Mob(player.registry["minorQuestTarget"]).lookColor}

						player:dialogSeq({monster, "Excellent, you are charged with slaying the "..Mob(player.registry["minorQuestTarget"]).name..", return to me with their blood fresh on your weapon.",
						t, "Do not take too long, I do not have all day..."}, 1)
				else
					player:dialogSeq({t, "Fair enough, perhaps another time."}, 1)
				end
		elseif(player.registry["minorQuestTarget"] == 2) then
			player:dialogSeq({t, "Great job! Here's your reward:"}, 1)
				player:giveXP(grantExp)
				onCalcTNL(player)
				player:addGold(grantGold)
				player.registry["minor_questaTimer"] = os.time() + repQuestTimer
				player:removeLegendbyName("minor_questa_slay")
				player:removeLegendbyName("minor_questa_total")
				player.registry["minorQuestTarget"] = 1
				player.registry["minor_questa_compTotal"] = player.registry["minor_questa_compTotal"] + 1
				player:addLegend("Has completed "..player.registry["minor_questa_compTotal"].." minor quests. "..curT(), "minor_questa_total", 2, 128)
				player:msg(8, "[Minor Quest #"..player.registry["minor_questa_compTotal"].."] :: Complete\n\n  Experience: "..grantExp.."\n        Gold: "..grantGold.."\n\n", player.ID)

		else
				monster = {graphic = convertGraphic(Mob(player.registry["minorQuestTarget"]).look, "monster"), color = Mob(player.registry["minorQuestTarget"]).lookColor}
				player:dialogSeq({monster, "You are charged with slaying the "..Mob(player.registry["minorQuestTarget"]).name..", why haven't you done so yet?"}, 1)
				local menuOption2 = player:menuString("Would you like to abandon this quest? Should you abandon you must wait some time to start another.", {"Yes", "No"})
					if (menuOption2 == "Yes") then
						player.registry["minorQuestTarget"] = 1
						player.registry["minor_questaTimer"] = os.time() + (repQuestTimer / 2)
						player:removeLegendbyName("minor_questa_slay")
						player:dialogSeq({t, "It is done."}, 1)
					else
						player:dialogSeq({t, "Then what are you waiting for? Go on now..."}, 1)
					end
		end
end,
}