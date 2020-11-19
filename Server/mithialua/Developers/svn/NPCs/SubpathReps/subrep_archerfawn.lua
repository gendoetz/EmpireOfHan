subrep_archerfawn = { 
click = async(function(player, npc)
	local npcA = {graphic = convertGraphic(667, "monster"), color = 3}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 0

	local npcB = {graphic = convertGraphic(666, "monster"), color = 3}
	local itemHoney = {graphic = convertGraphic(2875, "item"), color = 23}
	local itemSword = {graphic = convertGraphic(2, "item"), color = 4}
	local itemLeaf = {graphic = convertGraphic(2909, "item"), color = 9}

	if (player.quest["rQ_Archer"] ~= 1) then
		player:dialogSeq({npcA, "You notice a wounded fawn.",
		npcB, "As quickly as you noticed it, it bounds off into the woods."}, 1)
	else
		if (player.quest["rQ_ArcherFawn"] >= 2) then
			player:dialogSeq({npcB, "*You recall the memory of when you helped the wounded fawn."}, 1)
		
		elseif (player.quest["rQ_ArcherFawn"] == 1) then
			local cWeap = player:getEquippedItem(EQ_WEAP)		
			if (cWeap ~= nil) then
				if (cWeap.id == Item(40317).id) then
					player:dialogSeq({npcA, "You cannot get near the fawn while wearing a weapon, you might scare it!"}, 1)
				else
					if (player:hasItem("rep_archerhoney",	10) == true) then
						player.quest["rQ_Archer"] = player.quest["rQ_Archer"] + 1
						player.quest["rQ_ArcherFawn"] = player.quest["rQ_ArcherFawn"] + 1
						player:removeItem("rep_archerhoney", 10)
						player:removeItem("rep_archersword", 1)
						player:dialogSeq({itemHoney, "You cautiously apply a thin layer of honey to the fawn's wounds.",
						npcB, "As you finish applying the honey, you notice the fawn glance up at you.\n\nAs if it were thanking you; it bows its head, slowly stands, and bounds off into the distance.",
						itemLeaf, "As it prances off, a colorful leaf floats before you."}, 1)
						player:addItem("rep_archerdleaf", 1)
						player:dialogSeq({npcB, "What luck! That fawn was resting on the leaf the Archer was talking about. Head back to him now."}, 1)
					else
						player:dialogSeq({itemHoney, "You don't seem to have nearly enough honey, gather more!"}, 1)
					end
				end
			else
				if (player:hasItem("rep_archerhoney", 10) == true) then
					player:removeItem("rep_archerhoney", 10)
					player:removeItem("rep_archersword", 1)
					player:dialogSeq({itemHoney, "You cautiously apply a thin layer of honey to the fawn's wounds.",
					npcB, "As you finish applying the honey, you notice the fawns glance on you.\n\nAs if it were thanking you; it bows its head, slowly stands, and bounds off into the distance.",
					itemLeaf, "As it prances off, a colorful leaf floats before you."}, 1)
					player:addItem("rep_archerdleaf", 1)
					player:dialogSeq({npcB, "What luck! That fawn was resting on the leaf the Archer was talking about. Head back to him now."}, 1)
					player.quest["rQ_Archer"] = player.quest["rQ_Archer"] + 1
					player.quest["rQ_ArcherFawn"] = player.quest["rQ_ArcherFawn"] + 1
				else
					player:dialogSeq({itemHoney, "You don't seem to have nearly enough honey, gather more!"}, 1)
				end
			end					

		elseif (player.quest["rQ_ArcherFawn"] == 0) then
			if (player:hasSpace("rep_archersword", 1) == false) then
				player:dialogSeq({npcA, "You want to offer help, but with your pack weighing you down there isn't much you can do."}, 1)

			elseif (player:hasSpace("rep_archersword", 1) == true) then
				player:dialogSeq({npcA, "You notice a hurt fawn kneeling in the grass, seeking to help you search nearby for aid."}, 1)
				player:addItem("rep_archersword", 1)
				player:dialogSeq({itemSword, "After not seeing anyone around, you instead grab a stick from the ground.\n\nGo in search of honey in the neighboring woods. Swing your stick at the trees in attempts to collect some.",
				itemHoney, "Once you've gotten a few batches of honey bring it back to the fawn."}, 1)
				player.quest["rQ_ArcherFawn"] = player.quest["rQ_ArcherFawn"] + 1
			end
		end
	end

end),

}
