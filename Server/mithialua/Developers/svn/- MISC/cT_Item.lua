cT_Item = {
use = async(function(player)
	local itemA = {graphic = convertGraphic(4776, "item"), color = 0}
		player.npcGraphic = itemA.graphic
		player.npcColor = itemA.color
		player.dialogType = 0 -- 1 Player-Graphic NPC // 0 Disguise-Graphic NPC

	local mainOpts = {}
		table.insert(mainOpts, "- Summon Assistant")
		table.insert(mainOpts, "- Lock Character")
		table.insert(mainOpts, "- Force Apology")
		table.insert(mainOpts, "- Clear Floor")
		table.insert(mainOpts, " ")
		table.insert(mainOpts, "  Botting Check")
		table.insert(mainOpts, "  Adjust Players")
		table.insert(mainOpts, "  Spawn Mobs")

	local mainMenu = player:menuString3("What shall you do?", mainOpts)

		if (mainMenu == "- Summon Assistant") then
			local assistantMenu = player:menuString3("What shall you do?", {"  Summon", "  Dismiss"})
				if (assistantMenu == "  Summon") then
					NPC(113):warp(player.m, player.x, player.y)
					NPC(113):talk(0, "Assistant: You called, sire?")
					NPC(113).registry["follow"] = 1
				elseif (assistantMenu == "  Dismiss") then
					NPC(113):talk(0, "Assistant: I shall take my leave now, Master.")
					NPC(113).registry["follow"] = 0
					NPC(113):warp(NPC(113).startM, NPC(113).startX, NPC(113).startY)
				end
		elseif (mainMenu == "- Lock Character") then
			local lockMenu = player:menuString("What would you like to do?", {"Freeze", "Thaw"})			
				if (lockMenu == "Freeze") then
					local input1 = player:input("Who do you wish to freeze?")
						Player(input1):lock()
				elseif (lockMenu == "Thaw") then
					local input1 = player:input("Who do you wish to thaw?")
						Player(input1):unlock()
				end
		elseif (mainMenu == "- Force Apology") then
			local playerName = player:input("Who do you want to apologize?")
				Player(playerName):talk(0, ""..playerName..": I'm sorry "..player.name..", please forgive me.")
		elseif (mainMenu == "- Clear Floor") then
			local m = player.m
			local itemBlocks = player:getObjectsInMap(m, BL_ITEM)
				local itemReturns = {}
					for i = 1,#itemBlocks do
						table.insert(itemReturns, itemBlocks[i].id)
							itemBlocks[i]:delete()
					end		
		elseif (mainMenu == "  Botting Check") then
			local input1 = player:input("Check Who?")
			bot.check(Player(input1))
		elseif (mainMenu == "  Adjust Players") then
			local playerOpts = {}
				table.insert(playerOpts, "- Player Greetings")
				table.insert(playerOpts, "- Player Emote")
				table.insert(playerOpts, "  NPC")
				table.insert(playerOpts, "  Legend Marks")
				table.insert(playerOpts, "  Gathering")
				table.insert(playerOpts, "  Crafting")
				table.insert(playerOpts, "  Subpaths")
				table.insert(playerOpts, "  Stats")
				table.insert(playerOpts, " ")
				table.insert(playerOpts, "  Move Player")
				table.insert(playerOpts, "  Item Related")
			local playerMenu = player:menuString3("What with players?", playerOpts)
				if (playerMenu == "- Player Greetings") then
					local players = player:getObjectsInArea(BL_PC)
					for i = 1, #players do
						if (players[i].id ~= player.id) then	
							local people = players[i].class
							if (people == 14) then -- ARCHON
								Player(players[i].name):sendAnimation(10, 1)
								Player(players[i].name):sendAnimation(11, 1)
							elseif (people == 13) then -- BARD
								Player(players[i].name):sendAnimation(80,1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 12) then -- DRUID
								Player(players[i].name):sendAnimation(80,1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 11) then -- SEER
								Player(players[i].name):sendAnimation(81,1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 10) then -- ELEMENTALIST
								Player(players[i].name):sendAnimation(81,1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 9) then -- ARCHER
								Player(players[i].name):sendAnimation(82,1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 8) then -- SHADOW
								Player(players[i].name):sendAnimation(82,1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 7) then -- GLADIATOR
								Player(players[i].name):sendAnimation(83,1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 6) then -- KNIGHT
								Player(players[i].name):sendAnimation(83,1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 5) then -- DREAMWEAVER
								Player(players[i].name):sendAnimation(10, 1)
								Player(players[i].name):sendAnimation(11, 1)
							elseif (people == 4) then -- POET
								Player(players[i].name):sendAnimation(80, 1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 3) then -- MAGE
								Player(players[i].name):sendAnimation(81, 1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 2) then -- ROGUE
								Player(players[i].name):sendAnimation(82, 1)
								Player(players[i].name):sendAction(4,100)
							elseif (people == 1) then -- WARRIOR
							Player(players[i].name):sendAnimation(83, 1)
									Player(players[i].name):sendAction(4,100)
							elseif (people == 0) then -- NOVICE
								Player(players[i].name):sendAnimation(10, 1)
								Player(players[i].name):sendAnimation(11, 1)
							end
						end
					end
				elseif (playerMenu == "- Player Emote") then
					local input1 = player:input("Who in question?")
					local input2 = player:input("What Emote?")
						if (string.lower(input2) == "a") then
							Player(input1):sendAction(11,80)
						elseif (string.lower(input2) == "b") then
							Player(input1):sendAction(12,80)
						elseif (string.lower(input2) == "c") then
							Player(input1):sendAction(13,80)
						elseif (string.lower(input2) == "d") then
							Player(input1):sendAction(14,80)
						elseif (string.lower(input2) == "e") then
							Player(input1):sendAction(15,80)
						elseif (string.lower(input2) == "f") then
							Player(input1):sendAction(16,80)
						elseif (string.lower(input2) == "g") then
							Player(input1):sendAction(17,80)
						elseif (string.lower(input2) == "h") then	
							Player(input1):sendAction(18,80)
						elseif (string.lower(input2) == "i") then
							Player(input1):sendAction(19,80)
						elseif (string.lower(input2) == "j") then	
							Player(input1):sendAction(20,80)
						elseif (string.lower(input2) == "k") then
							Player(input1):sendAction(21,80)
						elseif (string.lower(input2) == "l") then
							Player(input1):sendAction(22,80)
						elseif (string.lower(input2) == "m") then
							Player(input1):sendAction(9,80)
						elseif (string.lower(input2) == "n") then
							Player(input1):sendAction(10,80)
						elseif (string.lower(input2) == "o") then
							Player(input1):sendAction(23,80)
						elseif (string.lower(input2) == "p") then
							Player(input1):sendAction(24,80)
						end
				elseif (playerMenu == "  Legend Marks") then
					local input1 = player:input("Reset Legend of:")
						for x=1, 230 do
							Player(input1):removeLegendbyColor(x)
							Player(input1):removeLegendbyColor(x)
							Player(input1):removeLegendbyColor(x)
						end
						Player(input1):msg(8, "Your Legend has been erased.", Player(input1).ID)
				elseif (playerMenu == "  NPC") then
					local menu1 = player:menuString3("Which NPC?", {"Single", "In Map"})
						if (menu1 == "Single") then
							local input1 = player:input("Reset NPC:")
								NPC(input1):warp(NPC(input1).startM, NPC(input1).startX, NPC(input1).startY)
								player:sendMinitext("Moved NPC#: "..NPC(input1).id..".")
						elseif (menu1 == "In Map") then
							local npcs = player:getObjectsInMap(player.m, BL_NPC)
								for i = 1, #npcs do
									local selects = npcs[i].id
									NPC(selects):warp(NPC(selects).startM, NPC(selects).startX, NPC(selects).startY)
									player:sendMinitext("Moved NPC#: "..NPC(selects).id..".")
								end
						end
				elseif (playerMenu == "  Gathering") then
					local gatherOpts = {}
						table.insert(gatherOpts, "Set: Gathering Bag(s)")
						table.insert(gatherOpts, "Set: Gathering Skills")
						table.insert(gatherOpts, " ")
						table.insert(gatherOpts, "Check: Gathering Bag(s)")
						table.insert(gatherOpts, "Check: Gathering Skills")
						table.insert(gatherOpts, " ")
						table.insert(gatherOpts, "Reset: Gathering Bag(s)")
						table.insert(gatherOpts, "Reset: Gathering Skills")
					local gatherMenu = player:menuString3("What about Gathering?", gatherOpts)
						if (gatherMenu == "Set: Gathering Bag(s)") then
							local input1 = player:input("Set Gathering Bag of:")
							local input2 = player:input("Set to what?")
							local menu1 = player:menuString3("Which gathering bag?", {"Miner", "Shearer", "Forester"})
								if (menu1 == "Miner") then
									player.quest["gatherQuest_miner"] = input2
									player:sendMinitext("Set Miner Chest to "..input2.."")
								elseif (menu1 == "Shearer") then
									player.quest["gatherQuest_shearer"] = input2
									player:sendMinitext("Set Shearer to "..input2.."")
								elseif (menu1 == "Forester") then
									player.quest["gatherQuest_forester"] = input2
									player:sendMinitext("Set Forester to "..input2.."")
								end
						elseif (gatherMenu == "Set: Gathering Skills") then
							local input1 = player:input("Set Gathering skills of:")
							local input2 = player:input("Set to what?")
							local menu1 = player:menuString3("Which gathering skill?", {"Miner", "Shearer", "Forester"})
								if (menu1 == "Miner") then
									player.registry["miner"] = input2
									player:sendMinitext("Set Miner Skill to "..input2.."")
								elseif (menu1 == "Shearer") then
									player.registry["shearer"] = input2
									player:sendMinitext("Set Miner Skill to "..input2.."")
								elseif (menu1 == "Forester") then
									player.registry["forester"] = input2
									player:sendMinitext("Set Miner Skill to "..input2.."")
								end
						elseif (gatherMenu == "Check: Gathering Bag(s)") then
							local input1 = player:input("Check Gathering Bag of:")
							local menu1 = player:menuString3("Which gathering bag?", {"Miner", "Shearer", "Forester", "- All"})
								if (menu1 == "Miner") then
									player:msg(8, "Miner Quest: "..tonumber(Player(input1).quest["gatherQuest_miner"]).."", player.ID)
								elseif (menu1 == "Shearer") then
									player:msg(8, "Shearer Quest: "..tonumber(Player(input1).quest["gatherQuest_shearer"]).."", player.ID)
								elseif (menu1 == "Forester") then
									player:msg(8, "Forester Quest: "..tonumber(Player(input1).quest["gatherQuest_forester"]).."", player.ID)
								elseif (menu1 == "- All") then
									player:msg(8, "Miner Quest: "..tonumber(Player(input1).quest["gatherQuest_miner"]).."\nShearer Quest: "..tonumber(Player(input1).quest["gatherQuest_shearer"]).."\nForester Quest: "..tonumber(Player(input1).quest["gatherQuest_forester"]).."", player.ID)
								end
						elseif (gatherMenu == "Check: Gathering Skills") then
							local input1 = player:input("Check Gathering skills of:")
							local menu1 = player:menuString3("Which skill?", {"Miner", "Shearer", "Forester", "- All"})
								if (menu1 == "Miner") then
									player:msg(8, "Miner Skill: "..tonumber(Player(input1).registry["miner"]).."", player.ID)
								elseif (menu1 == "Shearer") then
									player:msg(8, "Shearer Skill: "..tonumber(Player(input1).registry["shearer"]).."", player.ID)
								elseif (menu1 == "Forester") then
									player:msg(8, "Forester Skill: "..tonumber(Player(input1).registry["miner"]).."", player.ID)
								elseif (menu1 == "- All") then
									player:msg(8, "Miner Skill: "..tonumber(Player(input1).registry["miner"]).."\nShearer Skill: "..tonumber(Player(input1).registry["shearer"]).."\nForester Skill: "..tonumber(Player(input1).registry["miner"]).."", player.ID)
								end
						elseif (gatherMenu == "Reset: Gathering Bag(s)") then
							local input1 = player:input("Gathering Bag of:")
							local menu1 = player:menuString3("Which gathering bag?", {"Miner", "Shearer", "Forester", "- All"})
								if (menu1 == "Miner") then
									Player(input1).quest["gatherQuest_miner"] = 0
									Player(input1).registry["gQuest_mTimer"] = 0
									Player(input1):msg(8, "Your Ore Chest quests have been reset.", Player(input1).ID)
								elseif (menu1 == "Shearer") then
									Player(input1).quest["gatherQuest_shearer"] = 0
									Player(input1).registry["gQuest_sTimer"] = 0
									Player(input1):msg(8, "Your Fibre Bag quests have been reset.", Player(input1).ID)
								elseif (menu1 == "Forester") then
									Player(input1).quest["gatherQuest_forester"] = 0
									Player(input1).registry["gQuest_fTimer"] = 0
									Player(input1):msg(8, "Your Branch Crate quests have been reset.", Player(input1).ID)
								elseif (menu1 == "- All") then
									Player(input1).quest["gatherQuest_miner"] = 0
									Player(input1).registry["gQuest_mTimer"] = 0
									Player(input1).quest["gatherQuest_shearer"] = 0
									Player(input1).registry["gQuest_sTimer"] = 0
									Player(input1).quest["gatherQuest_forester"] = 0
									Player(input1).registry["gQuest_fTimer"] = 0
									Player(input1):msg(8, "Your Ore Chest, Fibre Bag, and Branch Crate quests have been reset.", Player(input1).ID)
								end
						elseif (gatherMenu == "Reset: Gathering Skills") then
							local input1 = player:input("Reset Gathering skills of:")
							local menu1 = player:menuString3("Which skill?", {"Miner", "Shearer", "Forester", "- All"})
								if (menu1 == "Miner") then
									Player(input1):removeLegendbyName("forester")
									Player(input1).registry["forester"] = 0
									Player(input1):msg(8, "Your Miner skills have been erased.", Player(input1).ID)
								elseif (menu1 == "Shearer") then
									Player(input1):removeLegendbyName("miner")
									Player(input1).registry["miner"] = 0
									Player(input1):msg(8, "Your Shearer skills have been erased.", Player(input1).ID)
								elseif (menu1 == "Forester") then
									Player(input1):removeLegendbyName("shearer")
									Player(input1).registry["shearer"] = 0
									Player(input1):msg(8, "Your Forester skills have been erased.", Player(input1).ID)
								elseif (menu1 == "- All") then
									Player(input1):removeLegendbyName("forester")
									Player(input1).registry["forester"] = 0
									Player(input1):removeLegendbyName("miner")
									Player(input1).registry["miner"] = 0
									Player(input1):removeLegendbyName("shearer")
									Player(input1).registry["shearer"] = 0
									Player(input1):msg(8, "Your Gathering skills have been erased.", Player(input1).ID)
								end			
						end
				elseif (playerMenu == "  Crafting") then
					local craftOpts = {}
						table.insert(craftOpts, "Set: Crafting Skill")
						table.insert(craftOpts, " ")
						table.insert(craftOpts, "Check: Crafting Skill")
						table.insert(craftOpts, " ")
						table.insert(craftOpts, "Reset: Crafting Skill")
					local craftMenu = player:menuString3("What about Crafting?", craftOpts)
						if (craftMenu == "Set: Crafting Skill") then
							local input1 = player:input("Set Crafting Skill of:")
							local menu1 = player:menuString3("Which Crafting skill?", {"Smith", "Tailor", "Carpentry"})
								if (menu1 == "Smith") then
									local craftingOpts = {}
										table.insert(craftingOpts, "Aptitude I")
										table.insert(craftingOpts, "Aptitude II")
										table.insert(craftingOpts, "Aptitude III")
										table.insert(craftingOpts, "Aptitude IV")
										table.insert(craftingOpts, "Aptitude V")
										table.insert(craftingOpts, "Aptitude VI")
										table.insert(craftingOpts, "Aptitude VII")
										table.insert(craftingOpts, "Aptitude VIII")
										table.insert(craftingOpts, "Aptitude IX")
										table.insert(craftingOpts, "Aptitude X")
										table.insert(craftingOpts, "Aptitude XI")
										table.insert(craftingOpts, "Master")
									local craftMenu2 = player:menuString("What level would you like to set?", craftingOpts)
										if (craftMenu2 == "Aptitude I") then
											player.registry["smithing_skill"] = 5
										elseif (craftMenu2 == "Aptitude II") then	
											player.registry["smithing_skill"] = 50
										elseif (craftMenu2 == "Aptitude III") then	
											player.registry["smithing_skill"] = 500
										elseif (craftMenu2 == "Aptitude IV") then	
											player.registry["smithing_skill"] = 1500
										elseif (craftMenu2 == "Aptitude V") then	
											player.registry["smithing_skill"] = 5000
										elseif (craftMenu2 == "Aptitude VI") then	
											player.registry["smithing_skill"] = 12500
										elseif (craftMenu2 == "Aptitude VII") then	
											player.registry["smithing_skill"] = 25000
										elseif (craftMenu2 == "Aptitude VIII") then	
											player.registry["smithing_skill"] = 100000
										elseif (craftMenu2 == "Aptitude IX") then	
											player.registry["smithing_skill"] = 200000
										elseif (craftMenu2 == "Aptitude X") then	
											player.registry["smithing_skill"] = 300000
										elseif (craftMenu2 == "Aptitude XI") then	
											player.registry["smithing_skill"] = 500000
										elseif (craftMenu2 == "Master") then
											player.registry["smithing_skill"] = 681000
										end
								elseif (menu1 == "Tailor") then
									local craftingOpts = {}
										table.insert(craftingOpts, "Aptitude I")
										table.insert(craftingOpts, "Aptitude II")
										table.insert(craftingOpts, "Aptitude III")
										table.insert(craftingOpts, "Aptitude IV")
										table.insert(craftingOpts, "Aptitude V")
										table.insert(craftingOpts, "Aptitude VI")
										table.insert(craftingOpts, "Aptitude VII")
										table.insert(craftingOpts, "Aptitude VIII")
										table.insert(craftingOpts, "Aptitude IX")
										table.insert(craftingOpts, "Aptitude X")
										table.insert(craftingOpts, "Aptitude XI")
										table.insert(craftingOpts, "Master")

									local craftMenu2 = player:menuString("What level would you like to set?", craftingOpts)
										if (craftMenu2 == "Aptitude I") then
											player.registry["tailoring_skill"] = 5
										elseif (craftMenu2 == "Aptitude II") then	
											player.registry["tailoring_skill"] = 50
										elseif (craftMenu2 == "Aptitude III") then	
											player.registry["tailoring_skill"] = 500
										elseif (craftMenu2 == "Aptitude IV") then	
											player.registry["tailoring_skill"] = 1500
										elseif (craftMenu2 == "Aptitude V") then	
											player.registry["tailoring_skill"] = 5000
										elseif (craftMenu2 == "Aptitude VI") then	
											player.registry["tailoring_skill"] = 12500
										elseif (craftMenu2 == "Aptitude VII") then	
											player.registry["tailoring_skill"] = 25000
										elseif (craftMenu2 == "Aptitude VIII") then	
											player.registry["tailoring_skill"] = 100000
										elseif (craftMenu2 == "Aptitude IX") then	
											player.registry["tailoring_skill"] = 200000
										elseif (craftMenu2 == "Aptitude X") then	
											player.registry["tailoring_skill"] = 300000
										elseif (craftMenu2 == "Aptitude XI") then	
											player.registry["tailoring_skill"] = 500000
										elseif (craftMenu2 == "Master") then
											player.registry["tailoring_skill"] = 681000
										end
								elseif (menu1 == "Carpentry") then
									local craftingOpts = {}
										table.insert(craftingOpts, "Aptitude I")
										table.insert(craftingOpts, "Aptitude II")
										table.insert(craftingOpts, "Aptitude III")
										table.insert(craftingOpts, "Aptitude IV")
										table.insert(craftingOpts, "Aptitude V")
										table.insert(craftingOpts, "Aptitude VI")
										table.insert(craftingOpts, "Aptitude VII")
										table.insert(craftingOpts, "Aptitude VIII")
										table.insert(craftingOpts, "Aptitude IX")
										table.insert(craftingOpts, "Aptitude X")
										table.insert(craftingOpts, "Aptitude XI")
										table.insert(craftingOpts, "Master")

									local craftMenu2 = player:menuString("What level would you like to set?", craftingOpts)
										if (craftMenu2 == "Aptitude I") then
											player.registry["carpentry_skill"] = 5
										elseif (craftMenu2 == "Aptitude II") then	
											player.registry["carpentry_skill"] = 50
										elseif (craftMenu2 == "Aptitude III") then	
											player.registry["carpentry_skill"] = 500
										elseif (craftMenu2 == "Aptitude IV") then	
											player.registry["carpentry_skill"] = 1500
										elseif (craftMenu2 == "Aptitude V") then	
											player.registry["carpentry_skill"] = 5000
										elseif (craftMenu2 == "Aptitude VI") then	
											player.registry["carpentry_skill"] = 12500
										elseif (craftMenu2 == "Aptitude VII") then	
											player.registry["carpentry_skill"] = 25000
										elseif (craftMenu2 == "Aptitude VIII") then	
											player.registry["carpentry_skill"] = 100000
										elseif (craftMenu2 == "Aptitude IX") then	
											player.registry["carpentry_skill"] = 200000
										elseif (craftMenu2 == "Aptitude X") then	
											player.registry["carpentry_skill"] = 300000
										elseif (craftMenu2 == "Aptitude XI") then	
											player.registry["carpentry_skill"] = 500000
										elseif (craftMenu2 == "Master") then
											player.registry["carpentry_skill"] = 681000
										end						
								end
						elseif (craftMenu == "Check: Crafting Skill") then
							local input1 = player:input("Check Crafting Skill:")
							local pSmithB = Player(input1).registry["smithing_skill"]
							local pTailorB = Player(input1).registry["tailoring_skill"]
							local pCarpenterB = Player(input1).registry["carpentry_skill"]
								if (pSmithB == 0) then			
									percentSmith = "N/A"
								elseif (pSmithB >= 1 and pSmithB < 25) then
									mathSmith = math.floor(((pSmithB-1)/(25-1))*100)
									percentSmith = "Apt 1: "..mathSmith.."%"
								elseif (pSmithB >= 25 and pSmithB < 220) then
									mathSmith = math.floor(((pSmithB-25)/(220-25))*100)
									percentSmith = "Apt 2: "..mathSmith.."%"
								elseif (pSmithB >= 220 and pSmithB < 840) then
									mathSmith = math.floor(((pSmithB-220)/(840-220))*100)
									percentSmith = "Apt 3: "..mathSmith.."%"
								elseif (pSmithB >= 840 and pSmithB < 2200) then
									mathSmith = math.floor(((pSmithB-840)/(2200-840))*100)
									percentSmith = "Apt 4: "..mathSmith.."%"
								elseif (pSmithB >= 2200 and pSmithB < 6400) then
									mathSmith = math.floor(((pSmithB-2200)/(6400-2200))*100)
									percentSmith = "Apt 5: "..mathSmith.."%"
								elseif (pSmithB >= 6400 and pSmithB < 18000) then
									mathSmith = math.floor(((pSmithB-6400)/(18000-6400))*100)
									percentSmith = "Apt 6: "..mathSmith.."%"
								elseif (pSmithB >= 18000 and pSmithB < 50000) then
									mathSmith = math.floor(((pSmithB-18000)/(50000-18000))*100)
									percentSmith = "Apt 7: "..mathSmith.."%"
								elseif (pSmithB >= 50000 and pSmithB < 124000) then
									mathSmith = math.floor(((pSmithB-50000)/(124000-50000))*100)
									percentSmith = "Apt 8: "..mathSmith.."%"
								elseif (pSmithB >= 124000 and pSmithB < 237000) then
									mathSmith = math.floor(((pSmithB-124000)/(237000-124000))*100)
									percentSmith = "Apt 9: "..mathSmith.."%"
								elseif (pSmithB >= 237000 and pSmithB < 400000) then
									mathSmith = math.floor(((pSmithB-237000)/(400000-237000))*100)
									percentSmith = "Apt 10: "..mathSmith.."%"
								elseif (pSmithB >= 400000 and pSmithB < 680000) then
									mathSmith = math.floor(((pSmithB-400000)/(680000-400000))*100)
									percentSmith = "Apt 11: "..mathSmith.."%"
								elseif (pSmithB >= 680000) then
									percentSmith = "Master"
								end
								if (pTailorB == 0) then			
									percentTailor = "N/A"
								elseif (pTailorB >= 1 and pTailorB < 25) then
									mathTailor = math.floor(((pTailorB-1)/(25-1))*100)
									percentTailor = "Apt 1: "..mathTailor.."%"
								elseif (pTailorB >= 25 and pTailorB < 220) then
									mathTailor = math.floor(((pTailorB-25)/(220-25))*100)
									percentTailor = "Apt 2: "..mathTailor.."%"
								elseif (pTailorB >= 220 and pTailorB < 840) then
									mathTailor = math.floor(((pTailorB-220)/(840-220))*100)
									percentTailor = "Apt 3: "..mathTailor.."%"
								elseif (pTailorB >= 840 and pTailorB < 2200) then
									mathTailor = math.floor(((pTailorB-840)/(2200-840))*100)
									percentTailor = "Apt 4: "..mathTailor.."%"
								elseif (pTailorB >= 2200 and pTailorB < 6400) then
									mathTailor = math.floor(((pTailorB-2200)/(6400-2200))*100)
									percentTailor = "Apt 5: "..mathTailor.."%"
								elseif (pTailorB >= 6400 and pTailorB < 18000) then
									mathTailor = math.floor(((pTailorB-6400)/(18000-6400))*100)
									percentTailor = "Apt 6: "..mathTailor.."%"
								elseif (pTailorB >= 18000 and pTailorB < 50000) then
									mathTailor = math.floor(((pTailorB-18000)/(50000-18000))*100)
									percentTailor = "Apt 7: "..mathTailor.."%"
								elseif (pTailorB >= 50000 and pTailorB < 124000) then
									mathTailor = math.floor(((pTailorB-50000)/(124000-50000))*100)
									percentTailor = "Apt 8: "..mathTailor.."%"
								elseif (pTailorB >= 124000 and pTailorB < 237000) then
									mathTailor = math.floor(((pTailorB-124000)/(237000-124000))*100)
									percentTailor = "Apt 9: "..mathTailor.."%"
								elseif (pTailorB >= 237000 and pTailorB < 400000) then
									mathTailor = math.floor(((pTailorB-237000)/(400000-237000))*100)
									percentTailor = "Apt 10: "..mathTailor.."%"
								elseif (pTailorB >= 400000 and pTailorB < 680000) then
									mathTailor = math.floor(((pTailorB-400000)/(680000-400000))*100)
									percentTailor = "Apt 11: "..mathTailor.."%"
								elseif (pTailorB >= 680000) then
									percentTailor = "Master"
								end
								if (pCarpenterB == 0) then			
									percentCarpenter = "N/A"
								elseif (pCarpenterB >= 1 and pCarpenterB < 25) then
									mathCarpenter = math.floor(((pCarpenterB-1)/(25-1))*100)
									percentCarpenter = "Apt 1: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 25 and pCarpenterB < 220) then
									mathCarpenter = math.floor(((pCarpenterB-25)/(220-25))*100)
									percentCarpenter = "Apt 2: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 220 and pCarpenterB < 840) then
									mathCarpenter = math.floor(((pCarpenterB-220)/(840-220))*100)
									percentCarpenter = "Apt 3: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 840 and pCarpenterB < 2200) then
									mathCarpenter = math.floor(((pCarpenterB-840)/(2200-840))*100)
									percentCarpenter = "Apt 4: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 2200 and pCarpenterB < 6400) then
									mathCarpenter = math.floor(((pCarpenterB-2200)/(6400-2200))*100)
									percentCarpenter = "Apt 5: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 6400 and pCarpenterB < 18000) then
									mathCarpenter = math.floor(((pCarpenterB-6400)/(18000-6400))*100)
									percentCarpenter = "Apt 6: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 18000 and pCarpenterB < 50000) then
									mathCarpenter = math.floor(((pCarpenterB-18000)/(50000-18000))*100)
									percentCarpenter = "Apt 7: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 50000 and pCarpenterB < 124000) then
									mathCarpenter = math.floor(((pCarpenterB-50000)/(124000-50000))*100)
									percentCarpenter = "Apt 8: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 124000 and pCarpenterB < 237000) then
									mathCarpenter = math.floor(((pCarpenterB-124000)/(237000-124000))*100)
									percentCarpenter = "Apt 9: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 237000 and pCarpenterB < 400000) then
									mathCarpenter = math.floor(((pCarpenterB-237000)/(400000-237000))*100)
									percentCarpenter = "Apt 10: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 400000 and pCarpenterB < 680000) then
									mathCarpenter = math.floor(((pCarpenterB-400000)/(680000-400000))*100)
									percentCarpenter = "Apt 11: "..mathCarpenter.."%"
								elseif (pCarpenterB >= 680000) then
									percentCarpenter = "You're already a Master."
								end
								player:msg(8, "  Smithing --- "..percentSmith.."\n  Tailoring -- "..percentTailor.."\n  Carpentry -- "..percentCarpenter.."\n\n  Smithing --- "..pSmithB.."\n  Tailoring -- "..pTailorB.."\n  Carpentry -- "..pCarpenterB.."", player.ID)
						elseif (craftMenu == "Reset: Crafting Skill") then
							local input1 = player:input("Crafting Skill of:")
							local menu1 = player:menuString3("Which Crafting bag?", {"Smith", "Tailor", "Carpentry", "- All"})
								if (menu1 == "Smith") then
									Player(input1).registry["smithing_skill"] = 0
									Player(input1):msg(8, "Your Smithing skill has been reset.", Player(input1).ID)
									player:msg(8, "You have reset "..Player(input1).name.."'s Smithing skill.", player.ID)
								elseif (menu1 == "Tailor") then
									Player(input1).registry["tailoring_skill"] = 0
									Player(input1):msg(8, "Your Smithing skill has been reset.", Player(input1).ID)
									player:msg(8, "You have reset "..Player(input1).name.."'s Smithing skill.", player.ID)
								elseif (menu1 == "Carpentry") then
									Player(input1).registry["carpentry_skill"] = 0
									Player(input1):msg(8, "Your Smithing skill has been reset.", Player(input1).ID)
									player:msg(8, "You have reset "..Player(input1).name.."'s Smithing skill.", player.ID)
								elseif (menu1 == "- All") then
									Player(input1).registry["smithing_skill"] = 0
									Player(input1).registry["tailoring_skill"] = 0
									Player(input1).registry["carpentry_skill"] = 0
									Player(input1):msg(8, "Your Smithing skill has been reset.", Player(input1).ID)
									player:msg(8, "You have reset "..Player(input1).name.."'s Smithing, Tailoring, and Carpentry skills.", player.ID)
								end
						end
				elseif (playerMenu == "  Subpaths") then
					local subpathOpts = {}
						table.insert(subpathOpts, "  Representitive Quest")
					local subpathMenu = player:menuString3("What shall you do?", subpathOpts)
						if (subpathMenu == "  Representitive Quest") then
							local menu1 = player:menuString("Which main class?", {"Warrior", "Rogue", "Mage", "Poet"})
								if (menu1 == "Warrior") then
									local input1 = player:input("Check Warrior Quest of:")
									local menu2 = player:menuString("Do you want to Check or Reset them?", {"Check", "Reset"})
										if (menu2 == "Check") then
											player:msg(8, "warrior_pickSubpath Q = "..player.quest["warrior_pickSubpath"].."\n\nrQ_Knight Q: "..player.quest["rQ_Knight"].."\nrQ_KnightEscort Q: "..player.quest["rQ_KnightEscort"].."\n\nrQ_Gladiator Q: "..player.quest["rQ_Gladiator"].."", player.ID)
										elseif (menu2 == "Reset") then
											local menu3 = player:menuString("Are you positive you want to reset "..Player(input1).name.."'s quests?", {"Yes", "No"})
												if (menu3 == "Yes") then
													Player(input1).quest["warrior_pickSubpath"] = 0
													Player(input1).quest["rQ_Knight"] = 0
													Player(input1).quest["rQ_KnightEscort"] = 0
													Player(input1).quest["rQ_Gladiator"] = 0
													Player(input1):removeLegendbyName("repSubQ_Knight")
													Player(input1):removeLegendbyName("repSubQ_Gladiator")
													Player(input1):msg(8, "Your Warrior Subpath Reputation quests have been reset. Please revisit your Guildmaster to begin again.", player.ID)
													player:msg(8, ""..Player(input1).name.."'s quests have been reset", player.ID)
												elseif (menu3 == "No") then
													player:dialogSeq({npcA, "Very well, then."}, 0)
												end
										end
								elseif (menu1 == "Rogue") then
									local input1 = player:input("Check Rogue Quest of:")
									local menu2 = player:menuString("Do you want to Check or Reset them?", {"Check", "Reset"})
										if (menu2 == "Check") then
											player:msg(8, "rogue_pickSubpath Q = "..player.quest["rogue_pickSubpath"].."\n\nrQ_Shadow Q: "..player.quest["rQ_Shadow"].."\n\nrQ_Archer Q: "..player.quest["rQ_Archer"].."\nrQ_ArcherFawn Q: "..player.quest["rQ_ArcherFawn"].."", player.ID)
										elseif (menu2 == "Reset") then
											local menu3 = player:menuString("Are you positive you want to reset "..input1.."'s quests?", {"Yes", "No"})
												if (menu3 == "Yes") then
													Player(input1).quest["rogue_pickSubpath"] = 0
													Player(input1).quest["rQ_Shadow"] = 0
													Player(input1).quest["rQ_Archer"] = 0
													Player(input1).quest["rQ_ArcherFawn"] = 0
													Player(input1):removeLegendbyName("repSubQ_Archer")
													Player(input1):removeLegendbyName("repSubQ_Shadow")
													Player(input1):msg(8, "Your Rogue Subpath Reputation quests have been reset. Please revisit your Guildmaster to begin again.", player.ID)
													player:msg(8, ""..Player(input1).name.."'s quests have been reset", player.ID)
												elseif (menu3 == "No") then
													player:dialogSeq({npcA, "Very well, then."}, 0)
												end
										end
								elseif (menu1 == "Mage") then
									local input1 = player:input("Check Mage Quest of:")
									local menu2 = player:menuString("Do you want to Check or Reset them?", {"Check", "Reset"})
										if (menu2 == "Check") then
											player:msg(8, "mage_pickSubpath Q:"..player.quest["mage_pickSubpath"].."\n\nrQ_Elementalist Q: "..player.quest["rQ_Elementalist"].."\nrQ_Elementalist R:" ..player.registry["rQ_Elementalist"].."\nrQ_elementalistT1 R:"..player.registry["rQ_elementalistT1"].."\nrQ_elementalistT2 R:"..player.registry["rQ_elementalistT2"].."\nrQ_elementalistT3 R:"..player.registry["rQ_elementalistT3"].."\nrQ_elementalistT4 R:"..player.registry["rQ_elementalistT3"].."\n\nrQ_Seer Q: "..player.quest["rQ_Seer"].."\nrQ_Seer R: "..player.registry["rQ_Seer"].."\nrQ_seerT1 R:"..player.registry["rQ_seerT1"].."\nrQ_seerT2 R:"..player.registry["rQ_seerT2"].."\nrQ_seerT3 R:"..player.registry["rQ_seerT3"].."", player.ID)
										elseif (menu2 == "Reset") then
											local menu3 = player:menuString("Are you positive you want to reset "..input1.."'s quests?", {"Yes", "No"})
												if (menu3 == "Yes") then
													Player(input1).quest["mage_pickSubpath"] = 0
													Player(input1).quest["rQ_Elementalist"] = 0
													Player(input1).registry["rQ_Elementalist"] = 0
													Player(input1).registry["rQ_elementalistT1"] = 0
													Player(input1).registry["rQ_elementalistT2"] = 0
													Player(input1).registry["rQ_elementalistT3"] = 0
													Player(input1).registry["rQ_elementalistT4"] = 0
													Player(input1).quest["rQ_Seer"] = 0
													Player(input1).registry["rQ_Seer"] = 0
													Player(input1).registry["rQ_seerT1"] = 0
													Player(input1).registry["rQ_seerT2"] = 0
													Player(input1).registry["rQ_seerT3"] = 0
													Player(input1):removeLegendbyName("repSubQ_Elementalist")
													Player(input1):removeLegendbyName("repSubQ_Seer")
													Player(input1):msg(8, "Your Mage Subpath Reputation quests have been reset. Please revisit your Guildmaster to begin again.", player.ID)
													player:msg(8, ""..Player(input1).name.."'s quests have been reset", player.ID)
												elseif (menu3 == "No") then
													player:dialogSeq({npcA, "Very well, then."}, 0)
												end
										end
								elseif (menu1 == "Poet") then
									local input1 = player:input("Check Poet Quest of:")
									local menu2 = player:menuString("Do you want to Check or Reset them?", {"Check", "Reset"})
										if (menu2 == "Check") then
											player:msg(8, "poet_pickSubpath Q:"..player.quest["poet_pickSubpath"].."\n\nrQ_Druid Q: "..player.quest["rQ_Druid"].."\nrQ_Druid R:" ..player.registry["rQ_Druid"].."\nrQ_Bard Q: "..player.quest["rQ_Bard"].."\nrQ_Bard R: "..player.registry["rQ_Bard"].."\nrQBardnpc1 R:"..player.registry["rQBardnpc1"].."\nrQBardnpc2 R:"..player.registry["rQBardnpc2"].."\nrQBardnpc3 R:"..player.registry["rQBardnpc3"].."\nrQBardnpc4 R:"..player.registry["rQBardnpc4"].."", player.ID)
										elseif (menu2 == "Reset") then
											local menu3 = player:menuString("Are you positive you want to reset "..input1.."'s quests?", {"Yes", "No"})
												if (menu3 == "Yes") then
													Player(input1).quest["poet_pickSubpath"] = 0
													Player(input1).quest["rQ_Druid"] = 0
													Player(input1).registry["rQ_Druid"] = 0
													Player(input1).quest["rQ_Bard"] = 0
													Player(input1).registry["rQ_Bard"] = 0
													Player(input1).registry["rQBardnpc1"] = 0
													Player(input1).registry["rQBardnpc2"] = 0
													Player(input1).registry["rQBardnpc3"] = 0
													Player(input1).registry["rQBardnpc4"] = 0
													Player(input1):removeLegendbyName("repSubQ_Druid")
													Player(input1):removeLegendbyName("repSubQ_Bard")
													Player(input1):msg(8, "Your Poet Subpath Reputation quests have been reset. Please revisit your Guildmaster to begin again.", player.ID)
													player:msg(8, ""..Player(input1).name.."'s quests have been reset", player.ID)
												elseif (menu3 == "No") then
													player:dialogSeq({npcA, "Very well, then."}, 0)
												end
										end
								end
						end
				elseif (playerMenu == "  Stats") then
					local statOpts = {}
						table.insert(statOpts, "  Player Speed")
						table.insert(statOpts, "  Player Stats")
					local statMenu = player:menuString3("What with players?", statOpts)
						if (statMenu == "  Player Speed") then
							local input1 = player:input("Who in question?")
							local statMenu2 = player:menuString3("What with players?", {"Check", "Reset"})
								if (statMenu2 == "Check") then
									player:msg(8, ""..Player(input1).speed.."", player.ID)
								elseif (statMenu2 == "Reset") then
									Player(input1).speed = 80
									Player(input1):refresh()
								end
						elseif (statMenu == "  Player Stats") then
							local input1 = player:input("Who in question?")
								player:msg(8, "  Base Vita  :: "..Player(input1).baseHealth.."\n  Base Mana  :: "..Player(input1).baseMagic.."\n\n  Base Might :: "..Player(input1).basemight.."\n  Base Grace :: "..Player(input1).basegrace.."\n  Base Will  :: "..Player(input1).basewill.."", player.ID)
						end
				elseif (playerMenu == "  Move Player") then
					local moveOpts = {}
						table.insert(moveOpts, "  Han Inn")
					local input1 = player:input("Move:")
					local moveMenu = player:menuString3("Where do you want to move them to?", moveOpts)
					if (moveMenu == "  Han Inn") then
						Player(input1):warp(39, 15, 5)
						Player(input1):sendMinitext("An Imperial Soldier carries you back to the Inn.")
					end
				elseif (playerMenu == "  Item Related") then
					local itemOpts = {}
						table.insert(itemOpts, "  Inv: Add Item")
						table.insert(itemOpts, "  Inv: Check/Remove Item")
						table.insert(itemOpts, " ")
						table.insert(itemOpts, "-- Clear Inventory")
					local itemMenu = player:menuString3("What would you like to do?", itemOpts)
						if (itemMenu == "  Inv: Add Item") then
							local input1 = player:input("Who?")
							local input2 = tonumber(player:input("What item?"))
							local input3 = tonumber(player:input("How many?"))
							local yName = Item(input2).id
								if (Player(input1):hasSpace(input2, input3) == true) then
									Player(input1):addItem(yName, input3)
									Player(input1):sendMinitext("You have been given; ("..input3..") "..Item(input2).name..", by the Gods.")
									player:msg(8, "You have granted "..Player(input1).name..";\n\n("..input3..") "..Item(input2).name..".", player.ID)
								else
									player:msg(8, "They do not have enough room.", player.ID)
								end
						elseif (itemMenu == "  Inv: Check/Remove Item") then
							local input1 = player:input("Check Who?")
							local amountCheck = 0
							local itemTable = {}
							local amount = 0
							local found = 0
							for i = 0, Player(input1).maxInv do
								local nItem = Player(input1):getInventoryItem(i)
								if (nItem ~= nil and nItem.id > 0) then
									if (#itemTable > 0) then
										found = 0
										for j = 1, #itemTable do
											if (itemTable[j] == nItem.id) then
												found = 1
												break
											end
										end
										if (found == 0) then
											table.insert(itemTable, ""..nItem.id..": "..nItem.name.." - "..nItem.amount.."")
										end
									else
										table.insert(itemTable, ""..nItem.id..": "..nItem.name.." - "..nItem.amount.."")
									end
								end
							end

							local choice = player:menuString3("Here is their current inventory.", itemTable)
							local remove1 = tonumber(player:input("Item ID #:"))
							local remove2 = tonumber(player:input("Item Amount:"))
								Player(input1):removeItem(Item(remove1).yname, remove2)
								Player(input1):sendStatus()
								player:msg(8, "You have removed "..Player(input1).name.."'s items.\n\n("..remove2..") "..Item(remove1).name..".\n", player.ID)

						elseif (itemMenu == "-- Clear Inventory") then
							local input1 = player:input("Clear out who's inventory?")
						    local item
						    for i = 0, Player(input1).maxInv do
						        item = Player(input1):getInventoryItem( i )
						        if (item ~= nil) then
						            Player(input1):removeItem(item.id, item.amount)
						        end
						    end
						end
				end
		elseif (mainMenu == "  Spawn Mobs") then
			local what_mobID = tonumber(player:input("What monster ID will you set to spawn?"))
			local what_mobAMT = tonumber(player:input("How many monsters?"))
			local what_mobXstart = 0
			local what_mobYstart = 0
			local what_mobXend = npc.xmax
			local what_mobYend = npc.ymax
			local mobCheck
			local pcCheck
			local repCounter = 0
				for i = 1, what_mobAMT do
					repeat
						x = math.random(what_mobXstart, what_mobXend)
						y = math.random(what_mobYstart, what_mobYend)
						mobCheck = player:getObjectsInCell(player.m, x, y, BL_MOB)
						pcCheck = player:getObjectsInCell(player.m, x, y, BL_PC)
					until ((getPass(player.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0) or repCounter >= what_mobAMT)
						if (repCounter >= what_mobAMT) then
							player:sendMinitext("Attempted spawning mob over "..what_mobAMT.." times, aborted.")
							repCounter = 0
						else
							player:spawn(what_mobID, x, y, 1, player.m)
							local mob_para = player:getObjectsInCell(player.m, x, y, BL_MOB)
							mob_para[1].paralyzed = true
							mob_para[1]:sendAnimation(74)
							repCounter = repCounter + 1
						end
				end
		end
end),
}