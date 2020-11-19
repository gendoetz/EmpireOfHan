click_95w_chest = {
	use = function(player)
		local chest = {graphic = convertGraphic(1955, "item"), color = 0}
		player.dialogType = 0
		player.npcGraphic=chest.graphic
		player.npcColor=chest.color

		if(player.state==1) then
			player:sendMinitext("Spirits can't do that")
			return
		end

		if (player.baseClass == 1) then
			player:removeItem("click_95w_chest", 1)
			player:addItem("warrior_95w_cur", 1)
			player.quest["weapon95_uncurse"] = 1
			player:sendMinitext("You find a cursed weapon inside the chest...")
			player:dialogSeq({chest, "A cursed weapon was inside the chest.. it is impossible to wield it in this state, perhaps you could remove the curse somehow?"}, 1)
		elseif (player.baseClass == 2) then
			player:removeItem("click_95w_chest", 1)
			player:addItem("rogue_95w_cur", 1)
			player.quest["weapon95_uncurse"] = 1
			player:sendMinitext("You find a cursed weapon inside the chest...")
			player:dialogSeq({chest, "A cursed weapon was inside the chest.. it is impossible to wield it in this state, perhaps you could remove the curse somehow?"}, 1)
		elseif (player.baseClass == 3) then
			player:removeItem("click_95w_chest", 1)
			player:addItem("mage_95w_cur", 1)
			player.quest["weapon95_uncurse"] = 1
			player:sendMinitext("You find a cursed weapon inside the chest...")
			player:dialogSeq({chest, "A cursed weapon was inside the chest.. it is impossible to wield it in this state, perhaps you could remove the curse somehow?"}, 1)
		elseif (player.baseClass == 4) then
			player:removeItem("click_95w_chest", 1)
			player:addItem("poet_95w_cur", 1)
			player.quest["weapon95_uncurse"] = 1
			player:sendMinitext("You find a cursed weapon inside the chest...")
			player:dialogSeq({chest, "A cursed weapon was inside the chest.. it is impossible to wield it in this state, perhaps you could remove the curse somehow?"}, 1)
		end
	end
}