han_carpentercraft = {
click = async(function(player, npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local typeOpts = {}
		table.insert(typeOpts, "About Carpentry")
		table.insert(typeOpts, "Learn Carpentry")
		table.insert(typeOpts, "Forget Carpentry")
		table.insert(typeOpts, " ")
		table.insert(typeOpts, "- Skill Levels")
			if (player.registry["forester"] >= 6400 and (player.quest["gatherQuest_forester"] <= 9)) then
				table.insert(typeOpts, " ")
				table.insert(typeOpts, "A bushel, a basket..")
			end

	local craftCount = 0

	player.npcGraphic=t.graphic
	player.npcColor=t.color
	player.dialogType = 0

	local typeChoice = player:menuString("How can I help you little one?", typeOpts)
		if (typeChoice == "About Carpentry") then
			player:dialogSeq({t, "Carpentry is a labor intensive skill that allows you to manipulate wood in unusual ways. First by trimming branches, then cutting them to shape. Finally bending and forming them into numerous tools, weapons and even bows.",
						t, "This skill, like other manufacturing skills uses the method of selecting a focus in item creation. You can choose to focus on improving an item's (Completion) or an item's (Quality).",
						t, "Be wary though. Each item has a set number of (Durability) for its creation, taking from it (10 Points) per focus selected. Depending on your selection, there is a (Stamina) cost as well.",
						t, "Finally, pay attention to the items (State). As you progress and item may be in a Poor, Good, or Excellent (State) this state further changes the progress of a selected focus.",
						t, "Who knows.. maybe even other factors weigh in on the creation of items!"}, 1)
		elseif (typeChoice == "Learn Carpentry") then
	
			if (player.registry["smithing_skill"] == 1) then
				craftCount = craftCount + 1
			end

			if (player.registry["tailoring_skill"] == 1) then
				craftCount = craftCount + 1
			end
			
			if (player.registry["carpentry_skill"] == 1) then
				craftCount = craftCount + 1
			end
		
			if (player.registry["alchemy_skill"] == 1) then
				craftCount = craftCount + 1
			end

			if (player.registry["jeweling_skill"] == 1) then
				craftCount = craftCount + 1
			end

			if (player.registry["carpentry_skill"] == 0 and craftCount < 2) then
				local options = {"Yes", "No"}
				local choice = player:menuString("Would you like to become a carpenter?", options)
				
				if (choice == "Yes") then
					player.registry["carpentry_skill"] = 1
					player:dialogSeq({t, "Excellent, lets gets started by teaching you Carpentry, ask me if you need more information or get started by attempting to spin some fibres."}, 1)
				else
					player:dialogSeq({t, "Very well then, maybe another time."}, 1)
					return
				end
			elseif (player.registry["carpentry_skill"] == 0) then
				player:removeLegendbyName("carpentry_skill")
				player.registry["carpentry_skill"] = 0
				player:dialogSeq({t, "I'm sorry, but you can only have a maximum of two crafts. Please forget one if you would like to start Carpentry."}, 1)
				return
			elseif (player.registry["carpentry_skill"] > 0) then
				player:dialogSeq({t, "You have chosen to become a carpenter previously."}, 1)
				return
			end
		elseif (typeChoice == "Forget Carpentry") then
			if(player.registry["carpentry_skill"] == 0) then
				player:dialogSeq({t, "You are not a carpenter to begin with..."}, 1)
				return
			end

			local options = {"Yes", "No"}
			local choice = player:menuString("Are you absolutely sure you wish to forget Carpentry? This will erase all skill you have earned thus far.", options)
			
			if (choice == "Yes") then
				player:dialogSeq({t, "I am sorry that it has come to this, maybe you will find your success in another craft..."}, 1)
				player:removeLegendbyName("carpentry_skill")
				player.registry["carpentry_skill"] = 0
				player.registry["crafting_item"] = 0
				player.registry["refining_item"] = 0
			else
				player:dialogSeq({t, "Not quite ready to give it up, eh?"}, 1)
				return
			end
		elseif (typeChoice == "- Skill Levels") then
			check_skilllevel.click(player, npc)
			return
		elseif (typeChoice == "A bushel, a basket..") then
			local timerAdd = 604800
			local itemGraphic = {graphic = convertGraphic(3313, "item"), color = 0}	
				local qmatA = "Elm Branch"
				local qmatAy = "branch_elm"
				local qmatB = "Birch Branch"
				local qmatBy = "branch_birch"
				local qmatC = "Maple Branch"
				local qmatCy = "branch_maple"
				local qfinalItem = "Branch Crate"
				local qfinalItemy = "branch_crate"

			if (player.registry["gQuest_fTimer"] >= os.time()) then
				player:dialogSeq({t, "I've already gifted you an item recently. You'll need to wait at least another "..(math.ceil((player.registry["gQuest_fTimer"] - os.time())/10800)).." more day(s) before you can receive another."}, 1)

			elseif (player.registry["gQuest_fTimer"] <= os.time()) then
				if (player.quest["gatherQuest_forester"] == 9) then
					if (player:hasItem(qmatAy, 100) == true and player:hasItem(qmatBy, 100) == true and player:hasItem(qmatCy, 100) == true) then
						if (player:hasSpace(qfinalItemy, 1) ~= true) then
							player:dialogSeq({t, "Your pack seems to be too full. Come back when you have lightened your load.\n\n((You need at least *ONE* free slot.))"}, 0)
						else
							player:dialogSeq({t, "Wonderful! I'll be sure to put these items to good use.",
								itemGraphic, "In return, here is the item I spoke to you about. It cannot be dropped, but it can be deposited if you feel you don't need it at the time.",
								t, "However I have dire news, this is the last item I can give to you. While you seem eager to complete my tasks I must also save these items for other adventurers.",
								t, "Good luck on your journies young one, and thank you for all of your devotion to the Tailoring craft!"}, 1)
							player:removeItem(qmatAy, 100)
							player:removeItem(qmatBy, 100)
							player:removeItem(qmatCy, 100)
							player:addItem(qfinalItemy, 1)
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end					
				elseif (player.quest["gatherQuest_forester"] == 8) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_forester"] == 7) then
					if (player:hasItem(qmatAy, 100) == true and player:hasItem(qmatBy, 100) == true and player:hasItem(qmatCy, 100) == true) then
						if (player:hasSpace(qfinalItemy, 1) ~= true) then
							player:dialogSeq({t, "Your pack seems to be too full. Come back when you have lightened your load.\n\n((You need at least *ONE* free slot.))"}, 0)
						else
							player:dialogSeq({t, "Wonderful! I'll be sure to put these items to good use.",
								itemGraphic, "In return, here is the item I spoke to you about.\n\nIt cannot be dropped, but you can deposited if you feel like it.",
								t, "Come back and see me in a few days, I may have another one for you. If you're up for the challenge that is."}, 1)
							player:removeItem(qmatAy, 100)
							player:removeItem(qmatBy, 100)
							player:removeItem(qmatCy, 100)
							player:addItem(qfinalItemy, 1)
							player.registry["gQuest_fTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_forester"] == 6) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_forester"] == 5) then
					if (player:hasItem(qmatAy, 100) == true and player:hasItem(qmatBy, 100) == true and player:hasItem(qmatCy, 100) == true) then
						if (player:hasSpace(qfinalItemy, 1) ~= true) then
							player:dialogSeq({t, "Your pack seems to be too full. Come back when you have lightened your load.\n\n((You need at least *ONE* free slot.))"}, 0)
						else
							player:dialogSeq({t, "Wonderful! I'll be sure to put these items to good use.",
								itemGraphic, "In return, here is the item I spoke to you about.\n\nIt cannot be dropped, but you can deposited if you feel like it.",
								t, "Come back and see me in a few days, I may have another one for you. If you're up for the challenge that is."}, 1)
							player:removeItem(qmatAy, 100)
							player:removeItem(qmatBy, 100)
							player:removeItem(qmatCy, 100)
							player:addItem(qfinalItemy, 1)
							player.registry["gQuest_fTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_forester"] == 4) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_forester"] == 3) then
					if (player:hasItem(qmatAy, 100) == true and player:hasItem(qmatBy, 100) == true and player:hasItem(qmatCy, 100) == true) then
						if (player:hasSpace(qfinalItemy, 1) ~= true) then
							player:dialogSeq({t, "Your pack seems to be too full. Come back when you have lightened your load.\n\n((You need at least *ONE* free slot.))"}, 0)
						else
							player:dialogSeq({t, "Wonderful! I'll be sure to put these items to good use.",
								itemGraphic, "In return, here is the item I spoke to you about.\n\nIt cannot be dropped, but you can deposited if you feel like it.",
								t, "Come back and see me in a few days, I may have another one for you. If you're up for the challenge that is."}, 1)
							player:removeItem(qmatAy, 100)
							player:removeItem(qmatBy, 100)
							player:removeItem(qmatCy, 100)
							player:addItem(qfinalItemy, 1)
							player.registry["gQuest_fTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_forester"] == 2) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_forester"] == 1) then
					if (player:hasItem(qmatAy, 100) == true and player:hasItem(qmatBy, 100) == true and player:hasItem(qmatCy, 100) == true) then
						if (player:hasSpace(qfinalItemy, 1) ~= true) then
							player:dialogSeq({t, "Your pack seems to be too full. Come back when you have lightened your load.\n\n((You need at least *ONE* free slot.))"}, 0)
						else
							player:dialogSeq({t, "Wonderful! I'll be sure to put these items to good use.",
								itemGraphic, "In return, here is the item I spoke to you about.\n\nIt cannot be dropped, but you can deposited if you feel like it.",
								t, "Come back and see me in a few days, I may have another one for you. If you're up for the challenge that is."}, 1)
							player:removeItem(qmatAy, 100)
							player:removeItem(qmatBy, 100)
							player:removeItem(qmatCy, 100)
							player:addItem(qfinalItemy, 1)
							player.registry["gQuest_fTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_forester"] == 0) then
					player:dialogSeq({t, "It seems you're very keen on gathering materials..",
						t, "If you feel willing, I have a small task for you that will in turn help you in the long run.",
						itemGraphic, "Complete it and I shall grant you a mystical item, that will multiple your strength by five!!",
						t, "I'm kidding of course.. But I am not joking about this items magic potential. It can grant those who use it the ability to hold up to five times more than their normal carrying capacity.",
						t, "Instead of needing to run back to the inn, you can simple toss your items into this and continue your search."}, 1)
					local finaldecision = player:menuString("Are you willing to accept this task?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player:dialogSeq({t, "The task is simple; all you need to do is gather the following for me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
								t, "While this may seem a bit steep, the rewards are well worth it.\n\nYou wont need to travel to the Inn Keeper as frequently as before.\n\n*laughs*",
								itemGraphic, "Return to me once you've gathered these item and I'll give you one of these bags in return."}, 1)
							player.quest["gatherQuest_forester"] = player.quest["gatherQuest_forester"] + 1
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				end
			end
		end
