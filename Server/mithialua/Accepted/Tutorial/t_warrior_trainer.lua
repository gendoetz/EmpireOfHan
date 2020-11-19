t_warrior_trainer = {
click = async(function(player, npc)
		t_warrior_trainer.choose_path(player, npc)
end),

choose_path = function(player, npc)
	local t = {graphic = convertGraphic(39, "monster"), color = 4}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local menuOptions = {}
	local choiceOptions = {"Yes, I wish to become a Warrior.", "No, I need some time to think."}
	
	if (player.class == 0) then
		table.insert(menuOptions, "About Warrior")
	end
	
	if (player.class == 0 and player.level >= 5) then
		table.insert(menuOptions, "Become a Warrior")
	end
	
	--if (player.class == 0 or player.baseClass == 1) then
	--	table.insert(menuOptions, "Learn Spell")
	--end
	
	--table.insert(menuOptions, "Forget Spell")
	
	if (player.quest["path_choice_quest"] == 3) then
	local choice = player:menuString("How may I assist you, young fledgling?", menuOptions)

	if (choice == "About Warrior") then
		player:dialogSeq({t, "Warriors are fighters capable of great devastation, they hit multiple enemies at a time and have the ability to control the flow of battle through enemy threat."}, 1)
		t_warrior_trainer.choose_path(player, npc)
	elseif (choice == "Become a Warrior") then
		local choice2 = player:menuString("Do you wish to devote yourself to the Warrior path?  This choice is final.", choiceOptions)

		if (choice2 == "Yes, I wish to become a Warrior.") then
		local spells = player:getSpells()
		
		for x = 1, #spells do
			if (spells[x] ~= 1 and spells[x] ~= 2 and spells[x] ~= 4) then
				player:removeSpell(spells[x])
			end
		end
		
		if (player:canLearnSpell("fighters_stance"))  then
			player:addSpell("fighters_stance")
		end
		
		if (player:canLearnSpell("bash"))  then
			player:addSpell("bash")
		end
		
		player:flushDuration(1)
		player:sendMinitext("You learn beginner warrior spells and are given beginner gear.")
			if (player.sex == 0) then
				player:addItem("basicw_mail", 1)
			else
				player:addItem("basicw_maildress", 1)
			end
				player:addItem("heavy_blade", 1)
				player.class = 1
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