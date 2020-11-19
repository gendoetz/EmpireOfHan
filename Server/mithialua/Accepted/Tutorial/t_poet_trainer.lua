t_poet_trainer = {
click = async(function(player, npc)
	t_poet_trainer.choose_path(player, npc)
end),

choose_path = function(player, npc)
	local t = {graphic = convertGraphic(16, "monster"), color = 9}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local menuOptions = {}
	local choiceOptions = {"Yes, I wish to become a Poet.", "No, I need some time to think."}
	
	if (player.class == 0) then
		table.insert(menuOptions, "About Poet")
	end
	
	if (player.class == 0 and player.level >= 5) then
		table.insert(menuOptions, "Become a Poet")
	end
	
	--if (player.class == 0 or player.baseClass == 4) then
	--	table.insert(menuOptions, "Learn Spell")
	--end
	
	--table.insert(menuOptions, "Forget Spell")
	
	if (player.quest["path_choice_quest"] == 3) then
	local choice = player:menuString("How may I assist you, young fledgling?", menuOptions)
	

	if (choice == "About Poet") then
		player:dialogSeq({t, "Poets utilize powerful enchantments, buffs, spirital attacks, and healing magic.  They are able to use these skills to both defeat their foes and increase the abilities of their allies in battle."}, 1)
		t_poet_trainer.choose_path(player, npc)
	elseif (choice == "Become a Poet") then
		local choice2 = player:menuString("Do you wish to devote yourself to the Poet path?  This choice is final.", choiceOptions)

		if (choice2 == "Yes, I wish to become a Poet.") then
		local spells = player:getSpells()
		
		for x = 1, #spells do
			if (spells[x] ~= 1 and spells[x] ~= 2 and spells[x] ~= 4) then
				player:removeSpell(spells[x])
			end
		end
		
		if (player:canLearnSpell("flare"))  then
			player:addSpell("flare")
		end
		
		if (player:canLearnSpell("solace"))  then
			player:addSpell("solace")
		end
		
		player:flushDuration(1)
		player:sendMinitext("You learn beginner poet spells and are given beginner gear.")
		if (player.sex == 0) then
				player:addItem("basicp_robe", 1)
			else
				player:addItem("basicp_gown", 1)
			end
			player:addItem("light_staff", 1)
				player.class = 4
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
end,
}