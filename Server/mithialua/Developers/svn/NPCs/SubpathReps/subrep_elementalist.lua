subrep_elementalist = { 
click = async(function(player, npc)
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 1

	local itemGraphic = {graphic = convertGraphic(1715, "item"), color = 0}
	local rQ_Elementalist = player.quest["rQ_Elementalist"]
	local w_yname = Item(40315).yname
	local w_id = Item(40315).id

-- GREETINGS
	if (player.class == 10) then
		npc:talk(0, "Elementalist: Aha! Elementalist "..player.name.."!")
		npc:talk(0, "Elementalist: It is good to see a you again!")
		player:sendAnimation(422,1)
		npc:sendAction(11,50)
	else
		if (player.quest["rQ_Elementalist"] >= 6) then
			npc:talk(0, "Elementalist: Hello again, "..player.name..".")
			player:sendAnimation(422,1)
			npc:sendAction(11,50)
		else
			npc:talk(0, "Elementalist: Hello "..player.name..".")
			player:sendAnimation(422,1)
			npc:sendAction(11,50)
		end
	end
-- MAIN MENU :: MENU OPTIONS
	local npcMenuopts = {}
		table.insert(npcMenuopts,"About the Elementalists")
		if (player.class == 10) then
			table.insert(npcMenuopts, "- Warp to Circle")
		elseif (player.class == 3 and (player.level >= 50)) then
			if (player.quest["mage_pickSubpath"] == 2) then
				table.insert(npcMenuopts, "- Join the Elementalists")
			elseif (player.quest["mage_pickSubpath"] == 1 and (player.quest["rQ_Elementalist"] <= 5)) then
				table.insert(npcMenuopts, "- A Elementalists Calling..")
			end
		end

-- MAIN MENU
	local menuChoice1 = player:menuString("Is there something I can help you with?", npcMenuopts)

	if (menuChoice1 == "About the Elementalists") then
		player:dialogSeq({npcA, "Elementalists, these are magicians who have come to obtain powers from the Elemental Spirits.",
			npcA, "From summoning earth constructs, to bewitching elemental entities to do their bidding. The Elementalists are the Elements balancer."}, 0)
	elseif (menuChoice1 == "- Warp to Circle") then
		player:warp(74, 94, 67)
	elseif (menuChoice1 == "- Join the Elementalists") then
		player:dialogSeq({npcA, "Are you sure you want to join the Elementalist path?"}, 1)
		local menuChoice2 = player:menuString("Once you confirm this, you wont be able to choose to become a Seer..", {"Yes, I know.", "No, I need more time."})
			if (menuChoice2 == "Yes, I know.") then
				player:removeLegendbyName("repSubQ_Elementalist")
				player:removeLegendbyName("repSubQ_Seer")
				player.class = 10
				player:addLegend("Inner potential of the Elementalist discovered. "..curT().."", "Elementalist_Joined", 145, 1)
				player:dialogSeq({npcA, "Very well then, let it be known throughout the Empire..",
				npcA, ""..player.name..", is now recognized as a Elementalist of Han."}, 1)
				broadcast(-1, "<~~~~ "..player.name..", has joined the Elementalist path. ~~~~>")
				local warpChoice = player:menuString("Would you like to warp to your new home?", {"Yes", "No"})
					if (warpChoice == "Yes") then
						player:warp(74, 94, 67)
					elseif (warpChoice == "No") then
						player:dialogSeq({npcA, "Alright.. Just don't forget where its located!",
						npcA, "Map Location: Vogt Forest\nX-Coords: 94\nY-Coords: 67",
						npcA, "Welcome to the path, "..player.name.."!"}, 0)
					end
			elseif (menuChoice2 == "No, I need more time.") then
				player:dialogSeq({npcA, "Very well, come back when you've made a solid decision."}, 0)
			end
	elseif (menuChoice1 == "- A Elementalists Calling..") then
		if (player.quest["rQ_Elementalist"] == 5) then
			player.registry["rQ_elementalistT1"] = 0
			player.registry["rQ_elementalistT2"] = 0
			player.registry["rQ_elementalistT3"] = 0
			player.registry["rQ_elementalistT4"] = 0
			player:removeItem(""..w_yname.."", 1)
			player.quest["rQ_Elementalist"] = player.quest["rQ_Elementalist"] + 1
			player:addLegend("Has learned about the Elementalist path.", "repSubQ_Elementalist", 3, 1)
			player:dialogSeq({npcA, "Amazing, I cannot believe you found all four spirits so easily!",
			npcA, "You must have the blood connection with the Elements after all. Astonishing!",
			npcA, "If you care to hone those skills, our tribe is always looking for new kin."}, 0)

		elseif (player.quest["rQ_Elementalist"] >= 1 and (player.quest["rQ_Elementalist"] <= 4)) then
			player:dialogSeq({npcA, "You haven't found all of the spirits yet. Don't come back until you've found them all!",
			npcA, "The Spirit Locations;\n\nDor Nalan Wilds,\nVogt Forest,\nSeong Lowlands,\nPalace Throne Room."}, 0)

		elseif (player.quest["rQ_Elementalist"] == 0) then
			local decision = player:menuString("So, you're interested in the Elementalists?", {"Yes, I am.", "No. Nevermind."})
			if (decision == "Yes, I am.") then
				player:dialogSeq({npcA, "If you have any magical talent at all, you should be able to find a few Spirits of the Elements.",
				npcA, "Take this orb and venture out into neighboring lands of Han. It will help you locate an Elemental Spirit. When found, try to convince it of your powers.",
				itemGraphic, "Once you've found one of each spirit, bring the orb back to me and we'll see if the Elementals favor you or not.",
				npcA, "There has been spirits witnessed in the Dor Nalan Wilds, Vogt Forest, Seong Lowlands, and even in the Palace's Throne Room."}, 1)
				local finaldecision = player:menuString3("..what say you, are you up for it?", {"Yes, I am.", "No thanks."})
					if (finaldecision == "Yes, I am.") then
						if (player:hasSpace(""..w_yname.."", 1) ~= true) then
							player:dialogSeq({npcA, "Your pack seems to be too full. Come back when you lighten your satchel."}, 0)	
						else
							player:addItem(""..w_yname.."", 1)
							player.quest["rQ_Elementalist"] = player.quest["rQ_Elementalist"] + 1
							player:dialogSeq({itemGraphic, "Here is your orb, remember to find one of each spirit before coming back to me.",
							npcA, "The Spirit Locations;\n- Dor Nalan Wilds,\n- Vogt Forest,\n- Seong Lowlands,\n- Han Palace, Throne Room."}, 0)
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
subrep_elementalist.move(npc)
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