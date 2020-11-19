subrep_archer = { 
click = async(function(player, npc)
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 1

	local itemLeaf = {graphic = convertGraphic(2909, "item"), color = 9}

-- GREETINGS
	if (player.class == 9) then
		npc:talk(0, "Archer: "..player.name..", what a joyous surprise!")
		player:sendAnimation(16,1)
		npc:sendAction(241,50)
	else
		if (player.quest["rQ_Archer"] >= 3) then
			npc:talk(0, "Archer: Hello again, "..player.name..".")
			player:sendAnimation(241,1)
			npc:sendAction(1,50)
		else
			npc:talk(0, "Archer: Hello "..player.name..".")
			player:sendAnimation(241,1)
			npc:sendAction(1,50)
		end
	end
-- MAIN MENU :: MENU OPTIONS
	local npcMenuopts = {}
		if (player.class == 9) then
			table.insert(npcMenuopts, "- Warp to Circle")
		end
		table.insert(npcMenuopts,"About the Archers")
		if (player.class == 2 and player.level >= 50) then
			if (player.quest["rogue_pickSubpath"] == 2) then
				table.insert(npcMenuopts, "- Join the Archers")
			elseif (player.quest["rogue_pickSubpath"] == 1 and (player.quest["rQ_Archer"] <= 2)) then
				table.insert(npcMenuopts, "- An Archers Calling..")
			end
		end
-- MAIN MENU
	local menuChoice1 = player:menuString("Is there something I can help you with?", npcMenuopts)

	if (menuChoice1 == "About the Archers") then
		player:dialogSeq({npcA, "The Archers are a talented group, their skills with a bow would astound you.\n\nAs foragers of the land, they're often found traversing the lands and gathering treasures.",
			npcA, "Due to their mid-to-long range training, they're usually found off in the distance.\n\nJust because they're not next to you doesn't mean they aren't watching you.."}, 0)
	elseif (menuChoice1 == "- Warp to Circle") then
		player:warp(74, 10, 67)
	elseif (menuChoice1 == "- Join the Archers") then
		player:dialogSeq({npcA, "Are you sure you want to join the Archer path?"}, 1)
		local menuChoice2 = player:menuString("Once you confirm this, you wont be able to choose to become a Shadow..", {"Yes, I know.", "No, I need more time."})
			if (menuChoice2 == "Yes, I know.") then
				player:removeLegendbyName("repSubQ_Archer")
				player:removeLegendbyName("repSubQ_Shadow")
				player.class = 9
				player:addLegend("Inner potential of the Archer discovered. "..curT().."", "Archer_Joined", 212, 1)
				player:dialogSeq({npcA, "Very well then, let it be known throughout the Empire..",
				npcA, ""..player.name..", is now recognized as a Archer of Han."}, 1)
				broadcast(-1, "<~~~~ "..player.name..", has joined the Archer path. ~~~~>")
				local warpChoice = player:menuString("Would you like to warp to your new home?", {"Yes", "No"})
					if (warpChoice == "Yes") then
						player:warp(74, 10, 67)
					elseif (warpChoice == "No") then
						player:dialogSeq({npcA, "Alright.. Just don't forget where its located!",
						npcA, "Map Location: Vogt Forest\nX-Coords: 10\nY-Coords: 67",
						npcA, "Welcome to the path, "..player.name.."!"}, 0)
					end
			elseif (menuChoice2 == "No, I need more time.") then
				player:dialogSeq({npcA, "Very well, come back when you've made a solid decision."}, 0)
			end
	elseif (menuChoice1 == "- An Archers Calling..") then
		if (player.quest["rQ_Archer"] == 2) then
			if (player:hasItem("rep_archerdleaf", 1) == true) then
				player:removeItem("rep_archerdleaf", 1)
				player.quest["rQ_Archer"] = player.quest["rQ_Archer"] + 1
				player:addLegend("Has learned about the Archer path.", "repSubQ_Archer", 3, 1)
				player:dialogSeq({npcA, "How did you find this?! This leaf is native only to the southern most part of the empire..",
				itemLeaf, "How did you manage to obtain one so quickly?!",
				npcA, "Ahem. I'm sorry, but your agility makes me envious. Our path could use an forager like yourself.",
				npcA, "If you ever find yourself looking for a home, we'd be more than welcome to teach you Archery."}, 0)
			else
				player:dialogSeq({npcA, "You have yet to bring me back a rare leaf, one that is as white as snow.",
				npcA, "Go off into the Vogt Forest and find me one!"}, 0)
			end
		elseif (player.quest["rQ_Archer"] == 1) then
			player:dialogSeq({npcA, "You have yet to bring me back a rare leaf, one that is as white as snow.",
				npcA, "Go off into the Vogt Forest and find me one!"}, 0)
		elseif (player.quest["rQ_Archer"] == 0) then
			local decision = player:menuString("So, you're interested in the Archers?", {"Yes, I am.", "No. Nevermind."})
			if (decision == "Yes, I am.") then
				player:dialogSeq({npcA, "Archers are known for their dexterity and agility. We're known foragers of the land.",
				npcA, "Besides our obvious long-range abilities, we are also to akin to nature. Being skilled hunters, we tend to empathize with the animals of the lands.",
				itemLeaf, "Venture out into the Vogt forest and find me a pure as white leaf.",
				npcA, "If you can do that, you can prove yourself as a forager."}, 1)
				local finaldecision = player:menuString("..what say you, are you up for it?", {"Yes, I am.", "No, thanks."})
					if (finaldecision == "Yes, I am.") then
						player.quest["rQ_Archer"] = player.quest["rQ_Archer"] + 1
						player:dialogSeq({itemLeaf, "Good, head out to the Vogt Forest.\n\nStart your search there, I'll be waiting for you.",
							npcA, "Remember to be mindful of the creatures lurking in the wilderness. There may be more than meets the eye to some."}, 0)
					elseif (finaldecision == "No, thanks.") then
						player:dialogSeq({npcA, "Alright, well come back when you feel up to the task."}, 0)
					end
			elseif (decision == "No. Nevermind.") then
				player:dialogSeq({npcA, "Oh well, maybe another time then."}, 0)	
			end
		end
	end

end),

action = function(npc)
subrep_archer.move(npc)
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