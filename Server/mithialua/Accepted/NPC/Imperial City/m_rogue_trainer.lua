m_rogue_trainer = {
click = async(function(player, npc)
	local t = {graphic = convertGraphic(2, "monster"), color = 10}
	local npcB = {graphic = 0, color = 0}
	local menuOptions = {}
	local choiceOptions = {"Yes, I wish to become a Rogue.", "No, I need some time to think."}
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if (player.baseClass == 2 and player.level >= 65) then
		table.insert(menuOptions, "Reinforced Rogue Armor")
	end

	if (player.baseClass == 2 and player.level >= 65 and player.quest["rogue_65armor"] >= 6) then
		table.insert(menuOptions, "Tarnished Soul: Rogue Armor")
	end

	--if (player.class == 2 and player.level >= 50) then
	--	table.insert(menuOptions, "Destined Path")
	--end

	if (player.gmLevel == 99) then
		--table.insert(menuOptions, "Reinforced Rogue Armor")
	end

	if (player.class == 0 or player.baseClass == 2) then
		table.insert(menuOptions, "Minor Quest")
		table.insert(menuOptions, "Learn Spell")
	end
	
	table.insert(menuOptions, "Forget Spell")

	if (player.class == 2 and player.level >= 50) then
		table.insert(menuOptions, "")
		table.insert(menuOptions, "Rogue Subpaths")
	end

	local choice = player:menuString("How may I assist you "..player.name.."?", menuOptions)
	
	if (choice == "Reinforced Rogue Armor") then
	if (player.quest["rogue_65armor"] == 0) then
			player:dialogSeq({t, "You seek an enhanced armor? Whispers around town tell tales of master Rogues, their weapons so nimble the wind is all you hear before realizing you have been severely damaged.",
				t, "I can tell you have a flair for the wicked, I can help you reach your full potential... However, it will take training, cunning, and the willingness to do anything.",
				t, "For your first task you must invoke the power of one of the great elements, Wind.",
				stone, "Take this stone east to the Dor Nalan Wilds, climb the steps upon the sacred mountain to the temples that rest on the top. These temples were once home to a sacred order that employed only the greatest Tricksters, Shadows and Archers.",
				t, "The temples are built strong, strong enough to endure the rampant winds that slice through the air. The moaning of them sounds much like a whisper of voices from the past speaking to you...",
				t, "Stand upon the archway, grasp your stone tightly and hold it high above your head to harness the violent winds. ((Click to use the item.))",
				t, "Once you have completed this task, return to me with your imbued stone and we shall progress from there."}, 1)
					if (player:hasSpace("base_stone", 1) ~= true) then
						player:dialogSeq({t, "You seem to have no space, make room first and talk to me again."}, 0)
					else
						player:addItem("base_stone", 1)
						player.quest["rogue_65armor"] = 1
					end
		elseif (player.quest["rogue_65armor"] == 1) then
			if (player:hasItem("r_stone", 1) == true) then
				player:dialogSeq({t, "The stone vibrates with energy from the wind spirit you harnessed.. What raw power...",
					t, "Now we need a base by which to form your armor. Gather some Tin Ore, about 100 should do. Return to me when you have them in your pack."}, 1)
				player:removeItem("r_stone", 1)
				player.quest["rogue_65armor"] = 2
			else
				player:dialogSeq({t, "Bring back the imbued stone from the wind-worn temples in the Dor Nalan Wilds."}, 1)
			end
		elseif (player.quest["rogue_65armor"] == 2) then
			if (player:hasItem("tin_ore", 100) == true) then
				player:dialogSeq({t, "You have mined the ore and shown your endurance. I am sure you are up for this next task...",
					t, "Gather your comrades and venture to the Haunted Valley in the Seong Lowlands. Slay the undead menace that bears a great resemblance to our kind. Return to me once you have slaughtered their current form."}, 1)
				player:removeItem("tin_ore", 100)
				player.quest["rogue_65armor"] = 3
			else
				player:dialogSeq({t, "Tin Ore can be gathered by using a pickaxe on ore nodes. Mining tools are sold by any smith.",
					t, "Tin Ore is located in the Isla Caverns, north of the Seong Lowlands."}, 1)
			end
		elseif (player.quest["rogue_65armor"] == 3) then
				player:dialogSeq({t, "You must slay the undead menace that clutches a great Rogue weapon. We need the energies released by its recent defeat to press on with your armor."}, 1)
		elseif (player.quest["rogue_65armor"] == 4) then
				player:dialogSeq({t, "I can sense you have completed your task. The undead Rogue of the Haunted Valley has been vanquished. Congratulations.",
					t, "Now go visit Bando, the Han smith, he should have the metal prepared from the ore you mined earlier.",
					t, "Bring the metal from Bando and a bracer worn by our path, the ones coveted by the Emerald Tigers of the Tanzar Empire should do nicely. Do this for me and we shall forge your new armor!"}, 1)
				player.quest["rogue_65armor"] = 5
		elseif (player.quest["rogue_65armor"] == 5) then
			if (player:hasItem("65quest_metal", 1) == true and player:hasItem("roguehand2", 1) == true) then
				player:dialogSeq({t, "I see you have gathered all the items I asked for. As you grow in power, so shall this armor. Return to me when you have gained more insight and we shall improve it further...",
					t, "*You witness the master mumble to himself for a moment, casting a grand spell upon the items...*",
					t, "*As you peer closer you feel wind whip from behind you, encircling the items. A loud clash rings out and you're pushed off your feet from the force of the winds...*",
					t, "*Recovering your equilibrium you stand, looking back at the once vicious whirlwind noticing a new sleek armor lay in its wake.*"}, 1)
				player:removeItem("65quest_metal", 1)
				player:removeItem("roguehand2", 1)

				if (player.sex == 0) then
					player:addItem("rogue_65m", 1, 0, player.id)
				else
					player:addItem("rogue_65f", 1, 0, player.id)
				end
				player:addLegend("Blessed by the spirit of Baekho. "..curT(), "bonded_element", 132, 61)
				player.quest["rogue_65armor"] = 6
			else
				player:dialogSeq({t, "You don't have the required items. To forge your armor I need the metal Bando has prepared and the hand-item from the Emerald Tigers."}, 1)
			end
		elseif (player.quest["rogue_65armor"] == 6) then
				player:dialogSeq({t, "I am not prepared to share any secrets with you at this time..."}, 1)
		end
	elseif (choice == "Minor Quest") then
		minor_questa.click(player, npc)
	elseif (choice == "Tarnished Soul: Rogue Armor") then
		player:dialogSeq({t, "I see.. so your soul has become tarnished and you have lost your armor on your travels, we can start again from scratch but you will lose all progress on this journey.",
				t, "((Please only continue if you wish to fully reset the armor quests))"}, 1)
					local newChoice=player:menuString("Are you certain you wish to start over again? It will cost you 10,000 gold.",{"Yes","No"})
					if(newChoice == "Yes") then
							if(player.money >= 10000) then
								player.money = player.money - 10000
								player:sendStatus()
								player:dialogSeq({t, "Speak with me again and we shall start over."}, 1)
								player.quest["rogue_65armor"] = 0
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
			if (player:hasItem("rogue_sevent", 100) == true) then
					player:dialogSeq({t, "Ah, you have the stones! Excellent! *he examines the stones carefully* Ah… I see.. Are you ready to gain the knowledge contained within?"}, 1)
					
					local newChoice=player:menuString("Choose carefully, this is not a choice you can turn back from...",{"Shadow","Archer"})
					if(newChoice == "Shadow") then
						player:dialogSeq({t, "It says here that the Shadows were the most agile of fighters in the lands! With their honed agility, they brought forth great powers!"}, 1)
						local newChoice2=player:menuString("Are you certain of your choice?",{"Yes","No"})
						if(newChoice2 == "Yes") then
							player:removeItem("rogue_sevent", 100)
							player.class = 8
							player.registry["subpathlevel"] = 1
							player.quest["choose_subpath"] = 0
							player:sendStatus()
							player:dialogSeq({t, "A wise choice. You now have a new power surging within you.. seek others like yourself and find where they gather, new secrets await you..."}, 1)
						else
							player:dialogSeq({t, "I see..."}, 1)
						end
					elseif(newChoice == "Archer") then
						player:dialogSeq({t, "It says here that the Archers were the most agile of fighters in the lands! With their honed agility, they brought forth great powers!"}, 1)
						local newChoice2=player:menuString("Are you certain of your choice?",{"Yes","No"})
						if(newChoice2 == "Yes") then
							player:removeItem("rogue_sevent", 100)
							player.class = 9
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
	elseif (choice == "Rogue Subpaths") then
			if (player.quest["rogue_pickSubpath"] >= 2) then
				player:dialogSeq({t, "Have you picked one yet?"}, 0)	
			elseif (player.quest["rogue_pickSubpath"] == 1) then
				if (player:hasLegend("repSubQ_Archer") == true) then
					if (player:hasLegend("repSubQ_Shadow") == true) then
						player.quest["rogue_pickSubpath"] = player.quest["rogue_pickSubpath"] + 1
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

			elseif (player.quest["rogue_pickSubpath"] == 0) then
				player.dialogType = 1
				player:dialogSeq({t, "So, you're interested in joining a Subpath are you?",
				t, "There are two within each main path. For the nimble, rogues of the Empire, you can either become a Shadow or Archer."}, 1)
				player.lastClick = NPC(134).ID
				player:dialogSeq({npcB, "The Shadows.\n\nSecluded and surprisingly scarce. They are the assassins of Han, trained in the silent art of killing.. a deadly combatant."}, 1)
				player.lastClick = NPC(133).ID
				player:dialogSeq({npcB, "The Archers.\n\nAgile huntsmen and profound foragers. Most often seen with a bow, they are masters of archery."}, 1)
				player.dialogType = 0
				player.lastClick = NPC(113).ID
				player.quest["rogue_pickSubpath"] = player.quest["rogue_pickSubpath"] + 1 	
				player:dialogSeq({t, "Seek out both representatives for each path and complete a small task for them. Once you've done this come back and see me."}, 0)
			end
	end
	
	player:calcStat()
end),

action = function(npc, player)

end
}