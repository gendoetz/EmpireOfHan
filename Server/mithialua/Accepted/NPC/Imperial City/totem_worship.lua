han_totem_chungryong = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local opts = {"The Powerful Dragon"}
	local menuOption
	local faith = player.registry["totem_faith"]
	local rewards = {}

	if (faith >= 0) then
	
	end
	if (faith >= 11) then
		if (player.sex == 0) then
			table.insert(rewards, 459)
		else
			table.insert(rewards, 460)
		end
	end
	if (faith >= 26) then
		--TOTEM HELM SPECIFIC
		table.insert(rewards, 455)
	end
	if (faith >= 46) then
		if (player.sex == 0) then
			table.insert(rewards, 461)
		else
			table.insert(rewards, 462)
		end
	end
	if (faith >= 76) then
		--TOTEM NECKLACE SPECIFIC
		table.insert(rewards, 275)
	end
	if (faith > 150) then
		
	end

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if (player.totem == 3) then
		table.insert(opts, "Worship")
		table.insert(opts, "Rewards")
		table.insert(opts, "Where lies my faith?")
	elseif (player.totem ~= 3) then
		table.insert(opts, "Change Devotion")
	end

	menuOption = player:menuString("How may I assist you?", opts)
	
	if (menuOption == "The Powerful Dragon") then
				player:dialogSeq({t, "Chung Ryong is the great blue dragon, he is the totem that represents power, strength, and war.",
				t, "Those who fight beside the great Chung Ryong are gifted in the dawn as the sun rises."}, 1)
	elseif(menuOption=="Rewards") then
			player:buyBonded("With greater faith you gain access to additional rewards. What reward do you wish to obtain?", rewards)
	elseif (menuOption == "Where lies my faith?") then
	han_totem_worship.check_faith(player, npc)
	elseif (menuOption == "Worship") then
		player:dialogSeq({t, "You may show your faith and devotion by sacraficing an offering. Approach the statue and place before it your offering, you may only make an offering once every 12 hours.",
		t, "Gold Acorn: Lesser Faith (+1).\nGolden Branch: Greater Faith (+2).\nGolden Statue: Greater Faith (+3)."}, 1)
	elseif (menuOption == "Change Devotion") then
		player:dialogSeq({t, "You may change your totem of worship but you will lose all faith you have gained in doing so.",
		t, "If you wish to proceed you must bring to me 10 gold acorns."}, 1)

		if (player:hasItem("gold_acorn", 10) == true ) then
		local choice = player:menuString("Are you absolutely certain you wish to change your totem of worship?", {"Yes", "No"})
			if (choice == "Yes") then
				player:removeItem("gold_acorn", 10, 9)
				player.totemTime = 0
				player.totem = 3
				player.registry["totem_faith"] = 0
				player:dialogSeq({t, "It is done."}, 1)
			else
				player:dialogSeq({t, "Very well."}, 1)
			end
		end
	end
end)
}

