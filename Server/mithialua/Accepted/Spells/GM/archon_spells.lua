gm_broadcast2 = {
cast=function(player)
	local question = player.question
	if (player.gmLevel > 0) then
		if(string.len(question) > 0) then
			if(player.ID == 2) then
				player:broadcast(-1, "[GM "..player.name.."]: "..question)
			else
				player:broadcast(-1, "[Archon "..player.name.."]: "..question)
			end
		else
			player:sendMinitext("Can't send an empty broadcast")
		end
		player:broadcast("Player "..player.name.."has a GM spell.", -1)
	end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Broadcast sends a message to all players online."}
	return level, items, itemAmounts, description
end
}

gm_playersummon2 = {
cast=function(player,target)
	local question = Player(player.question)

	if(question == nil) then
		player:sendMinitext("They are not online.")
	else
		if (player.region == question.region or player.gmLevel > 50) then
			question:warp(player.m, player.x, player.y)
		else
			player:sendMinitext("That player is in a different region from yours.")
			player:setAether("summon", 5000)
		end
	end
end,
on_aethers = function(player)
	local question=Player(player.question)

	if(question == nil) then
		player:sendMinitext("They are not online.")
	else
		if (player.region == question.region) then
			question:warp(player.m, player.x, player.y)
		else
			question:warp(player.m, player.x, player.y)
			player:sendMinitext("You have summoned "..player.question.." from region "..question.region".")
		end
	end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Player Summon brings a currently online player to your location."}
	return level, items, itemAmounts, description
end
}

gm_playerapproach2 = {
cast=function(player, target)
	local question=Player(player.question)

	if(question == nil) then
		player:sendMinitext("They are not online.")
	else
		if (player.region == question.region) then
			player:warp(question.m, question.x, question.y)
		end
	end
end,

requirements = function(player)
	local level = 28
	local items = {}
	local itemAmounts = {}
	local description = {"Approach brings you to a person that is in the same region as you."}
	return level, items, itemAmounts, description
end
}

inspiration_mark = {
cast = function(player)
player:freeAsync()
inspiration_mark.popup(player)
end,

popup = async(function(player)
	local t = {graphic = convertGraphic(654,"monster"),color=15}
	local aether = 0
	local menuOptions = {}
	local magicCost = 10
	
	table.insert(menuOptions, "Grant a Mark")
	table.insert(menuOptions, "Remove a Mark")
	table.insert(menuOptions, "Create Reward Item")

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0


		local testerchoice=player:input("Which character? (Enter player name)")
		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end

	local choice = player:menuString("Which will you do?", menuOptions)
		if(choice == "Grant a Mark") then
			local wins = Player(testerchoice).registry["inspirationWins"] + 1
			
			--Player(testerchoice):dialogSeq({npcGraphics, "I see you've won the Carnage. Congratulations on your victory!!"}, 1)
			Player(testerchoice).registry["inspirationWins"] = wins

			Player(testerchoice):removeLegendbyName("inspirationWWins")
			if (wins == 1) then
				Player(testerchoice):addLegend("Has inspired the Immortals "..wins.." time.", "inspirationWWins", 157, 68)
			else
				Player(testerchoice):addLegend("Has inspired the Immortals "..wins.." times.", "inspirationWWins", 157, 68)
			end
			

		elseif(choice == "Remove a Mark") then
			local wins = Player(testerchoice).registry["inspirationWins"] - 1
			
			--Player(testerchoice):dialogSeq({npcGraphics, "I see you've won the Carnage. Congratulations on your victory!!"}, 1)
			Player(testerchoice).registry["inspirationWins"] = wins

			Player(testerchoice):removeLegendbyName("inspirationWWins")
				if (wins == 1) then
					Player(testerchoice):addLegend("Has inspired the Immortals "..wins.." time.", "inspirationWWins", 157, 68)
				elseif (wins > 1) then
					Player(testerchoice):addLegend("Has inspired the Immortals "..wins.." times.", "inspirationWWins", 157, 68)
				elseif (wins < 1) then
					Player(testerchoice).registry["inspirationWins"] = 0
				end

		elseif(choice == "Create Reward Item") then
			player:addItem("inspiration_shield", 1, 0, Player(testerchoice).id)
			--Player(testerchoice):dialogSeq({npcGraphics, "I see you've won the Carnage. Congratulations on your victory!!"}, 1)
			
		end

end),

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Spell used to mark winners of the Inspiration Contest."}
	return level, items, itemAmounts, description
end
}

builder_mark = {
cast = function(player)
player:freeAsync()
builder_mark.popup(player)
end,

popup = async(function(player)
	local t = {graphic = convertGraphic(654,"monster"),color=15}
	local aether = 0
	local menuOptions = {}
	local magicCost = 10
	
	table.insert(menuOptions, "Grant a Mark")
	table.insert(menuOptions, "Remove a Mark")

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0


		local testerchoice=player:input("Which character? (Enter player name)")
		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end

	local choice = player:menuString("Which will you do?", menuOptions)
		if(choice == "Grant a Mark") then
			local times = Player(testerchoice).registry["builder_rewardmark"] + 1
			
			--Player(testerchoice):dialogSeq({npcGraphics, "I see you've won the Carnage. Congratulations on your victory!!"}, 1)
			Player(testerchoice).registry["builder_rewardmark"] = times

			Player(testerchoice):removeLegendbyName("builder_r_mark")
			if (times == 1) then
				Player(testerchoice):addLegend("Helped to build a better kingdom, recognized "..times.." time.", "builder_r_mark", 157, 68)
			else
				Player(testerchoice):addLegend("Helped to build a better kingdom, recognized "..times.." times.", "builder_r_mark", 157, 68)
			end
			

		elseif(choice == "Remove a Mark") then
			local times = Player(testerchoice).registry["builder_rewardmark"] - 1
			
			--Player(testerchoice):dialogSeq({npcGraphics, "I see you've won the Carnage. Congratulations on your victory!!"}, 1)
			Player(testerchoice).registry["builder_rewardmark"] = times

			Player(testerchoice):removeLegendbyName("builder_r_mark")
				if (times == 1) then
					Player(testerchoice):addLegend("Has inspired the Immortals "..times.." time.", "builder_r_mark", 157, 68)
				elseif (times > 1) then
					Player(testerchoice):addLegend("Has inspired the Immortals "..times.." times.", "builder_r_mark", 157, 68)
				elseif (times < 1) then
					Player(testerchoice).registry["builder_rewardmark"] = 0
				end
			
		end

end),

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Spell used to mark winners of the Inspiration Contest."}
	return level, items, itemAmounts, description
end
}

