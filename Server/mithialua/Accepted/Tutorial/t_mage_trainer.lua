t_mage_trainer = {
click = async(function(player, npc)
	t_mage_trainer.choose_path(player, npc)
end),

choose_path = function(player, npc)
	local t = {graphic = convertGraphic(40, "monster"), color = 8}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local menuOptions = {}
	local choiceOptions = {"Yes, I wish to become a Mage.", "No, I need some time to think."}
	
	if (player.class == 0) then
		table.insert(menuOptions, "About Mage")
	end
	
	if (player.class == 0 and player.level >= 5) then
		table.insert(menuOptions, "Become a Mage")
	end
	
	--if (player.class == 0 or player.baseClass == 3) then
	--	table.insert(menuOptions, "Learn Spell")
	--end
	
	--table.insert(menuOptions, "Forget Spell")
	
	if (player.quest["path_choice_quest"] == 3) then
	local choice = player:menuString("How may I assist you, young fledgling?", menuOptions)
	

	if (choice == "About Mage") then
		player:dialogSeq({t, "Mages are a path of high single and multiple target damage and crowd control. Their ability to manipulate the enemies around them is unrivaled and their burst unmatched."}, 1)
		t_mage_trainer.choose_path(player, npc)
	elseif (choice == "Become a Mage") then

		local choice2 = player:menuString("Do you wish to devote yourself to the Mage path?  This choice is final.", choiceOptions)

		if (choice2 == "Yes, I wish to become a Mage.") then
			local spells = player:getSpells()
		
			for x = 1, #spells do
				if (spells[x] ~= 1 and spells[x] ~= 2 and spells[x] ~= 4) then
					player:removeSpell(spells[x])
				end
			end
		
			if (player:canLearnSpell("hindrance"))  then
				player:addSpell("hindrance")
			end
		
			if (player:canLearnSpell("molten_blast"))  then
				player:addSpell("molten_blast")
			end
		
			player:flushDuration(1)
			player:sendMinitext("You learn beginner mage spells and are given beginner gear.")
			if (player.sex == 0) then
				player:addItem("basicm_garb", 1)
			else
				player:addItem("basicm_skirt", 1)
			end
				player:addItem("dark_staff", 1)
				player.class = 3
				player:status()
				player:calcStat()
				player.quest["path_choice_quest"] = 4
				path_guide.give_supplies(player, npc)
		else
			player:dialogSeq({t, "I see.  You should take time to think.  Talk to each of the trainers first."}, 1)
		end
	elseif (choice == "Learn Spell") then
		player:learnSpell()
	elseif (choice == "Forget Spell") then
		player:forgetSpell()	
	end

	end
end
}