han_totem_baekho = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local opts = {"The Swift Tiger"}
	local menuOption
	local faith = player.registry["totem_faith"]
	local rewards = {}

	if (faith >= 0) then
	
	end
	if (faith >= 11) then
		if (player.sex == 0) then
			table.insert(rewards, 459)
		else
			table.insert(rewards, 460)
		end
	end
	if (faith >= 26) then
		--TOTEM HELM SPECIFIC
		table.insert(rewards, 456)
	end
	if (faith >= 46) then
		if (player.sex == 0) then
			table.insert(rewards, 461)
		else
			table.insert(rewards, 462)
		end
	end
	if (faith >= 76) then
		--TOTEM NECKLACE SPECIFIC
		table.insert(rewards, 276)
	end
	if (faith > 150) then
		
	end

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if (player.totem == 1) then
		table.insert(opts, "Worship")
		table.insert(opts, "Rewards")
		table.insert(opts, "Where lies my faith?")
	elseif (player.totem ~= 1) then
		table.insert(opts, "Change Devotion")
	end

	menuOption = player:menuString("How may I assist you?", opts)
	
	if (menuOption == "The Swift Tiger") then
				player:dialogSeq({t, "Baekho is the swift white tiger, it posesses unmatched stealth, cunning, and speed.",
				t, "Those who fight beside the swift Baekho gain favor in the dusk as the sun sets."}, 1)
	elseif(menuOption=="Rewards") then
			player:buyBonded("With greater faith you gain access to additional rewards. What reward do you wish to obtain?", rewards)
	elseif (menuOption == "Where lies my faith?") then
	han_totem_worship.check_faith(player, npc)
	elseif (menuOption == "Worship") then
		player:dialogSeq({t, "You may show your faith and devotion by sacraficing an offering. Approach the statue and place before it your offering, you may only make an offering once every 12 hours.",
		t, "Gold Acorn: Lesser Faith (+1).\nGolden Branch: Greater Faith (+2).\nGolden Statue: Greater Faith (+3)."}, 1)
	elseif (menuOption == "Change Devotion") then
		player:dialogSeq({t, "You may change your totem of worship but you will lose all faith you have gained in doing so.",
		t, "If you wish to proceed you must bring to me 10 gold acorns."}, 1)

		if (player:hasItem("gold_acorn", 10) == true ) then
		local choice = player:menuString("Are you absolutely certain you wish to change your totem of worship?", {"Yes", "No"})
			if (choice == "Yes") then
				player:removeItem("gold_acorn", 10, 9)
				player.totemTime = 0
				player.totem = 1
				player.registry["totem_faith"] = 0
				player:dialogSeq({t, "It is done."}, 1)
			else
				player:dialogSeq({t, "Very well."}, 1)
			end
		end
	end
end)
}

han_totem_jujak = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local opts = {"The Magical Bird"}
	local menuOption
	local faith = player.registry["totem_faith"]
	local rewards = {}

	if (faith >= 0) then
	
	end
	if (faith >= 11) then
		if (player.sex == 0) then
			table.insert(rewards, 459)
		else
			table.insert(rewards, 460)
		end
	end
	if (faith >= 26) then
		--TOTEM HELM SPECIFIC
		table.insert(rewards, 457)
	end
	if (faith >= 46) then
		if (player.sex == 0) then
			table.insert(rewards, 461)
		else
			table.insert(rewards, 462)
		end
	end
	if (faith >= 76) then
		--TOTEM NECKLACE SPECIFIC
		table.insert(rewards, 277)
	end
	if (faith > 150) then
		
	end

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if (player.totem == 0) then
		table.insert(opts, "Worship")
		table.insert(opts, "Rewards")
		table.insert(opts, "Where lies my faith?")
	elseif (player.totem ~= 0) then
		table.insert(opts, "Change Devotion")
	end

	menuOption = player:menuString("How may I assist you?", opts)
	
	if (menuOption == "The Magical Bird") then
				player:dialogSeq({t, "Ju Jak is the magical bird of flame, it's control over elemental magic energies is unmatched.",
				t, "Those who place their faith in the magical Ju Jak are most powerful at high noon."}, 1)
	elseif(menuOption=="Rewards") then
			player:buyBonded("With greater faith you gain access to additional rewards. What reward do you wish to obtain?", rewards)
	elseif (menuOption == "Where lies my faith?") then
	han_totem_worship.check_faith(player, npc)
	elseif (menuOption == "Worship") then
		player:dialogSeq({t, "You may show your faith and devotion by sacraficing an offering. Approach the statue and place before it your offering, you may only make an offering once every 12 hours.",
		t, "Gold Acorn: Lesser Faith (+1).\nGolden Branch: Greater Faith (+2).\nGolden Statue: Greater Faith (+3)."}, 1)
	elseif (menuOption == "Change Devotion") then
		player:dialogSeq({t, "You may change your totem of worship but you will lose all faith you have gained in doing so.",
		t, "If you wish to proceed you must bring to me 10 gold acorns."}, 1)

		if (player:hasItem("gold_acorn", 10) == true ) then
		local choice = player:menuString("Are you absolutely certain you wish to change your totem of worship?", {"Yes", "No"})
			if (choice == "Yes") then
				player:removeItem("gold_acorn", 10, 9)
				player.totemTime = 0
				player.totem = 0
				player.registry["totem_faith"] = 0
				player:dialogSeq({t, "It is done."}, 1)
			else
				player:dialogSeq({t, "Very well."}, 1)
			end
		end
	end
