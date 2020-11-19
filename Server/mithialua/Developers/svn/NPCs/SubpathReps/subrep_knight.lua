subrep_knight = { 
click = async(function(player, npc)
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 1

	local fatherGraphic = {graphic = convertGraphic(839, "monster"), color = 0}
	local daughterGraphic = {graphic = convertGraphic(960, "monster"), color = 0}

-- GREETINGS
	if (player.class == 6) then
		npc:talk(0, "Knight: "..player.name.."!")
		player:sendAction(11,50)
		npc:sendAction(10,50)
		player:sendAnimation(11,1)
	else
		if (player.quest["rQ_Knight"] >= 6) then
			npc:talk(0, "Knight: Hello again, "..player.name.."!")
			player:sendAction(11,50)
			npc:sendAction(10,50)
			player:sendAnimation(11,1)
		else
			npc:talk(0, "Knight: Hello "..player.name.."!")
			player:sendAction(11,50)
			npc:sendAction(10,50)
			player:sendAnimation(11,1)
		end
	end
-- MAIN MENU :: MENU OPTIONS
	local npcMenuopts = {}
		if (player.class == 6) then
			table.insert(npcMenuopts, "- Warp to Circle")
		end
		table.insert(npcMenuopts,"About the Knights")
		if (player.class == 1 and player.level >= 50) then
			if (player.quest["warrior_pickSubpath"] == 2) then
				table.insert(npcMenuopts, "- Join the Knights")
			elseif (player.quest["warrior_pickSubpath"] == 1 and (player.quest["rQ_Knight"] <= 2)) then
				table.insert(npcMenuopts, "- A Knights Calling..")
			end
		end

-- MAIN MENU
	local menuChoice1 = player:menuString("Is there something I can help you with?", npcMenuopts)

		if (menuChoice1 == "About the Knights") then
			player:dialogSeq({npcA, "Knights are the noble fighters of Han.\n\nFighting for justice and to protect the Empire's people, they stand in the pathway of evil.",
				npcA, "Casting judgment with their mighty swords, they excel in the strategy of endurance and defense."}, 0)
		elseif (menuChoice1 == "- Warp to Circle") then
			player:warp(15, 103, 113)
		elseif (menuChoice1 == "- Join the Knights") then
			player:dialogSeq({npcA, "Are you sure you want to join the Knight path?"}, 1)
			local menuChoice2 = player:menuString("Once you confirm this, you wont be able to choose to become a Gladiator..", {"Yes, I know.", "No, I need more time."})
				if (menuChoice2 == "Yes, I know.") then
					player:removeLegendbyName("repSubQ_Knight")
					player:removeLegendbyName("repSubQ_Gladiator")
					player.class = 6
					player:addLegend("Inner potential of the Knight discovered. "..curT().."", "Knight_Joined", 149, 1)
					player:dialogSeq({npcA, "Very well then, let it be known throughout the Empire..",
					npcA, ""..player.name..", is now recognized as a Knight of Han."}, 1)
					broadcast(-1, "<~~~~ "..player.name..", has joined the Knight path. ~~~~>")
					local warpChoice = player:menuString("Would you like to warp to your new home?", {"Yes", "No"})
						if (warpChoice == "Yes") then
							player:warp(15, 103, 113)
						elseif (warpChoice == "No") then
							player:dialogSeq({npcA, "Alright.. Just don't forget where its located!",
							npcA, "Map Location: Imperial City of Han\nX-Coords: 103\nY-Coords: 113",
							npcA, "Welcome to the path, "..player.name.."!"}, 0)
						end
				elseif (menuChoice2 == "No, I need more time.") then
					player:dialogSeq({npcA, "Very well, come back when you've made a solid decision."}, 0)
				end
		elseif (menuChoice1 == "- A Knights Calling..") then
			if (player.quest["rQ_Knight"] == 2) then
				player.quest["rQ_Knight"] = player.quest["rQ_Knight"] + 1
				player:addLegend("Has learned about the Knight path.", "repSubQ_Knight", 3, 1)
				player:dialogSeq({daughterGraphic, "His daughter was lost?!\n\nBy the way the report was worded, we thought it was a menial task not a missing person!",
				npcA, "Good work "..player.name..", you have the true workings of a Knight.",
				npcA, "If you find yourself looking for a home of respectable individuals like yourself, look no further. A Knight is your calling!"}, 0)
			elseif (player.quest["rQ_Knight"] == 1) then
				player:dialogSeq({npcA, "I haven't heard anything about you helping that man yet.\n\nHave you gone to see him in the Vogt Forest? He resides in the Apple Orchard."}, 0)
			elseif (player.quest["rQ_Knight"] == 0) then
				local decision = player:menuString("So, you're interested in the Knights?", {"Yes, I am.", "No. Nevermind."})
				if (decision == "Yes, I am.") then
					player:dialogSeq({npcA, "Knights are a true and noble people. We stand for courage, victory and justice."}, 1)
					player.lastClick = NPC(138).ID
					player:dialogSeq({fatherGraphic, "To show us your courage, go out and help the townsfolk.\n\nThere has been word of Jong'yul, a man just outside of the South Wall, near the Apple Orchard.."}, 1)
					player.lastClick = NPC(136).ID
					player:dialogSeq({npcA, "It seems he has some trouble going on, go out and offer your aid to this man."}, 1)
					local finaldecision = player:menuString("..what say you, are you up for it?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["rQ_Knight"] = player.quest["rQ_Knight"] + 1
							player.lastClick = NPC(138).ID
							player:dialogSeq({fatherGraphic, "Good, head out to the Vogt Forest and speak with Jong'yul.\n\nI'll be waiting for your report here."}, 0)
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
subrep_knight.move(npc)
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
