imperialguard_bounty = {
click = function(player, npc)
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 1

	if (player.level == 99) then
		local opts1 = { }
			table.insert(opts1,"(50-99) Caverns")
			table.insert(opts1,"( 99+ ) Caverns")
			table.insert(opts1,"(( Abandon Bounty ))")
		local opts1a = { }
			table.insert(opts1a,"Haunted Valley")
			table.insert(opts1a,"Tanzar Walls")
			table.insert(opts1a,"Serpents Slither")
			table.insert(opts1a,"Florandine")
			table.insert(opts1a,"Du Jan Volcano")
			table.insert(opts1a,"Dor Sun Tower")
			table.insert(opts1a,"North Kingdom Wall")
			table.insert(opts1a,"Ogre Wastelands")
			table.insert(opts1a,"Sinking Maiden")
		local opts1b = { }
			table.insert(opts1b,"Underwater Caverns")
				if (player.maxHealth >= 25000) or (player.maxMagic >= 12500) then
					table.insert(opts1b,"Jungle Temple")
				end

		local choice = player:menuString("Which cavern would you like start a bounty for?", opts1)
			if (choice == "(50-99) Caverns") then
				local choice2 = player:menuString("Which cavern would you like start a bounty for?", opts1a)
					if (choice2 == "Haunted Valley") then
						bountyquest50.click(player,npc)
						return
					elseif (choice2 == "Tanzar Walls") then
						bountyquest55.click(player,npc)
						return
					elseif (choice2 == "Serpents Slither") then
						bountyquest62.click(player,npc)
						return
					elseif (choice2 == "Florandine") then
						bountyquest67.click(player,npc)
						return
					elseif (choice2 == "Du Jan Volcano") then
						bountyquest73.click(player,npc)
						return
					elseif (choice2 == "Dor Sun Tower") then
						bountyquest79.click(player,npc)
						return
					elseif (choice2 == "North Kingdom Wall") then
						bountyquest85.click(player,npc)
						return
					elseif (choice2 == "Ogre Wastelands") then
						bountyquest91.click(player,npc)
						return
					elseif (choice2 == "Sinking Maiden") then
						bountyquest95.click(player,npc)
						return
					end
			elseif (choice == "( 99+ ) Caverns") then
				local choice2 = player:menuString("Which cavern would you like start a bounty for?", opts1b)
					if (choice2 == "Underwater Caverns") then
						bountyquest99a.click(player,npc)
						return
					elseif (choice2 == "Jungle Temple") then
						bountyquest99b.click(player,npc)
						return
					end
			elseif (choice == "(( Abandon Bounty ))") then
				abandonBounty.click(player,npc)
				return
			end
	elseif (player.level >= 50) and (player.level <= 98) then
		local opts1 = { }
			table.insert(opts1,"Haunted Valley")
				if (player.level >= 55) then
					table.insert(opts1,"Tanzar Walls")
						if (player.level >= 62) then
							table.insert(opts1,"Serpents Slither")
								if (player.level >= 67) then
									table.insert(opts1,"Florandine")
										if (player.level >= 73) then
											table.insert(opts1,"Du Jan Volcano")
												if (player.level >= 79) then
													table.insert(opts1,"Dor Sun Tower")
														if (player.level >= 85) then
															table.insert(opts1,"North Kingdom Wall")
																if (player.level >= 91) then
																	table.insert(opts1,"Ogre Wastelands")
																		if (player.level >= 95) then
																			table.insert(opts1,"Sinking Maiden")
																		end
																end
														end
												end
										end
								end
						end
				end
			table.insert(opts1,"(( Abandon Bounty ))")

		local choice = player:menuString("Which cavern would you like start a bounty for?", opts1)
			if (choice == "Haunted Valley") then
				bountyquest50.click(player,npc)
				return
			elseif (choice == "Tanzar Walls") then
				bountyquest55.click(player,npc)
				return
			elseif (choice == "Serpents Slither") then
				bountyquest62.click(player,npc)
				return
			elseif (choice == "Florandine") then
				bountyquest67.click(player,npc)
				return
			elseif (choice == "Du Jan Volcano") then
				bountyquest73.click(player,npc)
				return
			elseif (choice == "Dor Sun Tower") then
				bountyquest79.click(player,npc)
				return
			elseif (choice == "North Kingdom Wall") then
				bountyquest85.click(player,npc)
				return
			elseif (choice == "Ogre Wastelands") then
				bountyquest91.click(player,npc)
				return
			elseif (choice == "Sinking Maiden") then
				bountyquest95.click(player,npc)
				return
			elseif (choice == "(( Abandon Bounty ))") then
				abandonBounty.click(player,npc)
				return
			end
	elseif (player.level <= 48) then
		player:dialogSeq({npcA, "Sorry, you're too little to begin a bounty.\n\nCome back another time, when you're stronger."}, 1)
		return
	end
end,
}