end)
}

han_totem_hyunmoo = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local opts = {"The Mystical Tortoise"}
	local menuOption
	local faith = player.registry["totem_faith"]
	local rewards = {}

	if (faith >= 0) then
	
	end
	if (faith >= 11) then
		if (player.sex == 0) then
			table.insert(rewards, 459)
		else
			table.insert(rewards, 460)
		end
	end
	if (faith >= 26) then
		--TOTEM HELM SPECIFIC
		table.insert(rewards, 458)
	end
	if (faith >= 46) then
		if (player.sex == 0) then
			table.insert(rewards, 461)
		else
			table.insert(rewards, 462)
		end
	end
	if (faith >= 76) then
		--TOTEM NECKLACE SPECIFIC
		table.insert(rewards, 278)
	end
	if (faith > 150) then
		
	end

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if (player.totem == 2) then
		table.insert(opts, "Worship")
		table.insert(opts, "Rewards")
		table.insert(opts, "Where lies my faith?")
	elseif (player.totem ~= 2) then
		table.insert(opts, "Change Devotion")
	end

	menuOption = player:menuString("How may I assist you?", opts)
	
	if (menuOption == "The Mystical Tortoise") then
				player:dialogSeq({t, "Hyun Moo is the mystical black tortoise, it represents protection and healing.",
				t, "Those who walk beside the mystical Hyun Moo find their gifts flourish in the darkest hour of midnight."}, 1)
	elseif(menuOption=="Rewards") then
			player:buyBonded("With greater faith you gain access to additional rewards. What reward do you wish to obtain?", rewards)
	elseif (menuOption == "Where lies my faith?") then
	han_totem_worship.check_faith(player, npc)
	elseif (menuOption == "Worship") then
		player:dialogSeq({t, "You may show your faith and devotion by sacraficing an offering. Approach the statue and place before it your offering, you may only make an offering once every 12 hours.",
		t, "Gold Acorn: Lesser Faith (+1).\nGolden Branch: Greater Faith (+2).\nGolden Statue: Greater Faith (+3)."}, 1)
	elseif (menuOption == "Change Devotion") then
		player:dialogSeq({t, "You may change your totem of worship but you will lose all faith you have gained in doing so.",
		t, "If you wish to proceed you must bring to me 10 gold acorns."}, 1)

		if (player:hasItem("gold_acorn", 10) == true ) then
		local choice = player:menuString("Are you absolutely certain you wish to change your totem of worship?", {"Yes", "No"})
			if (choice == "Yes") then
				player:removeItem("gold_acorn", 10, 9)
				player.totemTime = 0
				player.totem = 2
				player.registry["totem_faith"] = 0
				player:dialogSeq({t, "It is done."}, 1)
			else
				player:dialogSeq({t, "Very well."}, 1)
			end
		end
	end
end)
}

