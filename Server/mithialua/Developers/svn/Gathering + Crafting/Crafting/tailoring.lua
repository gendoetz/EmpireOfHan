han_seamstresscraft = {
click = async(function(player, npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local typeOpts = {}
		table.insert(typeOpts, "About Tailoring")
		table.insert(typeOpts, "Learn Tailoring")
		table.insert(typeOpts, "Forget Tailoring")
		table.insert(typeOpts, " ")
		table.insert(typeOpts, "- Skill Levels")
			if (player.registry["shearer"] >= 6400 and (player.quest["gatherQuest_shearer"] <= 9)) then
				table.insert(typeOpts, " ")
				table.insert(typeOpts, "A bushel, a basket..")
			end

	local craftCount = 0

	player.npcGraphic=t.graphic
	player.npcColor=t.color
	player.dialogType = 0

	local typeChoice = player:menuString("How can I help you little one?", typeOpts)
		if (typeChoice == "About Tailoring") then
			player:dialogSeq({t, "Tailoring is a skill that allows you to create outstanding garments from mere fibres. It begins by spinning loose fibres into fabric, then using that fabric to make garments and satchels.",
						t, "This skill, like other manufacturing skills uses the method of selecting a focus in item creation. You can choose to focus on improving an item's (Completion) or an item's (Quality).",
						t, "Be wary though. Each item has a set number of (Durability) for its creation, taking from it (10 Points) per focus selected. Depending on your selection, there is a (Stamina) cost as well.",
						t, "Finally, pay attention to the items (State). As you progress and item may be in a Poor, Good, or Excellent (State) this state further changes the progress of a selected focus.",
						t, "Who knows.. maybe even other factors weigh in on the creation of items!"}, 1)
		elseif (typeChoice == "Learn Tailoring") then
	
			if (player.registry["smithing_skill"] == 1) then
				craftCount = craftCount + 1
			end

			if (player.registry["tailoring 	_skill"] == 1) then
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

			if (player.registry["tailoring_skill"] == 0 and craftCount < 2) then
				local options = {"Yes", "No"}
				local choice = player:menuString("Would you like to become a tailor?", options)
				
				if (choice == "Yes") then
					player.registry["tailoring_skill"] = 1
					player:dialogSeq({t, "Excellent, lets gets started by teaching you tailoring, ask me if you need more information or get started by attempting to spin some fibres."}, 1)
				else
					player:dialogSeq({t, "Very well then, maybe another time."}, 1)
					return
				end
			elseif (player.registry["tailoring_skill"] == 0) then
				player:removeLegendbyName("tailoring_skill")
				player.registry["tailoring_skill"] = 0
				player:dialogSeq({t, "I'm sorry, but you can only have a maximum of two crafts. Please forget one if you would like to start tailoring."}, 1)
				return
			elseif (player.registry["tailoring_skill"] > 0) then
				player:dialogSeq({t, "You have chosen to become a tailor previously."}, 1)
				return
			end
		elseif (typeChoice == "Forget Tailoring") then
			if(player.registry["tailoring_skill"] == 0) then
				player:dialogSeq({t, "You are not a tailor to begin with..."}, 1)
				return
			end

			local options = {"Yes", "No"}
			local choice = player:menuString("Are you absolutely sure you wish to forget tailoring? This will erase all skill you have earned thus far.", options)
			
			if (choice == "Yes") then
				player:dialogSeq({t, "I am sorry that it has come to this, maybe you will find your success in another craft..."}, 1)
				player:removeLegendbyName("tailoring_skill")
				player.registry["tailoring_skill"] = 0
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
			local itemGraphic = {graphic = convertGraphic(2232, "item"), color = 1}	
				local qmatA = "Wool Clump"
				local qmatAy = "fibre_wool"
				local qmatB = "Merino Clump"
				local qmatBy = "fibre_merino"
				local qmatC = "Angora Clump"
				local qmatCy = "fibre_angora"
				local qfinalItem = "Fibre Bag"
				local qfinalItemy = "fibre_bag"

			if (player.registry["gQuest_sTimer"] >= os.time()) then
				player:dialogSeq({t, "I've already gifted you an item recently. You'll need to wait at least another "..(math.ceil((player.registry["gQuest_sTimer"] - os.time())/10800)).." more day(s) before you can receive another."}, 1)

			elseif (player.registry["gQuest_sTimer"] <= os.time()) then
				if (player.quest["gatherQuest_shearer"] == 9) then
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
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end					
				elseif (player.quest["gatherQuest_shearer"] == 8) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_shearer"] == 7) then
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
							player.registry["gQuest_sTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_shearer"] == 6) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_shearer"] == 5) then
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
							player.registry["gQuest_sTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_shearer"] == 4) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_shearer"] == 3) then
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
							player.registry["gQuest_sTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_shearer"] == 2) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_shearer"] == 1) then
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
							player.registry["gQuest_sTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_shearer"] == 0) then
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
							player.quest["gatherQuest_shearer"] = player.quest["gatherQuest_shearer"] + 1
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				end
			end

		end
end),

