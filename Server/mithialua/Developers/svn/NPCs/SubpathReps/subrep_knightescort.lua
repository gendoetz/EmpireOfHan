subrep_knightescort = {
click = async(function(player, npc)
	local npcA = {graphic = convertGraphic(839, "monster"), color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 0

	local daughterGraphic = {graphic = convertGraphic(960, "monster"), color = 0}
	local KnightEscort = player.quest["rQ_KnightEscort"]
	local found

	if (player.class == 1 and player.level >= 50 and player.quest["rQ_Knight"] >= 1) then
		if (KnightEscort >= 2) then
			player:dialogSeq({npcA, "Thank you for returning my daughter!"}, 1)
		elseif (KnightEscort == 1) then
			local MobCheck = player:getObjectsInArea(BL_MOB)
			if (#MobCheck ~= 0) then
				for i = 1, #MobCheck do
					if (MobCheck[i].mobID == 181 and MobCheck[i].owner == player.id) then
						found = MobCheck[i]
					end
				end

				if (found) then
					player.quest["rQ_KnightEscort"] = player.quest["rQ_KnightEscort"] + 1
					player.quest["rQ_Knight"] = player.quest["rQ_Knight"] + 1
					player:dialogSeq({npcA, "Thank you for returning my daughter!",
					npcA, "We don't have any money but here is a bushel of apples as my thanks.",
					npcA, "Thank you, Warrior "..player.name..". You've saved my daughter."}, 1)
					found:talk(0, "Papa, I'm going off to play!")
					found:warp(found.startM, found.startX, found.startY)
					found.owner = 0
					found.target = 0
					found.registry["mob_quest_timer"] = 0
					found.registry["gob_ambush_timer"] = 0
					found.newMove = 3000
				else
					player:dialogSeq({npcA, "Please, help my find my daughter Anya!\n\nLast she was seen, she was headed South."}, 1)	
				end
			end

		elseif (KnightEscort == 0) then
			player:dialogSeq({npcA, "Please help me!\n\nMy daughter Anya has gone missing. I'm stuck here, we cannot leave the orchard unattended otherwise wild beasts or thieves may show up..",
			daughterGraphic, "Please help me search for her, she went off into the forest to the South the last I saw.."}, 1)
			local choice1 = player:menuString("Will you help search for her?", {"Yes", "No"})
				if (choice1 == "Yes") then
					player.quest["rQ_KnightEscort"] = player.quest["rQ_KnightEscort"] + 1
					player:dialogSeq({npcA, "Thank you! If you find her, please help guide her back home.\n",
					daughterGraphic, "*"..npc.name.." looks off South with a worried face"}, 1)
				elseif (choice1 == "No") then
					player:dialogSeq({npcA, "Well, if you see her in your travels tell her to come home!"}, 1)
				end	
		end

	else
		player:dialogSeq({npcA, "Hello there!"}, 1)
	
	end
end), 

}