scholar_recognition = {
cast = function(player)
player:freeAsync()
scholar_recognition.popup(player)
end,

popup = async(function(player)
	local t = {graphic = convertGraphic(654,"monster"),color=15}
	local aether = 0
	local menuOptions = {}
	local magicCost = 10
	
	table.insert(menuOptions, "Scholar: Grant Mark")
	table.insert(menuOptions, "Scholar: Remove Mark")
	table.insert(menuOptions, "High Scholar: Grant Mark")
	table.insert(menuOptions, "High Scholar: Remove Mark")

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0


		local testerchoice=player:input("Which character? (Enter player name)")
		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end

	local choice = player:menuString("Which will you do?", menuOptions)
		if(choice == "Scholar: Grant Mark") then

			Player(testerchoice):removeLegendbyName("scholar_appoint")
	
			Player(testerchoice):addLegend("Scholar of the Empire, appointed "..curT(),  "scholar_appoint", 199, 16)
			
		elseif(choice == "Scholar: Remove Mark") then

			Player(testerchoice):removeLegendbyName("scholar_appoint")
		elseif(choice == "High Scholar: Grant Mark") then

			Player(testerchoice):removeLegendbyName("scholar_appoint")
	
			Player(testerchoice):addLegend("High Scholar of the Empire, appointed "..curT(),  "scholar_appoint", 199, 16)
			
		elseif(choice == "High Scholar: Remove Mark") then

			Player(testerchoice):removeLegendbyName("scholar_appoint")

		end
end),

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Spell used to add members to the Scholars."}
	return level, items, itemAmounts, description
end
}

scholars_history = {
cast = function(player)
player:freeAsync()
scholars_history.popup(player)
end,

popup = async(function(player)
	local t = {graphic = convertGraphic(654,"monster"),color=15}
	local aether = 36000000
	local menuOptions = {}
	local magicCost = 10
	
	table.insert(menuOptions, "Grant a Mark")

	if(player.gmLevel > 1) then
	table.insert(menuOptions, "Remove a Mark")
	end
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.gmLevel < 50) then
		if (player:hasLegend("scholar_appoint") == false) then
				player:sendMinitext("You must be a Scholar to use this spell.")
			return
		end
	end


		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0


		local testerchoice=player:input("Which character? (Enter player name)")
		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end

		if(Player(testerchoice).id == player.id) then
			player:dialogSeq({t,"You may not mark yourself."})
			return
		end

	local choice = player:menuString("Which will you do?", menuOptions)
		if(choice == "Grant a Mark") then
			local times = Player(testerchoice).registry["scholars_history_mark"] + 1
			
			--Player(testerchoice):dialogSeq({npcGraphics, "I see you've won the Carnage. Congratulations on your victory!!"}, 1)
			Player(testerchoice).registry["scholars_history_mark"] = times

			Player(testerchoice):removeLegendbyName("scholars_history_mark")
			if (times == 1) then
				Player(testerchoice):addLegend("Studied the history of the Han Empire, uncovered "..times.." tome assisted by "..player.name, "scholar_history_r_mark", 199, 68)
			else
				Player(testerchoice):addLegend("Studied the history of the Han Empire, uncovered "..times.." tomes assisted by "..player.name, "scholar_history_r_mark", 199, 68)
			end
			local reward = math.random(1, 5)

			if (reward == 1) then
				Player(testerchoice):addItem("magic_tome", 1)
			elseif (reward == 2) then
				Player(testerchoice):addItem("healing_tome", 1)
			elseif (reward == 3) then
				Player(testerchoice):addItem("might_tome", 1)
			elseif (reward == 4) then
				Player(testerchoice):addItem("grace_tome", 1)
			elseif (reward == 5) then
				Player(testerchoice):addItem("will_tome", 1)
			end
		elseif(choice == "Remove a Mark") then
			local times = Player(testerchoice).registry["scholars_history_mark"] - 1
			
			--Player(testerchoice):dialogSeq({npcGraphics, "I see you've won the Carnage. Congratulations on your victory!!"}, 1)
			Player(testerchoice).registry["scholars_history_mark"] = times

			Player(testerchoice):removeLegendbyName("scholar_history_r_mark")
				if (times == 1) then
					Player(testerchoice):addLegend("Studied the history of the Han Empire, uncovered "..times.." tome assisted by "..player.name, "scholar_history_r_mark", 199, 68)
				elseif (times > 1) then
					Player(testerchoice):addLegend("Studied the history of the Han Empire, uncovered "..times.." tomes assisted by "..player.name, "scholar_history_r_mark", 199, 68)
				elseif (times < 1) then
					Player(testerchoice).registry["scholars_history_mark"] = 0
				end
			
		end
		player:setAether("scholars_history", aether)
end),

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"A spell given to Scholars that allow them to grant reward for history recognition."}
	return level, items, itemAmounts, description
end
}