say=function(player,npc)

	local ibuylist = {40215, 40329, 18, 19, 20, 21, 84, 85, 86, 87, 40330, 92, 93, 94, 95, 375, 376, 377, 378, 379, 380, 381, 382, 100, 101, 102, 103, 40331, 108, 109, 110, 111, 254, 255, 256, 257, 359, 360, 361, 362, 363, 364, 365, 366, 40332, 752, 753, 754, 755, 768, 769, 770, 771, 784, 785, 786, 787, 117, 118, 119, 120, 121, 122, 123, 124}
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
tailor_loom = {
click = async(function(player, mob)

		local mobG = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
		player.dialogType = 0
		player.npcGraphic = mobG.graphic
		player.npcColor = mobG.color
		local options = {}

		if (player.registry["tailoring_skill"] == 0) then
			player:dialogSeq({mobG, "You are not skilled to use this."}, 1)
			return
		end
		if (player.registry["tailoring_skill"] >= 1) then
			table.insert(options, "Spin: Wool")
		end
		if (player.registry["tailoring_skill"] >= 220) then
			table.insert(options, "Spin: Merino")
		end
		if (player.registry["tailoring_skill"] >= 2200) then
			table.insert(options, "Spin: Angora")
		end
		if (player.registry["tailoring_skill"] >= 18000) then
			table.insert(options, "Spin: Cashmere")
		end
		if (player.registry["tailoring_skill"] >= 124000) then
			table.insert(options, "Spin: Silk")
		end


		local menuOpt = player:menuString("What material are you attempting to make?", options)
		if(menuOpt == "Spin: Wool") then
			player.registry["refining_item"] = 40210
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Spin: Merino") then
			player.registry["refining_item"] = 40211
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Spin: Angora") then
			player.registry["refining_item"] = 40212
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Spin: Cashmere") then
			player.registry["refining_item"] = 40213
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Spin: Silk") then
			player.registry["refining_item"] = 40214
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
		if (tool ~= nil and (tool.id == 40105 or tool.id == 40106 or tool.id == 40107 or tool.id == 40108)) then

			if (player.registry["refining_item"] == 40210) then
				if (player:hasItem(40205, 2) == true) then
					if (player.registry["tailoring_skill"] < 25) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 25 and player.registry["tailoring_skill"] < 220) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 220 and player.registry["tailoring_skill"] < 840) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 840) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40205, 2)
					player:addItem("cloth_wool", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
						if (player.registry["tailoring_skill"] < 210) then
						player.registry["tailoring_skill"] = player.registry["tailoring_skill"] + 1
						tailor_loom.calcSkill(player)
						end
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)
					else
						--ADD FAIL
					player:removeItem(40205, 2)
					player:addItem("cloth_scrap", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
					end
					
				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 40211) then
				if (player:hasItem(40206, 2) == true) then
					if (player.registry["tailoring_skill"] < 840) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 840 and player.registry["tailoring_skill"] < 2200) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 2200 and player.registry["tailoring_skill"] < 6400) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 6400) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40206, 2)
					player:addItem("cloth_merino", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)

					else
						--ADD FAIL
					player:removeItem(40206, 2)
					player:addItem("cloth_scrap", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 40212) then
				if (tool.id == 40105) then
					player:dialogSeq({itemc, "You need a stronger tool for this material."}, 0)
				end
				if (player:hasItem(40207, 2) == true) then
					if (player.registry["tailoring_skill"] < 6400) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 6400 and player.registry["tailoring_skill"] < 18000) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 18000 and player.registry["tailoring_skill"] < 50000) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 50000) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40207, 2)
					player:addItem("cloth_angora", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)

					else
						--ADD FAIL
					player:removeItem(40207, 2)
					player:addItem("cloth_scrap", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 40213) then
				if (tool.id == 40105 or tool.id == 40106) then
					player:dialogSeq({itemc, "You need a stronger tool for this material."}, 0)
				end
				if (player:hasItem(40208, 2) == true) then
					if (player.registry["tailoring_skill"] < 50000) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 50000 and player.registry["tailoring_skill"] < 124000) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 124000 and player.registry["tailoring_skill"] < 237000) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 237000) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40208, 2)
					player:addItem("cloth_cashmere", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)

					else
						--ADD FAIL
					player:removeItem(40208, 2)
					player:addItem("cloth_scrap", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 40214) then
				if (tool.id == 40105 or tool.id == 40106 or tool.id == 40107) then
					player:dialogSeq({itemc, "You need a stronger tool for this material."}, 0)
				end
				if (player:hasItem(40209, 2) == true) then
					if (player.registry["tailoring_skill"] < 237000) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 237000 and player.registry["tailoring_skill"] < 400000) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 400000 and player.registry["tailoring_skill"] < 680000) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["tailoring_skill"] >= 680000) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(40209, 2)
					player:addItem("cloth_silk", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)
					else
						--ADD FAIL
					player:removeItem(40209, 2)
					player:addItem("cloth_scrap", 1)
					player:sendAnimation(272, 0)
					player:playSound(336)
					mob:sendAnimation(325, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			end
		end
	end
end,

calcSkill = function(player)
			if (player.registry["tailoring_skill"] < 25) then
				craftlevel = "Aptitude I"
			elseif (player.registry["tailoring_skill"] >= 25 and player.registry["tailoring_skill"] < 220) then
				craftlevel = "Aptitude II"
			elseif (player.registry["tailoring_skill"] >= 220 and player.registry["tailoring_skill"] < 840) then
				craftlevel = "Aptitude III"
			elseif (player.registry["tailoring_skill"] >= 840 and player.registry["tailoring_skill"] < 2200) then
				craftlevel = "Aptitude IV"
			elseif (player.registry["tailoring_skill"] >= 2200 and player.registry["tailoring_skill"] < 6400) then
				craftlevel = "Aptitude V"
			elseif (player.registry["tailoring_skill"] >= 6400 and player.registry["tailoring_skill"] < 18000) then
				craftlevel = "Aptitude VI"
			elseif (player.registry["tailoring_skill"] >= 18000 and player.registry["tailoring_skill"] < 50000) then
				craftlevel = "Aptitude VII"
			elseif (player.registry["tailoring_skill"] >= 50000 and player.registry["tailoring_skill"] < 124000) then
				craftlevel = "Aptitude VIII"
			elseif (player.registry["tailoring_skill"] >= 124000 and player.registry["tailoring_skill"] < 237000) then
				craftlevel = "Aptitude IX"
			elseif (player.registry["tailoring_skill"] >= 237000 and player.registry["tailoring_skill"] < 400000) then
				craftlevel = "Aptitude X"
			elseif (player.registry["tailoring_skill"] >= 400000 and player.registry["tailoring_skill"] < 680000) then
				craftlevel = "Aptitude XI"
			elseif (player.registry["tailoring_skill"] >= 680000) then
				craftlevel = "Master"
			end
			
			if (player.registry["tailoring_skill"] < 680000) then
				player:removeLegendbyName("tailoring_skill")
				player:addLegend("Tailor: "..craftlevel, "tailoring_skill", 7, 128)
			elseif (player.registry["tailoring_skill"] >= 680000) then
				player:removeLegendbyName("tailoring_skill")
				player:addLegend(craftlevel.." Tailor", "tailoring_skill", 63, 128)
			end
end,
}

