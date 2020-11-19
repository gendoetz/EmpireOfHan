t_rogue_trainer = {
click = async(function(player, npc)
		t_rogue_trainer.choose_path(player, npc)
end),

choose_path = function(player, npc)
	local t = {graphic = convertGraphic(2, "monster"), color = 10}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local menuOptions = {}
	local choiceOptions = {"Yes, I wish to become a Rogue.", "No, I need some time to think."}
	
	if (player.class == 0) then
		table.insert(menuOptions, "About Rogue")
	end
	
	if (player.class == 0 and player.level >= 5) then
		table.insert(menuOptions, "Become a Rogue")
	end
	
	--if (player.class == 0 or player.baseClass == 2) then
	--	table.insert(menuOptions, "Learn Spell")
	--end
	
	--table.insert(menuOptions, "Forget Spell")

	if (player.quest["path_choice_quest"] == 3) then
	local choice = player:menuString("How may I assist you, young fledgling?", menuOptions)
	
	if (choice == "About Rogue") then
		player:dialogSeq({t, "Rogues are nimble and agile, able to fade into the shadows and damage enemies through multiple tricks and powerful abilities with a quick attack rate."}, 1)
		t_rogue_trainer.choose_path(player, npc)
	elseif (choice == "Become a Rogue") then
		local choice2 = player:menuString("Do you wish to devote yourself to the Rogue path?  This choice is final.", choiceOptions)

		if (choice2 == "Yes, I wish to become a Rogue.") then
		local spells = player:getSpells()
		
		for x = 1, #spells do
			if (spells[x] ~= 1 and spells[x] ~= 2 and spells[x] ~= 4) then
				player:removeSpell(spells[x])
			end
		end
		
		if (player:canLearnSpell("precision"))  then
			player:addSpell("precision")
		end
		
		if (player:canLearnSpell("smoke_trap"))  then
			player:addSpell("smoke_trap")
		end
		
		--if (player:canLearnSpell("spot_traps"))  then
		--	player:addSpell("spot_traps")
		--end
		
		player:flushDuration(1)
		player:sendMinitext("You learn beginner rogue spells and are given beginner gear.")
			if (player.sex == 0) then
				player:addItem("basicr_armor", 1)
			else
				player:addItem("basicr_armordress", 1)
			end
				player:addItem("light_sword", 1)
				player.class = 2
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