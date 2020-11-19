subrep_druid = { 
click = async(function(player, npc)
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 1

	local treeGraphic = {graphic = convertGraphic(755, "monster"), color = 0}
	local itemGraphic = {graphic = convertGraphic(1961, "item"), color = 0}
	local elderspiritGraphic = {graphic = convertGraphic(767, "monster"), color = 30}

-- GREETINGS
	if (player.class == 12) then
		npc:talk(0, "Druid: "..player.name..", it is good to see a familiar face again.")
		player:sendAnimation(15,1)
		npc:sendAction(6,50)
	else
		if (player.quest["rQ_Druid"] >= 7) then
			npc:talk(0, "Druid: Hello again, "..player.name..".")
			player:sendAnimation(15,1)
			npc:sendAction(6,50)
		else
			npc:talk(0, "Druid: Hello "..player.name..".")
			player:sendAnimation(15,1)
			npc:sendAction(6,50)
		end
	end
-- MAIN MENU :: MENU OPTIONS
	local npcMenuopts = {}
		table.insert(npcMenuopts, "About the Druids")			
		if (player.class == 12) then
			table.insert(npcMenuopts, "- Warp to Circle")
		elseif (player.class == 4 and player.level >= 50) then		
			if (player.quest["poet_pickSubpath"] == 2) then
				table.insert(npcMenuopts, "- Join the Druids")
			elseif (player.quest["poet_pickSubpath"] == 1 and (player.quest["rQ_Druid"] <= 6)) then
				table.insert(npcMenuopts, "- A Druids Calling..")
			end
		end

-- MAIN MENU
	local menuChoice1 = player:menuString("Is there something I can help you with?", npcMenuopts)

	if (menuChoice1 == "- Warp to Circle") then
		player:warp(74, 56, 103)
	elseif (menuChoice1 == "About the Druids") then
		player:dialogSeq({elderspiritGraphic, "The Druids are people who've been granted blessings by the Elder Spirit.",
		npcA, "Not simply attuned with nature, but devoted to it. Each Druid's spirit has been bound to an Ent, a colossal tree."}, 0)
	elseif (menuChoice1 == "- Join the Druids") then
		player:dialogSeq({npcA, "Are you sure you want to join the Druid path?",
		npcA, "This is your last warning, once you make this decision it will be final."}, 1)
		local menuChoice2 = player:menuString("Are you POSITIVE you want to become a Druid?", {"Yes", "No"})
			if (menuChoice2 == "Yes") then
				player:removeLegendbyName("repSubQ_Druid")
				player:removeLegendbyName("repSubQ_Bard")
				player.class = 12
				player:addLegend("Inner potential of the Druid discovered. "..curT().."", "Druid_Joined", 130, 1)
				player:dialogSeq({npcA, "Very well then, let it be known throughout the Empire..",
				npcA, ""..player.name..", is now recognized as a Druid of Han."}, 1)
				broadcast(-1, "<~~~~ "..player.name..", has joined the Druid path. ~~~~>")
				local warpChoice = player:menuString("Would you like to warp to your new home?", {"Yes", "No"})
					if (warpChoice == "Yes") then
						player:warp(74, 56, 103)
					elseif (warpChoice == "No") then
						player:dialogSeq({npcA, "Alright.. Just don't forget where its located!",
						npcA, "Map Location: Vogt Forest\nX-Coords: 55\nY-Coords: 101",
						npcA, "Welcome to the path, "..player.name.."!"}, 0)
					end
			elseif (menuChoice2 == "No") then
				player:dialogSeq({npcA, "You best take some more time to think of this matter."}, 0)
			end					
	elseif (menuChoice1 == "- A Druids Calling..") then
		if (player.quest["rQ_Druid"] == 6) then
			local cWeap = player:getEquippedItem(EQ_WEAP)		
				if (cWeap ~= nil) then
					if (cWeap.id == Item(40310).id) then
						player:dialogSeq({npcA, "You seem to still be wielding the flowers."}, 0)
					else
						if (player:hasItem("rep_druid",	1) == true) then
							player:removeItem("rep_druid", 1)
							player.quest["rQ_Druid"] = player.quest["rQ_Druid"] + 1
							player:addLegend("Has learned about the Druid path.", "repSubQ_Druid", 3, 1)
							player:dialogSeq({npcA, "I see you have made it in one piece.",
							elderspiritGraphic, "The Elder Spirits seem pleased with your actions and have grown to like you.",
							npcA, "You have the makings of a Druid..\n\n\n..should you ever join our path, you have the Elder Spirits approval."}, 0)
						else
							player:dialogSeq({npcA, "You seem to have misplaced your flowers.."}, 0)
						end
					end
				else
					if (player:hasItem("rep_druid", 1) == true) then
						player:removeItem("rep_druid", 1)
						player.quest["rQ_Druid"] = player.quest["rQ_Druid"] + 1
						player:addLegend("Has learned about the Druid path.", "repSubQ_Druid", 3, 1)
						player:dialogSeq({npcA, "I see you have made it in one piece.",
						elderspiritGraphic, "The Elder Spirits seem pleased with your actions and have grown to like you.",
						npcA, "You have the makings of a Druid..\n\n\n..should you ever join our path, you have the Elder Spirits approval."}, 0)
					else
						player:dialogSeq({npcA, "You seem to have misplaced your flowers.."}, 0)
					end
				end					
		elseif (player.quest["rQ_Druid"] >= 1 and player.quest["rQ_Druid"] <= 5) then
			player:dialogSeq({npcA, "You haven't finished blessing the tree's yet. Come back after you've visited them all."}, 0)
		elseif (player.quest["rQ_Druid"] == 0) then
			local decision = player:menuString("So, you're interested in learning about the Druids?", {"Yes, I am.", "No. Never mind."})
			if (decision == "Yes, I am.") then
				player:dialogSeq({npcA, "To experience what we are as a path, take this blessed flower..",
				npcA, "..head off into the Empire and seek out first, the Elm Tree.",
				treeGraphic, "Citizens often cut them down and salvage the wood.\n\nIn order to pay respects, we ask you honor their presence.",
				itemGraphic, "Go and shake the flowers at the tree, blessing the tree's Spirit.\n\n((Swing at the tree.))",
				npcA, "Do this and you will know show your respects to the Elder Spirit and Druid path."}, 1)
				local finaldecision = player:menuString("..what say you, are you up for it?", {"Yes, I am.", "No thanks."})			
					if (finaldecision == "Yes, I am.") then	
						if (player:hasSpace("rep_druid", 1) ~= true) then
							player:dialogSeq({npcA, "Your pack seems to be too full. Come back when you lighten your satchel."}, 0)	
						else
							player:addItem("rep_druid", 1)
							player.quest["rQ_Druid"] = player.quest["rQ_Druid"] + 1
							player:dialogSeq({treeGraphic, "Here is your bushel of flowers, head out and start your blessings at the Elm Tree.",
							npcA, "Return to me once you've seen to all of the trees."}, 0)		
						end
					elseif (finaldecision == "No thanks.") then
						player:dialogSeq({npcA, "Alright, well come back when you feel up to the task."}, 0)	
					end
			elseif (decision == "No. Never mind.") then
				player:dialogSeq({npcA, "Oh well, maybe another time then."}, 0)	
			end
		end

	end
end),

action = function(npc)
subrep_druid.move(npc)
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
