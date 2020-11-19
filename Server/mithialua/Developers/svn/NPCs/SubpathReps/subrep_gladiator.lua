subrep_gladiator = { 
click = async(function(player, npc)
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 1

	local itemGraphic = {graphic = convertGraphic(3963, "item"), color = 17}

-- GREETINGS
	if (player.class == 7) then
		npc:talk(1, "Gladiator: "..player.name.."!")
		player:sendAction(17,50)
		npc:sendAction(18,50)
		player:sendAnimation(11,1)
	else
		if (player.quest["rQ_Gladiator"] >= 6) then
			npc:talk(1, "Gladiator: Hello again, "..player.name.."!")
			player:sendAction(17,50)
			npc:sendAction(18,50)
			player:sendAnimation(11,1)
		else
			npc:talk(1, "Gladiator: Hello "..player.name.."!")
			player:sendAction(17,50)
			npc:sendAction(18,50)
			player:sendAnimation(11,1)
		end
	end
-- MAIN MENU :: MENU OPTIONS
	local npcMenuopts = {}
		if (player.class == 7) then
			table.insert(npcMenuopts, "- Warp to Circle")
		end
		table.insert(npcMenuopts,"About the Gladiators")
		if (player.class == 1 and player.level >= 50) then
			if (player.quest["warrior_pickSubpath"] == 2) then
				table.insert(npcMenuopts, "- Join the Gladiators")
			elseif (player.quest["warrior_pickSubpath"] == 1 and (player.quest["rQ_Gladiator"] <= 1)) then
				table.insert(npcMenuopts, "- A Gladiators Calling..")
			end
		end

-- MAIN MENU

	local menuChoice1 = player:menuString("Is there something I can help you with?", npcMenuopts)

		if (menuChoice1 == "- Warp to Circle") then
			player:warp(82, 22, 7)
		elseif (menuChoice1 == "About the Gladiators") then
			player:dialogSeq({npcA, "Gladiators are extremely meticulous fighters.\n\nWhile being trained in the art of face-to-face combat, they are best suited amongst the battlefield.",
			npcA, "With brute strength, incredible frenzy talents and raging pride..\n\nThey're eager to prove their merits."}, 0)
		elseif (menuChoice1 == "- Join the Gladiators") then
			player:dialogSeq({npcA, "Are you sure you want to join the Gladiator path?"}, 1)
			local menuChoice2 = player:menuString("Once you confirm this, you will not be able to choose join the Knights..", {"Yes, I know.", "No, I need more time."})
				if (menuChoice2 == "Yes, I know.") then
					player:removeLegendbyName("repSubQ_Gladiator")
					player:removeLegendbyName("repSubQ_Knight")
					player.class = 7
					player:addLegend("Inner potential of the Gladiator discovered. "..curT().."", "Gladiator_Joined", 51, 1)
					player:dialogSeq({npcA, "Very well then, let it be known throughout the Empire..",
					npcA, ""..player.name..", is now recognized as a Gladiator of Han."}, 1)
					broadcast(-1, "<~~~~ "..player.name..", has joined the Gladiator path. ~~~~>")
					local warpChoice = player:menuString("Would you like to warp to your new home?", {"Yes", "No"})
						if (warpChoice == "Yes") then
							player:warp(82, 22, 7)
						elseif (warpChoice == "No") then
							player:dialogSeq({npcA, "Alright.. Just don't forget where its located!",
							npcA, "Map Location: Northern Seong Range\nX-Coords: 22\nY-Coords: 7",
							npcA, "Welcome to the path, "..player.name.."!"}, 0)
						end
				elseif (menuChoice2 == "No, I need more time.") then
					player:dialogSeq({npcA, "Very well, come back when you've made a solid decision."}, 0)
				end
		elseif (menuChoice1 == "- A Gladiators Calling..") then
			if (player.quest["rQ_Gladiator"] == 1) then
				if (player:hasItem("rep_gladiator2", 1) == true) then
					player:removeItem("rep_gladiator2", 1)
					player.quest["rQ_Gladiator"] = player.quest["rQ_Gladiator"] + 1
					player:addLegend("Has learned about the Gladiator path.", "repSubQ_Gladiator", 3, 1)
					player:dialogSeq({npcA, "Hahahaha! Good job!\n\nThe first steps of acknowledgement from our path has begun.",
					npcA, "Come back and see me again if you desire to join our path in the future."}, 1)
				else
					player:dialogSeq({npcA, "Hah, you haven't made your rage subdue yet. Get another mirror and try again.\n\nYou need to be at the lava pits in Vogt Forest to call out your rage."}, 0)
				end
			elseif (player.quest["rQ_Gladiator"] == 0) then
				local decision = player:menuString("So, you're interested in the Gladiators?", {"Yes, I am.", "No. Nevermind."})
				if (decision == "Yes, I am.") then
					player:dialogSeq({npcA, "You? Really?\n\nYou think you're strong enough to be a Gladiator?",
					npcA, "Alright, well.. I suppose we could test your abilities. I mean, to see if you have any that is.",
					npcA, "Each Gladitor fights with their own rage, it fills their body and is an extension of themselves on the battlefield.",
					itemGraphic, "Take this mirror, it has been enchanted by the Seers of Han.\n\nWhen you use it, it will summon your rage into a physical form before you.",
					npcA, "Battle with it, make it subdue to your power.\n\nOnce you contain and defeat it, come back and see me."}, 1)
					local finaldecision = player:menuString("..what say you, are you up for it?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							if (player:hasSpace("rep_gladiator", 1) ~= true) then
								player:dialogSeq({npcA, "Your pack seems to be too full. Come back when you lighten your satchel."}, 0)
							else
								player:addItem("rep_gladiator", 1)
								player.quest["rQ_Gladiator"] = player.quest["rQ_Gladiator"] + 1
								player:dialogSeq({itemGraphic, "Excellent, take this mirror and go off to the Vogt Forest.\n\nOnce there, use the mirror around the burning trees in the lava pits.",
								npcA, "Try not to lose to yourself, I know it wont be the easiest task."}, 0)
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
subrep_gladiator.move(npc)
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