han_totem_worship = {
click = async(function(player,npc)

end),

check_faith = function(player, npc)

	local t = {}

	local faith = player.registry["totem_faith"]
	local totem = ""

	--Totem images have 5 versions
	--Lv 1 = 0 - 10
	--Lv 2 = 11 - 25
	--Lv 3 = 26 - 45
	--Lv 4 = 46 - 75
	--Lv 5 = 76 - 150

	if (player.totem == 0) then --Ju Kak
		totem = "Ju Jak"

		if (faith >= 0 and faith <= 10) then
			t={graphic=convertGraphic(357,"monster"),color=0}
			player:dialogSeq({t, "Your faith in your totem god is but a small seed planted within your soul, nourish it and it shall grow."}, 1)
		elseif (faith >= 11 and faith <= 25) then
			t={graphic=convertGraphic(358,"monster"),color=0}
			player:dialogSeq({t, "The path you tread shows prosperity and good fortune. "..totem.." smiles upon you."}, 1)
		elseif (faith >= 26 and faith <= 45) then
			t={graphic=convertGraphic(359,"monster"),color=0}
			player:dialogSeq({t, "You have become a devoted follower. Your soul begins to strengthen with resolve."}, 1)
		elseif (faith >= 46 and faith <= 75) then
			t={graphic=convertGraphic(360,"monster"),color=0}
			player:dialogSeq({t, "You can hear the voice of "..totem..". The power of your totem god is swelling within you."}, 1)
		elseif (faith >= 76 and faith <= 150) then
			t={graphic=convertGraphic(361,"monster"),color=0}
			player:dialogSeq({t, "Your faith is unshakable, "..totem.." prospers from your devotion."}, 1)
		elseif (faith > 150) then
			t={graphic=convertGraphic(361,"monster"),color=0}
			player:dialogSeq({t, "You walk among the totem gods. Your faith has brought you to the pinnicle of devotion."}, 1)
		end

	elseif (player.totem == 1) then --Baekho
		totem = "Baekho"

		if (faith >= 0 and faith <= 10) then
			t={graphic=convertGraphic(352,"monster"),color=0}
			player:dialogSeq({t, "Your faith in your totem god is but a small seed planted within your soul, nourish it and it shall grow."}, 1)
		elseif (faith >= 11 and faith <= 25) then
			t={graphic=convertGraphic(353,"monster"),color=0}
			player:dialogSeq({t, "The path you tread shows prosperity and good fortune. "..totem.." smiles upon you."}, 1)
		elseif (faith >= 26 and faith <= 45) then
			t={graphic=convertGraphic(354,"monster"),color=0}
			player:dialogSeq({t, "You have become a devoted follower. Your soul begins to strengthen with resolve."}, 1)
		elseif (faith >= 46 and faith <= 75) then
			t={graphic=convertGraphic(355,"monster"),color=0}
			player:dialogSeq({t, "You can hear the voice of "..totem..". The power of your totem god is swelling within you."}, 1)
		elseif (faith >= 76 and faith <= 150) then
			t={graphic=convertGraphic(356,"monster"),color=0}
			player:dialogSeq({t, "Your faith is unshakable, "..totem.." prospers from your devotion."}, 1)
		elseif (faith > 150) then
			t={graphic=convertGraphic(356,"monster"),color=0}
			player:dialogSeq({t, "You walk among the totem gods. Your faith has brought you to the pinnicle of devotion."}, 1)
		end

	elseif (player.totem == 2) then --Hyun moo
		totem = "Hyun Moo"

		if (faith >= 0 and faith <= 10) then
			t={graphic=convertGraphic(367,"monster"),color=0}
			player:dialogSeq({t, "Your faith in your totem god is but a small seed planted within your soul, nourish it and it shall grow."}, 1)
		elseif (faith >= 11 and faith <= 25) then
			t={graphic=convertGraphic(368,"monster"),color=0}
			player:dialogSeq({t, "The path you tread shows prosperity and good fortune. "..totem.." smiles upon you."}, 1)
		elseif (faith >= 26 and faith <= 45) then
			t={graphic=convertGraphic(369,"monster"),color=0}
			player:dialogSeq({t, "You have become a devoted follower. Your soul begins to strengthen with resolve."}, 1)
		elseif (faith >= 46 and faith <= 75) then
			t={graphic=convertGraphic(370,"monster"),color=0}
			player:dialogSeq({t, "You can hear the voice of "..totem..". The power of your totem god is swelling within you."}, 1)
		elseif (faith >= 76 and faith <= 150) then
			t={graphic=convertGraphic(371,"monster"),color=0}
			player:dialogSeq({t, "Your faith is unshakable, "..totem.." prospers from your devotion."}, 1)
		elseif (faith > 150) then
			t={graphic=convertGraphic(371,"monster"),color=0}
			player:dialogSeq({t, "You walk among the totem gods. Your faith has brought you to the pinnicle of devotion."}, 1)
		end

	elseif (player.totem == 3) then --Chong Ryong
		totem = "Chung Ryong"

		if (faith >= 0 and faith <= 10) then
			t={graphic=convertGraphic(362,"monster"),color=0}
			player:dialogSeq({t, "Your faith in your totem god is but a small seed planted within your soul, nourish it and it shall grow."}, 1)
		elseif (faith >= 11 and faith <= 25) then
			t={graphic=convertGraphic(363,"monster"),color=0}
			player:dialogSeq({t, "The path you tread shows prosperity and good fortune. "..totem.." smiles upon you."}, 1)
		elseif (faith >= 26 and faith <= 45) then
			t={graphic=convertGraphic(364,"monster"),color=0}
			player:dialogSeq({t, "You have become a devoted follower. Your soul begins to strengthen with resolve."}, 1)
		elseif (faith >= 46 and faith <= 75) then
			t={graphic=convertGraphic(365,"monster"),color=0}
			player:dialogSeq({t, "You can hear the voice of "..totem..". The power of your totem god is swelling within you."}, 1)
		elseif (faith >= 76 and faith <= 150) then
			t={graphic=convertGraphic(366,"monster"),color=0}
			player:dialogSeq({t, "Your faith is unshakable, "..totem.." prospers from your devotion."}, 1)
		elseif (faith > 150) then
			t={graphic=convertGraphic(366,"monster"),color=0}
			player:dialogSeq({t, "You walk among the totem gods. Your faith has brought you to the pinnicle of devotion."}, 1)
		end

	end
		--player:dialogSeq({t, "Faith.",
		--t, "Faith."}, 1)
end
}