end),

say=function(player,npc)
	local ibuylist = {40229, 178, 188, 40094, 40075, 199, 40090, 40086, 40105, 40325, 40098, 40333, 40337,40071, 200, 40083, 40102, 40095, 40076, 201, 40091, 40087, 40106, 40326, 40099, 40334, 40338, 40072, 202, 40084, 40103, 40096, 40077, 203, 40092, 40088, 40107, 40327, 40100, 40335, 40339, 40073, 204, 20001, 477, 20002, 40085, 40104, 40097, 40078, 476, 20003, 479, 40093, 40089, 40108, 40328, 40101, 40336, 40340, 40074, 20004, 20005, 481}
	local ibuylistprice = {}
	local s = player.speech

	local mobG = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.dialogType = 0
	player.npcGraphic = mobG.graphic
	player.npcColor = mobG.color

	if (string.match(string.lower(s), "buy all my") ~= nil or string.match(string.lower(s), "buy my") ~= nil) then
		player:sellSpeech(npc, s, ibuylist)
	end
end,
}

-- REFINEMENT MACHINE
carpentry_saw = {
click = async(function(player, mob)

		local mobG = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
		player.dialogType = 0
		player.npcGraphic = mobG.graphic
		player.npcColor = mobG.color
		local options = {}

		if (player.registry["carpentry_skill"] == 0) then
			player:dialogSeq({mobG, "You are not skilled to use this."}, 1)
			return
		end
		if (player.registry["carpentry_skill"] >= 1) then
			table.insert(options, "Plane: Elm")
		end
		if (player.registry["carpentry_skill"] >= 220) then
			table.insert(options, "Plane: Birch")
		end
		if (player.registry["carpentry_skill"] >= 2200) then
			table.insert(options, "Plane: Maple")
		end
		if (player.registry["carpentry_skill"] >= 18000) then
			table.insert(options, "Plane: Cherry")
		end
		if (player.registry["carpentry_skill"] >= 124000) then
			table.insert(options, "Plane: Oak")
		end

		local menuOpt = player:menuString("What material are you attempting to make?", options)
		if(menuOpt == "Plane: Elm") then
			player.registry["refining_item"] = 40066
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Plane: Birch") then
			player.registry["refining_item"] = 40067
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Plane: Maple") then
			player.registry["refining_item"] = 40068
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Plane: Cherry") then
			player.registry["refining_item"] = 40069
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Plane: Oak") then
			player.registry["refining_item"] = 40070
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		end

end),

on_attacked = function(mob,player)
	player.damage = 0

	local probChance = ((math.random(100))/100)
	local spoilchance = 0
	local block = getTargetFacing(player, BL_MOB)
	local tool = player:getEquippedItem(EQ_WEAP)

	local itemc = {graphic = Item(player.registry["refining_item"]).icon, color = Item(player.registry["refining_item"]).iconC}

	if (block.id == mob.id) then
		if (tool ~= nil and (tool.id == 40098 or tool.id == 40099 or tool.id == 40100 or tool.id == 40101)) then

			if (player.registry["refining_item"] == 40066) then
				if (player:hasItem(40061, 2) == true) then
					if (player.registry["carpentry_skill"] < 25) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 25 and player.registry["carpentry_skill"] < 220) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 220 and player.registry["carpentry_skill"] < 840) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 840) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40061, 2)
					player:addItem("wood_elm", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
						if (player.registry["carpentry_skill"] < 210) then
						player.registry["carpentry_skill"] = player.registry["carpentry_skill"] + 1
						carpentry_saw.calcSkill(player)
						end
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)
					else
						--ADD FAIL
					player:removeItem(40061, 2)
					player:addItem("woodchips", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
					end
					
				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 40067) then
				if (player:hasItem(40062, 2) == true) then
					if (player.registry["carpentry_skill"] < 840) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 840 and player.registry["carpentry_skill"] < 2200) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 2200 and player.registry["carpentry_skill"] < 6400) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 6400) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40062, 2)
					player:addItem("wood_birch", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)

					else
						--ADD FAIL
					player:removeItem(40062, 2)
					player:addItem("woodchips", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
					end
				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 40068) then
				if (tool.id == 40098) then
					player:dialogSeq({itemc, "You need a stronger tool for this material."}, 0)
				end
				if (player:hasItem(40063, 2) == true) then
					if (player.registry["carpentry_skill"] < 6400) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 6400 and player.registry["carpentry_skill"] < 18000) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 18000 and player.registry["carpentry_skill"] < 50000) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 50000) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40063, 2)
					player:addItem("wood_maple", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)

					else
						--ADD FAIL
					player:removeItem(40063, 2)
					player:addItem("woodchips", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 40069) then
				if (tool.id == 40098 or tool.id == 40099) then
					player:dialogSeq({itemc, "You need a stronger tool for this material."}, 0)
				end
				if (player:hasItem(40064, 2) == true) then
					if (player.registry["carpentry_skill"] < 50000) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 50000 and player.registry["carpentry_skill"] < 124000) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 124000 and player.registry["carpentry_skill"] < 237000) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 237000) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40064, 2)
					player:addItem("wood_cherry", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)

					else
						--ADD FAIL
					player:removeItem(40064, 2)
					player:addItem("woodchips", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 40070) then
				if (tool.id == 40098 or tool.id == 40099 or tool.id == 40100) then
					player:dialogSeq({itemc, "You need a stronger tool for this material."}, 0)
				end
				if (player:hasItem(40065, 2) == true) then
					if (player.registry["carpentry_skill"] < 237000) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 237000 and player.registry["carpentry_skill"] < 400000) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 400000 and player.registry["carpentry_skill"] < 680000) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["carpentry_skill"] >= 680000) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40065, 2)
					player:addItem("cloth_silk", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)
					else
						--ADD FAIL
					player:removeItem(40065, 2)
					player:addItem("woodchips", 1)
					player:sendAnimation(269, 0)
					player:playSound(355)
					mob:sendAnimation(302, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			end
		end
	end
end,

calcSkill = function(player)
			if (player.registry["carpentry_skill"] < 25) then
				craftlevel = "Aptitude I"
			elseif (player.registry["carpentry_skill"] >= 25 and player.registry["carpentry_skill"] < 220) then
				craftlevel = "Aptitude II"
			elseif (player.registry["carpentry_skill"] >= 220 and player.registry["carpentry_skill"] < 840) then
				craftlevel = "Aptitude III"
			elseif (player.registry["carpentry_skill"] >= 840 and player.registry["carpentry_skill"] < 2200) then
				craftlevel = "Aptitude IV"
			elseif (player.registry["carpentry_skill"] >= 2200 and player.registry["carpentry_skill"] < 6400) then
				craftlevel = "Aptitude V"
			elseif (player.registry["carpentry_skill"] >= 6400 and player.registry["carpentry_skill"] < 18000) then
				craftlevel = "Aptitude VI"
			elseif (player.registry["carpentry_skill"] >= 18000 and player.registry["carpentry_skill"] < 50000) then
				craftlevel = "Aptitude VII"
			elseif (player.registry["carpentry_skill"] >= 50000 and player.registry["carpentry_skill"] < 124000) then
				craftlevel = "Aptitude VIII"
			elseif (player.registry["carpentry_skill"] >= 124000 and player.registry["carpentry_skill"] < 237000) then
				craftlevel = "Aptitude IX"
			elseif (player.registry["carpentry_skill"] >= 237000 and player.registry["carpentry_skill"] < 400000) then
				craftlevel = "Aptitude X"
			elseif (player.registry["carpentry_skill"] >= 400000 and player.registry["carpentry_skill"] < 680000) then
				craftlevel = "Aptitude XI"
			elseif (player.registry["carpentry_skill"] >= 680000) then
				craftlevel = "Master"
			end
			
			if (player.registry["carpentry_skill"] < 680000) then
				player:removeLegendbyName("carpentry_skill")
				player:addLegend("Carpenter: "..craftlevel, "carpentry_skill", 7, 128)
			elseif (player.registry["carpentry_skill"] >= 680000) then
				player:removeLegendbyName("carpentry_skill")
				player:addLegend(craftlevel.." Carpenter", "carpentry_skill", 66, 128)
			end
end,
}

