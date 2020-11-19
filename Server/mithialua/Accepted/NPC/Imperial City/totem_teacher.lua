totem_teacher = {
click = async(function(player,npc)
		local t={graphic=convertGraphic(87,"monster"),color=5}
		local opts = {"Who are you?","Researching the Totems"}

		player.npcGraphic=t.graphic
		player.npcColor=t.color
		player.dialogType = 0

		if (player.quest["weapon95_uncurse"] >= 1) then
			table.insert(opts,"A cursed weapon...")
		end

	menuOption = player:menuString("Did you need help with something?", opts)

	if (menuOption == "A cursed weapon...") then
			if (player.quest["weapon95_uncurse"] == 1) then
				if (player:hasItem("warrior_95w_cur", 1) == true or player:hasItem("rogue_95w_cur", 1) == true or player:hasItem("mage_95w_cur", 1) == true or player:hasItem("poet_95w_cur", 1) == true) then
						if (player:hasItem("warrior_95w_cur", 1) == true) then
							if (player:hasItem("rough_kyanite", 20) == true and player:hasItem("amber", 100) == true and player:hasItem("ppearl", 10) == true and player:hasItem("c_mass", 20) == true and player:hasItem("r_flesh", 20) == true and player.money >= 20000) then
									player:dialogSeq({t, "It looks like you have gathered everything required to uncurse this weapon. Let us proceed."}, 1)
								if (player:hasItem("warrior_95w_cur", 1) == true and player:hasItem("rough_kyanite", 20) == true and player:hasItem("amber", 100) == true and player:hasItem("ppearl", 10) == true and player:hasItem("c_mass", 20) == true and player:hasItem("r_flesh", 20) == true and player.money >= 20000) then
									player.money = player.money - 20000
									player:sendStatus()
									player:removeItem("rough_kyanite", 20)
									player:removeItem("rough_kyanite", 20)
									player:removeItem("amber", 100)
									player:removeItem("ppearl", 10)
									player:removeItem("c_mass", 20)
									player:removeItem("r_flesh", 20)
									player:removeItem("warrior_95w_cur", 20)
									player:addItem("warrior_95w", 1, 0, player.id)
									player.quest["weapon95_uncurse"] = 0
									player:dialogSeq({t, "*Maris takes the items from you, placing together the cursed weapon and offering before the Chung Ryong totem*",
									t, "*You notice the mass of objects begin to crumble into a dust and with a great flash the weapon emerges anew*",
									t, "The totems have blessed your weapon, the curse has been removed."}, 1)
									return
								else
									player:dialogSeq({t,"Did you lose one of the items?"})
								end
							end
						elseif (player:hasItem("rogue_95w_cur", 1) == true) then
							if (player:hasItem("rough_kyanite", 20) == true and player:hasItem("amber", 100) == true and player:hasItem("ppearl", 10) == true and player:hasItem("c_mass", 20) == true and player:hasItem("r_flesh", 20) == true and player.money >= 20000) then
									player:dialogSeq({t, "It looks like you have gathered everything required to uncurse this weapon. Let us proceed."}, 1)
								if (player:hasItem("rogue_95w_cur", 1) == true and player:hasItem("rough_kyanite", 20) == true and player:hasItem("amber", 100) == true and player:hasItem("ppearl", 10) == true and player:hasItem("c_mass", 20) == true and player:hasItem("r_flesh", 20) == true and player.money >= 20000) then
									player.money = player.money - 20000
									player:sendStatus()
									player:removeItem("rough_kyanite", 20)
									player:removeItem("amber", 100)
									player:removeItem("ppearl", 10)
									player:removeItem("c_mass", 20)
									player:removeItem("r_flesh", 20)
									player:removeItem("rogue_95w_cur", 20)
									player:addItem("rogue_95w", 1, 0, player.id)
									player.quest["weapon95_uncurse"] = 0
									player:dialogSeq({t, "*Maris takes the items from you, placing together the cursed weapon and offering before the Baekho totem*",
									t, "*You notice the mass of objects begin to crumble into a dust and with a great flash the weapon emerges anew*",
									t, "The totems have blessed your weapon, the curse has been removed."}, 1)
									return
								else
									player:dialogSeq({t,"Did you lose one of the items?"})
								end
							end
						elseif (player:hasItem("mage_95w_cur", 1) == true) then
							if (player:hasItem("rough_kyanite", 20) == true and player:hasItem("amber", 100) == true and player:hasItem("ppearl", 10) == true and player:hasItem("c_mass", 20) == true and player:hasItem("r_flesh", 20) == true and player.money >= 20000) then
									player:dialogSeq({t, "It looks like you have gathered everything required to uncurse this weapon. Let us proceed."}, 1)
								if (player:hasItem("mage_95w_cur", 1) == true and player:hasItem("rough_kyanite", 20) == true and player:hasItem("amber", 100) == true and player:hasItem("ppearl", 10) == true and player:hasItem("c_mass", 20) == true and player:hasItem("r_flesh", 20) == true and player.money >= 20000) then
									player.money = player.money - 20000
									player:sendStatus()
									player:removeItem("rough_kyanite", 20)
									player:removeItem("amber", 100)
									player:removeItem("ppearl", 10)
									player:removeItem("c_mass", 20)
									player:removeItem("r_flesh", 20)
									player:removeItem("mage_95w_cur", 20)
									player:addItem("mage_95w", 1, 0, player.id)
									player.quest["weapon95_uncurse"] = 0
									player:dialogSeq({t, "*Maris takes the items from you, placing together the cursed weapon and offering before the Baekho totem*",
									t, "*You notice the mass of objects begin to crumble into a dust and with a great flash the weapon emerges anew*",
									t, "The totems have blessed your weapon, the curse has been removed."}, 1)
									return
								else
									player:dialogSeq({t,"Did you lose one of the items?"})
								end
							end
						elseif (player:hasItem("poet_95w_cur", 1) == true) then
							if (player:hasItem("rough_kyanite", 20) == true and player:hasItem("amber", 100) == true and player:hasItem("ppearl", 10) == true and player:hasItem("c_mass", 20) == true and player:hasItem("r_flesh", 20) == true and player.money >= 20000) then
									player:dialogSeq({t, "It looks like you have gathered everything required to uncurse this weapon. Let us proceed."}, 1)
								if (player:hasItem("poet_95w_cur", 1) == true and player:hasItem("rough_kyanite", 20) == true and player:hasItem("amber", 100) == true and player:hasItem("ppearl", 10) == true and player:hasItem("c_mass", 20) == true and player:hasItem("r_flesh", 20) == true and player.money >= 20000) then
									player.money = player.money - 20000
									player:sendStatus()
									player:removeItem("rough_kyanite", 20)
									player:removeItem("amber", 100)
									player:removeItem("ppearl", 10)
									player:removeItem("c_mass", 20)
									player:removeItem("r_flesh", 20)
									player:removeItem("poet_95w_cur", 20)
									player:addItem("poet_95w", 1, 0, player.id)
									player.quest["weapon95_uncurse"] = 0
									player:dialogSeq({t, "*Maris takes the items from you, placing together the cursed weapon and offering before the Baekho totem*",
									t, "*You notice the mass of objects begin to crumble into a dust and with a great flash the weapon emerges anew*",
									t, "The totems have blessed your weapon, the curse has been removed."}, 1)
									return
								else
									player:dialogSeq({t,"Did you lose one of the items?"})
								end
							end

						end
				player:dialogSeq({t, "Ah, another cursed weapon that has found its way to me..",
					t, "It is indeed a strong curse, but one that can be broken with a totem blessing. It may not be restored to complete power, but it will return to a powerful state none-the-less.",
					t, "You must present an offering to the totem god that empowers your path. I will also require remnants of the wretched beasts that tainted the weapon you discovered...",
					t, "Return to me once you have gathered the following: 100 Amber, 20 Rough Kyanite, 10 Poring Pearls, 20 Calcified Mass, 20 Rotten Flesh, and a fee of 20,000 gold."}, 1)
				end
			end
	elseif (menuOption == "Who are you?") then
			player:dialogSeq({t, "I am Maris, a Scholar of the great totems. I have studied their great power since I was a young boy. The totems exist within us all, feeding us with magical energies and power!",
				t, "I'm afraid that there is so much to learn still--perhaps we can talk more on the subject when I am not so busy with research."}, 1)
	elseif (menuOption == "Researching the Totems") then
			player:dialogSeq({t, "I am sorry.. I am a bit busy at the moment..",
				t, "Perhaps if you come back at a later time?"}, 1)
	end
end)
}