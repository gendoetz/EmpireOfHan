m_warrior_trainer = {
click = async(function(player, npc)
	local t = {graphic = convertGraphic(39, "monster"), color = 4}
	local npcB = {graphic = 0, color = 0}
	
	local stone = {graphic = convertGraphic(2133, "item"), color = 0}
	local menuOptions = {}
		local choiceOptions = {"Yes, I wish to become a Warrior.", "No, I need some time to think."}
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if (player.baseClass == 1 and player.level >= 65) then
		table.insert(menuOptions, "Reinforced Warrior Plate")
	end

	if (player.baseClass == 1 and player.level >= 65 and player.quest["warrior_65armor"] >= 6) then
		table.insert(menuOptions, "Tarnished Soul: Warrior Plate")
	end

	--if (player.class == 1 and player.level >= 50) then
	--	table.insert(menuOptions, "Destined Path")
	--end

	if (player.gmLevel == 99) then
		--table.insert(menuOptions, "Reinforced Warrior Plate")
	end

	if (player.class == 0 or player.baseClass == 1) then
		table.insert(menuOptions, "Minor Quest")
		table.insert(menuOptions, "Learn Spell")
	end
	
	table.insert(menuOptions, "Forget Spell")

	if (player.class == 1 and player.level >= 50) then
		table.insert(menuOptions, "")
		table.insert(menuOptions, "Warrior Subpaths")
	end
	
	local choice = player:menuString("How may I assist you "..player.name.."?", menuOptions)
	if (choice == "Reinforced Warrior Plate") then
		if (player.quest["warrior_65armor"] == 0) then
			player:dialogSeq({t, "You seek a powerful platemail? Han has legends of Warrior's with untold strength, honor, and bravery. Many of these legendary warriors donned strong reinforced platemail.",
				t, "I can sense a brave spirit within you, I can help you learn to reach your full potential but it will take training, focus, and determination.",
				t, "For your first task you must invoke the power of one of the great elements, Earth.",
				stone, "Take this stone west to the Seong Lowlands, follow the edge of the western mountain's wall until you find an erection of rock nearby. It has been said that a grand warrior carved out the mountain range there with a single swing of his weapon.",
				t, "Battles can rage on for days, sometimes months or years. Great warriors leave their mark on the land in a fury of thunder and blood.",
				t, "Stand next to the fallen rock along the mountain's edge, grasp your stone tightly and hold it against the boulder to harness the hardened earth. ((Click to use the item.))",
				t, "Once you have completed this task, return to me with your imbued stone and we shall progress from there."}, 1)
					if (player:hasSpace("base_stone", 1) ~= true) then
						player:dialogSeq({t, "You seem to have no space, make room first and talk to me again."}, 0)
					else
						player:addItem("base_stone", 1)
						player.quest["warrior_65armor"] = 1
					end
		elseif (player.quest["warrior_65armor"] == 1) then
			if (player:hasItem("w_stone", 1) == true) then
				player:dialogSeq({t, "The stone vibrates with the raw power of the earth you've harnessed.",
					t, "Now we need a base by which to form your armor. Gather some Tin Ore, about 100 should do. Return to me when you have them in your pack."}, 1)
				player:removeItem("w_stone", 1)
				player.quest["warrior_65armor"] = 2
			else
				player:dialogSeq({t, "Bring back the imbued stone from the mountains wall of the Seong Lowlands."}, 1)
			end
		elseif (player.quest["warrior_65armor"] == 2) then
			if (player:hasItem("tin_ore", 100) == true) then
				player:dialogSeq({t, "You have mined the ore and shown your strength. I am sure you are up for the next task...",
					t, "Gather your comrades and venture to the Haunted Valley in the Seong Lowlands. Slay the undead menace that bears a great resemblance to our kind. Return to me once you have slaughtered their current form."}, 1)
				player:removeItem("tin_ore", 100)
				player.quest["warrior_65armor"] = 3
			else
				player:dialogSeq({t, "Tin Ore can be gathered by using a pickaxe on ore nodes. Mining tools are sold by any smith.",
					t, "Tin Ore is located in the Isla Caverns, north of the Seong Lowlands."}, 1)
			end
		elseif (player.quest["warrior_65armor"] == 3) then
				player:dialogSeq({t, "You must slay the undead menace that clutches a great Warrior weapon. We need the energies released by its recent defeat to press on with your armor."}, 1)
		elseif (player.quest["warrior_65armor"] == 4) then
				player:dialogSeq({t, "I can sense you have completed your task. The undead Warrior of the Haunted Valley has been vanquished. Congratulations.",
					t, "Now go visit Bando, the Han smith, he should have the metal prepared from the ore you mined earlier.",
					t, "Bring the metal from Bando and a glove for our path, the ones coveted by the Emerald Tigers of the Tanzar Empire should do nicely. Do this for me and we shall forge your new armor!"}, 1)
				player.quest["warrior_65armor"] = 5
		elseif (player.quest["warrior_65armor"] == 5) then
			if (player:hasItem("65quest_metal", 1) == true and player:hasItem("warriorhand2", 1) == true) then
				player:dialogSeq({t, "I see you have gathered all the items I asked for. As you grow in power, so shall this armor. Return to me when you have gained more insight and we shall improve it further...",
					t, "*You witness the master mumble to himself for a moment, casting a grand spell upon the items...*",
					t, "*As you peer closer you notice the stone begin to crack, shattering in a moment's notice. A cloud of dust arises as you feel shards of the stone fly outwards at you...*",
					t, "*Covering your face to deflect the flying shrapnel, you suddenly hear the master cough. Lowering your hands, your gaze falls upon a savage looking armor that appears to be made out of the mountain itself.*"}, 1)
				player:removeItem("65quest_metal", 1)
				player:removeItem("warriorhand2", 1)

				if (player.sex == 0) then
					player:addItem("warrior_65m", 1, 0, player.id)
				else
					player:addItem("warrior_65f", 1, 0, player.id)
				end
				player:addLegend("Blessed by the spirit of Chung Ryong. "..curT(), "bonded_element", 135, 218)
				player.quest["warrior_65armor"] = 6
			else
				player:dialogSeq({t, "You don't have the required items. To forge your platemail I need the metal Bando has prepared and the hand-item from the Emerald Tigers."}, 1)
			end
		elseif (player.quest["warrior_65armor"] == 6) then
				player:dialogSeq({t, "I am not prepared to share any secrets with you at this time..."}, 1)
		end
	elseif (choice == "Minor Quest") then
		minor_questa.click(player, npc)
	elseif (choice == "Tarnished Soul: Warrior Plate") then
		player:dialogSeq({t, "I see.. so your soul has become tarnished and you have lost your armor on your travels, we can start again from scratch but you will lose all progress on this journey.",
				t, "((Please only continue if you wish to fully reset the armor quests))"}, 1)
					local newChoice=player:menuString("Are you certain you wish to start over again? It will cost you 10,000 gold.",{"Yes","No"})
					if(newChoice == "Yes") then
							if(player.money >= 10000) then
								player.money = player.money - 10000
								player:sendStatus()
								player:dialogSeq({t, "Speak with me again and we shall start over."}, 1)
								player.quest["warrior_65armor"] = 0
								player:removeLegendbyName("bonded_element")
							else
								player:dialogSeq({t,"You do not have the money."})
							end
					else
						player:dialogSeq({t, "I see..."}, 1)
					end
	elseif (choice == "Destined Path") then
		if(player.quest["choose_subpath"] == 0) then
				player:dialogSeq({t, "Ah, you are here about the stones. These stones behold great power; a power that many believe to have gone extinct centuries ago. Ever since Tsugua had appeared, our empire has been thrown into shambles.",
				"The Empress Asako has dedicated her time to finding a way to stop Tsugua, and in the process, has brought the Empire’s scholars together to scour the royal libraries for any knowledge that could possibly aid us in this seemingly impossible mission.",
				"The Dark Sorcerer Tsugua is very powerful, but what we have discovered when the Shaman had banished him into the Dark Realm was something even more powerful: The power of the Totems. We are unsure how we lost such ancient knowledge!",
				"Each path within our Empire was founded by great creatures that were gifted with immensely powerful abilities. In ancient times, the people revered these creatures for their power, and in return, the creatures lent such powers to us.",
				"History becomes very vague about the creatures, but from what we know, the Warriors worshiped a giant Dragon, the Rogues kneeled to a vigorous Tiger, the Mages honored a legendary Phoenix, and the poets prayed to a mighty Tortoise.",
				"These celestial creatures spoke of ancient practices that each path could diverge into, allowing the people to grow in strength. Such knowledge was lost to the ages until we had discovered these stones! Bless it be, will you help us recover the information?!",
				"Bring to me a hundred stones that represent your path and we shall infuse you with their great power."}, 1)
				player.quest["choose_subpath"] = 1
			end
		if(player.quest["choose_subpath"] == 1) then
			if (player:hasItem("warrior_sevent", 100) == true) then
				player:dialogSeq({t, "Ah, you have the stones! Excellent! *he examines the stones carefully* Ah… I see.. Are you ready to gain the knowledge contained within?"}, 1)
		
					local newChoice=player:menuString("Choose carefully, this is not a choice you can turn back from...",{"Knight","Gladiator"})
					if(newChoice == "Knight") then
						player:dialogSeq({t, "It says here that the Gladiators were the strongest of fighters in the lands! With their immense strength, they brought forth great powers!"}, 1)
						local newChoice2=player:menuString("Are you certain of your choice?",{"Yes","No"})
						if(newChoice2 == "Yes") then
							player:removeItem("warrior_sevent", 100)
							player.class = 6
							player.registry["subpathlevel"] = 1
							player.quest["choose_subpath"] = 0
							player:sendStatus()
							player:dialogSeq({t, "A wise choice. You now have a new power surging within you.. seek others like yourself and find where they gather, new secrets await you..."}, 1)
						else
							player:dialogSeq({t, "I see..."}, 1)
						end
					elseif(newChoice == "Gladiator") then
						player:dialogSeq({t, "It says here that the Gladiators were the strongest of fighters in the lands! With their immense strength, they brought forth great powers!"}, 1)
						local newChoice2=player:menuString("Are you certain of your choice?",{"Yes","No"})
						if(newChoice2 == "Yes") then
							player:removeItem("warrior_sevent", 100)
							player.class = 7
							player.registry["subpathlevel"] = 1
							player.quest["choose_subpath"] = 0
							player:sendStatus()
							player:dialogSeq({t, "A wise choice. You now have a new power surging within you.. seek others like yourself and find where they gather, new secrets await you..."}, 1)
						else
							player:dialogSeq({t, "I see..."}, 1)
						end
					end
			else
				player:dialogSeq({t, "Bring to me a hundred stones that represent your path and we shall infuse you with their great power."}, 1)
			end
		end
	elseif (choice == "Learn Spell") then
		player:learnSpell_base(t)
	elseif (choice == "Forget Spell") then
		player:forgetSpell(t)
	elseif (choice == "Warrior Subpaths") then
			if (player.quest["warrior_pickSubpath"] >= 2) then
				player:dialogSeq({t, "Have you picked one yet?"}, 0)	
			elseif (player.quest["warrior_pickSubpath"] == 1) then
				if (player:hasLegend("repSubQ_Gladiator") == true) then
					if (player:hasLegend("repSubQ_Knight") == true) then
						player.quest["warrior_pickSubpath"] = player.quest["warrior_pickSubpath"] + 1
						player:dialogSeq({t, "Well, I see you've learned from both of the paths.",
						t, "Take some time and contemplate, which of these two paths you feel most akin to.",
						t, "Once you've made your decision head back to that paths representative and seek admittance.",
						t, "Good job, and good luck "..player.name.."."}, 0)
					else
						player:dialogSeq({t, "You haven't visited both representatives yet!",
							t, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
					end
				else
					player:dialogSeq({t, "You haven't visited both representatives yet!",
						t, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
				end
			elseif (player.quest["warrior_pickSubpath"] == 0) then
				player.dialogType = 1
				player:dialogSeq({t, "So, you're interested in joining a Subpath are you?",
				t, "There are two within each main path. For the fighters, warriors of the Empire, you can either become a Knight or Gladiator."}, 1)
				player.lastClick = NPC(136).ID
				player:dialogSeq({npcB, "The Knights.\n\nThey fight for justice, the ones who are at the front line. Ready to defend and protect the Empire and its people."}, 1)
				player.lastClick = NPC(135).ID
				player:dialogSeq({npcB, "The Gladiators.\n\nSavage tacticians, known for slaughtering all in their sight. They're hungry for bloodshed and eager to lay waste to those who challenge them."}, 1)
				player.dialogType = 0
				player.lastClick = NPC(113).ID
				player.quest["warrior_pickSubpath"] = player.quest["warrior_pickSubpath"] + 1 	
				player:dialogSeq({t, "Seek out both representatives for each path and complete a small task for them. Once you've done this come back and see me."}, 0)
			end
	end
	
	player:calcStat()
end),

action = function(npc, player)

end
}