-- MANUFACTURING MACHINE
carpentry_table = {
click = async(function(player, mob)
	
	local craftOptions = {}
	local aptitudeOptions = {}

	local options = {"Yes", "No"}
	local typeOpts = {"Gathering Tools", "Crafting Tools", "Carpenter Staves", "Carpenter Bows", "Carpenter Polearms"}

	player.dialogType = 0
	local manuf = {graphic = convertGraphic(745, "monster"), color = 0}
	player.npcGraphic = manuf.graphic
	player.npcColor = manuf.color

	if (player.registry["carpentry_skill"] == 0) then
		player:dialogSeq({manuf, "You are not skilled to use this."}, 1)
		return
	end

			if (player.registry["carpentry_skill"] >= 1) then
				table.insert(aptitudeOptions, "Aptitude I")
			end
			if (player.registry["carpentry_skill"] >= 25) then
				table.insert(aptitudeOptions, "Aptitude II")
			end
			if (player.registry["carpentry_skill"] >= 220) then
				table.insert(aptitudeOptions, "Aptitude III")
			end
			if (player.registry["carpentry_skill"] >= 840) then
				table.insert(aptitudeOptions, "Aptitude IV")
			end
			if (player.registry["carpentry_skill"] >= 2200) then
				table.insert(aptitudeOptions, "Aptitude V")
			end
			if (player.registry["carpentry_skill"] >= 6400) then
				table.insert(aptitudeOptions, "Aptitude VI")
			end
			if (player.registry["carpentry_skill"] >= 18000) then
				table.insert(aptitudeOptions, "Aptitude VII")
			end
			if (player.registry["carpentry_skill"] >= 50000) then
				table.insert(aptitudeOptions, "Aptitude VIII")
			end
			if (player.registry["carpentry_skill"] >= 124000) then
				table.insert(aptitudeOptions, "Aptitude IX")
			end
			if (player.registry["carpentry_skill"] >= 237000) then
				table.insert(aptitudeOptions, "Aptitude X")
			end
			if (player.registry["carpentry_skill"] >= 400000) then
				table.insert(aptitudeOptions, "Aptitude XI")
			end
			if (player.registry["carpentry_skill"] >= 680000) then
				table.insert(aptitudeOptions, "Master")
			end

	local itemAptitude = player:menuString2("Which category?", aptitudeOptions)
		if(itemAptitude == "Aptitude I") then
			table.insert(craftOptions, "Dull Pickaxe")
			table.insert(craftOptions, "Dull Shears")
			table.insert(craftOptions, "Dull Axe")
			table.insert(craftOptions, "Dull Sickle")
			table.insert(craftOptions, "Basic Staff")
		elseif(itemAptitude == "Aptitude II") then
			table.insert(craftOptions, "Dull Tongs")
			table.insert(craftOptions, "Dull Hammer")
			table.insert(craftOptions, "Dull Bobbin")
			table.insert(craftOptions, "Dull Shears")
			table.insert(craftOptions, "Dull Planer")
			table.insert(craftOptions, "Dull Toolbox")
			table.insert(craftOptions, "Dull Knife")
			table.insert(craftOptions, "Dull Pestle")
			table.insert(craftOptions, "Average Staff")
		elseif(itemAptitude == "Aptitude III") then
			table.insert(craftOptions, "Basic Pickaxe")
			table.insert(craftOptions, "Basic Shears")
			table.insert(craftOptions, "Basic Axe")
			table.insert(craftOptions, "Basic Sickle")
			table.insert(craftOptions, "Tough Staff")
		elseif(itemAptitude == "Aptitude IV") then
			table.insert(craftOptions, "Basic Tongs")
			table.insert(craftOptions, "Basic Hammer")
			table.insert(craftOptions, "Basic Bobbin")
			table.insert(craftOptions, "Basic Scissors")
			table.insert(craftOptions, "Basic Planer")
			table.insert(craftOptions, "Basic Toolbox")
			table.insert(craftOptions, "Basic Knife")
			table.insert(craftOptions, "Basic Pestle")
			table.insert(craftOptions, "Fine Staff")
		elseif(itemAptitude == "Aptitude V") then
			table.insert(craftOptions, "Metallic Pickaxe")
			table.insert(craftOptions, "Metallic Shears")
			table.insert(craftOptions, "Metallic Axe")
			table.insert(craftOptions, "Metallic Sickle")
			table.insert(craftOptions, "Durable Staff")
		elseif(itemAptitude == "Aptitude VI") then
			table.insert(craftOptions, "Metallic Tongs")
			table.insert(craftOptions, "Metallic Hammer")
			table.insert(craftOptions, "Metallic Bobbin")
			table.insert(craftOptions, "Metallic Scissors")
			table.insert(craftOptions, "Metallic Planer")
			table.insert(craftOptions, "Metallic Toolbox")
			table.insert(craftOptions, "Metallic Knife")
			table.insert(craftOptions, "Metallic Pestle")
			table.insert(craftOptions, "Strong Staff")
			table.insert(craftOptions, "Trainee's Bow")
			table.insert(craftOptions, "Lesser Polearm")
		elseif(itemAptitude == "Aptitude VII") then
			--table.insert(craftOptions, "Branch Crate")
			table.insert(craftOptions, "Longbow")
		elseif(itemAptitude == "Aptitude VIII") then
			table.insert(craftOptions, "Golden Pickaxe")
			table.insert(craftOptions, "Golden Shears")
			table.insert(craftOptions, "Golden Axe")
			table.insert(craftOptions, "Golden Sickle")
			table.insert(craftOptions, "Gold Statue")
			table.insert(craftOptions, "Recurve Bow")
			table.insert(craftOptions, "Greater Polearm")
		elseif(itemAptitude == "Aptitude IX") then
			table.insert(craftOptions, "Golden Tongs")
			table.insert(craftOptions, "Golden Hammer")
			table.insert(craftOptions, "Golden Bobbin")
			table.insert(craftOptions, "Golden Scissors")
			table.insert(craftOptions, "Golden Planer")
			table.insert(craftOptions, "Golden Toolbox")
			table.insert(craftOptions, "Golden Knife")
			table.insert(craftOptions, "Golden Pestle")
			table.insert(craftOptions, "Compound Bow")		
		elseif(itemAptitude == "Aptitude X") then
			table.insert(craftOptions, "Traitor's Bow")
			table.insert(craftOptions, "Superior Polearm")
		end
	local itemToCraft = player:menuString2("Craft which item?", craftOptions)

	---- APTITUDE I
		if(itemToCraft == "Dull Pickaxe") then
			player.registry["crafting_item"] = 178
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Shears") then
			player.registry["crafting_item"] = 188
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Axe") then
			player.registry["crafting_item"] = 40094
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Sickle") then
			player.registry["crafting_item"] = 40075
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Staff") then
			player.registry["crafting_item"] = 199
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE II
		if(itemToCraft == "Dull Tongs") then
			player.registry["crafting_item"] = 40090
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Hammer") then
			player.registry["crafting_item"] = 40086
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Bobbin") then
			player.registry["crafting_item"] = 40105
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Scissors") then
			player.registry["crafting_item"] = 40325
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Planer") then
			player.registry["crafting_item"] = 40098
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Toolbox") then
			player.registry["crafting_item"] = 40333
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Knife") then
			player.registry["crafting_item"] = 40337
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Pestle") then
			player.registry["crafting_item"] = 40071
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Average Staff") then
			player.registry["crafting_item"] = 200
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE III
		if(itemToCraft == "Basic Pickaxe") then
			player.registry["crafting_item"] = 40083
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Shears") then
			player.registry["crafting_item"] = 40102
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Axe") then
			player.registry["crafting_item"] = 40095
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Sickle") then
			player.registry["crafting_item"] = 40076
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tough Staff") then
			player.registry["crafting_item"] = 201
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE IV
		if(itemToCraft == "Basic Tongs") then
			player.registry["crafting_item"] = 40091
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Hammer") then
			player.registry["crafting_item"] = 40087
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Bobbin") then
			player.registry["crafting_item"] = 40106
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Scissors") then
			player.registry["crafting_item"] = 40326
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Planer") then
			player.registry["crafting_item"] = 40099
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Toolbox") then
			player.registry["crafting_item"] = 40334
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Knife") then
			player.registry["crafting_item"] = 40338
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Pestle") then
			player.registry["crafting_item"] = 40072
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Fine Staff") then
			player.registry["crafting_item"] = 202
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE V
		if(itemToCraft == "Metallic Pickaxe") then
			player.registry["crafting_item"] = 40084
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Shears") then
			player.registry["crafting_item"] = 40103
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Axe") then
			player.registry["crafting_item"] = 40096
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Sickle") then
			player.registry["crafting_item"] = 40077
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Durable Staff") then
			player.registry["crafting_item"] = 203
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE VI
		if(itemToCraft == "Metallic Tongs") then
			player.registry["crafting_item"] = 40092
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Hammer") then
			player.registry["crafting_item"] = 40088
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Bobbin") then
			player.registry["crafting_item"] = 40107
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Scissors") then
			player.registry["crafting_item"] = 40327
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Planer") then
			player.registry["crafting_item"] = 40100
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Toolbox") then
			player.registry["crafting_item"] = 40335
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Knife") then
			player.registry["crafting_item"] = 40339
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Metallic Pestle") then
			player.registry["crafting_item"] = 40073
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Strong Staff") then
			player.registry["crafting_item"] = 204
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Trainee's Bow") then
			player.registry["crafting_item"] = 20001
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Lesser Polearm") then
			player.registry["crafting_item"] = 477
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE VII
		if(itemToCraft == "Longbow") then
			player.registry["crafting_item"] = 20002
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE VIII
		if(itemToCraft == "Golden Pickaxe") then
			player.registry["crafting_item"] = 40085
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Shears") then
			player.registry["crafting_item"] = 40104
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Axe") then
			player.registry["crafting_item"] = 40097
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Sickle") then
			player.registry["crafting_item"] = 40078
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Gold Statue") then
			player.registry["crafting_item"] = 476
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Recurve Bow") then
			player.registry["crafting_item"] = 20003
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Greater Polearm") then
			player.registry["crafting_item"] = 479
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE IX
		if(itemToCraft == "Golden Tongs") then
			player.registry["crafting_item"] = 40093
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Hammer") then
			player.registry["crafting_item"] = 40089
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Bobbin") then
			player.registry["crafting_item"] = 40108
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Scissors") then
			player.registry["crafting_item"] = 40328
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Planer") then
			player.registry["crafting_item"] = 40101
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Toolbox") then
			player.registry["crafting_item"] = 40336
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Knife") then
			player.registry["crafting_item"] = 40340
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Golden Pestle") then
			player.registry["crafting_item"] = 40074
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Compound Bow") then
			player.registry["crafting_item"] = 20004
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end	
	---- APTITUDE X
		if(itemToCraft == "Traitor's Bow") then
			player.registry["crafting_item"] = 20005
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Superior Polearm") then
			player.registry["crafting_item"] = 481
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE XI
	---- MASTER

end),

on_attacked = function(mob,player)
	local skill_weapID1 = 40333
	local skill_weapID2 = 40334
	local skill_weapID3 = 40335
	local skill_weapID4 = 40336
	player.damage = 0

	player.dialogType = 0
	local manuf = {graphic = convertGraphic(745, "monster"), color = 0}
	player.npcGraphic = manuf.graphic
	player.npcColor = manuf.color

	if (player.registry["carpentry_skill"] > 0) then

		local itemSelected = player.registry["crafting_item"]
		local block = getTargetFacing(player, BL_MOB)
		local tool = player:getEquippedItem(EQ_WEAP)

		if (block.id == mob.id) then
			if (tool ~= nil and (tool.id == skill_weapID1 or tool.id == skill_weapID2 or tool.id == skill_weapID3 or tool.id == skill_weapID4)) then

	---- APTITUDE I
				if (itemSelected == 178) then
					local itemName = "Dull Pickaxe"
					local itemNameY = "pickaxe_i"
					local itemNameRareY = "pickaxe_i"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 1
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 188) then
					local itemName = "Dull Shears"
					local itemNameY = "shears_i"
					local itemNameRareY = "shears_i"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 1
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40094) then
					local itemName = "Dull Axe"
					local itemNameY = "axe_i"
					local itemNameRareY = "axe_i"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 1
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40075) then
					local itemName = "Dull Sickle"
					local itemNameY = "sickle_i"
					local itemNameRareY = "sickle_i"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 1
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 199) then
					local itemName = "Basic Staff"
					local itemNameY = "basic_staff"
					local itemNameRareY = "basic_staff_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE II
				if (itemSelected == 40090) then
					local itemName = "Dull Tongs"
					local itemNameY = "tongs_i"
					local itemNameRareY = "tongs_i"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40086) then
					local itemName = "Dull Hammer"
					local itemNameY = "hammer_i"
					local itemNameRareY = "hammer_i"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40105) then
					local itemName = "Dull Bobbin"
					local itemNameY = "bobbin_i"
					local itemNameRareY = "bobbin_i"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40325) then
					local itemName = "Dull Scissors"
					local itemNameY = "scissors_i"
					local itemNameRareY = "scissors_i"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40098) then
					local itemName = "Dull Planer"
					local itemNameY = "planer_i"
					local itemNameRareY = "planer_i"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40333) then
					local itemName = "Dull Toolbox"
					local itemNameY = "toolbox_i"
					local itemNameRareY = "toolbox_i"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40337) then
					local itemName = "Dull Knife"
					local itemNameY = "knife_i"
					local itemNameRareY = "knife_i"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40071) then
					local itemName = "Dull Pestle"
					local itemNameY = "pestle_i"
					local itemNameRareY = "pestle_i"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 200) then
					local itemName = "Average Staff"
					local itemNameY = "average_staff"
					local itemNameRareY = "average_staff_po"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Elm Plank"
					local mat1y = "wood_elm"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE III
				if (itemSelected == 40083) then
					local itemName = "Basic Pickaxe"
					local itemNameY = "pickaxe_ii"
					local itemNameRareY = "pickaxe_ii"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 2
					local mat2 = "Elm Plank"
					local mat2y = "wood_elm"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40102) then
					local itemName = "Basic Shears"
					local itemNameY = "shears_ii"
					local itemNameRareY = "shears_ii"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 2
					local mat2 = "Elm Plank"
					local mat2y = "wood_elm"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40095) then
					local itemName = "Basic Axe"
					local itemNameY = "axe_ii"
					local itemNameRareY = "axe_ii"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 2
					local mat2 = "Elm Plank"
					local mat2y = "wood_elm"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40076) then
					local itemName = "Basic Sickle"
					local itemNameY = "sickle_ii"
					local itemNameRareY = "sickle_ii"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 2
					local mat2 = "Elm Plank"
					local mat2y = "wood_elm"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 201) then
					local itemName = "Tough Staff"
					local itemNameY = "tough_staff"
					local itemNameRareY = "tough_staff_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 2
					local mat2 = "Elm Plank"
					local mat2y = "wood_elm"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE IV
				if (itemSelected == 40091) then
					local itemName = "Basic Tongs"
					local itemNameY = "tongs_ii"
					local itemNameRareY = "tongs_ii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40087) then
					local itemName = "Basic Hammer"
					local itemNameY = "hammer_ii"
					local itemNameRareY = "hammer_ii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40106) then
					local itemName = "Basic Bobbin"
					local itemNameY = "bobbin_ii"
					local itemNameRareY = "bobbin_ii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40326) then
					local itemName = "Basic Scissors"
					local itemNameY = "scissors_ii"
					local itemNameRareY = "scissors_ii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40099) then
					local itemName = "Basic Planer"
					local itemNameY = "planer_ii"
					local itemNameRareY = "planer_ii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40334) then
					local itemName = "Basic Toolbox"
					local itemNameY = "toolbox_ii"
					local itemNameRareY = "toolbox_ii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40338) then
					local itemName = "Basic Knife"
					local itemNameY = "knife_ii"
					local itemNameRareY = "knife_ii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40072) then
					local itemName = "Basic Pestle"
					local itemNameY = "pestle_ii"
					local itemNameRareY = "pestle_ii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 202) then
					local itemName = "Fine Staff"
					local itemNameY = "fine_staff"
					local itemNameRareY = "fine_staff_po"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Birch Plank"
					local mat1y = "wood_birch"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE V
				if (itemSelected == 40084) then
					local itemName = "Metallic Pickaxe"
					local itemNameY = "pickaxe_iii"
					local itemNameRareY = "pickaxe_iii"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 2
					local mat2 = "Birch Plank"
					local mat2y = "wood_birch"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40103) then
					local itemName = "Metallic Shears"
					local itemNameY = "shears_iii"
					local itemNameRareY = "shears_iii"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 2
					local mat2 = "Birch Plank"
					local mat2y = "wood_birch"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40096) then
					local itemName = "Metallic Axe"
					local itemNameY = "axe_iii"
					local itemNameRareY = "axe_iii"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 2
					local mat2 = "Birch Plank"
					local mat2y = "wood_birch"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40077) then
					local itemName = "Metallic Sickle"
					local itemNameY = "sickle_iii"
					local itemNameRareY = "sickle_iii"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 2
					local mat2 = "Birch Plank"
					local mat2y = "wood_birch"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 203) then
					local itemName = "Durable Staff"
					local itemNameY = "durable_staff"
					local itemNameRareY = "durable_staff_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 2
					local mat2 = "Birch Plank"
					local mat2y = "wood_birch"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE VI
				if (itemSelected == 40092) then
					local itemName = "Metallic Tongs"
					local itemNameY = "tongs_iii"
					local itemNameRareY = "tongs_iii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40088) then
					local itemName = "Metallic Hammer"
					local itemNameY = "hammer_iii"
					local itemNameRareY = "hammer_iii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40107) then
					local itemName = "Metallic Bobbin"
					local itemNameY = "bobbin_iii"
					local itemNameRareY = "bobbin_iii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40327) then
					local itemName = "Metallic Scissors"
					local itemNameY = "scissors_iii"
					local itemNameRareY = "scissors_iii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40100) then
					local itemName = "Metallic Planer"
					local itemNameY = "planer_iii"
					local itemNameRareY = "planer_iii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40335) then
					local itemName = "Metallic Toolbox"
					local itemNameY = "toolbox_iii"
					local itemNameRareY = "toolbox_iii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40339) then
					local itemName = "Metallic Knife"
					local itemNameY = "knife_iii"
					local itemNameRareY = "knife_iii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40073) then
					local itemName = "Metallic Pestle"
					local itemNameY = "pestle_iii"
					local itemNameRareY = "pestle_iii"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 204) then
					local itemName = "Strong Staff"
					local itemNameY = "strong_staff"
					local itemNameRareY = "strong_staff_po"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 20001) then
					local itemName = "Trainee's Bow"
					local itemNameY = "archer_50b"
					local itemNameRareY = "archer_50b_po"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 477) then
					local itemName = "Lesser Polearm"
					local itemNameY = "polearm_strike1"
					local itemNameRareY = "polearm_strike1_po"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Maple Plank"
					local mat1y = "wood_maple"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE VII
				if (itemSelected == 20002) then
					local itemName = "Longbow"
					local itemNameY = "archer_65b"
					local itemNameRareY = "archer_65b_po"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Cherry Plank"
					local mat1y = "wood_cherry"
					local cost2 = 5
					local mat2 = "Maple Plank"
					local mat2y = "wood_maple"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 12
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE VIII
				if (itemSelected == 40085) then
					local itemName = "Golden Pickaxe"
					local itemNameY = "pickaxe_iv"
					local itemNameRareY = "pickaxe_iv"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cherry Plank"
					local mat1y = "wood_cherry"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 14
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40104) then
					local itemName = "Golden Shears"
					local itemNameY = "shears_iv"
					local itemNameRareY = "shears_iv"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cherry Plank"
					local mat1y = "wood_cherry"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 14
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40097) then
					local itemName = "Golden Axe"
					local itemNameY = "axe_iv"
					local itemNameRareY = "axe_iv"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cherry Plank"
					local mat1y = "wood_cherry"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 14
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40078) then
					local itemName = "Golden Sickle"
					local itemNameY = "sickle_iv"
					local itemNameRareY = "sickle_iv"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cherry Plank"
					local mat1y = "wood_cherry"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 14
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 476) then
					local itemName = "Gold Statue"
					local itemNameY = "gold_w_statue"
					local itemNameRareY = "gold_w_statue"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cherry Plank"
					local mat1y = "wood_cherry"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 20003) then
					local itemName = "Recurve Bow"
					local itemNameY = "archer_75b"
					local itemNameRareY = "archer_75b_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cherry Plank"
					local mat1y = "wood_cherry"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 479) then
					local itemName = "Greater Polearm"
					local itemNameY = "polearm_strike2"
					local itemNameRareY = "polearm_strike2_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cherry Plank"
					local mat1y = "wood_cherry"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE IX
				if (itemSelected == 40093) then
					local itemName = "Golden Tongs"
					local itemNameY = "tongs_iv"
					local itemNameRareY = "tongs_iv"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 10
					local mat2 = "Cherry Plank"
					local mat2y = "wood_cherry"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40089) then
					local itemName = "Golden Hammer"
					local itemNameY = "hammer_iv"
					local itemNameRareY = "hammer_iv"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 10
					local mat2 = "Cherry Plank"
					local mat2y = "wood_cherry"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40108) then
					local itemName = "Golden Bobbin"
					local itemNameY = "bobbin_iv"
					local itemNameRareY = "bobbin_iv"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 10
					local mat2 = "Cherry Plank"
					local mat2y = "wood_cherry"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40328) then
					local itemName = "Golden Scissors"
					local itemNameY = "scissors_iv"
					local itemNameRareY = "scissors_iv"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 10
					local mat2 = "Cherry Plank"
					local mat2y = "wood_cherry"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40101) then
					local itemName = "Golden Planer"
					local itemNameY = "planer_iv"
					local itemNameRareY = "planer_iv"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 10
					local mat2 = "Cherry Plank"
					local mat2y = "wood_cherry"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40336) then
					local itemName = "Golden Toolbox"
					local itemNameY = "toolbox_iv"
					local itemNameRareY = "toolbox_iv"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 10
					local mat2 = "Cherry Plank"
					local mat2y = "wood_cherry"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40340) then
					local itemName = "Golden Knife"
					local itemNameY = "knife_iv"
					local itemNameRareY = "knife_iv"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 10
					local mat2 = "Cherry Plank"
					local mat2y = "wood_cherry"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 40074) then
					local itemName = "Golden Pestle"
					local itemNameY = "pestle_iv"
					local itemNameRareY = "pestle_iv"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 10
					local mat2 = "Cherry Plank"
					local mat2y = "wood_cherry"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 20004) then
					local itemName = "Compound Bow"
					local itemNameY = "archer_90b"
					local itemNameRareY = "archer_90b_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 10
					local mat2 = "Cherry Plank"
					local mat2y = "wood_cherry"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 20
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE X
				if (itemSelected == 20005) then
					local itemName = "Traitor's Bow"
					local itemNameY = "archer_95b"
					local itemNameRareY = "archer_95b_po"
					local itemAmount = 1
					local cost1 = 25
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 22
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if (itemSelected == 481) then
					local itemName = "Superior Polearm"
					local itemNameY = "polearm_strike3"
					local itemNameRareY = "polearm_strike3_po"
					local itemAmount = 1
					local cost1 = 25
					local mat1 = "Oak Plank"
					local mat1y = "wood_oak"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 22
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					carpentry_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end

			end
		end
	end
