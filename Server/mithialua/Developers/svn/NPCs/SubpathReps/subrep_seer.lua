subrep_seer = { 
click = async(function(player, npc)
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 1

	local itemGraphic = {graphic = convertGraphic(1025, "item"), color = 0}
	local rQ_Seer = player.quest["rQ_Seer"]
	local w_yname = Item(40313).yname
	local w_id = Item(40313).id

-- GREETINGS
	if (player.class == 11) then
		npc:talk(0, "Seer: "..player.name..", our Fate's weave together again.")
		player:sendAnimation(348,1)
		npc:sendAction(14,50)
	else
		if (player.quest["rQ_Seer"] >= 5) then
			npc:talk(0, "Seer: Hello again, "..player.name..".")
			player:sendAnimation(348,1)
			npc:sendAction(1,50)
		else
			npc:talk(0, "Seer: Hello "..player.name..".")
			player:sendAnimation(348,1)
			npc:sendAction(1,50)
		end
	end
-- MAIN MENU :: MENU OPTIONS
	local npcMenuopts = {}
		table.insert(npcMenuopts,"About the Seers")
		if (player.class == 11) then
			table.insert(npcMenuopts, "- Warp to Circle")
		elseif (player.class == 3 and (player.level >= 50)) then
			if (player.quest["mage_pickSubpath"] == 2) then
				table.insert(npcMenuopts, "- Join the Seers")
			elseif (player.quest["mage_pickSubpath"] == 1 and (player.quest["rQ_Seer"] <= 4)) then
				table.insert(npcMenuopts, "- A Seers Calling..")
			end
		end
-- MAIN MENU
	local menuChoice1 = player:menuString("Is there something I can help you with?", npcMenuopts)

		if (menuChoice1 == "About the Seers") then
			player:dialogSeq({npcA, "The Seers, a group of very wise mystics.",
				npcA, "Originally feared for their gifts, each Seer has the gift of a third-eye. Being able to divine things yet to come, they can use ones Fate against them."}, 0)
		elseif (menuChoice1 == "- Warp to Circle") then
			player:warp(15, 81, 108)
		elseif (menuChoice1 == "- Join the Seers") then
			player:dialogSeq({npcA, "Are you sure you want to join the Seer path?"}, 1)
			local menuChoice2 = player:menuString("Once you confirm this, you wont be able to choose to become a Elementalist..", {"Yes, I know.", "No, I need more time."})
				if (menuChoice2 == "Yes, I know.") then
					player:removeLegendbyName("repSubQ_Elementalist")
					player:removeLegendbyName("repSubQ_Seer")
					player.class = 11
					player:addLegend("Inner potential of the Seer discovered. "..curT().."", "Seer_Joined", 202, 1)
					player:dialogSeq({npcA, "Very well then, let it be known throughout the Empire..",
					npcA, ""..player.name..", is now recognized as a Seer of Han."}, 1)
					broadcast(-1, "<~~~~ "..player.name..", has joined the Seer path. ~~~~>")
					local warpChoice = player:menuString("Would you like to warp to your new home?", {"Yes", "No"})
						if (warpChoice == "Yes") then
							player:warp(15, 81, 108)
						elseif (warpChoice == "No") then
							player:dialogSeq({npcA, "Alright.. Just don't forget where its located!",
							npcA, "Map Location: Imperial City of Han\nX-Coords: 81\nY-Coords: 108",
							npcA, "Welcome to the path, "..player.name.."!"}, 0)
						end
				elseif (menuChoice2 == "No, I need more time.") then
					player:dialogSeq({npcA, "Very well, come back when you've made a solid decision."}, 0)
				end
		elseif (menuChoice1 == "- A Seers Calling..") then
			if (player.quest["rQ_Seer"] == 4) then
				player.registry["rQ_seerT1"] = 0
				player.registry["rQ_seerT2"] = 0
				player.registry["rQ_seerT3"] = 0
				player:removeItem(""..w_yname.."", 1)
				player.quest["rQ_Seer"] = player.quest["rQ_Seer"] + 1
				player:addLegend("Has learned about the Seer path.", "repSubQ_Seer", 3, 1)
				player:dialogSeq({npcA, "So, did everyone have a good reading?",
				npcA, "WHAT?! You foretold Gemcutter Pongi was going to die?!",
				npcA, "Well, I'll do their reading once again just to be sure but that doesn't look too promising.",
				npcA, "Should curiosity bring you back, we're always willing to accept new path members."}, 0)
			elseif (player.quest["rQ_Seer"] >= 1 and (player.quest["rQ_Seer"] <= 3)) then
				player:dialogSeq({npcA, "Are you sure you've visited everyone? You need to preform readings for the following;\n\nAlchemist Tak, in Pinyan.\nGemcutter Pongi, in Han.\nButcher Roharth, in Han."}, 0)
			elseif (player.quest["rQ_Seer"] == 0 ) then
				local decision = player:menuString("So, you're interested in the Seers?", {"Yes, I am.", "No. Nevermind."})
				if (decision == "Yes, I am.") then
					player:dialogSeq({npcA, "To prove your worth, I have a small task for you.",
					npcA, "Seers are mystics, given a gift at birth. They're known as ones who can see into the future.",
					itemGraphic, "Let us see what powers you have, take this Crystal Ball and go into town.",
					npcA, "I originally had intended to preform these readings myself, but as peoples requests are flooding in I do not have the time to see everyone myself.",
					npcA, "When you get to town, visit with these three members;\nAlchemist Tak, in Pinyan.\nGemcutter Pongi, in Han.\nButcher Roharth, in Han.",
					itemGraphic, "Use the Crystal Ball and divine their Fate. Once you've seen to all three, bring the crystal back to me and tell me of your tales."}, 1)
					local finaldecision = player:menuString3("..what say you, are you up for it?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							if (player:hasSpace(""..w_yname.."", 1) ~= true) then
								player:dialogSeq({npcA, "Your pack seems to be too full. Come back when you lighten your satchel."}, 0)	
							else
								player.quest["rQ_Seer"] = player.quest["rQ_Seer"] + 1
								player:addItem(""..w_yname.."", 1)
								player:dialogSeq({itemGraphic, "Here is your Crystal Ball, be careful not to lose it.",
								npcA, "The ones you need to see again are;\n\nAlchemist Tak, in Pinyan.\nGemcutter Pongi, in Han.\nButcher Roharth, in Han."}, 0)
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
subrep_seer.move(npc)
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
