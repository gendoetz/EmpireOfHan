m_poet_trainer = {
click = async(function(player, npc)
	local t = {graphic = convertGraphic(16, "monster"), color = 9}
	local npcB = {graphic = 0, color = 0}
	local menuOptions = {}
	local choiceOptions = {"Yes, I wish to become a Poet.", "No, I need some time to think."}
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if (player.baseClass == 4 and player.level >= 65) then
		table.insert(menuOptions, "Enchanted Poet Garments")
	end

	if (player.baseClass == 4 and player.level >= 65 and player.quest["poet_65armor"] >= 6) then
		table.insert(menuOptions, "Tarnished Soul: Poet Garments")
	end

	--if (player.class == 4 and player.level >= 50) then
	--	table.insert(menuOptions, "Destined Path")
	--end

	if (player.gmLevel == 99) then
		--table.insert(menuOptions, "Enchanted Poet Garments")
	end
	
	if (player.class == 0 or player.baseClass == 4) then
		table.insert(menuOptions, "Minor Quest")
		table.insert(menuOptions, "Learn Spell")
	end
	
	table.insert(menuOptions, "Forget Spell")

	if (player.class == 4 and player.level >= 50) then
		table.insert(menuOptions, "")
		table.insert(menuOptions, "Poet Subpaths")
	end
	
	local choice = player:menuString("How may I assist you "..player.name.."?", menuOptions)
	if (choice == "Enchanted Poet Garments") then
		if (player.quest["poet_65armor"] == 0) then
			player:dialogSeq({t, "So, you seek an enchanted garment? The surrounding lands of Han are rich with magic and history. Many great Poets have graced the lands and healed grievous, otherwise fatal wounds of heroes.",
				t, "I can sense the kind nature within you, I can help you learn to reach your full potential but it will take focus, spirit, and determination.",
				t, "For your first task you must invoke the power of one of the great elements, Water.",
				stone, "Take this stone south to the Yogt Forest, find the soothing waters that flow from the cliff side. They say this water brings healing powers to all of Han, nourishing our lands.",
				t, "Poets are the masters of the healing arts, they have drawn power from the great waters for centuries. The peaceful ebb and flow of this mystical water will empower you. Once there grasp your stone tightly and hold it within the still waters to harness their power. ((Click to use the item.))",
				t, "Once you have completed this task, return to me with your imbued stone and we shall progress from there."}, 1)
				player:addItem("base_stone", 1)
				player.quest["poet_65armor"] = 1
		elseif (player.quest["poet_65armor"] == 1) then
			if (player:hasItem("p_stone", 1) == true) then
				player:dialogSeq({t, "Look at that! The stone resonates with the healing spirit you possess, remarkable!",
					t, "Now we need a base by which to form your garment. Gather me some Wool, about 100 should do. Return to me when you have them in your pack."}, 1)
					if (player:hasSpace("base_stone", 1) ~= true) then
						player:dialogSeq({t, "You seem to have no space, make room first and talk to me again."}, 0)
					else
						player:removeItem("p_stone", 1)
						player.quest["poet_65armor"] = 2
					end
			else
				player:dialogSeq({t, "Bring back the imbued stone from the mystical waterfall in the Yogt forest."}, 1)
			end
		elseif (player.quest["poet_65armor"] == 2) then
			if (player:hasItem("fibre_wool", 100) == true) then
				player:dialogSeq({t, "How much trouble did those pesky sheep give you?",
					t, "Gather your comrades and venture to the Haunted Valley in the Seong Lowlands. Slay the undead menace that bears a great resemblance to our kind. Return to me once you have slaughtered their current form."}, 1)
				player:removeItem("fibre_wool", 100)
				player.quest["poet_65armor"] = 3
			else
				player:dialogSeq({t, "Wool can be gathered by shearing sheep, a skill employed by gatherers. Shearing tools can be purchased at any smith.",
					t, "Sheep can be found grazing in the far east of the Dor Nalan Wilds."}, 1)
			end
		elseif (player.quest["poet_65armor"] == 3) then
				player:dialogSeq({t, "You must slay the undead menace that clutches a great Poet weapon. We need the energies released by its recent defeat to press on with your garment."}, 1)
		elseif (player.quest["poet_65armor"] == 4) then
				player:dialogSeq({t, "I can sense you have completed your task. The undead Pacifist of the Haunted Valley has been vanquished. Congratulations.",
					t, "Now go visit Yaki, the Han seamstress, she should have the cloth prepared from the wool you gathered earlier.",
					t, "Bring the cloth from Yaki and a strong magical wrap worn by our path, the ones coveted by the Emerald Tigers of the Tanzar Empire should do nicely. Do this for me and we shall forge your new garments!"}, 1)
				player.quest["poet_65armor"] = 5
		elseif (player.quest["poet_65armor"] == 5) then
			if (player:hasItem("65quest_cloth", 1) == true and player:hasItem("poethand2", 1) == true) then
				player:dialogSeq({t, "I see you have gathered all the items I asked for. As you grow in power, so shall this garment. Return to me when you have gained more insight and we shall improve it further...",
					t, "*You witness the master mumble to himself for a moment, casting a grand spell upon the items...*",
					t, "*As you peer closer, you feel little droplets appear on your arms. An orb of water now encases the items and as each second passes the orb grows larger and larger. Suddenly it bursts, sending water everywhere.*",
					t, "*Shaking the waters off yourself and ringing out your clothes, you step back towards the master. Your gaze falls upon what appears to be a pristine new garment in his hands.*"}, 1)				player:removeItem("65quest_cloth", 1)
				player:removeItem("65quest_cloth", 1)
				player:removeItem("poethand2", 1)

				if (player.sex == 0) then
					player:addItem("poet_65m", 1, 0, player.id)
				else
					player:addItem("poet_65f", 1, 0, player.id)
				end
				player:addLegend("Blessed by the spirit of Hyun Moo. "..curT(), "bonded_element", 134, 67)
				player.quest["poet_65armor"] = 6
			else
				player:dialogSeq({t, "You don't have the required items. To forge your garment I need the cloth Yaki has prepared and the hand-item from the Emerald Tigers."}, 1)
			end
		elseif (player.quest["poet_65armor"] == 6) then
				player:dialogSeq({t, "I am not prepared to share any secrets with you at this time..."}, 1)
		end
	elseif (choice == "Minor Quest") then
		minor_questa.click(player, npc)
	elseif (choice == "Tarnished Soul: Poet Garments") then
		player:dialogSeq({t, "I see.. so your soul has become tarnished and you have lost your armor on your travels, we can start again from scratch but you will lose all progress on this journey.",
				t, "((Please only continue if you wish to fully reset the armor quests))"}, 1)
					local newChoice=player:menuString("Are you certain you wish to start over again? It will cost you 10,000 gold.",{"Yes","No"})
					if(newChoice == "Yes") then
							if(player.money >= 10000) then
								player.money = player.money - 10000
								player:sendStatus()
								player:dialogSeq({t, "Speak with me again and we shall start over."}, 1)
								player.quest["poet_65armor"] = 0
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
			if (player:hasItem("poet_sevent", 100) == true) then
					player:dialogSeq({t, "Ah, you have the stones! Excellent! *he examines the stones carefully* Ah… I see.. Are you ready to gain the knowledge contained within?"}, 1)

					local newChoice=player:menuString("Choose carefully, this is not a choice you can turn back from...",{"Druid","Bard"})
					if(newChoice == "Druid") then
						player:dialogSeq({t, "It says here that the Druids were one of the supreme spirit menders of the lands! With their honed spirit, they brought forth great healing!"}, 1)
						local newChoice2=player:menuString("Are you certain of your choice?",{"Yes","No"})
						if(newChoice2 == "Yes") then
							player:removeItem("poet_sevent", 100)
							player.class = 12
							player.registry["subpathlevel"] = 1
							player.quest["choose_subpath"] = 0
							player:sendStatus()
							player:dialogSeq({t, "A wise choice. You now have a new power surging within you.. seek others like yourself and find where they gather, new secrets await you..."}, 1)
						else
							player:dialogSeq({t, "I see..."}, 1)
						end
					elseif(newChoice == "Bard") then
						player:dialogSeq({t, "It says here that the Bards were one of the supreme spirit menders of the lands! With their honed spirit, they brought forth great healing!"}, 1)
						local newChoice2=player:menuString("Are you certain of your choice?",{"Yes","No"})
						if(newChoice2 == "Yes") then
							player:removeItem("poet_sevent", 100)
							player.class = 13
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
	elseif (choice == "Poet Subpaths") then
			if (player.quest["poet_pickSubpath"] >= 2) then
				player:dialogSeq({t, "Have you picked one yet?"}, 0)	
			elseif (player.quest["poet_pickSubpath"] == 1) then
				if (player:hasLegend("repSubQ_Druid") == true) then
					if (player:hasLegend("repSubQ_Bard") == true) then
						player.quest["poet_pickSubpath"] = player.quest["poet_pickSubpath"] + 1
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

			elseif (player.quest["poet_pickSubpath"] == 0) then
				player.dialogType = 1
				player:dialogSeq({t, "So, you're interested in joining a Subpath are you?",
				t, "There are two within each main path. For the healers, poets of the Empire you can either become a Bard or Druid."}, 1)
				player.lastClick = NPC(129).ID
				player:dialogSeq({npcB, "The Druid people are one with the earth, they devote themselves to binding their lives with large Ent-like creatures."}, 1)
				player.lastClick = NPC(131).ID
				player:dialogSeq({npcB, "The Bards on the other hand, are known for their musical gifts. They are the ones who use songs, chants and other mediums for spiritual and fighting purposes."}, 1)
				player.dialogType = 0
				player.lastClick = NPC(113).ID
				player.quest["poet_pickSubpath"] = player.quest["poet_pickSubpath"] + 1 	
				player:dialogSeq({t, "Seek out both representatives for each path and complete a small task for them. Once you've done this come back and see me."}, 0)
			end
	end
	
	player:calcStat()
end),

action = function(npc, player)

end
}