abandonBounty = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1

		if (player.quest["BountyQuest"] == 0) then
			player:dialogSeq({npcA, "You're not currently on a bounty."}, 0)
		elseif (player.quest["BountyQuest"] > 0) then

			local bCheck_T = {}
				bCheck_T[1] = "Population - Haunted Valley"
				bCheck_T[2] = "Supplies - Haunted Valley"
				bCheck_T[3] = "Leader - Haunted Valley"
				bCheck_T[4] = "Population - Tanzar Walls"
				bCheck_T[5] = "Supplies - Tanzar Walls"
				bCheck_T[6] = "Leader - Tanzar Walls"
				bCheck_T[7] = "Population - Serpents Slither"
				bCheck_T[8] = "Supplies - Serpents Slither"
				bCheck_T[9] = "Leader - Serpents Slither"
				bCheck_T[10] = "Population - Florandine"
				bCheck_T[11] = "Supplies - Florandine"
				bCheck_T[12] = "Leader - Florandine"
				bCheck_T[13] = "Population - Du Jan Volcano"
				bCheck_T[14] = "Supplies - Du Jan Volcano"
				bCheck_T[15] = "Leader - Du Jan Volcano"
				bCheck_T[16] = "Population - Dor Sun Tower"
				bCheck_T[17] = "Supplies - Dor Sun Tower"
				bCheck_T[18] = "Leader - Dor Sun Tower"
				bCheck_T[19] = "Population - North Kingdom Wall"
				bCheck_T[20] = "Supplies - North Kingdom Wall"
				bCheck_T[21] = "Leader - North Kingdom Wall"
				bCheck_T[22] = "Population - Ogre Wastelands"
				bCheck_T[23] = "Supplies - Ogre Wastelands"
				bCheck_T[24] = "Leader - Ogre Wastelands"
				bCheck_T[25] = "Population - Sinking Maiden"
				bCheck_T[26] = "Supplies - Sinking Maiden"
				bCheck_T[27] = "Leader - Sinking Maiden"
				bCheck_T[28] = "Population - Underwater Caverns"
				bCheck_T[29] = "Supplies - Underwater Caverns"
				bCheck_T[30] = "Leader - Underwater Caverns"
				bCheck_T[31] = "Population - Jungle Temple"
				bCheck_T[32] = "Supplies - Jungle Temple"
				bCheck_T[33] = "Leader - Jungle Temple"
				--bCheck_T[#] = "Population - "
				--bCheck_T[#] = "Supplies - "
				--bCheck_T[#] = "Leader - "
			local bountyCheck1 = tonumber(player.quest["BountyQuest"])
			local bCheck_T1 = bCheck_T[bountyCheck1]

			local abandon = player:menuString3("Current Bounty;\n"..bCheck_T1.."?\n\nAre you positive?", {"Yes, abandon my bounty.", "No, keep my bounty."})
				if (abandon == "Yes, abandon my bounty.") then
					player.quest["BountyQuest"] = 0
					player:dialogSeq({npcA, "Your bounty has been reset."}, 0)
				elseif (abandon == "No, keep my bounty.") then
					player:dialogSeq({npcA, "Alright, I'll be awaiting your return then."}, 0)
				end
		end
end,
}

bountyquest50 = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC1 = 498000
		local PopGoldC1 = 4000
		local SupEXPC1 = 996000
		local SupGoldC1 = 8000
		local LeaEXPC1 = 747000
		local LeaGoldC1 = 6000
	-- QUEST MENU
			local C1LeaB = {graphic = convertGraphic(31, "monster"), color = 30}  -- Mob 135
			local killCount118 = tonumber(player:killCount(118))
 			local killCount119 = tonumber(player:killCount(119))
 			local killCount120 = tonumber(player:killCount(120))
 			local killCount121 = tonumber(player:killCount(121))
 			local killCount122 = tonumber(player:killCount(122))
			local C1PopKillTotal = killCount118 + killCount119 + killCount120 + killCount121 + killCount122
 			local killCount124 = tonumber(player:killCount(124))
 			local killCount125 = tonumber(player:killCount(125))
 			local killCount135 = tonumber(player:killCount(135))
 			local killCount136 = tonumber(player:killCount(136))
			local C1LeaKillTotal = killCount124 + killCount125 + killCount135 + killCount136

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Haunted Valley are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 1
					player:flushKills(118)
					player:flushKills(119)
					player:flushKills(120)
					player:flushKills(121)
					player:flushKills(122)
					player:flushKills(122)

				elseif (player.quest["BountyQuest"] == 1 ) then
					if (C1PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(118)
						player:flushKills(119)
						player:flushKills(120)
						player:flushKills(121)
						player:flushKills(122)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC1)
						onCalcTNL(player)						
						player:addGold(PopGoldC1)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC1.."\n        Gold: "..PopGoldC1.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C1PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nResentful Spirit: "..killCount118.."\nDry Bones: "..killCount119.."\nBloody Bones: "..killCount120.."\nConjured Bones: "..killCount121.."\nAngry Spirit: "..killCount122.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C1PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 2 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(411).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 2

				elseif (player.quest["BountyQuest"] <= 1 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 2) then
					if (player:hasItem("bone", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("bone", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC1)
						onCalcTNL(player)						
						player:addGold(SupGoldC1)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC1.."\n        Gold: "..SupGoldC1.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(411).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 3 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C1LeaB, "This is a list of this caverns current leaders;\n\n- Undead Pacifist,\n- Undead Elementalist,\n- Bones of the Warrior,\n- Bones of the Rogue.",
					C1LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 3
					player:flushKills(124)
					player:flushKills(125)
					player:flushKills(135)
					player:flushKills(136)

				elseif (player.quest["BountyQuest"] <= 2 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 3 ) then
					if (C1LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
							npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(124)
						player:flushKills(125)
						player:flushKills(135)
						player:flushKills(136)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC1)
						onCalcTNL(player)						
						player:addGold(LeaGoldC1)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC1.."\n        Gold: "..LeaGoldC1.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C1LeaB, "Come back when you've slain at least one of the following;\n\n- Undead Pacifist,\n- Undead Elementalist,\n- Bones of the Warrior,\n- Bones of the Rogue."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 4 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest55 = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC2 = 594000
		local PopGoldC2 = 4000
		local SupEXPC2 = 1188000
		local SupGoldC2 = 8000
		local LeaEXPC2 = 891000
		local LeaGoldC2 = 6000
	-- QUESTS
			local C2LeaB = {graphic = convertGraphic(166, "monster"), color = 22} -- Mob 49
			local killCount46 = tonumber(player:killCount(46))
 			local killCount47 = tonumber(player:killCount(47))
		 	local killCount48 = tonumber(player:killCount(48))
			local C2PopKillTotal = killCount46 + killCount47 + killCount48
 			local killCount49 = tonumber(player:killCount(49))
			local C2LeaKillTotal = killCount49

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Tanzar Walls are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 4
					player:flushKills(46)
					player:flushKills(47)
					player:flushKills(48)

				elseif (player.quest["BountyQuest"] <= 3 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 4) then
					if (C2PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(46)
						player:flushKills(47)
						player:flushKills(48)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC2)
						onCalcTNL(player)						
						player:addGold(PopGoldC2)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC2.."\n        Gold: "..PopGoldC2.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C2PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nEmerald Paw: "..killCount46.."\nEmerald Claw: "..killCount47.."\nEmerald Fang: "..killCount48.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C2PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 5 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(151).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 5

				elseif (player.quest["BountyQuest"] <= 4 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 5) then
					if (player:hasItem("tigers_tooth", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("tigers_tooth", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC2)
						onCalcTNL(player)						
						player:addGold(SupGoldC2)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC2.."\n        Gold: "..SupGoldC2.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(151).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 6 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C2LeaB, "This is a list of this caverns current leaders;\n\n- Emerald King.",
					C2LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 6
					player:flushKills(49)

				elseif (player.quest["BountyQuest"] <= 5 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 6 ) then
					if (C2LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
							npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(49)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC2)
						onCalcTNL(player)						
						player:addGold(LeaGoldC2)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC2.."\n        Gold: "..LeaGoldC2.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C2LeaB, "Come back when you've slain at least one of the following;\n\n- Emerald King."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 7 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest62 = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC3 = 720000
		local PopGoldC3 = 4500
		local SupEXPC3 = 1440000
		local SupGoldC3 = 9000
		local LeaEXPC3 = 1080000
		local LeaGoldC3 = 6750
	-- QUESTS
			local C3LeaB = {graphic = convertGraphic(577, "monster"), color = 22} -- Mob 139
			local killCount140 = tonumber(player:killCount(140))
 			local killCount141 = tonumber(player:killCount(141))
		 	local killCount142 = tonumber(player:killCount(142))
		 	local killCount143 = tonumber(player:killCount(143))
		 	local killCount144 = tonumber(player:killCount(144))
			local C3PopKillTotal = killCount140 + killCount141 + killCount142 + killCount143 + killCount144
 			local killCount139 = tonumber(player:killCount(139))
			local C3LeaKillTotal = killCount139

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Serpents Slither are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 7
					player:flushKills(140)
					player:flushKills(141)
					player:flushKills(142)
					player:flushKills(143)
					player:flushKills(144)

				elseif (player.quest["BountyQuest"] <= 6 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 7 ) then
					if (C3PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(140)
						player:flushKills(141)
						player:flushKills(142)
						player:flushKills(143)
						player:flushKills(144)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC3)
						onCalcTNL(player)						
						player:addGold(PopGoldC3)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC3.."\n        Gold: "..PopGoldC3.."\n\n  Imperial Standing: +1", player.ID)						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C3PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nCamo Serpent: "..killCount140.."\nCold Snake: "..killCount141.."\nSlither: "..killCount142.."\nSerpent High Guard: "..killCount143.."\nSerpent Sentry: "..killCount144.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C3PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 8 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(40047).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 8

				elseif (player.quest["BountyQuest"] <= 7 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 8 ) then
					if (player:hasItem("snake_meat", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("snake_meat", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC3)
						onCalcTNL(player)						
						player:addGold(SupGoldC3)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC3.."\n        Gold: "..SupGoldC3.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(40047).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 9 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C3LeaB, "This is a list of this caverns current leaders;\n\n- Serpentella.",
					C3LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 9
					player:flushKills(139)


				elseif (player.quest["BountyQuest"] <= 8 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 9 ) then
					if (C3LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
							npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(139)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC3)
						onCalcTNL(player)						
						player:addGold(LeaGoldC3)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC3.."\n        Gold: "..LeaGoldC3.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C3LeaB, "Come back when you've slain at least one of the following;\n\n- Serpentella."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 10 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest67 = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC4 = 822000
		local PopGoldC4 = 4500
		local SupEXPC4 = 1644000
		local SupGoldC4 = 9000
		local LeaEXPC4 = 1233000
		local LeaGoldC4 = 6750
	-- QUESTS
			local C4LeaB = {graphic = convertGraphic(580, "monster"), color = 21} -- Mob 148
			local killCount145 = tonumber(player:killCount(145))
 			local killCount146 = tonumber(player:killCount(146))
		 	local killCount147 = tonumber(player:killCount(147))
			local C4PopKillTotal = killCount145 + killCount146 + killCount147
 			local killCount148 = tonumber(player:killCount(148))
 			local killCount149 = tonumber(player:killCount(149))
 			local killCount150 = tonumber(player:killCount(150))
			local C4LeaKillTotal = killCount148 + killCount149 + killCount150

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Florandine are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 10
					player:flushKills(145)
					player:flushKills(146)
					player:flushKills(147)

				elseif (player.quest["BountyQuest"] <= 9 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 10 ) then
					if (C4PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(145)
						player:flushKills(146)
						player:flushKills(147)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC4)
						onCalcTNL(player)						
						player:addGold(PopGoldC4)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC4.."\n        Gold: "..PopGoldC4.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C4PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nFloris: "..killCount145.."\nFlary: "..killCount146.."\nFlenis: "..killCount147.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C4PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 11 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(40049).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 11

				elseif (player.quest["BountyQuest"] <= 10 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 11 ) then
					if (player:hasItem("plant_leaf", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("plant_leaf", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC4)
						onCalcTNL(player)						
						player:addGold(SupGoldC4)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC4.."\n        Gold: "..SupGoldC4.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(40049).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 12 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C4LeaB, "This is a list of this caverns current leaders;\n\n- Sister Yulep,\n- Sister Rena,\n- Sister Luxa.",
					C4LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 12
					player:flushKills(148)
					player:flushKills(149)
					player:flushKills(150)

				elseif (player.quest["BountyQuest"] <= 11 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 12 ) then
					if (C4LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
							npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(148)
						player:flushKills(149)
						player:flushKills(150)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC4)
						onCalcTNL(player)						
						player:addGold(LeaGoldC4)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC4.."\n        Gold: "..LeaGoldC4.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C4LeaB, "Come back when you've slain at least one of the following;\n\n- Sister Yulep,\n- Sister Rena,\n- Sister Luxa."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 13 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest73 = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC5 = 924000
		local PopGoldC5 = 5000
		local SupEXPC5 = 1848000
		local SupGoldC5 = 10000
		local LeaEXPC5 = 1386000
		local LeaGoldC5 = 7500
	-- QUESTS
			local C5LeaB = {graphic = convertGraphic(894, "monster"), color = 0} -- Mob 58
			local killCount126 = tonumber(player:killCount(126))
 			local killCount128 = tonumber(player:killCount(128))
		 	local killCount129 = tonumber(player:killCount(129))
		 	local killCount56 = tonumber(player:killCount(56))
		 	local killCount57 = tonumber(player:killCount(57))
		 	local killCount127 = tonumber(player:killCount(127))
			local C5PopKillTotal = killCount126 + killCount128 + killCount129 + killCount56 + killCount57 + killCount127
 			local killCount55 = tonumber(player:killCount(55))
 			local killCount58 = tonumber(player:killCount(58))
			local C5LeaKillTotal = killCount55 + killCount58

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Du Jan Volcano are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 13
					player:flushKills(126)
					player:flushKills(128)
					player:flushKills(129)
					player:flushKills(56)
					player:flushKills(57)
					player:flushKills(127)

				elseif (player.quest["BountyQuest"] <= 12 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 13) then
					if (C5PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(126)
						player:flushKills(128)
						player:flushKills(129)
						player:flushKills(56)
						player:flushKills(57)
						player:flushKills(127)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC5)
						onCalcTNL(player)						
						player:addGold(PopGoldC5)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC5.."\n        Gold: "..PopGoldC5.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C5PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nMolten Squirrel: "..killCount126.."\nMolten Buck: "..killCount128.."\nMolten Doe: "..killCount129.."\nZhar-Ptitsa Newborn: "..killCount56.."\nZhar-Ptitsa Juvenile: "..killCount57.."\nAsh Zhar-Ptitsa Juvenile: "..killCount127.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C5PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 14 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(161).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 14

				elseif (player.quest["BountyQuest"] <= 13 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 14 ) then
					if (player:hasItem("molten_scale", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("molten_scale", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC5)
						onCalcTNL(player)						
						player:addGold(SupGoldC5)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC5.."\n        Gold: "..SupGoldC5.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(161).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 15 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C5LeaB, "This is a list of this caverns current leaders;\n\n- Ash Zhar-Ptitsa,\n- Zhar-Ptitsa.",
					C5LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 15
					player:flushKills(55)
					player:flushKills(58)

				elseif (player.quest["BountyQuest"] <= 14 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 15 ) then
					if (C5LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
							npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(55)
						player:flushKills(58)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC5)
						onCalcTNL(player)						
						player:addGold(LeaGoldC5)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC5.."\n        Gold: "..LeaGoldC5.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C5LeaB, "Come back when you've slain at least one of the following;\n\n- Ash Zhar-Ptitsa,\n- Zhar-Ptitsa."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 16 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest79 = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC6 = 1026000
		local PopGoldC6 = 5000
		local SupEXPC6 = 2052000
		local SupGoldC6 = 10000
		local LeaEXPC6 = 1539000
		local LeaGoldC6 = 7500
	-- QUESTS
			local C6LeaB = {graphic = convertGraphic(325, "monster"), color = 40} -- Mob 156
			local killCount153 = tonumber(player:killCount(153))
 			local killCount154 = tonumber(player:killCount(154))
		 	local killCount155 = tonumber(player:killCount(155))
			local C6PopKillTotal = killCount153 + killCount154 + killCount155
 			local killCount156 = tonumber(player:killCount(156))
 			local killCount157 = tonumber(player:killCount(157))
			local C6LeaKillTotal = killCount156 + killCount157

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Dor Sun Tower are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 16
					player:flushKills(153)
					player:flushKills(154)
					player:flushKills(155)

				elseif (player.quest["BountyQuest"] <= 15 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 16 ) then
					if (C6PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(153)
						player:flushKills(154)
						player:flushKills(155)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC6)
						onCalcTNL(player)						
						player:addGold(PopGoldC6)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC6.."\n        Gold: "..PopGoldC6.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C6PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nWind Spirit: "..killCount153.."\nWind Spirit Vortex: "..killCount154.."\nWind Spirit Wisp: "..killCount155.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C6PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 17 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(427).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 17

				elseif (player.quest["BountyQuest"] <= 16 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 17 ) then
					if (player:hasItem("bottled_wind", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("bottled_wind", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC6)
						onCalcTNL(player)						
						player:addGold(SupGoldC6)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC6.."\n        Gold: "..SupGoldC6.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(427).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 18 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C6LeaB, "This is a list of this caverns current leaders;\n\n- Furious Wind Spirit,\n- Tormented Wind Spirit.",
					C6LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 18
					player:flushKills(156)
					player:flushKills(157)

				elseif (player.quest["BountyQuest"] <= 17 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 18 ) then
					if (C6LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
							npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(156)
						player:flushKills(157)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC6)
						onCalcTNL(player)						
						player:addGold(LeaGoldC6)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC6.."\n        Gold: "..LeaGoldC6.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C6LeaB, "Come back when you've slain at least one of the following;\n\n- Furious Wind Spirit,\n- Tormented Wind Spirit."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 19 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest85 = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC7 = 1158000
		local PopGoldC7 = 5500
		local SupEXPC7 = 2316000
		local SupGoldC7 = 11000
		local LeaEXPC7 = 1737000
		local LeaGoldC7 = 8250
	-- QUESTS
			local C7LeaB = {graphic = convertGraphic(515, "monster"), color = 15} -- Mob 162
			local killCount158 = tonumber(player:killCount(158))
 			local killCount159 = tonumber(player:killCount(159))
		 	local killCount160 = tonumber(player:killCount(160))
		 	local killCount161 = tonumber(player:killCount(161))
			local C7PopKillTotal = killCount158 + killCount159 + killCount160 + killCount161
 			local killCount162 = tonumber(player:killCount(162))
			local C7LeaKillTotal = killCount162

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the North Kingdom Wall are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 19
					player:flushKills(158)
					player:flushKills(159)
					player:flushKills(160)
					player:flushKills(161)

				elseif (player.quest["BountyQuest"] <= 18 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 19 ) then
					if (C7PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(158)
						player:flushKills(159)
						player:flushKills(160)
						player:flushKills(161)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC7)
						onCalcTNL(player)						
						player:addGold(PopGoldC7)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC7.."\n        Gold: "..PopGoldC7.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C7PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nHobgoblin Rampager: "..killCount158.."\nHobgoblin Sneak: "..killCount159.."\nHobgoblin Firestarter: "..killCount160.."\nHobgoblin Mender: "..killCount161.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C7PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 20 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(428).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 20

				elseif (player.quest["BountyQuest"] <= 19 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 20 ) then
					if (player:hasItem("hobgob_goo", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("hobgob_goo", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC7)
						onCalcTNL(player)						
						player:addGold(SupGoldC7)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC7.."\n        Gold: "..SupGoldC7.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(428).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 21 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C7LeaB, "This is a list of this caverns current leaders;\n\n- Chutac Kikini.",
					C7LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 21
					player:flushKills(162)

				elseif (player.quest["BountyQuest"] <= 20 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 21 ) then
					if (C7LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
						npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(162)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC7)
						onCalcTNL(player)						
						player:addGold(LeaGoldC7)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC7.."\n        Gold: "..LeaGoldC7.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C7LeaB, "Come back when you've slain at least one of the following;\n\n- Chutac Kikini."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 22 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest91 = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC8 = 1260000
		local PopGoldC8 = 5500
		local SupEXPC8 = 2520000
		local SupGoldC8 = 11000
		local LeaEXPC8 = 1890000
		local LeaGoldC8 = 8250
	-- QUESTS
			local C8LeaB = {graphic = convertGraphic(185, "monster"), color = 28} -- Mob 166
			local killCount163 = tonumber(player:killCount(163))
 			local killCount164 = tonumber(player:killCount(164))
		 	local killCount165 = tonumber(player:killCount(165))
			local C8PopKillTotal = killCount163 + killCount164 + killCount165
 			local killCount166 = tonumber(player:killCount(166))
 			local killCount167 = tonumber(player:killCount(167))
			local C8LeaKillTotal = killCount166 + killCount167

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Ogre Wastelands are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 22
					player:flushKills(163)
					player:flushKills(164)
					player:flushKills(165)

				elseif (player.quest["BountyQuest"] <= 21 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 22 ) then
					if (C8PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(163)
						player:flushKills(164)
						player:flushKills(165)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC8)
						onCalcTNL(player)						
						player:addGold(PopGoldC8)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC8.."\n        Gold: "..PopGoldC8.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C8PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nReckless Ogre: "..killCount163.."\nMenacing Ogre: "..killCount164.."\nBerserk Ogre: "..killCount165.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C8PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 23 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(431).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 23

				elseif (player.quest["BountyQuest"] <= 22 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 23 ) then
					if (player:hasItem("amber", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("amber", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC8)
						onCalcTNL(player)						
						player:addGold(SupGoldC8)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC8.."\n        Gold: "..SupGoldC8.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(431).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 24 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C8LeaB, "This is a list of this caverns current leaders;\n\n- Grukor,\n- Guiruk.",
					C8LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 24
					player:flushKills(166)
					player:flushKills(167)

				elseif (player.quest["BountyQuest"] <= 23 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 24 ) then
					if (C8LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
							npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(166)
						player:flushKills(167)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC8)
						onCalcTNL(player)						
						player:addGold(LeaGoldC8)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC8.."\n        Gold: "..LeaGoldC8.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C8LeaB, "Come back when you've slain at least one of the following;\n\n- Grukor,\n- Guiruk."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 25 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest95 = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC9 = 1380000
		local PopGoldC9 = 6000
		local SupEXPC9 = 2760000
		local SupGoldC9 = 12000
		local LeaEXPC9 = 2070000
		local LeaGoldC9 = 9000
	-- QUESTS
			local C9LeaB = {graphic = convertGraphic(589, "monster"), color = 0} -- Mob 175
			local killCount169 = tonumber(player:killCount(169))
 			local killCount170 = tonumber(player:killCount(170))
		 	local killCount171 = tonumber(player:killCount(171))
		 	local killCount172 = tonumber(player:killCount(172))
		 	local killCount173 = tonumber(player:killCount(173))
		 	local killCount174 = tonumber(player:killCount(174))
			local C9PopKillTotal = killCount169 + killCount170 + killCount171 + killCount172 + killCount173 + killCount174
 			local killCount175 = tonumber(player:killCount(175))
			local C9LeaKillTotal = killCount175

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Sinking Maiden are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 25
					player:flushKills(169)
					player:flushKills(170)
					player:flushKills(171)
					player:flushKills(172)
					player:flushKills(173)
					player:flushKills(174)

				elseif (player.quest["BountyQuest"] <= 24 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 25 ) then
					if (C9PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(169)
						player:flushKills(170)
						player:flushKills(171)
						player:flushKills(172)
						player:flushKills(173)
						player:flushKills(174)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC9)
						onCalcTNL(player)						
						player:addGold(PopGoldC9)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC9.."\n        Gold: "..PopGoldC9.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C9PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nPirate Ghast: "..killCount169.."\nPirate Ghoul: "..killCount170.."\nPirate Phantasm: "..killCount171.."\nPirate Skeleton: "..killCount172.."\nPirate Poltergeist: "..killCount173.."\nPirate Undead: "..killCount174.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C9PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 26 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(433).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 26

				elseif (player.quest["BountyQuest"] <= 25 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 26 ) then
					if (player:hasItem("r_flesh", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("r_flesh", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC9)
						onCalcTNL(player)						
						player:addGold(SupGoldC9)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC9.."\n        Gold: "..SupGoldC9.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(433).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 27 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C9LeaB, "This is a list of this caverns current leaders;\n\n- Captain Bartolomeo.",
					C9LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 27
					player:flushKills(175)

				elseif (player.quest["BountyQuest"] <= 26 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 27 ) then
					if (C9LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
							npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(175)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC9)
						onCalcTNL(player)						
						player:addGold(LeaGoldC9)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC9.."\n        Gold: "..LeaGoldC9.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C9LeaB, "Come back when you've slain at least one of the following;\n\n- Captain Bartolomeo."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 28 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest99a = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC10 = 2520000
		local PopGoldC10 = 10000
		local SupEXPC10 = 5040000
		local SupGoldC10 = 20000
		local LeaEXPC10 = 3780000
		local LeaGoldC10 = 15000
	-- QUESTS
			local C10LeaB = {graphic = convertGraphic(398, "monster"), color = 0} -- Mob 217
			local killCount211 = tonumber(player:killCount(211))
 			local killCount212 = tonumber(player:killCount(212))
		 	local killCount213 = tonumber(player:killCount(213))
		 	local killCount214 = tonumber(player:killCount(214))
		 	local killCount215 = tonumber(player:killCount(215))
		 	local killCount216 = tonumber(player:killCount(216))
			local C10PopKillTotal = killCount211 + killCount212 + killCount213 + killCount214 + killCount215 + killCount216
 			local killCount217 = tonumber(player:killCount(217))
 			local killCount218 = tonumber(player:killCount(218))
 			local killCount219 = tonumber(player:killCount(219))

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Underwater Caverns are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 28
					player:flushKills(211)
					player:flushKills(212)
					player:flushKills(213)
					player:flushKills(214)
					player:flushKills(215)
					player:flushKills(216)

				elseif (player.quest["BountyQuest"] <= 27 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 28 ) then
					if (C10PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(211)
						player:flushKills(212)
						player:flushKills(213)
						player:flushKills(214)
						player:flushKills(215)
						player:flushKills(216)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC10)
						onCalcTNL(player)						
						player:addGold(PopGoldC10)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC10.."\n        Gold: "..PopGoldC10.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C10PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nShrimpy Shrimp: "..killCount211.."\nSquishy Shrimp: "..killCount212.."\nCrunchy Shrimp: "..killCount213.."\nAgile Jellyfish: "..killCount214.."\nPotent Jellyfish: "..killCount215.."\nIrate Anemone: "..killCount216.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C10PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 29 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(284).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 29

				elseif (player.quest["BountyQuest"] <= 28 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 29 ) then
					if (player:hasItem("uw_cave1", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("uw_cave1", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC10)
						onCalcTNL(player)						
						player:addGold(SupGoldC10)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC10.."\n        Gold: "..SupGoldC10.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(284).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 30 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)


				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leaders?!",
					C10LeaB, "This is a list of this caverns current leaders;\n\n- Muk-uk.",
					C10LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 30
					player:flushKills(217)
					player:flushKills(218)
					player:flushKills(219)

				elseif (player.quest["BountyQuest"] <= 29 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 30 ) then
					if (killCount217 >= 1 ) then										
						if (killCount218 >= 1) or (killCount219 >= 1) then
							player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
							npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
							player:flushKills(217)
							player:flushKills(218)
							player:flushKills(219)
							player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
							player.quest["BountyQuest"] = 0
							player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
							player:giveXP(LeaEXPC10)
							player:addGold(LeaGoldC10)
							player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC10.."\n        Gold: "..LeaGoldC10.."\n\n  Imperial Standing: +1", player.ID)
							player.registry["bountytotal"] = player.registry["bountytotal"] + 1
							player:removeLegendbyName("bounties")
							player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
							player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

						else
							player:dialogSeq({npcA, "You've only killed part of their leader!",
							C10LeaB, "Muk-uk is going to restore himself now, you fool!\n\nGet back in there and kill BOTH of his forms!"}, 1)
							return
						end

					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C10LeaB, "Come back when you've slain at least one of the following;\n\n- Muk-uk."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 31 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}

bountyquest99b = {
	click = function(player, npc)
		local npcA = {graphic = 0, color = 0}
			player.npcGraphic = npcA.graphic
			player.npcColor = npcA.color
			player.dialogType = 1
	-- OPTIONS
		local opts2 = { }
			table.insert(opts2,"Population Control")
			table.insert(opts2,"Gathering Supplies")
			table.insert(opts2,"Confronting their Leader")
	-- TIMERS
		local PopulationB_Timer = 25200  -- 7 IRL Hrs
		local SupplyB_Timer = 39600      --11 IRL Hrs
		local LeaderB_Timer = 82800      --23 IRL Hrs
	-- POPULATION/LEADER AMOUNT
		local PopulationAmount = 100
		local LeaderAmount = 1
	-- REWARDS
		local PopEXPC11 = 2880000
		local PopGoldC11 = 14000
		local SupEXPC11 = 5760000
		local SupGoldC11 = 28000
		local LeaEXPC11 = 4320000
		local LeaGoldC11 = 21000
	-- QUESTS
			local C11LeaB = {graphic = convertGraphic(424, "monster"), color = 0} -- Mob 243
			local killCount239 = tonumber(player:killCount(239))
 			local killCount240 = tonumber(player:killCount(240))
		 	local killCount241 = tonumber(player:killCount(241))
		 	local killCount242 = tonumber(player:killCount(242))
		 	local killCount236 = tonumber(player:killCount(236))
		 	local killCount237 = tonumber(player:killCount(237))
			local C11PopKillTotal = killCount239 + killCount240 + killCount241 + killCount242 + killCount236 + killCount237
 			local killCount243 = tonumber(player:killCount(243))
			local C11LeaKillTotal = killCount243

			local choice=player:menuString("Which of the following would you like to do?", opts2)
			if (choice == "Population Control") then
				if (player.registry["BountyQuestPTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestPTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "The monsters inside of the Jungle Temple are rising in numbers. Head into their territory and vanquish them!",
					npcA, "Come back to me after you've slain at least "..PopulationAmount..", if you can I'll be sure to give you a hefty reward."}, 1)
					player.quest["BountyQuest"] = 31
					player:flushKills(239)
					player:flushKills(240)
					player:flushKills(241)
					player:flushKills(242)
					player:flushKills(236)
					player:flushKills(237)

				elseif (player.quest["BountyQuest"] <= 30 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 31 ) then
					if (C11PopKillTotal >= PopulationAmount) then
						player:dialogSeq({npcA, "Good job! You seem to have made quick work of those foes. As promised, here is your reward.."}, 1)
						player:flushKills(239)
						player:flushKills(240)
						player:flushKills(241)
						player:flushKills(242)
						player:flushKills(236)
						player:flushKills(237)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestPTimer"] = os.time() + PopulationB_Timer
						player:giveXP(PopEXPC11)
						onCalcTNL(player)						
						player:addGold(PopGoldC11)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..PopEXPC11.."\n        Gold: "..PopGoldC11.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You have killed "..C11PopKillTotal.." creatures out of "..PopulationAmount..".",
						npcA, "Your current head-count is as follows;\n\nVoodoo Tribesman: "..killCount239.."\nVoodoo Tribesman: "..killCount240.."\nVoodoo Warrior: "..killCount241.."\nVoodoo Warrior: "..killCount242.."\nFuzzy Baboon: "..killCount236.."\nBlue-faced Baboon: "..killCount237.."",
						npcA, "Come back when you've slain at least "..(PopulationAmount - C11PopKillTotal).." more."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 32 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end
					
			elseif (choice == "Gathering Supplies") then
				if (player.registry["BountyQuestSTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestSTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)

				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "So, you're interested in gathering us some supplies are you?",
					npcA, "If would be mighty helpful if you could bring us;\n\n(100) "..Item(484).name.."'s.",
					npcA, "Once you've gather those, come back and see me again."}, 1)
					player.quest["BountyQuest"] = 32

				elseif (player.quest["BountyQuest"] <= 31 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 32 ) then
					if (player:hasItem("voodoo_charm", 100) == true ) then
						player:dialogSeq({npcA, "Good job! This should keep us stocked-up for a few days, here is that reward I promised you.."}, 1)
						player:removeItem("voodoo_charm", 100)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestSTimer"] = os.time() + SupplyB_Timer
						player:giveXP(SupEXPC11)
						onCalcTNL(player)						
						player:addGold(SupGoldC11)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..SupEXPC11.."\n        Gold: "..SupGoldC11.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)

					else
						player:dialogSeq({npcA, "You don't have everything I've asked for..",
						npcA, "I need the following things:\n\n(100) "..Item(484).name.."'s."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 33 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			elseif (choice == "Confronting their Leader") then
				if (player.registry["BountyQuestLTimer"] >= os.time()) then
					player:dialogSeq({npcA, "You will need to wait roughly "..(math.ceil((player.registry["BountyQuestLTimer"] - os.time())/10800)).." more day(s) before you can re-attempt this bounty."}, 1)


				elseif (player.quest["BountyQuest"] == 0 ) then
					player:dialogSeq({npcA, "Hah! You of all people think you have what it takes to kill their leader?!",
					C11LeaB, "This is a list of this caverns current leaders;\n\n- Thunderjel.",
					C11LeaB, "Slay one of them and return back to me."}, 1)
					player.quest["BountyQuest"] = 33
					player:flushKills(243)

				elseif (player.quest["BountyQuest"] <= 32 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)

				elseif (player.quest["BountyQuest"] == 33 ) then
					if (C11LeaKillTotal >= LeaderAmount) then
						player:dialogSeq({npcA, "I cannot believe my eyes!\nYou've actually done it!",
						npcA, "I mean you REALLY killed them!\n\nHere, take this as a reward. You have definately earned it by now.."}, 1)
						player:flushKills(243)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player.quest["BountyQuest"] = 0
						player.registry["BountyQuestLTimer"] = os.time() + LeaderB_Timer
						player:giveXP(LeaEXPC11)
						player:addGold(LeaGoldC11)
						player:msg(8, "[Bounty #"..(player.registry["bountytotal"] + 1).."] :: Complete\n\n  Experience: "..LeaEXPC11.."\n        Gold: "..LeaGoldC11.."\n\n  Imperial Standing: +1", player.ID)
						player.registry["bountytotal"] = player.registry["bountytotal"] + 1
						player:removeLegendbyName("bounties")
						player:sendMinitext("You've finished "..player.registry["bountytotal"].." bounties.")
						player:addLegend("Has completed "..player.registry["bountytotal"].." bounties. "..curT(), "bounties", 7, 128)
					else
						player:dialogSeq({npcA, "You haven't killed any of their leaders!",
						C11LeaB, "Come back when you've slain at least one of the following;\n\n- Thunderjel."}, 1)
						return
					end

				elseif (player.quest["BountyQuest"] >= 34 ) then
					player:dialogSeq({npcA, "You seem to be working on another bounty already."}, 1)
				end

			end
end,
}