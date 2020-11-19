subrep_shadow = { 
click = async(function(player, npc)
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 1

-- GREETINGS
	if (player.class == 8) then
		npc:talk(0, "Shadow: ..*nods a greeting to "..player.name.."*..")
		player:sendAnimation(16,1)
		npc:sendAction(122,50)
	else
		if (player.quest["rQ_Shadow"] >= 7) then
			npc:talk(0, "Shadow: .."..player.name.."..")
			player:sendAnimation(122,1)
			npc:sendAction(1,50)
		else
			npc:talk(0, "Shadow: .."..player.name.."..")
			player:sendAnimation(122,1)
			npc:sendAction(1,50)
		end
	end
-- MAIN MENU :: MENU OPTIONS
	local npcMenuopts = {}
		if (player.class == 8) then
			table.insert(npcMenuopts, "- Warp to Circle")
		end
		table.insert(npcMenuopts, "About the Shadows")			
		if (player.class == 2 and player.level >= 50) then
			if (player.quest["rogue_pickSubpath"] == 2) then
				table.insert(npcMenuopts, "- Join the Shadows")
			elseif (player.quest["rogue_pickSubpath"] == 1 and (player.quest["rQ_Shadow"] <= 2)) then
				table.insert(npcMenuopts, "- A Shadows Calling..")
			end
		end

	local birdGraphic = {graphic = convertGraphic(961, "monster"), color = 0}
	local itemGraphic = {graphic = convertGraphic(2825, "item"), color = 28}
	local rQ_Shadow = player.quest["rQ_Shadow"]
-- MAIN MENU
	local menuChoice1 = player:menuString("Is there something I can help you with?", npcMenuopts)

	if (menuChoice1 == "- Warp to Circle") then
		player:warp(37, 2, 53)
	elseif (menuChoice1 == "About the Shadows") then
		player:dialogSeq({npcA, "The Shadows are an elusive bunch.\n\nBest known as true assassins, they're the ones hiding within the darkness.",
		npcA, "With extreme precision, they hatch their plans from the dark shadows.\n\nManipulate their prey like puppets."}, 0)
	elseif (menuChoice1 == "- Join the Shadows") then
		player:dialogSeq({npcA, "Are you sure you want to join the Shadow path?"}, 1)
		local menuChoice2 = player:menuString("Once you confirm this, you wont be able to choose to become a Archer..", {"Yes, I know.", "No, I need more time."})
			if (menuChoice2 == "Yes, I know.") then
				player:removeLegendbyName("repSubQ_Archer")
				player:removeLegendbyName("repSubQ_Shadow")
				player.class = 8
				player:addLegend("Inner potential of the Shadow discovered. "..curT().."", "Shadow_Joined", 22, 1)
				player:dialogSeq({npcA, "Very well then, let it be known throughout the Empire..",
				npcA, ""..player.name..", is now recognized as a Shadow of Han."}, 1)
				broadcast(-1, "<~~~~ "..player.name..", has joined the Shadow path. ~~~~>")
				local warpChoice = player:menuString("Would you like to warp to your new home?", {"Yes", "No"})
					if (warpChoice == "Yes") then
						player:warp(37, 2, 53)
					elseif (warpChoice == "No") then
						player:dialogSeq({npcA, "Alright.. Just don't forget where its located!",
						npcA, "Map Location: Dor Nalan Wilds\nX-Coords: 2\nY-Coords: 53",
						npcA, "Welcome to the path, "..player.name.."!"}, 0)
					end
			elseif (menuChoice2 == "No, I need more time.") then
				player:dialogSeq({npcA, "Very well, come back when you've made a solid decision."}, 0)
			end
	elseif (menuChoice1 == "- A Shadows Calling..") then
		if (player.quest["rQ_Shadow"] == 2) then					
			player:removeItem("rep_shadowglove", 1)
			player:removeItem("rep_shadowfeather", 1)			
			player.quest["rQ_Shadow"] = player.quest["rQ_Shadow"] + 1
			player:addLegend("Has learned about the Shadow path.", "repSubQ_Shadow", 3, 1)
			player:dialogSeq({npcA, "Huh, so you actually did it. I'm surprised, mind you it was such a menial task.",
			npcA, "Well, now that you've passed our little hazing. I suppose you could use my name down the road, if you wanted to be part of the Shadow path.",
			npcA, "This doesn't make us best-buddies however! Remember that!"}, 0)
		elseif (player.quest["rQ_Shadow"] == 1) then
			player:dialogSeq({npcA, "You don't have a feather from that paranoid bird yet!\n\nGo back and pluck one using the Black Glove I gave you!"}, 0)
		elseif (player.quest["rQ_Shadow"] == 0) then
			local decision = player:menuString("So, you're interested in learning about the Shadows?", {"Yes, I am.", "No. Never mind."})
			if (decision == "Yes, I am.") then
				player:dialogSeq({npcA, "Well before you can learn anything about us, I have a simple task for you.",
				npcA, "All you need to do is prove to me you can be stealthy, quick natured, and be able to think on your feet.",
				birdGraphic, "Venture out into the Dor Nalan Wilds, there you'll find a bird just below the temple and hall. He has become so paranoid from people plucking his plumes he cannot settle down.",
				itemGraphic, "Using your basic abilities as a rogue, conceal your presence and using this glove, grab one of his feathers.",
				npcA, "That should be easy enough, even you could do it.."}, 1)
				local finaldecision = player:menuString("..what say you, are you up for it?", {"Yes, I am.", "No, thanks."})
				if (finaldecision == "Yes, I am.") then	
					if (player:hasSpace("rep_shadowglove", 1) ~= true) then
						player:dialogSeq({npcA, "Your pack seems to be too full. Come back when you lighten your satchel."}, 0)
					else
						player:addItem("rep_shadowglove", 1)
						player.quest["rQ_Shadow"] = player.quest["rQ_Shadow"] + 1
						player:dialogSeq({npcA, "Excellent!\nHere is your glove.\n\nOnce you have a feather, bring it back to me and we'll see about teaching you things."}, 0)
					end
				elseif (finaldecision == "No, thanks.") then
					player:dialogSeq({npcA, "Alright, well come back when you feel up to the task."}, 0)
				end
			elseif (decision == "No. Never mind.") then
				player:dialogSeq({npcA, "Oh well, maybe another time then."}, 0)	
			end
		end
	end
end),

action = function(npc)
subrep_shadow.move(npc)
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