-- MANUFACTURING MACHINE
tailor_table = {
click = async(function(player, mob)
	
	local craftOptions = {}
	local aptitudeOptions = {}

	local options = {"Yes", "No"}
	local typeOpts = {"Tailor Supplies", "Tailor Garb", "Tailor Skirt", "Tailor Robe", "Tailor Gown"}
	player.dialogType = 0

	local manuf = {graphic = convertGraphic(744, "monster"), color = 0}
		player.npcGraphic = manuf.graphic
		player.npcColor = manuf.color

	if (player.registry["tailoring_skill"] == 0) then
		player:dialogSeq({manuf, "You are not skilled to use this."}, 1)
		return
	end

		if (player.registry["tailoring_skill"] >= 1) then
			table.insert(aptitudeOptions, "Aptitude I")
		end
		if (player.registry["tailoring_skill"] >= 25) then
			table.insert(aptitudeOptions, "Aptitude II")
		end
		if (player.registry["tailoring_skill"] >= 220) then
			table.insert(aptitudeOptions, "Aptitude III")
		end
		if (player.registry["tailoring_skill"] >= 840) then
			table.insert(aptitudeOptions, "Aptitude IV")
		end
		if (player.registry["tailoring_skill"] >= 2200) then
			table.insert(aptitudeOptions, "Aptitude V")
		end
		if (player.registry["tailoring_skill"] >= 6400) then
			table.insert(aptitudeOptions, "Aptitude VI")
		end
		if (player.registry["tailoring_skill"] >= 18000) then
			table.insert(aptitudeOptions, "Aptitude VII")
		end
		if (player.registry["tailoring_skill"] >= 50000) then
			table.insert(aptitudeOptions, "Aptitude VIII")
		end
		if (player.registry["tailoring_skill"] >= 124000) then
			table.insert(aptitudeOptions, "Aptitude IX")
		end
		if (player.registry["tailoring_skill"] >= 237000) then
			table.insert(aptitudeOptions, "Aptitude X")
		end
		if (player.registry["tailoring_skill"] >= 400000) then
			table.insert(aptitudeOptions, "Aptitude XI")
		end
		if (player.registry["tailoring_skill"] >= 680000) then
			table.insert(aptitudeOptions, "Master")
		end

	local itemAptitude = player:menuString2("Which category?", aptitudeOptions)
		if(itemAptitude == "Aptitude I") then
			table.insert(craftOptions, "Weak Thread")
			table.insert(craftOptions, "Basic Garb")
			table.insert(craftOptions, "Basic Skirt")
			table.insert(craftOptions, "Basic Robe")
			table.insert(craftOptions, "Basic Gown")
		elseif(itemAptitude == "Aptitude II") then
			table.insert(craftOptions, "Average Garb")
			table.insert(craftOptions, "Average Skirt")
			table.insert(craftOptions, "Average Robe")
			table.insert(craftOptions, "Average Gown")
		elseif(itemAptitude == "Aptitude III") then
			table.insert(craftOptions, "Thread")
			table.insert(craftOptions, "Tough Garb")
			table.insert(craftOptions, "Tough Skirt")
			table.insert(craftOptions, "Tough Robe")
			table.insert(craftOptions, "Tough Gown")
			table.insert(craftOptions, " ")
			table.insert(craftOptions, "Vanity Coats - I")
		elseif(itemAptitude == "Aptitude IV") then
			table.insert(craftOptions, "Fine Garb")
			table.insert(craftOptions, "Fine Skirt")
			table.insert(craftOptions, "Fine Robe")
			table.insert(craftOptions, "Fine Gown")
		elseif(itemAptitude == "Aptitude V") then
			table.insert(craftOptions, "Excellent Thread")
			table.insert(craftOptions, "Durable Garb")
			table.insert(craftOptions, "Durable Skirt")
			table.insert(craftOptions, "Durable Robe")
			table.insert(craftOptions, "Durable Gown")
		elseif(itemAptitude == "Aptitude VI") then
			table.insert(craftOptions, "Strong Garb")
			table.insert(craftOptions, "Strong Skirt")
			table.insert(craftOptions, "Strong Robe")
			table.insert(craftOptions, "Strong Gown")
			table.insert(craftOptions, " ")
			table.insert(craftOptions, "Vanity Coats - II")
		elseif(itemAptitude == "Aptitude VII") then
			table.insert(craftOptions, "Embroidery Thread")	
			table.insert(craftOptions, "Celestial Garb")
			table.insert(craftOptions, "Celestial Skirt")
			table.insert(craftOptions, "Celestial Robe")
			table.insert(craftOptions, "Celestial Gown")
		elseif(itemAptitude == "Aptitude VIII") then
			table.insert(craftOptions, "Lunar Garb")
			table.insert(craftOptions, "Lunar Skirt")
			table.insert(craftOptions, "Lunar Robe")
			table.insert(craftOptions, "Lunar Gown")
		elseif(itemAptitude == "Aptitude IX") then
			table.insert(craftOptions, "Solar Garb")
			table.insert(craftOptions, "Solar Skirt")
			table.insert(craftOptions, "Solar Robe")
			table.insert(craftOptions, "Solar Gown")
			table.insert(craftOptions, " ")
			table.insert(craftOptions, "Vanity Coats - III")
		end

	local itemToCraft = player:menuString2("Craft which item?", craftOptions)

---- APTITUDE I
		if(itemToCraft == "Weak Thread") then
			player.registry["crafting_item"] = 40329
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Garb") then
			player.registry["crafting_item"] = 18
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Skirt") then
			player.registry["crafting_item"] = 19
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Robe") then
			player.registry["crafting_item"] = 20
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Gown") then
			player.registry["crafting_item"] = 21
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
---- APTITUDE II
		if(itemToCraft == "Average Garb") then
			player.registry["crafting_item"] = 84
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Average Skirt") then
			player.registry["crafting_item"] = 85
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Average Robe") then
			player.registry["crafting_item"] = 86
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Average Gown") then
			player.registry["crafting_item"] = 87
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
---- APTITUDE III
		if(itemToCraft == "Thread") then
			player.registry["crafting_item"] = 40330
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tough Garb") then
			player.registry["crafting_item"] = 92
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tough Skirt") then
			player.registry["crafting_item"] = 93
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tough Robe") then
			player.registry["crafting_item"] = 94
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tough Gown") then
			player.registry["crafting_item"] = 95
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	-- VANITY COATS - I
		if(itemToCraft == "Vanity Coats - I") then
			local coatOpts = {}
				table.insert(coatOpts, "Simple Mail Coat")
				table.insert(coatOpts, "Simple Mail Dress Coat")
				table.insert(coatOpts, "Simple Armor Coat")
				table.insert(coatOpts, "Simple Armor Dress Coat")
				table.insert(coatOpts, "Simple Garb Coat")
				table.insert(coatOpts, "Simple Skirt Coat")
				table.insert(coatOpts, "Simple Robe Coat")
				table.insert(coatOpts, "Simple Gown Coat")
			local itemToCraft2 = player:menuString2("Craft which item?", coatOpts)
				if(itemToCraft2 == "Simple Mail Coat") then
					player.registry["crafting_item"] = 375
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Simple Mail Dress Coat") then
					player.registry["crafting_item"] = 376
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Simple Armor Coat") then
					player.registry["crafting_item"] = 377
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Simple Armor Dress Coat") then
					player.registry["crafting_item"] = 378
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Simple Garb Coat") then
					player.registry["crafting_item"] = 379
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Simple Skirt Coat") then
					player.registry["crafting_item"] = 380
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Simple Robe Coat") then
					player.registry["crafting_item"] = 381
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Simple Gown Coat") then
					player.registry["crafting_item"] = 382
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
		end
---- APTITUDE IV
		if(itemToCraft == "Fine Garb") then
			player.registry["crafting_item"] = 100
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Fine Skirt") then
			player.registry["crafting_item"] = 101
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Fine Robe") then
			player.registry["crafting_item"] = 102
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Fine Gown") then
			player.registry["crafting_item"] = 103
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
---- APTITUDE V
		if(itemToCraft == "Excellent Thread") then
			player.registry["crafting_item"] = 40331
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Durable Garb") then
			player.registry["crafting_item"] = 108
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Durable Skirt") then
			player.registry["crafting_item"] = 109
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Durable Robe") then
			player.registry["crafting_item"] = 110
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Durable Gown") then
			player.registry["crafting_item"] = 111
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
---- APTITUDE VI
		if(itemToCraft == "Strong Garb") then
			player.registry["crafting_item"] = 254
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Strong Skirt") then
			player.registry["crafting_item"] = 255
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Strong Robe") then
			player.registry["crafting_item"] = 256
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Strong Gown") then
			player.registry["crafting_item"] = 257
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	-- VANITY COATS - II
		if(itemToCraft == "Vanity Coats - II") then
			local coatOpts = {}
				table.insert(coatOpts, "Platemail Coat")
				table.insert(coatOpts, "Platedress Coat")
				table.insert(coatOpts, "Assassin Robes")
				table.insert(coatOpts, "Assassin Skirt")
				table.insert(coatOpts, "Magus Vest")
				table.insert(coatOpts, "Magus Wrap")
				table.insert(coatOpts, "Ceremonial Kesa")
				table.insert(coatOpts, "Ceremonial Kesa Gown")
			local itemToCraft2 = player:menuString2("Craft which item?", coatOpts)
				if(itemToCraft2 == "Platemail Coat") then
					player.registry["crafting_item"] = 359
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Platedress Coat") then
					player.registry["crafting_item"] = 360
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Assassin Robes") then
					player.registry["crafting_item"] = 361
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Assassin Skirt") then
					player.registry["crafting_item"] = 362
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Magus Vest") then
					player.registry["crafting_item"] = 363
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Magus Wrap") then
					player.registry["crafting_item"] = 364
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Ceremonial Kesa") then
					player.registry["crafting_item"] = 365
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Ceremonial Kesa Gown") then
					player.registry["crafting_item"] = 366
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
		end
---- APTITUDE VII
		if(itemToCraft == "Embroidery Thread") then
			player.registry["crafting_item"] = 40332
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Celestial Garb") then
			player.registry["crafting_item"] = 752
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Celestial Skirt") then
			player.registry["crafting_item"] = 753
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Celestial Robe") then
			player.registry["crafting_item"] = 754
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Celestial Gown") then
			player.registry["crafting_item"] = 755
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
---- APTITUDE VIII
		if(itemToCraft == "Lunar Garb") then
			player.registry["crafting_item"] = 768
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Lunar Skirt") then
			player.registry["crafting_item"] = 769
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Lunar Robe") then
			player.registry["crafting_item"] = 770
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Lunar Gown") then
			player.registry["crafting_item"] = 771
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
---- APTITUDE IX
		if(itemToCraft == "Solar Garb") then
			player.registry["crafting_item"] = 784
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Solar Skirt") then
			player.registry["crafting_item"] = 785
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Solar Robe") then
			player.registry["crafting_item"] = 786
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Solar Gown") then
			player.registry["crafting_item"] = 787
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	-- VANITY COATS - III
		if(itemToCraft == "Vanity Coats - III") then
			local coatOpts = {}
				table.insert(coatOpts, "Hero's Mail")
				table.insert(coatOpts, "Heroine's Mail Dress")
				table.insert(coatOpts, "Hero's Armor")
				table.insert(coatOpts, "Heroine's Armor Dress")
				table.insert(coatOpts, "Hero's Garb")
				table.insert(coatOpts, "Heroine's Skirt")
				table.insert(coatOpts, "Hero's Robe")
				table.insert(coatOpts, "Heroine's Gown")
			local itemToCraft2 = player:menuString2("Craft which item?", coatOpts)
				if(itemToCraft2 == "Hero's Mail") then
					player.registry["crafting_item"] = 117
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Heroine's Mail Dress") then
					player.registry["crafting_item"] = 118
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Hero's Armor") then
					player.registry["crafting_item"] = 119
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Heroine's Armor Dress") then
					player.registry["crafting_item"] = 120
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Hero's Garb") then
					player.registry["crafting_item"] = 121
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Heroine's Skirt") then
					player.registry["crafting_item"] = 122
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Hero's Robe") then
					player.registry["crafting_item"] = 123
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
				if(itemToCraft2 == "Heroine's Gown") then
					player.registry["crafting_item"] = 124
					local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
				end
		end

end),

on_attacked = function(mob,player)
	local skill_weapID1 = 40325
	local skill_weapID2 = 40326
	local skill_weapID3 = 40327
	local skill_weapID4 = 40328
	player.damage = 0

	player.dialogType = 0
	local manuf = {graphic = convertGraphic(744, "monster"), color = 0}
		player.npcGraphic = manuf.graphic
		player.npcColor = manuf.color

	if (player.registry["tailoring_skill"] > 0) then

		local itemSelected = player.registry["crafting_item"]
		local block = getTargetFacing(player, BL_MOB)
		local tool = player:getEquippedItem(EQ_WEAP)

		if (block.id == mob.id) then
			if (tool ~= nil and (tool.id == skill_weapID1 or tool.id == skill_weapID2 or tool.id == skill_weapID3 or tool.id == skill_weapID4)) then

	---- APTITUDE I
				if(itemSelected == 40329) then
					local itemName = "Weak Thread"
					local itemNameY = "weak_thread"
					local itemNameRareY = "weak_thread"
					local itemAmount = 5
					local cost1 = 1
					local mat1 = "Wool Cloth"
					local mat1y = "cloth_wool"
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
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 18) then
					local itemName = "Basic Garb"
					local itemNameY = "basicm_garb"
					local itemNameRareY = "basicm_garb_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Wool Cloth"
					local mat1y = "cloth_wool"
					local cost2 = 2
					local mat2 = "Weak Thread"
					local mat2y = "weak_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 19) then
					local itemName = "Basic Skirt"
					local itemNameY = "basicm_skirt"
					local itemNameRareY = "basicm_skirt_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Wool Cloth"
					local mat1y = "cloth_wool"
					local cost2 = 2
					local mat2 = "Weak Thread"
					local mat2y = "weak_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 20) then
					local itemName = "Basic Robe"
					local itemNameY = "basicp_robe"
					local itemNameRareY = "basicp_robe_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Wool Cloth"
					local mat1y = "cloth_wool"
					local cost2 = 2
					local mat2 = "Weak Thread"
					local mat2y = "weak_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 21) then
					local itemName = "Basic Gown"
					local itemNameY = "basicp_gown"
					local itemNameRareY = "basicp_gown_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Wool Cloth"
					local mat1y = "cloth_wool"
					local cost2 = 2
					local mat2 = "Weak Thread"
					local mat2y = "weak_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE II
				if(itemSelected == 84) then
					local itemName = "Average Garb"
					local itemNameY = "averagem_garb"
					local itemNameRareY = "averagem_garb_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Wool Cloth"
					local mat1y = "cloth_wool"
					local cost2 = 3
					local mat2 = "Weak Thread"
					local mat2y = "weak_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 85) then
					local itemName = "Average Skirt"
					local itemNameY = "averagem_skirt"
					local itemNameRareY = "averagem_skirt_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Wool Cloth"
					local mat1y = "cloth_wool"
					local cost2 = 3
					local mat2 = "Weak Thread"
					local mat2y = "weak_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 86) then
					local itemName = "Average Robe"
					local itemNameY = "averagep_robe"
					local itemNameRareY = "averagep_robe_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Wool Cloth"
					local mat1y = "cloth_wool"
					local cost2 = 3
					local mat2 = "Weak Thread"
					local mat2y = "weak_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 87) then
					local itemName = "Average Gown"
					local itemNameY = "averagep_gown"
					local itemNameRareY = "averagep_gown_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Wool Cloth"
					local mat1y = "cloth_wool"
					local cost2 = 3
					local mat2 = "Weak Thread"
					local mat2y = "weak_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE III
				if(itemSelected == 40330) then
					local itemName = "Thread"
					local itemNameY = "reg_thread"
					local itemNameRareY = "reg_thread"
					local itemAmount = 5
					local cost1 = 2
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
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
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 92) then
					local itemName = "Tough Garb"
					local itemNameY = "toughm_garb"
					local itemNameRareY = "toughm_garb_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 2
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 1
					local mat3 = "Weak Thread"
					local mat3y = "weak_thread"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 93) then
					local itemName = "Tough Skirt"
					local itemNameY = "toughm_skirt"
					local itemNameRareY = "toughm_skirt_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 2
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 1
					local mat3 = "Weak Thread"
					local mat3y = "weak_thread"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 94) then
					local itemName = "Tough Robe"
					local itemNameY = "toughp_robe"
					local itemNameRareY = "toughp_robe_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 2
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 1
					local mat3 = "Weak Thread"
					local mat3y = "weak_thread"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 95) then
					local itemName = "Tough Gown"
					local itemNameY = "toughp_gown"
					local itemNameRareY = "toughp_gown_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 2
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 1
					local mat3 = "Weak Thread"
					local mat3y = "weak_thread"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
		-- VANITY COATS - I
				if(itemSelected == 375) then
					local itemName = "Simple Mail Coat"
					local itemNameY = "simple_mail_coat"
					local itemNameRareY = "simple_mail_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 2
					local mat2 = "Merino Cloth"
					local mat2y = "cloth_merino"
					local cost3 = 1
					local mat3 = "Thread"
					local mat3y = "reg_thread"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 376) then
					local itemName = "Simple Mail Dress Coat"
					local itemNameY = "simple_maildress_coat"
					local itemNameRareY = "simple_maildress_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 2
					local mat2 = "Merino Cloth"
					local mat2y = "cloth_merino"
					local cost3 = 1
					local mat3 = "Thread"
					local mat3y = "reg_thread"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 377) then
					local itemName = "Simple Armor Coat"
					local itemNameY = "simple_armor_coat"
					local itemNameRareY = "simple_armor_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 2
					local mat2 = "Merino Cloth"
					local mat2y = "cloth_merino"
					local cost3 = 1
					local mat3 = "Thread"
					local mat3y = "reg_thread"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 378) then
					local itemName = "Simple Armor Dress Coat"
					local itemNameY = "simple_armordress_coat"
					local itemNameRareY = "simple_armordress_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 2
					local mat2 = "Merino Cloth"
					local mat2y = "cloth_merino"
					local cost3 = 1
					local mat3 = "Thread"
					local mat3y = "reg_thread"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 379) then
					local itemName = "Simple Garb Coat"
					local itemNameY = "simple_garb_coat"
					local itemNameRareY = "simple_garb_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 2
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 1
					local mat3 = "Weak Thread"
					local mat3y = "weak_thread"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 380) then
					local itemName = "Simple Skirt Coat"
					local itemNameY = "simple_skirt_coat"
					local itemNameRareY = "simple_skirt_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 2
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 1
					local mat3 = "Weak Thread"
					local mat3y = "weak_thread"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 381) then
					local itemName = "Simple Robe Coat"
					local itemNameY = "simple_robe_coat"
					local itemNameRareY = "simple_robe_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 2
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 1
					local mat3 = "Weak Thread"
					local mat3y = "weak_thread"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 382) then
					local itemName = "Simple Gown Coat"
					local itemNameY = "simple_gown_coat"
					local itemNameRareY = "simple_gown_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 2
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 1
					local mat3 = "Weak Thread"
					local mat3y = "weak_thread"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE IV
				if(itemSelected == 100) then
					local itemName = "Fine Garb"
					local itemNameY = "finem_garb"
					local itemNameRareY = "finem_garb_po"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 3
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 101) then
					local itemName = "Fine Skirt"
					local itemNameY = "finem_skirt"
					local itemNameRareY = "finem_skirt_po"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 3
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 102) then
					local itemName = "Fine Robe"
					local itemNameY = "finep_robe"
					local itemNameRareY = "finep_robe_po"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 3
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 103) then
					local itemName = "Fine Gown"
					local itemNameY = "finep_gown"
					local itemNameRareY = "finep_gown_po"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Merino Cloth"
					local mat1y = "cloth_merino"
					local cost2 = 3
					local mat2 = "Thread"
					local mat2y = "reg_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE V
				if(itemSelected == 40331) then
					local itemName = "Excellent Thread"
					local itemNameY = "excellent_thread"
					local itemNameRareY = "excellent_thread"
					local itemAmount = 5
					local cost1 = 5
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 108) then
					local itemName = "Durable Garb"
					local itemNameY = "durablem_garb"
					local itemNameRareY = "durablem_garb_po"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 109) then
					local itemName = "Durable Skirt"
					local itemNameY = "durablem_skirt"
					local itemNameRareY = "durablem_skirt_po"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 110) then
					local itemName = "Durable Robe"
					local itemNameY = "durablep_robe"
					local itemNameRareY = "durablep_robe_po"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 111) then
					local itemName = "Durable Gown"
					local itemNameY = "durablep_gown"
					local itemNameRareY = "durablep_gown_po"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE VI
				if(itemSelected == 254) then
					local itemName = "Strong Garb"
					local itemNameY = "strongm_garb"
					local itemNameRareY = "strongm_garb_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 7
					local itemDifficulty = 7
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 255) then
					local itemName = "Strong Skirt"
					local itemNameY = "strongm_skirt"
					local itemNameRareY = "strongm_skirt_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 7
					local itemDifficulty = 7
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 256) then
					local itemName = "Strong Robe"
					local itemNameY = "strongp_robe"
					local itemNameRareY = "strongp_robe_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 7
					local itemDifficulty = 7
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 257) then
					local itemName = "Strong Gown"
					local itemNameY = "strongp_gown"
					local itemNameRareY = "strongp_gown_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 7
					local itemDifficulty = 7
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
		-- VANITY COATS - II
				if(itemSelected == 359) then
					local itemName = "Platemail Coat"
					local itemNameY = "platemail_coat"
					local itemNameRareY = "platemail_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Angora Cloth"
					local mat2y = "cloth_angora"
					local cost3 = 1
					local mat3 = "Excellent Thread"
					local mat3y = "excellent_thread"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 8
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 360) then
					local itemName = "Platedress Coat"
					local itemNameY = "platedress_coat"
					local itemNameRareY = "platedress_coat"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Angora Cloth"
					local mat2y = "cloth_angora"
					local cost3 = 1
					local mat3 = "Excellent Thread"
					local mat3y = "excellent_thread"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 8
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 361) then
					local itemName = "Assassin Robes"
					local itemNameY = "assassin_robes"
					local itemNameRareY = "assassin_robes"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Angora Cloth"
					local mat2y = "cloth_angora"
					local cost3 = 1
					local mat3 = "Excellent Thread"
					local mat3y = "excellent_thread"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 8
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 362) then
					local itemName = "Assassin Skirt"
					local itemNameY = "assassin_skirt"
					local itemNameRareY = "assassin_skirt"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Angora Cloth"
					local mat2y = "cloth_angora"
					local cost3 = 1
					local mat3 = "Excellent Thread"
					local mat3y = "excellent_thread"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 8
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 363) then
					local itemName = "Magus Vest"
					local itemNameY = "magus_vest"
					local itemNameRareY = "magus_vest"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 8
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 364) then
					local itemName = "Magus Wrap"
					local itemNameY = "magus_wrap"
					local itemNameRareY = "magus_wrap"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 8
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 365) then
					local itemName = "Ceremonial Kesa"
					local itemNameY = "ceremonial_kesa"
					local itemNameRareY = "ceremonial_kesa"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 8
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 366) then
					local itemName = "Ceremonial Kesa Gown"
					local itemNameY = "ceremonial_kesa_gown"
					local itemNameRareY = "ceremonial_kesa_gown"
					local itemAmount = 1
					local cost1 = 4
					local mat1 = "Angora Cloth"
					local mat1y = "cloth_angora"
					local cost2 = 2
					local mat2 = "Excellent Thread"
					local mat2y = "excellent_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 8
					local itemDifficulty = 8
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE VII
				if(itemSelected == 40332) then
					local itemName = "Embroidery Thread"
					local itemNameY = "embroidery_thread"
					local itemNameRareY = "embroidery_thread"
					local itemAmount = 5
					local cost1 = 10
					local mat1 = "Cashmere Cloth"
					local mat1y = "cloth_cashmere"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 12
					local itemDifficulty = 12
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 752) then
					local itemName = "Celestial Garb"
					local itemNameY = "celestialm_garb"
					local itemNameRareY = "celestialm_garb_po"
					local itemAmount = 1
					local cost1 = 12
					local mat1 = "Cashmere Cloth"
					local mat1y = "cloth_cashmere"
					local cost2 = 3
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Celestial Fragment"
					local mat3y = "cel_fragore"
					local craftDura = 50
					local itemBonus = 13
					local itemDifficulty = 13
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 753) then
					local itemName = "Celestial Skirt"
					local itemNameY = "celestialm_skirt"
					local itemNameRareY = "celestialm_skirt_po"
					local itemAmount = 1
					local cost1 = 12
					local mat1 = "Cashmere Cloth"
					local mat1y = "cloth_cashmere"
					local cost2 = 3
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Celestial Fragment"
					local mat3y = "cel_fragore"
					local craftDura = 50
					local itemBonus = 13
					local itemDifficulty = 13
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 754) then
					local itemName = "Celestial Robe"
					local itemNameY = "celestialp_robe"
					local itemNameRareY = "celestialp_robe_po"
					local itemAmount = 1
					local cost1 = 12
					local mat1 = "Cashmere Cloth"
					local mat1y = "cloth_cashmere"
					local cost2 = 3
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Celestial Fragment"
					local mat3y = "cel_fragore"
					local craftDura = 50
					local itemBonus = 13
					local itemDifficulty = 13
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 755) then
					local itemName = "Celestial Gown"
					local itemNameY = "celestialp_gown"
					local itemNameRareY = "celestialp_gown_po"
					local itemAmount = 1
					local cost1 = 12
					local mat1 = "Cashmere Cloth"
					local mat1y = "cloth_cashmere"
					local cost2 = 3
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Celestial Fragment"
					local mat3y = "cel_fragore"
					local craftDura = 50
					local itemBonus = 13
					local itemDifficulty = 13
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE VIII
				if(itemSelected == 768) then
					local itemName = "Lunar Garb"
					local itemNameY = "lunarm_garb"
					local itemNameRareY = "lunarm_garb_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cashmere Cloth"
					local mat1y = "cloth_cashmere"
					local cost2 = 4
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Lunar Fragment"
					local mat3y = "lun_fragore"
					local craftDura = 50
					local itemBonus = 15
					local itemDifficulty = 15
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 769) then
					local itemName = "Lunar Skirt"
					local itemNameY = "lunarm_skirt"
					local itemNameRareY = "lunarm_skirt_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cashmere Cloth"
					local mat1y = "cloth_cashmere"
					local cost2 = 4
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Lunar Fragment"
					local mat3y = "lun_fragore"
					local craftDura = 50
					local itemBonus = 15
					local itemDifficulty = 15
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 770) then
					local itemName = "Lunar Robe"
					local itemNameY = "lunarp_robe"
					local itemNameRareY = "lunarp_robe_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cashmere Cloth"
					local mat1y = "cloth_cashmere"
					local cost2 = 4
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Lunar Fragment"
					local mat3y = "lun_fragore"
					local craftDura = 50
					local itemBonus = 15
					local itemDifficulty = 15
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 771) then
					local itemName = "Lunar Gown"
					local itemNameY = "lunarp_gown"
					local itemNameRareY = "lunarp_gown_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Cashmere Cloth"
					local mat1y = "cloth_cashmere"
					local cost2 = 4
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Lunar Fragment"
					local mat3y = "lun_fragore"
					local craftDura = 50
					local itemBonus = 15
					local itemDifficulty = 15
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE IX
				if(itemSelected == 784) then
					local itemName = "Solar Garb"
					local itemNameY = "solarm_garb"
					local itemNameRareY = "solarm_garb_po"
					local itemAmount = 1
					local cost1 = 20
					local mat1 = "Silk Cloth"
					local mat1y = "cloth_silk"
					local cost2 = 10
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Sun Fragment"
					local mat3y = "sol_fragore"
					local craftDura = 50
					local itemBonus = 17
					local itemDifficulty = 17
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 785) then
					local itemName = "Solar Skirt"
					local itemNameY = "solarm_skirt"
					local itemNameRareY = "solarm_skirt_po"
					local itemAmount = 1
					local cost1 = 20
					local mat1 = "Silk Cloth"
					local mat1y = "cloth_silk"
					local cost2 = 10
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Sun Fragment"
					local mat3y = "sol_fragore"
					local craftDura = 50
					local itemBonus = 17
					local itemDifficulty = 17
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 786) then
					local itemName = "Solar Robe"
					local itemNameY = "solarp_robe"
					local itemNameRareY = "solarp_robe_po"
					local itemAmount = 1
					local cost1 = 20
					local mat1 = "Silk Cloth"
					local mat1y = "cloth_silk"
					local cost2 = 10
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Sun Fragment"
					local mat3y = "sol_fragore"
					local craftDura = 50
					local itemBonus = 17
					local itemDifficulty = 17
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 787) then
					local itemName = "Solar Gown"
					local itemNameY = "solarp_gown"
					local itemNameRareY = "solarp_gown_po"
					local itemAmount = 1
					local cost1 = 20
					local mat1 = "Silk Cloth"
					local mat1y = "cloth_silk"
					local cost2 = 10
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 1
					local mat3 = "Sun Fragment"
					local mat3y = "sol_fragore"
					local craftDura = 50
					local itemBonus = 17
					local itemDifficulty = 17
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
		-- VANITY COATS - III
				if(itemSelected == 117) then
					local itemName = "Hero's Mail"
					local itemNameY = "warrior_mail99_coat"
					local itemNameRareY = "warrior_mail99_coat"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 10
					local mat2 = "Silk Cloth"
					local mat2y = "cloth_silk"
					local cost3 = 10
					local mat3 = "Embroidery Thread"
					local mat3y = "embroidery_thread"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 118) then
					local itemName = "Heroine's Mail Dress"
					local itemNameY = "warrior_maildress99_coat"
					local itemNameRareY = "warrior_maildress99_coat"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 10
					local mat2 = "Silk Cloth"
					local mat2y = "cloth_silk"
					local cost3 = 10
					local mat3 = "Embroidery Thread"
					local mat3y = "embroidery_thread"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 119) then
					local itemName = "Hero's Armor"
					local itemNameY = "rogue_armor99_coat"
					local itemNameRareY = "rogue_armor99_coat"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 10
					local mat2 = "Silk Cloth"
					local mat2y = "cloth_silk"
					local cost3 = 10
					local mat3 = "Embroidery Thread"
					local mat3y = "embroidery_thread"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 120) then
					local itemName = "Heroine's Armor Dress"
					local itemNameY = "rogue_blouse99_coat"
					local itemNameRareY = "rogue_blouse99_coat"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 10
					local mat2 = "Silk Cloth"
					local mat2y = "cloth_silk"
					local cost3 = 10
					local mat3 = "Embroidery Thread"
					local mat3y = "embroidery_thread"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 121) then
					local itemName = "Hero's Garb"
					local itemNameY = "mage_garb99_coat"
					local itemNameRareY = "mage_garb99_coat"
					local itemAmount = 1
					local cost1 = 20
					local mat1 = "Silk Cloth"
					local mat1y = "cloth_silk"
					local cost2 = 10
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 122) then
					local itemName = "Heroine's Skirt"
					local itemNameY = "mage_dress99_coat"
					local itemNameRareY = "mage_dress99_coat"
					local itemAmount = 1
					local cost1 = 20
					local mat1 = "Silk Cloth"
					local mat1y = "cloth_silk"
					local cost2 = 10
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 123) then
					local itemName = "Hero's Robe"
					local itemNameY = "poet_mantle99_coat"
					local itemNameRareY = "poet_mantle99_coat"
					local itemAmount = 1
					local cost1 = 20
					local mat1 = "Silk Cloth"
					local mat1y = "cloth_silk"
					local cost2 = 10
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 124) then
					local itemName = "Heroine's Gown"
					local itemNameY = "poet_gown99_coat"
					local itemNameRareY = "poet_gown99_coat"
					local itemAmount = 1
					local cost1 = 20
					local mat1 = "Silk Cloth"
					local mat1y = "cloth_silk"
					local cost2 = 10
					local mat2 = "Embroidery Thread"
					local mat2y = "embroidery_thread"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 18
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					tailor_table.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE X
	---- APTITUDE I
	---- MASTER

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
	local skill_weapID1 = 40325
	local skill_weapID2 = 40326
	local skill_weapID3 = 40327
	local skill_weapID4 = 40328

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
			if (player.registry["tailoring_skill"] < 25) then
				craftingstamina = 20
				incrementMod = 1
				incrementMultiplier = 1
			elseif (player.registry["tailoring_skill"] >= 25 and player.registry["tailoring_skill"] < 220) then
				craftingstamina = 30
				incrementMod = 2
				incrementMultiplier = 1.2
			elseif (player.registry["tailoring_skill"] >= 220 and player.registry["tailoring_skill"] < 840) then
				craftingstamina = 40
				incrementMod = 3
				incrementMultiplier = 1.3
			elseif (player.registry["tailoring_skill"] >= 840 and player.registry["tailoring_skill"] < 2200) then
				craftingstamina = 50
				incrementMod = 4
				incrementMultiplier = 1.4
			elseif (player.registry["tailoring_skill"] >= 2200 and player.registry["tailoring_skill"] < 6400) then
				craftingstamina = 60
				incrementMod = 5
				incrementMultiplier = 1.5
			elseif (player.registry["tailoring_skill"] >= 6400 and player.registry["tailoring_skill"] < 18000) then
				craftingstamina = 70
				incrementMod = 6
				incrementMultiplier = 1.6
			elseif (player.registry["tailoring_skill"] >= 18000 and player.registry["tailoring_skill"] < 50000) then
				craftingstamina = 80
				incrementMod = 7
				incrementMultiplier = 1.7
			elseif (player.registry["tailoring_skill"] >= 50000 and player.registry["tailoring_skill"] < 124000) then
				craftingstamina = 90
				incrementMod = 8
				incrementMultiplier = 1.8
			elseif (player.registry["tailoring_skill"] >= 124000 and player.registry["tailoring_skill"] < 237000) then
				craftingstamina = 100
				incrementMod = 9
				incrementMultiplier = 1.9
			elseif (player.registry["tailoring_skill"] >= 237000 and player.registry["tailoring_skill"] < 400000) then
				craftingstamina = 110
				incrementMod = 10
				incrementMultiplier = 2.0
			elseif (player.registry["tailoring_skill"] >= 400000 and player.registry["tailoring_skill"] < 680000) then
				craftingstamina = 120
				incrementMod = 11
				incrementMultiplier = 2.2
			elseif (player.registry["tailoring_skill"] >= 680000) then
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
		local manuf = {graphic = convertGraphic(744, "monster"), color = 0}
		player.npcGraphic = manuf.graphic
		player.npcColor = manuf.color

		cq_options = {}
		cq_costs = {}

		table.insert(cq_options, 551)
		table.insert(cq_costs, 0)

		if (currentCraftStamina >= 10 and player.registry["tailoring_skill"] >= 220) then
			table.insert(cq_options, 552)
			table.insert(cq_costs, 10)
		end

		if (currentCraftStamina >= 20 and player.registry["tailoring_skill"] >= 6400) then
			table.insert(cq_options, 553)
			table.insert(cq_costs, 20)
		end

		if (currentCraftStamina >= 15) then
			table.insert(cq_options, 554)
			table.insert(cq_costs, 15)
		end

		if (currentCraftStamina >= 30 and player.registry["tailoring_skill"] >= 840) then
			table.insert(cq_options, 555)
			table.insert(cq_costs, 30)
		end

		if (currentCraftStamina >= 50 and player.registry["tailoring_skill"] >= 18000) then
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
		player:sendAnimation(271, 0)
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

			player.registry["tailoring_skill"] = player.registry["tailoring_skill"] + (skillAdded * 2)
			
			if (player.registry["tailoring_skill"] < 25) then
				craftlevel = "Aptitude I"
			elseif (player.registry["tailoring_skill"] >= 25 and player.registry["tailoring_skill"] < 220) then
				craftlevel = "Aptitude II"
			elseif (player.registry["tailoring_skill"] >= 220 and player.registry["tailoring_skill"] < 840) then
				craftlevel = "Aptitude III"
			elseif (player.registry["tailoring_skill"] >= 840 and player.registry["tailoring_skill"] < 2200) then
				craftlevel = "Aptitude IV"
			elseif (player.registry["tailoring_skill"] >= 2200 and player.registry["tailoring_skill"] < 6400) then
				craftlevel = "Aptitude V"
			elseif (player.registry["tailoring_skill"] >= 6400 and player.registry["tailoring_skill"] < 18000) then
				craftlevel = "Aptitude VI"
			elseif (player.registry["tailoring_skill"] >= 18000 and player.registry["tailoring_skill"] < 50000) then
				craftlevel = "Aptitude VII"
			elseif (player.registry["tailoring_skill"] >= 50000 and player.registry["tailoring_skill"] < 124000) then
				craftlevel = "Aptitude VIII"
			elseif (player.registry["tailoring_skill"] >= 124000 and player.registry["tailoring_skill"] < 237000) then
				craftlevel = "Aptitude IX"
			elseif (player.registry["tailoring_skill"] >= 237000 and player.registry["tailoring_skill"] < 400000) then
				craftlevel = "Aptitude X"
			elseif (player.registry["tailoring_skill"] >= 400000 and player.registry["tailoring_skill"] < 680000) then
				craftlevel = "Aptitude XI"
			elseif (player.registry["tailoring_skill"] >= 680000) then
				craftlevel = "Master"
			end
			
			if (player.registry["tailoring_skill"] < 680000) then
				player:removeLegendbyName("tailoring_skill")
				player:addLegend("Tailor: "..craftlevel, "tailoring_skill", 7, 128)
			elseif (player.registry["tailoring_skill"] >= 680000) then
				player:removeLegendbyName("tailoring_skill")
				player:addLegend(craftlevel.." Tailor", "tailoring_skill", 63, 128)
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