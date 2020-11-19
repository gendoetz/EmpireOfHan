han_smithcraft = {
click = async(function(player, npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local typeOpts = {}
		table.insert(typeOpts, "About Smithing")
		table.insert(typeOpts, "Learn Smithing")
		table.insert(typeOpts, "Forget Smithing")
		table.insert(typeOpts, " ")
		table.insert(typeOpts, "- Skill Levels")
			if (player.registry["miner"] >= 6400 and (player.quest["gatherQuest_miner"] <= 9)) then
				table.insert(typeOpts, " ")
				table.insert(typeOpts, "A bushel, a basket..")
			end

	local craftCount = 0

	player.npcGraphic=t.graphic
	player.npcColor=t.color
	player.dialogType = 0

	local typeChoice = player:menuString("How can I help you little one?", typeOpts)
		if (typeChoice == "About Smithing") then
			player:dialogSeq({t, "Smithing is a skill that provides great satisfaction in the manipulation of ores and metals. By gathering raw ore a smith can smelt these materials into metal and forge great weapons, shields, and armors.",
						t, "This skill, like other manufacturing skills uses the method of selecting a focus in item creation. You can choose to focus on improving an item's (Completion) or an item's (Quality).",
						t, "Be wary though. Each item has a set number of (Durability) for its creation, taking from it (10 Points) per focus selected. Depending on your selection, there is a (Stamina) cost as well.",
						t, "Finally, pay attention to the items (State). As you progress and item may be in a Poor, Good, or Excellent (State) this state further changes the progress of a selected focus.",
						t, "Who knows.. maybe even other factors weigh in on the creation of items!"}, 1)
		elseif (typeChoice == "Learn Smithing") then
	
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

			if (player.registry["smithing_skill"] == 0 and craftCount < 2) then
				local options = {"Yes", "No"}
				local choice = player:menuString("Would you like to become a smith?", options)
				
				if (choice == "Yes") then
					player.registry["smithing_skill"] = 1
					player:dialogSeq({t, "Excellent, lets gets started by teaching you smithing, ask me if you need more information or get started by attempting to smelt some materials."}, 1)
				else
					player:dialogSeq({t, "Very well then, maybe another time."}, 1)
					return
				end
			elseif (player.registry["smithing_skill"] == 0) then
				player:removeLegendbyName("smithing_skill")
				player.registry["smithing_skill"] = 0
				player:dialogSeq({t, "I'm sorry, but you can only have a maximum of two crafts. Please forget one if you would like to start smithing."}, 1)
				return
			elseif (player.registry["smithing_skill"] > 0) then
				player:dialogSeq({t, "You have chosen to become a smith previously."}, 1)
				return
			end
		elseif (typeChoice == "Forget Smithing") then
			if(player.registry["smithing_skill"] == 0) then
				player:dialogSeq({t, "You are not a smith to begin with..."}, 1)
				return
			end

			local options = {"Yes", "No"}
			local choice = player:menuString("Are you absolutely sure you wish to forget smithing? This will erase all skill you have earned thus far.", options)
			
			if (choice == "Yes") then
				player:dialogSeq({t, "I am sorry that it has come to this, maybe you will find your success in another craft..."}, 1)
				player:removeLegendbyName("smithing_skill")
				player.registry["smithing_skill"] = 0
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
			local itemGraphic = {graphic = convertGraphic(1270, "item"), color = 1}	
				local qmatA = "Tin Ore"
				local qmatAy = "tin_ore"
				local qmatB = "Copper Ore"
				local qmatBy = "copper_ore"
				local qmatC = "Iron Ore"
				local qmatCy = "iron_ore"
				local qfinalItem = "Ore Chest"
				local qfinalItemy = "ore_chest"

			if (player.registry["gQuest_mTimer"] >= os.time()) then
				player:dialogSeq({t, "I've already gifted you an item recently. You'll need to wait at least another "..(math.ceil((player.registry["gQuest_mTimer"] - os.time())/10800)).." more day(s) before you can receive another."}, 1)

			elseif (player.registry["gQuest_mTimer"] <= os.time()) then
				if (player.quest["gatherQuest_miner"] == 9) then
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
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end					
				elseif (player.quest["gatherQuest_miner"] == 8) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_miner"] == 7) then
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
							player.registry["gQuest_mTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_miner"] == 6) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_miner"] == 5) then
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
							player.registry["gQuest_mTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_miner"] == 4) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_miner"] == 3) then
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
							player.registry["gQuest_mTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 1)
					end
				elseif (player.quest["gatherQuest_miner"] == 2) then
					player:dialogSeq({t, "Welcome back!\n\nI've come across another item if you wish to take up the task again."}, 1)
					local finaldecision = player:menuString("Are you willing to work again?", {"Yes, I am.", "No thanks."})
						if (finaldecision == "Yes, I am.") then
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
							player:dialogSeq({t, "Excellent, you know the challenge from before. What I require is the following;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC.."",
							itemGraphic, "Return to me once you've gathered these item and I'll give you another bag."}, 0)
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				elseif (player.quest["gatherQuest_miner"] == 1) then
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
							player.registry["gQuest_mTimer"] = os.time() + timerAdd
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
						end
					else
						player:dialogSeq({t, "You don't seem to have enough materials, remember you need to bring me;\n\n(100) - "..qmatA.."\n(100) - "..qmatB.."\n(100) - "..qmatC..""}, 0)
					end
				elseif (player.quest["gatherQuest_miner"] == 0) then
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
							player.quest["gatherQuest_miner"] = player.quest["gatherQuest_miner"] + 1
						elseif (finaldecision == "No thanks.") then
							player:dialogSeq({t, "Alright, well come back if you feel up to the task."}, 0)
						end
				end
			end

		end
end),

say=function(player,npc)
	local ibuylist = {300, 303, 439, 184, 14, 15, 16, 17, 185, 80, 81, 82, 83, 304, 186, 88, 89, 90, 91, 187, 96, 97, 98, 99, 441, 291, 104, 105, 106, 107, 301, 250, 251, 252, 253, 305, 445, 40282, 748, 749, 750, 751, 357, 764, 765, 766, 787, 449, 443, 780, 781, 782, 783}
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

-- REFINING MACHINE
smith_furnace = {
click = async(function(player, mob)

		local mobG = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
		player.dialogType = 0
		player.npcGraphic = mobG.graphic
		player.npcColor = mobG.color
		local options = {}

		if (player.registry["smithing_skill"] == 0) then
			player:dialogSeq({mobG, "You are not skilled to use this."}, 1)
			return
		end
		if (player.registry["smithing_skill"] >= 1) then
			table.insert(options, "Smelt: Tin")
		end
		if (player.registry["smithing_skill"] >= 220) then
			table.insert(options, "Smelt: Copper")
		end
		if (player.registry["smithing_skill"] >= 2200) then
			table.insert(options, "Smelt: Iron")
		end
		if (player.registry["smithing_skill"] >= 18000) then
			table.insert(options, "Smelt: Platinum")
		end
		if (player.registry["smithing_skill"] >= 124000) then
			table.insert(options, "Smelt: Titanium")
		end


		local menuOpt = player:menuString("What material are you attempting to make?", options)
		if(menuOpt == "Smelt: Tin") then
			player.registry["refining_item"] = 294
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Smelt: Copper") then
			player.registry["refining_item"] = 295
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Smelt: Iron") then
			player.registry["refining_item"] = 296
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Smelt: Platinum") then
			player.registry["refining_item"] = 298
			player:dialogSeq({mobG, "Item Set: "..Item(player.registry["refining_item"]).name}, 0)
		elseif(menuOpt == "Smelt: Titanium") then
			player.registry["refining_item"] = 299
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
		if (tool ~= nil and (tool.id == 40093 or tool.id == 40092 or tool.id == 40091 or tool.id == 40090)) then
			if (player.registry["refining_item"] == 294) then
				if (player:hasItem(180, 2) == true) then
					if (player.registry["smithing_skill"] < 25) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 25 and player.registry["smithing_skill"] < 220) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 220 and player.registry["smithing_skill"] < 840) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 840) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(180, 2)
					player:addItem("tin_ingot", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
						if (player.registry["smithing_skill"] < 210) then
						player.registry["smithing_skill"] = player.registry["smithing_skill"] + 1
						smith_furnace.calcSkill(player)
						end
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)
					else
						--ADD FAIL
					player:removeItem(180, 2)
					player:addItem("slag", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
					end					
				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 295) then
				if (player:hasItem(179, 2) == true) then
					if (player.registry["smithing_skill"] < 840) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 840 and player.registry["smithing_skill"] < 2200) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 2200 and player.registry["smithing_skill"] < 6400) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 6400) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(179, 2)
					player:addItem("copper_ingot", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)

					else
						--ADD FAIL
					player:removeItem(179, 2)
					player:addItem("slag", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 296) then
				if (tool.id == 40090) then
					player:dialogSeq({itemc, "You need a stronger tool for this material."}, 0)
				end
				if (player:hasItem(181, 2) == true and player:hasItem(297, 1) == true) then
					if (player.registry["smithing_skill"] < 6400) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 6400 and player.registry["smithing_skill"] < 18000) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 18000 and player.registry["smithing_skill"] < 50000) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 50000) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(297, 1)
					player:removeItem(181, 2)
					player:addItem("iron_ingot", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)

					else
						--ADD FAIL
					player:removeItem(181, 2)
					player:removeItem(297, 1)
					player:addItem("slag", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 298) then
				if (tool.id == 40091 or tool.id == 40090) then
					player:dialogSeq({itemc, "You need a stronger tool for this material."}, 0)
				end
				if (player:hasItem(182, 2) == true) then
					if (player.registry["smithing_skill"] < 50000) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 50000 and player.registry["smithing_skill"] < 124000) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 124000 and player.registry["smithing_skill"] < 237000) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 237000) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(182, 2)
					player:addItem("platinum_ingot", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)

					else
						--ADD FAIL
					player:removeItem(182, 2)
					player:addItem("slag", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			elseif (player.registry["refining_item"] == 299) then
				if (tool.id == 40092 or tool.id == 40091 or tool.id == 40090) then
					player:dialogSeq({itemc, "You need a stronger tool for this material."}, 0)
				end
				if (player:hasItem(183, 2) == true) then
					if (player.registry["smithing_skill"] < 237000) then
						if (probChance <= 0.30) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 237000 and player.registry["smithing_skill"] < 400000) then
						if (probChance <= 0.45) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 400000 and player.registry["smithing_skill"] < 680000) then
						if (probChance <= 0.60) then
							spoilchance = 1
						end
					elseif (player.registry["smithing_skill"] >= 680000) then
						if (probChance <= 0.75) then
							spoilchance = 1
						end
					end
					if (spoilchance == 1) then
						--ADD ITEM
					player:removeItem(183, 2)
					player:addItem("titanium_ingot", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
					player:dialogSeq({itemc, "You successfully create a "..Item(player.registry["refining_item"]).name.."."}, 0)
					else
						--ADD FAIL
					player:removeItem(183, 2)
					player:addItem("slag", 1)
					player:sendAnimation(315, 0)
					player:playSound(370)
					mob:sendAnimation(310, 0)
					end

				else
					player:dialogSeq({itemc, "You dont have the materials to make a "..Item(player.registry["refining_item"]).name.."."}, 0)
				end
			end
		end
	end
end,

calcSkill = function(player)
			if (player.registry["smithing_skill"] < 25) then
				craftlevel = "Aptitude I"
			elseif (player.registry["smithing_skill"] >= 25 and player.registry["smithing_skill"] < 220) then
				craftlevel = "Aptitude II"
			elseif (player.registry["smithing_skill"] >= 220 and player.registry["smithing_skill"] < 840) then
				craftlevel = "Aptitude III"
			elseif (player.registry["smithing_skill"] >= 840 and player.registry["smithing_skill"] < 2200) then
				craftlevel = "Aptitude IV"
			elseif (player.registry["smithing_skill"] >= 2200 and player.registry["smithing_skill"] < 6400) then
				craftlevel = "Aptitude V"
			elseif (player.registry["smithing_skill"] >= 6400 and player.registry["smithing_skill"] < 18000) then
				craftlevel = "Aptitude VI"
			elseif (player.registry["smithing_skill"] >= 18000 and player.registry["smithing_skill"] < 50000) then
				craftlevel = "Aptitude VII"
			elseif (player.registry["smithing_skill"] >= 50000 and player.registry["smithing_skill"] < 124000) then
				craftlevel = "Aptitude VIII"
			elseif (player.registry["smithing_skill"] >= 124000 and player.registry["smithing_skill"] < 237000) then
				craftlevel = "Aptitude IX"
			elseif (player.registry["smithing_skill"] >= 237000 and player.registry["smithing_skill"] < 400000) then
				craftlevel = "Aptitude X"
			elseif (player.registry["smithing_skill"] >= 400000 and player.registry["smithing_skill"] < 680000) then
				craftlevel = "Aptitude XI"
			elseif (player.registry["smithing_skill"] >= 680000) then
				craftlevel = "Master"
			end
			
			if (player.registry["smithing_skill"] < 680000) then
				player:removeLegendbyName("smithing_skill")
				player:addLegend("Smith: "..craftlevel, "smithing_skill", 7, 128)
			elseif (player.registry["smithing_skill"] >= 680000) then
				player:removeLegendbyName("smithing_skill")
				player:addLegend(craftlevel.." Smith", "smithing_skill", 191, 128)
			end
end,
}