totem_offering = {
click = async(function(player,npc)

end),

on_drop = async(function(player, npc, item)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local worshipTimer = 43200

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if (player.m == 264 and player.totem ~= 1) then
		player:dialogSeq({t, "You may not worship at this totem heathen..."}, 1)
		return
	end
	if (player.m == 263 and player.totem ~= 3) then
		player:dialogSeq({t, "You may not worship at this totem heathen..."}, 1)
		return
	end
	if (player.m == 266 and player.totem ~= 2) then
		player:dialogSeq({t, "You may not worship at this totem heathen..."}, 1)
		return
	end
	if (player.m == 265 and player.totem ~= 0) then
		player:dialogSeq({t, "You may not worship at this totem heathen..."}, 1)
		return
	end

	if (player.registry["worship_totem_timer"] <= os.time()) then
		--worship items check
		if (item.id == 160) then -- gold acorn
			t = {graphic=Item(item.id).icon,color=Item(item.id).iconC}
			item:delete()
			player.registry["totem_faith"] = player.registry["totem_faith"] + 1
			player.registry["worship_totem_timer"] = os.time() + worshipTimer
			player:dialogSeq({t, "Your faith has increased a small amount."}, 1)
		end

	else
		player:dialogSeq({t, "You must wait "..(math.ceil((player.registry["worship_totem_timer"] - os.time())/10800)).." game day(s) before you may worship again."}, 1)
	end

end),

action = function(npc)
	local playerStand = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_PC)

	if (#playerStand > 0) then
		for i = 1, #playerStand do
			playerStand[i]:warp(playerStand[i].m, playerStand[i].x, playerStand[i].y + 4)
			playerStand[i]:sendMinitext("You anger the totem god by offering nothing, a powerful force tosses you away from the statue.")
		end
	end
end,
}