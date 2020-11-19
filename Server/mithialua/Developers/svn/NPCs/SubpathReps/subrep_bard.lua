subrep_bard = { 
click = async(function(player, npc)
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 1

	local itemGraphic = {graphic = convertGraphic(1554, "item"), color = 0}
	local songStr = {}
		songStr[1] = "..O the ocean's waves will roll.."
		songStr[2] = "..And the stormy winds will blow.."
		songStr[3] = "..While we poor sailors go skipping to the top.."
		songStr[4] = "..And the landlubbers lie down below.."

-- GREETINGS
	if (player.class == 13) then
		npc:talk(0, "Bard: "..player.name.."! I've missed your voice!")
		player:sendAnimation(197,1)
		npc:sendAction(14,50)
	else
		if (player.quest["rQ_Bard"] >= 6) then
			npc:talk(0, "Bard: Hello again, "..player.name..".")
			player:sendAnimation(197,1)
			npc:sendAction(14,50)
		else
			npc:talk(0, "Bard: Hello "..player.name..".")
			player:sendAnimation(197,1)
			npc:sendAction(14,50)
		end
	end
-- MAIN MENU :: MENU OPTIONS
	local npcMenuopts = {}
		if (player.class == 13) then
			table.insert(npcMenuopts, "- Warp to Circle")
		end
		table.insert(npcMenuopts,"About the Bards")
		if (player.class == 4 and (player.level >= 50)) then
			if (player.quest["poet_pickSubpath"] == 2) then
				table.insert(npcMenuopts, "- Join the Bards")
			elseif (player.quest["poet_pickSubpath"] == 1 and (player.quest["rQ_Bard"] <= 5)) then
				table.insert(npcMenuopts, "- A Bards Calling..")
			end
		end

-- MAIN MENU

	local menuChoice1 = player:menuString("Is there something I can help you with?", npcMenuopts)
	
	if (menuChoice1 == "- Warp to Circle") then
		player:warp(82, 65, 71)
	elseif (menuChoice1 == "About the Bards") then
		player:dialogSeq({npcA, "The Bards are a band of travelers who're most known for their songs, poetry and artworks.",
		npcA, "They use their musical talents to enhance their parties attributes."}, 0)
	elseif (menuChoice1 == "- Join the Bards") then
		player:dialogSeq({npcA, "Are you sure you want to join the Bard path?",
		npcA, "This is your last warning, once you make this decision it will be final."}, 1)
		local menuChoice2 = player:menuString("Are you POSITIVE you want to become a Bard?", {"Yes", "No"})
			if (menuChoice2 == "Yes") then
				player:removeLegendbyName("repSubQ_Druid")
				player:removeLegendbyName("repSubQ_Bard")
				player.class = 13
				player:addLegend("Inner potential of the Bard discovered. "..curT().."", "Bard_Joined", 96, 1)
				player:dialogSeq({npcA, "Very well then, let it be known throughout the Empire..",
				npcA, ""..player.name..", is now recognized as a Bard of Han."}, 1)
				broadcast(-1, "<~~~~ "..player.name..", has joined the Bard path. ~~~~>")
				local warpChoice = player:menuString("Would you like to warp to your new home?", {"Yes", "No"})
					if (warpChoice == "Yes") then
						player:warp(82, 65, 71)
					elseif (warpChoice == "No") then
						player:dialogSeq({npcA, "Alright.. Just don't forget where its located!",
							npcA, "Map Location: Northern Seong Range\nX-Coords: 65\nY-Coords: 71",
							npcA, "Welcome to the path, "..player.name.."!"}, 0)
					end
		elseif (menuChoice2 == "No") then
			player:dialogSeq({npcA, "You best take some more time to think of this matter."}, 0)
		end
	elseif (menuChoice1 == "- A Bards Calling..") then
		if (player.quest["rQ_Bard"] == 5) then
			player:removeItem("rep_bard", 1)
			player:dialogSeq({npcA, "So, ready to see if you can get them all in the right order?",
			npcA, "((Input what number you think each lyric is.. If you think its the FIRST line, put in 1. If you think its the third, put in 3.))"}, 1)
			local input1 = player:input(""..songStr[3].."")
				local input2 = player:input(""..songStr[2].."")
					local input3 = player:input(""..songStr[1].."")
						local input4 = player:input(""..songStr[4].."")
							if (input1 ~= "3") then
								player:popUp("No, that doesn't seem quite right.\n\nPlease try again.")
							else
								if (input2 ~= "2") then
									player:popUp("No, that doesn't seem quite right.\n\nPlease try again.")
								else
									if (input3 ~= "1") then
										player:popUp("No, that doesn't seem quite right.\n\nPlease try again.")
									else
										if (input4 ~= "4") then
											player:popUp("No, that doesn't seem quite right.\n\nPlease try again.")
										else
											player.quest["rQ_Bard"] = player.quest["rQ_Bard"] + 1
											player:addLegend("Has learned about the Bard path.", "repSubQ_Bard", 3, 1)
											player:dialogSeq({npcA, ""..songStr[1].."",
											npcA, ""..songStr[2].."",
											npcA, ""..songStr[3].."",
											npcA, ""..songStr[4].."",
											npcA, "Ah, what a wonderful melody.. Seems like you've got some talent yet!",
											npcA, "If your heart follow this calling, maybe the Bard path is where you belong."}, 0)
										end
									end
								end
							end
		elseif (player.quest["rQ_Bard"] >= 1 and (player.quest["rQ_Bard"] <= 4)) then
			player:dialogSeq({npcA, "You haven't found all of the melody pieces yet!",
				npcA, "Go visit the wandering Druid, he may share his insight with you.."}, 0)
		elseif (player.quest["rQ_Bard"] == 0 ) then
			local decision = player:menuString("So, you're interested in learning about the Bards?", {"Yes, I am.", "No. Nevermind."})
				if (decision == "Yes, I am.") then
					player:dialogSeq({npcA, "The Bards are a band of travellers who're most known for supporting their groups.",
					npcA, "They use their musical talents to enhance their group fighting abilities and defenses.",
					itemGraphic, "To prove you have any skills in this craft; take this beginners music instrument.",
					npcA, "Head off into the Empire and seek out anyone who can remember anything about this tool. Hopefully at least four will recall something..",
					npcA, "When you've found all four, come back and see me again.\n\nI've heard the Druid's are pretty knowledgeable, why not start there?"}, 1)
					local finaldecision = player:menuString("..what say you, are you up for it?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							if (player:hasSpace("rep_bard", 1) ~= true) then
								player:dialogSeq({npcA, "Your pack seems to be too full. Come back when you lighten your satchel."}, 0)	
							else
								player:addItem("rep_bard", 1)
								player.quest["rQ_Bard"] = player.quest["rQ_Bard"] + 1
								player:dialogSeq({itemGraphic, "Here is your instrument.\n\nReturn to me once you've heard all four lyrics."}, 0)
							end
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({npcA, "Alright, well come back when you feel up to the task."}, 0)
						end
			elseif (decision == "No. Nevermind.") then
				player:dialogSeq({npcA, "Oh well, maybe another time then."}, 0)
			end
		end

	end
end),

action = function(npc)
subrep_bard.move(npc)
end,

move = function(npc)
	local oldside = npc.side
	local checkmove = math.random(0,10)

	if ((npc.x - npc.startX) >= 5) then
		npc.side=3
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.x - npc.startX) <= -5) then
		npc.side=1
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.y - npc.startY) >= 5) then
		npc.side=0
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.y - npc.startY) <= -5) then
		npc.side=2
		npc:sendSide()
		npc:move()
		return
	end

	if(checkmove >= 4) then
		npc.side=math.random(0,3)
		npc:sendSide()
		if(npc.side == oldside) then
			npc:move()
		end
	else
		npc:move()
	end
end,

}