-- MANUFACTURING MACHINE
smith_forge = {
click = async(function(player, mob)
	
	local craftOptions = {}
	local aptitudeOptions = {}

	local options = {"Yes", "No"}
	local typeOpts = {"Smith Shields", "Smith Mail", "Smith Mail Dress", "Smith Armor", "Smith Armor Dress", "Smith Weapons"}

	player.dialogType = 0
	local manuf = {graphic = convertGraphic(828, "monster"), color = 0}
	player.npcGraphic = manuf.graphic
	player.npcColor = manuf.color

	if (player.registry["smithing_skill"] == 0) then
		player:dialogSeq({manuf, "You are not skilled to use this."}, 1)
		return
	end

			if (player.registry["smithing_skill"] >= 1) then
				table.insert(aptitudeOptions, "Aptitude I")
			end
			if (player.registry["smithing_skill"] >= 25) then
				table.insert(aptitudeOptions, "Aptitude II")
			end
			if (player.registry["smithing_skill"] >= 220) then
				table.insert(aptitudeOptions, "Aptitude III")
			end
			if (player.registry["smithing_skill"] >= 840) then
				table.insert(aptitudeOptions, "Aptitude IV")
			end
			if (player.registry["smithing_skill"] >= 2200) then
				table.insert(aptitudeOptions, "Aptitude V")
			end
			if (player.registry["smithing_skill"] >= 6400) then
				table.insert(aptitudeOptions, "Aptitude VI")
			end
			if (player.registry["smithing_skill"] >= 18000) then
				table.insert(aptitudeOptions, "Aptitude VII")
			end
			if (player.registry["smithing_skill"] >= 50000) then
				table.insert(aptitudeOptions, "Aptitude VIII")
			end
			if (player.registry["smithing_skill"] >= 124000) then
				table.insert(aptitudeOptions, "Aptitude IX")
			end
			if (player.registry["smithing_skill"] >= 237000) then
				table.insert(aptitudeOptions, "Aptitude X")
			end
			if (player.registry["smithing_skill"] >= 400000) then
				table.insert(aptitudeOptions, "Aptitude XI")
			end
			if (player.registry["smithing_skill"] >= 680000) then
				table.insert(aptitudeOptions, "Master")
			end

	local itemAptitude = player:menuString2("Which category?", aptitudeOptions)

		if(itemAptitude == "Aptitude I") then
			table.insert(craftOptions, "Tin Wire")
			table.insert(craftOptions, "Tin Band")
			table.insert(craftOptions, "Dull Tin Sword")
			table.insert(craftOptions, "Basic Mail")
			table.insert(craftOptions, "Basic Mail Dress")
			table.insert(craftOptions, "Basic Armor")
			table.insert(craftOptions, "Basic Armor Dress")
		elseif(itemAptitude == "Aptitude II") then
			table.insert(craftOptions, "Tin Sword")
			table.insert(craftOptions, "Average Mail")
			table.insert(craftOptions, "Average Mail Dress")
			table.insert(craftOptions, "Average Armor")
			table.insert(craftOptions, "Average Armor Dress")
		elseif(itemAptitude == "Aptitude III") then
			table.insert(craftOptions, "Copper Wire")
			table.insert(craftOptions, "Dull Copper Sword")
			table.insert(craftOptions, "Tough Mail")
			table.insert(craftOptions, "Tough Mail Dress")
			table.insert(craftOptions, "Tough Armor")
			table.insert(craftOptions, "Tough Armor Dress")
		elseif(itemAptitude == "Aptitude IV") then
			table.insert(craftOptions, "Copper Sword")
			table.insert(craftOptions, "Fine Mail")
			table.insert(craftOptions, "Fine Mail Dress")
			table.insert(craftOptions, "Fine Armor")
			table.insert(craftOptions, "Fine Armor Dress")
		elseif(itemAptitude == "Aptitude V") then
			table.insert(craftOptions, "Iron Shield")
			table.insert(craftOptions, "Dull Iron Sword")
			table.insert(craftOptions, "Durable Mail")
			table.insert(craftOptions, "Durable Mail Dress")
			table.insert(craftOptions, "Durable Armor")
			table.insert(craftOptions, "Durable Armor Dress")
		elseif(itemAptitude == "Aptitude VI") then
			table.insert(craftOptions, "Iron Sword")
			table.insert(craftOptions, "Strong Mail")
			table.insert(craftOptions, "Strong Mail Dress")
			table.insert(craftOptions, "Strong Armor")
			table.insert(craftOptions, "Strong Armor Dress")
		elseif(itemAptitude == "Aptitude VII") then
			table.insert(craftOptions, "Platinum Wire")
			table.insert(craftOptions, "Platinum Shield")
			--table.insert(craftOptions, "Ore Chest")
			table.insert(craftOptions, "Celestial Mail")
			table.insert(craftOptions, "Celestial Mail Dress")
			table.insert(craftOptions, "Celestial Armor")
			table.insert(craftOptions, "Celestial Armor Dress")
		elseif(itemAptitude == "Aptitude VIII") then
			table.insert(craftOptions, "Charcoal Helm")
			table.insert(craftOptions, "Lunar Mail")
			table.insert(craftOptions, "Lunar Mail Dress")
			table.insert(craftOptions, "Lunar Armor")
			table.insert(craftOptions, "Lunar Armor Dress")
		elseif(itemAptitude == "Aptitude IX") then
			table.insert(craftOptions, "Platinum Blade")
			table.insert(craftOptions, "Titanium Glove")
			table.insert(craftOptions, "Solar Mail")
			table.insert(craftOptions, "Solar Mail Dress")
			table.insert(craftOptions, "Solar Armor")
			table.insert(craftOptions, "Solar Armor Dress")
		end

	local itemToCraft = player:menuString2("Craft which item?", craftOptions)

	---- APTITUDE I
		if(itemToCraft == "Tin Wire") then
			player.registry["crafting_item"] = 303
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tin Band") then
			player.registry["crafting_item"] = 439
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Tin Sword") then
			player.registry["crafting_item"] = 184
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Mail") then
			player.registry["crafting_item"] = 14
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Mail Dress") then
			player.registry["crafting_item"] = 15
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Armor") then
			player.registry["crafting_item"] = 16
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Basic Armor Dress") then
			player.registry["crafting_item"] = 17
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE II
		if(itemToCraft == "Tin Sword") then
			player.registry["crafting_item"] = 185
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Average Mail") then
			player.registry["crafting_item"] = 80
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Average Mail Dress") then
			player.registry["crafting_item"] = 81
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Average Armor") then
			player.registry["crafting_item"] = 82
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Average Armor Dress") then
			player.registry["crafting_item"] = 83
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE III
		if(itemToCraft == "Copper Wire") then
			player.registry["crafting_item"] = 304
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Copper Sword") then
			player.registry["crafting_item"] = 186
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tough Mail") then
			player.registry["crafting_item"] = 88
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tough Mail Dress") then
			player.registry["crafting_item"] = 89
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tough Armor") then
			player.registry["crafting_item"] = 90
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Tough Armor Dress") then
			player.registry["crafting_item"] = 91
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE IV
		if(itemToCraft == "Copper Sword") then
			player.registry["crafting_item"] = 187
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Fine Mail") then
			player.registry["crafting_item"] = 96
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Fine Mail Dress") then
			player.registry["crafting_item"] = 97
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Fine Armor") then
			player.registry["crafting_item"] = 98
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Fine Armor Dress") then
			player.registry["crafting_item"] = 99
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE V
		if(itemToCraft == "Iron Shield") then
			player.registry["crafting_item"] = 441
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Dull Iron Sword") then
			player.registry["crafting_item"] = 291
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Durable Mail") then
			player.registry["crafting_item"] = 104
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Durable Mail Dress") then
			player.registry["crafting_item"] = 105
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Durable Armor") then
			player.registry["crafting_item"] = 106
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Durable Armor Dress") then
			player.registry["crafting_item"] = 107
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE VI
		if(itemToCraft == "Iron Sword") then
			player.registry["crafting_item"] = 301
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Strong Mail") then
			player.registry["crafting_item"] = 250
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Strong Mail Dress") then
			player.registry["crafting_item"] = 251
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Strong Armor") then
			player.registry["crafting_item"] = 252
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Strong Armor Dress") then
			player.registry["crafting_item"] = 253
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE VII
		if(itemToCraft == "Platinum Wire") then
			player.registry["crafting_item"] = 305
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Platinum Shield") then
			player.registry["crafting_item"] = 445
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Ore Chest") then
			player.registry["crafting_item"] = 40282
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Celestial Mail") then
			player.registry["crafting_item"] = 748
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Celestial Mail Dress") then
			player.registry["crafting_item"] = 749
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Celestial Armor") then
			player.registry["crafting_item"] = 750
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Celestial Armor Dress") then
			player.registry["crafting_item"] = 751
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE VIII
		if(itemToCraft == "Charcoal Helm") then
			player.registry["crafting_item"] = 357
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Lunar Mail") then
			player.registry["crafting_item"] = 764
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Lunar Mail Dress") then
			player.registry["crafting_item"] = 765
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Lunar Armor") then
			player.registry["crafting_item"] = 766
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Lunar Armor Dress") then
			player.registry["crafting_item"] = 787
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
	---- APTITUDE IX
		if(itemToCraft == "Platinum Blade") then
			player.registry["crafting_item"] = 449
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Titanium Glove") then
			player.registry["crafting_item"] = 443
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end		
		if(itemToCraft == "Solar Mail") then
			player.registry["crafting_item"] = 780
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Solar Mail Dress") then
			player.registry["crafting_item"] = 781
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Solar Armor") then
			player.registry["crafting_item"] = 782
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end
		if(itemToCraft == "Solar Armor Dress") then
			player.registry["crafting_item"] = 783
			local itemI = {graphic = Item(player.registry["crafting_item"]).icon, color = Item(player.registry["crafting_item"]).iconC}
			player:dialogSeq({itemI, "Item Set: "..Item(player.registry["crafting_item"]).name}, 0)
		end

end),

on_attacked = function(mob,player)
	local skill_weapID1 = 40086
	local skill_weapID2 = 40087
	local skill_weapID3 = 40088
	local skill_weapID4 = 40089
	player.damage = 0

	player.dialogType = 0
	local manuf = {graphic = convertGraphic(828, "monster"), color = 0}
	player.npcGraphic = manuf.graphic
	player.npcColor = manuf.color

	if (player.registry["smithing_skill"] > 0) then

		local itemSelected = player.registry["crafting_item"]
		local block = getTargetFacing(player, BL_MOB)
		local tool = player:getEquippedItem(EQ_WEAP)

		if (block.id == mob.id) then
			if (tool ~= nil and (tool.id == skill_weapID1 or tool.id == skill_weapID2 or tool.id == skill_weapID3 or tool.id == skill_weapID4)) then

	---- APTITUDE I
				if(itemSelected == 303) then
					local itemName = "Tin Wire"
					local itemNameY = "tin_wire"
					local itemNameRareY = "tin_wire"
					local itemAmount = 5
					local cost1 = 1
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 0
					local mat2 = "Copper Ingot"
					local mat2y = "copper_ingot"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 100
					local itemBonus = 1
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 439) then
					local itemName = "Tin Band"
					local itemNameY = "tin_band"
					local itemNameRareY = "tin_band_plusone"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 1
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 70
					local itemBonus = 2
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 184) then
					local itemName = "Dull Tin Sword"
					local itemNameY = "dull_tin_sword"
					local itemNameRareY = "dull_tin_sword_plusone"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 0
					local mat2 = "Copper Ingot"
					local mat2y = "copper_ingot"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 60
					local itemBonus = 3
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 14) then
					local itemName = "Basic Mail"
					local itemNameY = "basicw_mail"
					local itemNameRareY = "basicw_mail_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 15) then
					local itemName = "Basic Mail Dress"
					local itemNameY = "basicw_maildress"
					local itemNameRareY = "basicw_maildress_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 16) then
					local itemName = "Basic Armor"
					local itemNameY = "basicr_armor"
					local itemNameRareY = "basicr_armor_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 17) then
					local itemName = "Basic Armor Dress"
					local itemNameY = "basicr_armordress"
					local itemNameRareY = "basicr_armordress_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 2
					local itemDifficulty = 1
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE II
				if(itemSelected == 185) then
					local itemName = "Tin Sword"
					local itemNameY = "tin_sword"
					local itemNameRareY = "tin_sword_plusone"
					local itemAmount = 1
					local cost1 = 3
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 0
					local mat2 = "Copper Ingot"
					local mat2y = "copper_ingot"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 60
					local itemBonus = 4
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 80) then
					local itemName = "Average Mail"
					local itemNameY = "averagew_mail"
					local itemNameRareY = "averagew_mail_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 81) then
					local itemName = "Average Mail Dress"
					local itemNameY = "averagew_maildress"
					local itemNameRareY = "averagew_maildress_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 82) then
					local itemName = "Average Armor"
					local itemNameY = "averager_armor"
					local itemNameRareY = "averager_armor_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 83) then
					local itemName = "Average Armor Dress"
					local itemNameY = "averager_armordress"
					local itemNameRareY = "averager_armordress_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Tin Ingot"
					local mat1y = "tin_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 3
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE III
				if(itemSelected == 304) then
					local itemName = "Copper Wire"
					local itemNameY = "copper_wire"
					local itemNameRareY = "copper_wire"
					local itemAmount = 5
					local cost1 = 1
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 0
					local mat2 = "nada"
					local mat2y = "nada"
					local cost3 = 0
					local mat3 = "nada"
					local mat3y = "nada"
					local craftDura = 100
					local itemBonus = 3
					local itemDifficulty = 2
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 186) then
					local itemName = "Dull Copper Sword"
					local itemNameY = "dull_copper_sword"
					local itemNameRareY = "dull_copper_sword_plusone"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 60
					local itemBonus = 5
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 88) then
					local itemName = "Tough Mail"
					local itemNameY = "toughw_mail"
					local itemNameRareY = "toughw_mail_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 89) then
					local itemName = "Tough Mail Dress"
					local itemNameY = "toughw_maildress"
					local itemNameRareY = "toughw_maildress_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 90) then
					local itemName = "Tough Armor"
					local itemNameY = "toughr_armor"
					local itemNameRareY = "toughr_armor_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 91) then
					local itemName = "Tough Armor Dress"
					local itemNameY = "toughr_armordress"
					local itemNameRareY = "toughr_armordress_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 2
					local mat2 = "Tin Wire"
					local mat2y = "tin_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 4
					local itemDifficulty = 3
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE IV
				if(itemSelected == 187) then
					local itemName = "Copper Sword"
					local itemNameY = "copper_sword"
					local itemNameRareY = "copper_sword_plusone"
					local itemAmount = 1
					local cost1 = 3
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 0
					local mat2 = "gold"
					local mat2y = "gold"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 60
					local itemBonus = 6
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 96) then
					local itemName = "Fine Mail"
					local itemNameY = "finew_mail"
					local itemNameRareY = "finew_mail_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 1
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 97) then
					local itemName = "Fine Mail Dress"
					local itemNameY = "finew_maildress"
					local itemNameRareY = "finew_maildress_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 1
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 98) then
					local itemName = "Fine Armor"
					local itemNameY = "finer_armor"
					local itemNameRareY = "finer_armor_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 1
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 99) then
					local itemName = "Fine Armor Dress"
					local itemNameY = "finer_armordress"
					local itemNameRareY = "finer_armordress_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Copper Ingot"
					local mat1y = "copper_ingot"
					local cost2 = 1
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 5
					local itemDifficulty = 4
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE V
				if(itemSelected == 441) then
					local itemName = "Iron Shield"
					local itemNameY = "iron_shield"
					local itemNameRareY = "iron_shield_po"
					local itemAmount = 1
					local cost1 = 5
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 1
					local mat2 = "Copper Ingot"
					local mat2y = "copper_ingot"
					local cost3 = 5
					local mat3 = "Copper Wire"
					local mat3y = "copper_wire"
					local craftDura = 60
					local itemBonus = 6
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 291) then
					local itemName = "Dull Iron Sword"
					local itemNameY = "dull_iron_sword"
					local itemNameRareY = "dull_iron_sword_plusone"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 0
					local mat2 = "Copper Ingot"
					local mat2y = "copper_ingot"
					local cost3 = 0
					local mat3 = "Tin Ingot"
					local mat3y = "tin_ingot"
					local craftDura = 60
					local itemBonus = 7
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 104) then
					local itemName = "Durable Mail"
					local itemNameY = "durablew_mail"
					local itemNameRareY = "durablew_mail_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 105) then
					local itemName = "Durable Mail Dress"
					local itemNameY = "durablew_maildress"
					local itemNameRareY = "durablew_maildress_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 106) then
					local itemName = "Durable Armor"
					local itemNameY = "durabler_armor"
					local itemNameRareY = "durabler_armor_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 107) then
					local itemName = "Durable Armor Dress"
					local itemNameY = "durabler_armordress"
					local itemNameRareY = "durabler_armordress_po"
					local itemAmount = 1
					local cost1 = 1
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 6
					local itemDifficulty = 5
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE VI
				if(itemSelected == 301) then
					local itemName = "Iron Sword"
					local itemNameY = "iron_sword"
					local itemNameRareY = "iron_sword_plusone"
					local itemAmount = 1
					local cost1 = 3
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 0
					local mat2 = "Copper Ingot"
					local mat2y = "copper_ingot"
					local cost3 = 0
					local mat3 = "Tin Ingot"
					local mat3y = "tin_ingot"
					local craftDura = 60
					local itemBonus = 8
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 250) then
					local itemName = "Strong Mail"
					local itemNameY = "strongw_mail"
					local itemNameRareY = "strongw_mail_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 7
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 251) then
					local itemName = "Strong Mail Dress"
					local itemNameY = "strongw_maildress"
					local itemNameRareY = "strongw_maildress_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 7
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 252) then
					local itemName = "Strong Armor"
					local itemNameY = "strongr_armor"
					local itemNameRareY = "strongr_armor_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 7
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 253) then
					local itemName = "Strong Armor Dress"
					local itemNameY = "strongr_armordress"
					local itemNameRareY = "strongr_armordress_po"
					local itemAmount = 1
					local cost1 = 2
					local mat1 = "Iron Ingot"
					local mat1y = "iron_ingot"
					local cost2 = 2
					local mat2 = "Copper Wire"
					local mat2y = "copper_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 7
					local itemDifficulty = 6
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE VII
				if(itemSelected == 305) then
					local itemName = "Platinum Wire"
					local itemNameY = "platinum_wire"
					local itemNameRareY = "platinum_wire"
					local itemAmount = 5
					local cost1 = 1
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 0
					local mat2 = "Copper Ingot"
					local mat2y = "copper_ingot"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 100
					local itemBonus = 12
					local itemDifficulty = 12
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 445) then
					local itemName = "Platinum Shield"
					local itemNameY = "platinum_shield"
					local itemNameRareY = "platinum_shield_po"
					local itemAmount = 1
					local cost1 = 8
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 1
					local mat2 = "Iron Ingot"
					local mat2y = "iron_ingot"
					local cost3 = 5
					local mat3 = "Platinum Wire"
					local mat3y = "platinum_wire"
					local craftDura = 80
					local itemBonus = 14
					local itemDifficulty = 12
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 748) then
					local itemName = "Celestial Mail"
					local itemNameY = "celestialw_mail"
					local itemNameRareY = "celestialw_mail_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 2
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Celestial Fragment"
					local mat3y = "cel_fragore"
					local craftDura = 50
					local itemBonus = 14
					local itemDifficulty = 12
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 749) then
					local itemName = "Celestial Mail Dress"
					local itemNameY = "celestialw_maildress"
					local itemNameRareY = "celestialw_maildress_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 2
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Celestial Fragment"
					local mat3y = "cel_fragore"
					local craftDura = 50
					local itemBonus = 14
					local itemDifficulty = 12
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 750) then
					local itemName = "Celestial Armor"
					local itemNameY = "celestialr_armor"
					local itemNameRareY = "celestialr_armor_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 2
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Celestial Fragment"
					local mat3y = "cel_fragore"
					local craftDura = 50
					local itemBonus = 14
					local itemDifficulty = 12
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 751) then
					local itemName = "Celestial Armor Dress"
					local itemNameY = "celestialr_armordress"
					local itemNameRareY = "celestialr_armordress_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 2
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Celestial Fragment"
					local mat3y = "cel_fragore"
					local craftDura = 50
					local itemBonus = 14
					local itemDifficulty = 12
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE VIII
				if(itemSelected == 357) then
					local itemName = "Charcoal Helm"
					local itemNameY = "charcoal_helm"
					local itemNameRareY = "charcoal_helm_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Coal"
					local mat1y = "coal"
					local cost2 = 10
					local mat2 = "Platinum Ingot"
					local mat2y = "platinum_ingot"
					local cost3 = 5
					local mat3 = "Copper Wire"
					local mat3y = "copper_wire"
					local craftDura = 80
					local itemBonus = 16
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 764) then
					local itemName = "Lunar Mail"
					local itemNameY = "lunarw_mail"
					local itemNameRareY = "lunarw_mail_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 4
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Lunar Fragment"
					local mat3y = "lun_fragore"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 765) then
					local itemName = "Lunar Mail Dress"
					local itemNameY = "lunarw_maildress"
					local itemNameRareY = "lunarw_maildress_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 4
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Lunar Fragment"
					local mat3y = "lun_fragore"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 766) then
					local itemName = "Lunar Armor"
					local itemNameY = "lunarr_armor"
					local itemNameRareY = "lunarr_armor_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 4
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Lunar Fragment"
					local mat3y = "lun_fragore"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 767) then
					local itemName = "Lunar Armor Dress"
					local itemNameY = "lunarr_armordress"
					local itemNameRareY = "lunarr_armordress_po"
					local itemAmount = 1
					local cost1 = 15
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 4
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Lunar Fragment"
					local mat3y = "lun_fragore"
					local craftDura = 50
					local itemBonus = 16
					local itemDifficulty = 14
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
	---- APTITUDE IX
				if(itemSelected == 449) then
					local itemName = "Platinum Blade"
					local itemNameY = "platinum_blade"
					local itemNameRareY = "platinum_blade_po"
					local itemAmount = 1
					local cost1 = 12
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 5
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 20
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end	
				if(itemSelected == 443) then
					local itemName = "Titanium Glove"
					local itemNameY = "titanium_glove"
					local itemNameRareY = "titanium_glove_po"
					local itemAmount = 1
					local cost1 = 12
					local mat1 = "Platinum Ingot"
					local mat1y = "platinum_ingot"
					local cost2 = 5
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 0
					local mat3 = "gold"
					local mat3y = "gold"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end	
				if(itemSelected == 780) then
					local itemName = "Solar Mail"
					local itemNameY = "solarw_mail"
					local itemNameRareY = "solarw_mail_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Titanium Ingot"
					local mat1y = "titanium_ingot"
					local cost2 = 4
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Solar Fragment"
					local mat3y = "sol_fragore"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 781) then
					local itemName = "Solar Mail Dress"
					local itemNameY = "solarw_maildress"
					local itemNameRareY = "solarw_maildress_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Titanium Ingot"
					local mat1y = "titanium_ingot"
					local cost2 = 4
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Solar Fragment"
					local mat3y = "sol_fragore"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 782) then
					local itemName = "Solar Armor"
					local itemNameY = "solarr_armor"
					local itemNameRareY = "solarr_armor_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Titanium Ingot"
					local mat1y = "titanium_ingot"
					local cost2 = 4
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Solar Fragment"
					local mat3y = "sol_fragore"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
				end
				if(itemSelected == 783) then
					local itemName = "Solar Armor Dress"
					local itemNameY = "solarr_armordress"
					local itemNameRareY = "solarr_armordress_po"
					local itemAmount = 1
					local cost1 = 10
					local mat1 = "Titanium Ingot"
					local mat1y = "titanium_ingot"
					local cost2 = 4
					local mat2 = "Platinum Wire"
					local mat2y = "platinum_wire"
					local cost3 = 1
					local mat3 = "Solar Fragment"
					local mat3y = "sol_fragore"
					local craftDura = 50
					local itemBonus = 18
					local itemDifficulty = 16
					local tItem={graphic=Item(itemNameY).icon, color=Item(itemNameY).iconC}
					local tItemRare={graphic=convertGraphic(Item(itemNameRareY).look,"item"),color=Item(itemNameRareY).lookC}
					smith_forge.craftItem(player, tItem, tItemRare, itemName, itemNameY, itemNameRareY, itemAmount, cost1, mat1, mat1y, cost2, mat2, mat2y, cost3, mat3, mat3y, craftDura, itemBonus, itemDifficulty)
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
	local skill_weapID1 = 40086
	local skill_weapID2 = 40087
	local skill_weapID3 = 40088
	local skill_weapID4 = 40089
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
			if (player.registry["smithing_skill"] < 25) then
				craftingstamina = 20
				incrementMod = 1
				incrementMultiplier = 1
			elseif (player.registry["smithing_skill"] >= 25 and player.registry["smithing_skill"] < 220) then
				craftingstamina = 30
				incrementMod = 2
				incrementMultiplier = 1.2
			elseif (player.registry["smithing_skill"] >= 220 and player.registry["smithing_skill"] < 840) then
				craftingstamina = 40
				incrementMod = 3
				incrementMultiplier = 1.3
			elseif (player.registry["smithing_skill"] >= 840 and player.registry["smithing_skill"] < 2200) then
				craftingstamina = 50
				incrementMod = 4
				incrementMultiplier = 1.4
			elseif (player.registry["smithing_skill"] >= 2200 and player.registry["smithing_skill"] < 6400) then
				craftingstamina = 60
				incrementMod = 5
				incrementMultiplier = 1.5
			elseif (player.registry["smithing_skill"] >= 6400 and player.registry["smithing_skill"] < 18000) then
				craftingstamina = 70
				incrementMod = 6
				incrementMultiplier = 1.6
			elseif (player.registry["smithing_skill"] >= 18000 and player.registry["smithing_skill"] < 50000) then
				craftingstamina = 80
				incrementMod = 7
				incrementMultiplier = 1.7
			elseif (player.registry["smithing_skill"] >= 50000 and player.registry["smithing_skill"] < 124000) then
				craftingstamina = 90
				incrementMod = 8
				incrementMultiplier = 1.8
			elseif (player.registry["smithing_skill"] >= 124000 and player.registry["smithing_skill"] < 237000) then
				craftingstamina = 100
				incrementMod = 9
				incrementMultiplier = 1.9
			elseif (player.registry["smithing_skill"] >= 237000 and player.registry["smithing_skill"] < 400000) then
				craftingstamina = 110
				incrementMod = 10
				incrementMultiplier = 2.0
			elseif (player.registry["smithing_skill"] >= 400000 and player.registry["smithing_skill"] < 680000) then
				craftingstamina = 120
				incrementMod = 11
				incrementMultiplier = 2.2
			elseif (player.registry["smithing_skill"] >= 680000) then
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
		local manuf = {graphic = convertGraphic(828, "monster"), color = 0}
		player.npcGraphic = manuf.graphic
		player.npcColor = manuf.color

		cq_options = {}
		cq_costs = {}

		table.insert(cq_options, 551)
		table.insert(cq_costs, 0)

		if (currentCraftStamina >= 10 and player.registry["smithing_skill"] >= 220) then
			table.insert(cq_options, 552)
			table.insert(cq_costs, 10)
		end

		if (currentCraftStamina >= 20 and player.registry["smithing_skill"] >= 6400) then
			table.insert(cq_options, 553)
			table.insert(cq_costs, 20)
		end

		if (currentCraftStamina >= 15) then
			table.insert(cq_options, 554)
			table.insert(cq_costs, 15)
		end

		if (currentCraftStamina >= 30 and player.registry["smithing_skill"] >= 840) then
			table.insert(cq_options, 555)
			table.insert(cq_costs, 30)
		end

		if (currentCraftStamina >= 50 and player.registry["smithing_skill"] >= 18000) then
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
		player:sendAnimation(312, 0)
		player:sendAction(1, 20)
		player:playSound(348)
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

			player.registry["smithing_skill"] = player.registry["smithing_skill"] + (skillAdded * 2)
			
			if (player.registry["smithing_skill"] < 25) then
				craftlevel = "Aptitude I"
			elseif (player.registry["smithing_skill"] >= 25 and player.registry["smithing_skill"] < 220) then
				craftlevel = "Aptitude II"
			elseif (player.registry["smithing_skill"] >= 220 and player.registry["smithing_skill"] < 840) then
				craftlevel = "Aptitude III"
			elseif (player.registry["smithing_skill"] >= 840 and player.registry["smithing_skill"] < 2200) then
				craftlevel = "Aptitude IV"
			elseif (player.registry["smithing_skill"] >= 2200 and player.registry["smithing_skill"] < 6400) then
				craftlevel = "Aptitude V"
			elseif (player.registry["smithing_skill"] >= 6400 and player.registry["smithing_skill"] < 18000) then
				craftlevel = "Aptitude VI"
			elseif (player.registry["smithing_skill"] >= 18000 and player.registry["smithing_skill"] < 50000) then
				craftlevel = "Aptitude VII"
			elseif (player.registry["smithing_skill"] >= 50000 and player.registry["smithing_skill"] < 124000) then
				craftlevel = "Aptitude VIII"
			elseif (player.registry["smithing_skill"] >= 124000 and player.registry["smithing_skill"] < 237000) then
				craftlevel = "Aptitude IX"
			elseif (player.registry["smithing_skill"] >= 237000 and player.registry["smithing_skill"] < 400000) then
				craftlevel = "Aptitude X"
			elseif (player.registry["smithing_skill"] >= 400000 and player.registry["smithing_skill"] < 680000) then
				craftlevel = "Aptitude XI"
			elseif (player.registry["smithing_skill"] >= 680000) then
				craftlevel = "Master"
			end
			
			if (player.registry["smithing_skill"] < 680000) then
				player:removeLegendbyName("smithing_skill")
				player:addLegend("Smith: "..craftlevel, "smithing_skill", 7, 128)
			elseif (player.registry["smithing_skill"] >= 680000) then
				player:removeLegendbyName("smithing_skill")
				player:addLegend(craftlevel.." Smith", "smithing_skill", 92, 128)
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