end,

craftItem = async(function(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
	local t = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
		player.npcGraphic = t.graphic
		player.npcColor = t.color	
		player.dialogType = 0
				
	local weap = player:getEquippedItem(EQ_WEAP)
	local skill_weapID1 = 40333
	local skill_weapID2 = 40334
	local skill_weapID3 = 40335
	local skill_weapID4 = 40336
	--Remember to change weapon IDs for each crafting class

	if (weap ~= nil and (weap.id == skill_weapID1 or weap.id == skill_weapID2 or weap.id == skill_weapID3 or weap.id == skill_weapID4)) then
		player:deductDura(EQ_WEAP, 5)
	end

	local confirmCraft
	if (cost1 >= 1 and cost2 == 0 and cost3 == 0) then
		confirmCraft = player:menuString3("Crafting a "..itemName.." requires ("..cost1..") "..mat1..". Proceed?", {"Yes", "No"})
	elseif (cost1 >= 1 and cost2 >= 1 and cost3 == 0) then
		confirmCraft = player:menuString3("Crafting a "..itemName.." requires ("..cost1..") "..mat1..", ("..cost2..") "..mat2..". Proceed?", {"Yes", "No"})
	elseif (cost1 >= 1 and cost2 >= 1 and cost3 >= 1) then
		confirmCraft = player:menuString3("Crafting a "..itemName.." requires ("..cost1..") "..mat1..", ("..cost2..") "..mat2..", and ("..cost3..") "..mat3..". Proceed?", {"Yes", "No"})
	end

		if (confirmCraft == "Yes") then
				
				if (cost1 >= 1 and cost2 == 0 and cost3 == 0) then
					if(player:hasItem(mat1y, cost1) == true) then
						player:removeItem(mat1y, cost1)
					else
						player:dialogSeq({t, "Hmm.. You don't seem to have enough material(s) for the job."}, 1)
						return
					end
				elseif (cost1 >= 1 and cost2 >= 1 and cost3 == 0) then
					if(player:hasItem(mat1y, cost1) == true and player:hasItem(mat2y, cost2) == true) then
						player:removeItem(mat1y, cost1)
						player:removeItem(mat2y, cost2)
					else
						player:dialogSeq({t, "Hmm.. You don't seem to have enough material(s) for the job."}, 1)
						return
					end
				elseif (cost1 >= 1 and cost2 >= 1 and cost3 >= 1) then
					if(player:hasItem(mat1y, cost1) == true and player:hasItem(mat2y, cost2) == true and player:hasItem(mat3y, cost3) == true) then
						player:removeItem(mat1y, cost1)
						player:removeItem(mat2y, cost2)
						player:removeItem(mat3y, cost3)
					else
						player:dialogSeq({t, "Hmm.. You don't seem to have enough material(s) for the job."}, 1)
						return
					end
				end

		elseif (confirmCraft == "No") then
			return
		end

		local craftingstamina = 0
		local incrementMod = 0
		local incrementMultiplier = 0
			if (player.registry["carpentry_skill"] < 25) then
				craftingstamina = 20
				incrementMod = 1
				incrementMultiplier = 1
			elseif (player.registry["carpentry_skill"] >= 25 and player.registry["carpentry_skill"] < 220) then
				craftingstamina = 30
				incrementMod = 2
				incrementMultiplier = 1.2
			elseif (player.registry["carpentry_skill"] >= 220 and player.registry["carpentry_skill"] < 840) then
				craftingstamina = 40
				incrementMod = 3
				incrementMultiplier = 1.3
			elseif (player.registry["carpentry_skill"] >= 840 and player.registry["carpentry_skill"] < 2200) then
				craftingstamina = 50
				incrementMod = 4
				incrementMultiplier = 1.4
			elseif (player.registry["carpentry_skill"] >= 2200 and player.registry["carpentry_skill"] < 6400) then
				craftingstamina = 60
				incrementMod = 5
				incrementMultiplier = 1.5
			elseif (player.registry["carpentry_skill"] >= 6400 and player.registry["carpentry_skill"] < 18000) then
				craftingstamina = 70
				incrementMod = 6
				incrementMultiplier = 1.6
			elseif (player.registry["carpentry_skill"] >= 18000 and player.registry["carpentry_skill"] < 50000) then
				craftingstamina = 80
				incrementMod = 7
				incrementMultiplier = 1.7
			elseif (player.registry["carpentry_skill"] >= 50000 and player.registry["carpentry_skill"] < 124000) then
				craftingstamina = 90
				incrementMod = 8
				incrementMultiplier = 1.8
			elseif (player.registry["carpentry_skill"] >= 124000 and player.registry["carpentry_skill"] < 237000) then
				craftingstamina = 100
				incrementMod = 9
				incrementMultiplier = 1.9
			elseif (player.registry["carpentry_skill"] >= 237000 and player.registry["carpentry_skill"] < 400000) then
				craftingstamina = 110
				incrementMod = 10
				incrementMultiplier = 2.0
			elseif (player.registry["carpentry_skill"] >= 400000 and player.registry["carpentry_skill"] < 680000) then
				craftingstamina = 120
				incrementMod = 11
				incrementMultiplier = 2.2
			elseif (player.registry["carpentry_skill"] >= 680000) then
				craftingstamina = 125
				incrementMod = 12
				incrementMultiplier = 2.50
			end

			local cq_modBonus = (incrementMod - itemDifficulty) + 1
	
	local state_mod = 0
	local mod_text = ""
	local mod_math = 0

	--local craftDura = 0
	local currentCraftDura = 0
	local currentCraftStamina = craftingstamina
	local completionper = 0
	local qualityper = 0
	local selected_item = 0
	local item_completed = 0

	currentCraftDura = craftDura

	local cq_options = {551, 554}
	local cq_costs = {10, 15}
	local found

	repeat
		player.dialogType = 0
		local manuf = {graphic = convertGraphic(745, "monster"), color = 0}
		player.npcGraphic = manuf.graphic
		player.npcColor = manuf.color

		cq_options = {}
		cq_costs = {}

		table.insert(cq_options, 551)
		table.insert(cq_costs, 0)

		if (currentCraftStamina >= 10 and player.registry["carpentry_skill"] >= 220) then
			table.insert(cq_options, 552)
			table.insert(cq_costs, 10)
		end

		if (currentCraftStamina >= 20 and player.registry["carpentry_skill"] >= 6400) then
			table.insert(cq_options, 553)
			table.insert(cq_costs, 20)
		end

		if (currentCraftStamina >= 15) then
			table.insert(cq_options, 554)
			table.insert(cq_costs, 15)
		end

		if (currentCraftStamina >= 30 and player.registry["carpentry_skill"] >= 840) then
			table.insert(cq_options, 555)
			table.insert(cq_costs, 30)
		end

		if (currentCraftStamina >= 50 and player.registry["carpentry_skill"] >= 18000) then
			table.insert(cq_options, 556)
			table.insert(cq_costs, 50)
		end

		--State Mod Chance%
		state_mod = math.random(1,3)
		if(state_mod == 1) then
			mod_text = "Poor"
			mod_math = 1.20
		elseif(state_mod == 2) then
			mod_text = "Good"
			mod_math = 1.40
		elseif(state_mod == 3) then
			mod_text = "Excellent"
			mod_math = 1.60
		end

		--Weapon Effects for Crafters.
		--Dull = chance at terrible item quality
		--Basic = normal crafting
		--Metallic = chance at another reroll for good if poor
		--Golden = chance at Superior item quality

		if (skill_weapID1 == weap.id) then
			local mod_lower = math.random(6)
			if (mod_lower == 1) then
				mod_text = "Terrible"
				mod_math = 1
			end
		end

		if (skill_weapID3 == weap.id) then
			local mod_reroll = math.random(5)
			if (state_mod == 1 and (mod_reroll == 1 or mod_reroll == 2)) then
				mod_text = "Good"
				mod_math = 1.40
			end
		end

		if (skill_weapID4 == weap.id) then
			local mod_reroll = math.random(5)
			if (state_mod == 1 and (mod_reroll == 1 or mod_reroll == 2)) then
				mod_text = "Superior"
				mod_math = 2.00
			end
		end


		local temp = player:buy("Durability: \["..currentCraftDura.."/"..craftDura.."\]   Stamina: \["..currentCraftStamina.."/"..craftingstamina.."\] \n\nCompletion: "..completionper.."%       Quality: "..qualityper.."% \n\nItem State: "..mod_text.." \n\n                             Stamina Cost", cq_options, cq_costs, {}, {})

		for x=1,#cq_options do
			if cq_options[x]==temp then
				found=x
				break
			end
		end

		if (temp == 551) then
			--player:dialogSeq({"You clicked complete"..cq_costs[found]}, 1)
			currentCraftDura = currentCraftDura - 10
			currentCraftStamina = currentCraftStamina - cq_costs[found]
			completionper = completionper + ((cq_modBonus + 13) * mod_math)
		elseif (temp == 552) then
			--player:dialogSeq({"You clicked complete"..cq_costs[found]}, 1)
			currentCraftDura = currentCraftDura - 10
			currentCraftStamina = currentCraftStamina - cq_costs[found]
			completionper = completionper + ((cq_modBonus + 14) * mod_math) * incrementMultiplier
		elseif (temp == 553) then
			--player:dialogSeq({"You clicked complete"..cq_costs[found]}, 1)
			currentCraftDura = currentCraftDura - 10
			currentCraftStamina = currentCraftStamina - cq_costs[found]
			completionper = completionper + ((cq_modBonus + 15) * mod_math) * (incrementMultiplier + .25)
		elseif (temp == 554) then
			--player:dialogSeq({"You clicked quality"..cq_costs[found]}, 1)
			local qualBonus = cq_modBonus
			currentCraftDura = currentCraftDura - 10
			currentCraftStamina = currentCraftStamina - cq_costs[found]
			if (qualBonus <= 0) then
				qualBonus = 1
			end
			qualityper = qualityper + (qualBonus * mod_math)
			if (qualityper >= 100) then
				qualityper = 100
			end
		elseif (temp == 555) then
			--player:dialogSeq({"You clicked quality"..cq_costs[found]}, 1)
			local qualBonus = cq_modBonus
			currentCraftDura = currentCraftDura - 10
			currentCraftStamina = currentCraftStamina - cq_costs[found]
			if (qualBonus <= 0) then
				qualBonus = 1
			end
			qualityper = qualityper + (qualBonus * mod_math) * (incrementMultiplier +.25)
			if (qualityper >= 100) then
				qualityper = 100
			end
		elseif (temp == 556) then
			--player:dialogSeq({"You clicked quality"..cq_costs[found]}, 1)
			local qualBonus = cq_modBonus
			currentCraftDura = currentCraftDura - 10
			currentCraftStamina = currentCraftStamina - cq_costs[found]
			if (qualBonus <= 0) then
				qualBonus = 1
			end
			qualityper = qualityper + (qualBonus * mod_math) * (incrementMultiplier + 1)
			if (qualityper >= 100) then
				qualityper = 100
			end
		end

		--SHOW SPELL EFFECT--
		player:sendAnimation(311, 0)
		player:sendAction(1, 20)
		player:playSound(355)
		--SHOW END

		if (completionper >= 100) then
			if (math.floor(qualityper) >= math.random(1, 100)) then
				if (itemNameY == itemNameRareY) then
					player:addItem(itemNameRareY, (itemAmount * 2))
					itemAmount = itemAmount * 2
				else
					player:addItem(itemNameRareY, itemAmount)
				end
			else
				player:addItem(itemNameY, itemAmount)
			end
			item_completed = 1

			if (itemAmount > 1) then
				player:dialogSeq({tItem, "You successfully create "..itemName.." x"..itemAmount.."."}, 1)
			else
				player:dialogSeq({tItem, "You successfully create a "..itemName.."."}, 1)
			end

			--ADD SKILL POINTS
			local skillAdded = math.random(2, 3)

			skillAdded = skillAdded + itemBonus

			player.registry["carpentry_skill"] = player.registry["carpentry_skill"] + (skillAdded * 2)
			
			if (player.registry["carpentry_skill"] < 25) then
				craftlevel = "Aptitude I"
			elseif (player.registry["carpentry_skill"] >= 25 and player.registry["carpentry_skill"] < 220) then
				craftlevel = "Aptitude II"
			elseif (player.registry["carpentry_skill"] >= 220 and player.registry["carpentry_skill"] < 840) then
				craftlevel = "Aptitude III"
			elseif (player.registry["carpentry_skill"] >= 840 and player.registry["carpentry_skill"] < 2200) then
				craftlevel = "Aptitude IV"
			elseif (player.registry["carpentry_skill"] >= 2200 and player.registry["carpentry_skill"] < 6400) then
				craftlevel = "Aptitude V"
			elseif (player.registry["carpentry_skill"] >= 6400 and player.registry["carpentry_skill"] < 18000) then
				craftlevel = "Aptitude VI"
			elseif (player.registry["carpentry_skill"] >= 18000 and player.registry["carpentry_skill"] < 50000) then
				craftlevel = "Aptitude VII"
			elseif (player.registry["carpentry_skill"] >= 50000 and player.registry["carpentry_skill"] < 124000) then
				craftlevel = "Aptitude VIII"
			elseif (player.registry["carpentry_skill"] >= 124000 and player.registry["carpentry_skill"] < 237000) then
				craftlevel = "Aptitude IX"
			elseif (player.registry["carpentry_skill"] >= 237000 and player.registry["carpentry_skill"] < 400000) then
				craftlevel = "Aptitude X"
			elseif (player.registry["carpentry_skill"] >= 400000 and player.registry["carpentry_skill"] < 680000) then
				craftlevel = "Aptitude XI"
			elseif (player.registry["carpentry_skill"] >= 680000) then
				craftlevel = "Master"
			end
			
			if (player.registry["carpentry_skill"] < 680000) then
				player:removeLegendbyName("carpentry_skill")
				player:addLegend("Carpenter: "..craftlevel, "carpentry_skill", 7, 128)
			elseif (player.registry["carpentry_skill"] >= 680000) then
				player:removeLegendbyName("carpentry_skill")
				player:addLegend(craftlevel.." Carpenter", "carpentry_skill", 66, 128)
			end

			--END ADD SKILL POINTS

		end

	until (currentCraftDura <= 0 or item_completed == 1)

		if (currentCraftDura <= 0 and item_completed == 0) then
			player:dialogSeq({tItem, "The item has broken..."}, 1)
		end
		--local tFail={graphic=convertGraphic(36,"item"),color=0}
		--local dumbDialog = "*Sparks fly and you hammer the ingots into shape*"
	end),
}