salon_hairndye = {
click = async(function(player,npc)
		--player:talk(0,""..player.lastClick)
		local t={graphic=convertGraphic(56,"monster"),color=6}
		local opts = { }

				player.npcGraphic=t.graphic
				player.npcColor=t.color
				player.dialogType = 0
				
			table.insert(opts,"Hair Style")
			table.insert(opts,"Hair Color")
			table.insert(opts,"Wigs/Beards")

			local menuOption=player:menuString("When it comes to hair I know the statement you want to make!", opts)
			--player:buyExtend("I have some supplies if you would like to style your hair. I'll give you a hand, just pick what you like.",{500, 501})

			if(menuOption=="Hair Style") then
				player:dialogSeq({t,"I can assist you if you would like to style your hair. It will cost you 3,000 coins."},1)
				if(player.money<3000) then
							player:dialogSeq({t,"You do not have enough money. Come back when your pockets are a little heavier."})
							return
				end
				salon_hairndye.hair_select(player)

			elseif(menuOption=="Hair Color") then
				player:dialogSeq({t,"I can assist you if you would like to color your hair. It will cost you 3,000 coins."},1)
				if(player.money<3000) then
							player:dialogSeq({t,"You do not have enough money. Come back when your pockets are a little heavier."})
							return
				end
				salon_hairndye.hair_color(player)
			elseif(menuOption=="Wigs/Beards") then
				player:buyExtend("These quality wigs are able to take to hair dyes. Please be aware some wigs types are affected differently by dyes.", {617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629})
			end

end),

hair_select = function(player)
	local npc
	local t={graphic=convertGraphic(56,"monster"),color=6}
	
	local hairStyles = {}
	local styleToCraft = 0

	local options = {"Yes", "No"}
	local choice = ""
	

		table.insert(hairStyles, "Fresh Meat")
		table.insert(hairStyles, "Wannabe")
		table.insert(hairStyles, "Everyman")
		table.insert(hairStyles, "Mesuvian")
		table.insert(hairStyles, "Grungy")
		table.insert(hairStyles, "Mop Top")
		table.insert(hairStyles, "Gretchen")
		table.insert(hairStyles, "Serpent Tail")
		table.insert(hairStyles, "Worker")
		table.insert(hairStyles, "Snake Charmer")
		table.insert(hairStyles, "Sheepish")

		table.insert(hairStyles, "Bound")
		table.insert(hairStyles, "Flipped")
		table.insert(hairStyles, "Schoolgirl")
		table.insert(hairStyles, "Farmer")
		table.insert(hairStyles, "Bathead")
		table.insert(hairStyles, "Stuck Up")
		table.insert(hairStyles, "Sidewinder")
		table.insert(hairStyles, "Chopstick")
		table.insert(hairStyles, "Emo")
		table.insert(hairStyles, "Bedhead")
		table.insert(hairStyles, "Chopped")

		table.insert(hairStyles, "Greased")
		table.insert(hairStyles, "Bandito")
		table.insert(hairStyles, "Chaos")
		table.insert(hairStyles, "Curled Up")
		table.insert(hairStyles, "Bunbuns")
		table.insert(hairStyles, "Wanderer")
		table.insert(hairStyles, "Gentleman")
		table.insert(hairStyles, "Brush")
		table.insert(hairStyles, "Flippy Dippy")
		table.insert(hairStyles, "Muffintop")
		table.insert(hairStyles, "Helmet Head")

		table.insert(hairStyles, "Topknot")
		table.insert(hairStyles, "Innocent")
		table.insert(hairStyles, "Patches")
		table.insert(hairStyles, "Wingtips")
		table.insert(hairStyles, "Side Curls")
		table.insert(hairStyles, "WIP")
		table.insert(hairStyles, "Parting Ways")
		table.insert(hairStyles, "Twin Rolls")
		table.insert(hairStyles, "Shoulder Puffs")
		table.insert(hairStyles, "Forked")
		table.insert(hairStyles, "Regal")

		table.insert(hairStyles, "Side Braids")
		table.insert(hairStyles, "Professional")
		table.insert(hairStyles, "Pompous")
		table.insert(hairStyles, "Flat Top")
		table.insert(hairStyles, "Cow Lick")
		table.insert(hairStyles, "Bookworm")
		table.insert(hairStyles, "Mad Chemist")
		table.insert(hairStyles, "Zen")
		table.insert(hairStyles, "Floor Sweeper")
		table.insert(hairStyles, "Coy")
		table.insert(hairStyles, "Swept Bangs")

		table.insert(hairStyles, "Gambler")
		table.insert(hairStyles, "Sprout")
		table.insert(hairStyles, "Fierce")
		table.insert(hairStyles, "Windblown")
		table.insert(hairStyles, "Shocked")
		table.insert(hairStyles, "Jester")
		table.insert(hairStyles, "Formality")
		table.insert(hairStyles, "Spiritual")
		table.insert(hairStyles, "Wisp")
		table.insert(hairStyles, "Hoarded")
		table.insert(hairStyles, "Whip Braid")

		table.insert(hairStyles, "Thin Mullet")
		table.insert(hairStyles, "Wooly Bully")
		table.insert(hairStyles, "Combed")
		table.insert(hairStyles, "Flutter")
		table.insert(hairStyles, "Under Curl")
		table.insert(hairStyles, "Wedge")
		table.insert(hairStyles, "Afro")
		table.insert(hairStyles, "Dreads")
		table.insert(hairStyles, "Rising Danger")
		table.insert(hairStyles, "Swirled")
		table.insert(hairStyles, "FABULOUS")

		table.insert(hairStyles, "Wave")
		table.insert(hairStyles, "Side Point")
		table.insert(hairStyles, "Wooly")
		table.insert(hairStyles, "Crested Wave")
		table.insert(hairStyles, "Delusive")
		table.insert(hairStyles, "Rice Buns")
		table.insert(hairStyles, "Hobo")
		table.insert(hairStyles, "Mischievous")
		table.insert(hairStyles, "Swept Out")
		table.insert(hairStyles, "Pulled Back")
		table.insert(hairStyles, "Eyesore")

		table.insert(hairStyles, "Bon Bon")
		table.insert(hairStyles, "Lolli")
		table.insert(hairStyles, "Upswept Fury")
		table.insert(hairStyles, "Romancer")
		table.insert(hairStyles, "Sticky")
		table.insert(hairStyles, "Looper")
		table.insert(hairStyles, "Starlet")
		table.insert(hairStyles, "Tribal Braid")
		table.insert(hairStyles, "Snub Tail")
		table.insert(hairStyles, "Explosion")
		table.insert(hairStyles, "Tattered")

		table.insert(hairStyles, "Balance")
		table.insert(hairStyles, "Sloped")
		table.insert(hairStyles, "Alluring")
		table.insert(hairStyles, "Sovereign")
		table.insert(hairStyles, "Contained")
		table.insert(hairStyles, "Turkey")
		table.insert(hairStyles, "Sakkat")
		table.insert(hairStyles, "Shuriken")
		table.insert(hairStyles, "Matriarch")
		table.insert(hairStyles, "Terbulent")
		table.insert(hairStyles, "Covered Buns")
		table.insert(hairStyles, "Recluse")

		table.insert(hairStyles, "Little Hood")
		table.insert(hairStyles, "Tuffled")
		table.insert(hairStyles, "Brush Over")
		table.insert(hairStyles, "Nifty")
		table.insert(hairStyles, "Rat's Nest")
		table.insert(hairStyles, "Frosted")
		table.insert(hairStyles, "Spider Silk")
		table.insert(hairStyles, "Highlight")
		table.insert(hairStyles, "Streaked")
		table.insert(hairStyles, "Cloud")
		table.insert(hairStyles, "Creampuff")
		table.insert(hairStyles, "Kid")
		table.insert(hairStyles, "Mess")

		table.insert(hairStyles, "Plaster")
		table.insert(hairStyles, "Headdress")
		table.insert(hairStyles, "Native")
		table.insert(hairStyles, "Gangsta")
		table.insert(hairStyles, "Classy")
		table.insert(hairStyles, "Radical")
		table.insert(hairStyles, "Onion")
		table.insert(hairStyles, "Elaborate")
		table.insert(hairStyles, "Rat Tail")
		table.insert(hairStyles, "Swoops")
		table.insert(hairStyles, "Loner")
		table.insert(hairStyles, "Feathered")
		table.insert(hairStyles, "Lolita")
		table.insert(hairStyles, "Bald")

	repeat
		local t={graphic=convertGraphic(56,"monster"),color=6}
		player.npcGraphic=t.graphic
		player.npcColor=t.color
		player.dialogType = 0
		styleToCraft = player:menu("What hair style would you like?", hairStyles)

		npc = styling.getFreeStylistNPC(player)
		stylist.setup(npc, player)
		player.lastClick = npc.ID
		player.dialogType = 2
	
		if (styleToCraft <= 19) then
			npc.gfxHair = styleToCraft - 1
		elseif (styleToCraft <= 61) then
			npc.gfxHair = styleToCraft
		elseif (styleToCraft <= 87) then
			npc.gfxHair = styleToCraft + 1
		elseif (styleToCraft <= 94) then
			npc.gfxHair = styleToCraft + 2
		elseif (styleToCraft <= 112) then
			npc.gfxHair = styleToCraft + 3
		elseif (styleToCraft <= 137) then
			npc.gfxHair = styleToCraft + 5
		elseif (styleToCraft == 138) then
			npc.gfxHair = 19
		end
		
		if (styleToCraft == #hairStyles + 1) then
			return
		end

		choice = player:menuString("Is this how you would like to style your hair?", options)
		
		if (choice == "Yes") then

			player.hair = npc.gfxHair
			player:updateState()
			player.money=player.money-3000
			player:sendStatus()

		elseif (choice == "No") then
			player.lastClick = 3221225500
		end
	until (choice == "Yes")

end,

hair_color = function(player, hair_dye)
	local npc
	local t={graphic=convertGraphic(56,"monster"),color=6}
	
	local hairColors = {}
	local styleToCraft = 0

	local options = {"Yes", "No"}
	local choice = ""

		table.insert(hairColors, "Black")
		table.insert(hairColors, "White")
		table.insert(hairColors, "Red")
		table.insert(hairColors, "Light Red")
		table.insert(hairColors, "Rust")
		table.insert(hairColors, "Blue")
		table.insert(hairColors, "Light Blue")
		table.insert(hairColors, "Turquoise")
		table.insert(hairColors, "Brown")
		table.insert(hairColors, "Light Brown")
		table.insert(hairColors, "Blonde")
		table.insert(hairColors, "Green")
		table.insert(hairColors, "Light Green")
		table.insert(hairColors, "Light Purple")
		table.insert(hairColors, "Purple")
		table.insert(hairColors, "Dark Purple")
		table.insert(hairColors, "Orange")
		table.insert(hairColors, "Mint Green")
		table.insert(hairColors, "Honest Blue")
		table.insert(hairColors, "Dull Blue")

	repeat
		local t={graphic=convertGraphic(56,"monster"),color=6}
		player.npcGraphic=t.graphic
		player.npcColor=t.color
		player.dialogType = 0

		styleToCraft = player:menu("What hair color would you like?", hairColors)

		npc = styling.getFreeStylistNPC(player)
		stylist.setup(npc, player)
		player.lastClick = npc.ID
		player.dialogType = 2

		if (styleToCraft == 1) then
			npc.gfxHairC = 0
		elseif (styleToCraft == 2) then
			npc.gfxHairC = 1
		elseif (styleToCraft == 3) then
			npc.gfxHairC = 21
		elseif (styleToCraft == 4) then
			npc.gfxHairC = 11
		elseif (styleToCraft == 5) then
			npc.gfxHairC = 27
		elseif (styleToCraft == 6) then
			npc.gfxHairC = 7
		elseif (styleToCraft == 7) then
			npc.gfxHairC = 8
		elseif (styleToCraft == 8) then
			npc.gfxHairC = 12
		elseif (styleToCraft == 9) then
			npc.gfxHairC = 2
		elseif (styleToCraft == 10) then
			npc.gfxHairC = 13
		elseif (styleToCraft == 11) then
			npc.gfxHairC = 20
		elseif (styleToCraft == 12) then
			npc.gfxHairC = 42
		elseif (styleToCraft == 13) then
			npc.gfxHairC = 5
		elseif (styleToCraft == 14) then
			npc.gfxHairC = 29
		elseif (styleToCraft == 15) then
			npc.gfxHairC = 3
		elseif (styleToCraft == 16) then
			npc.gfxHairC = 9
		elseif (styleToCraft == 17) then
			npc.gfxHairC = 10
		elseif (styleToCraft == 18) then
			npc.gfxHairC = 23
		elseif (styleToCraft == 19) then
			npc.gfxHairC = 24
		elseif (styleToCraft == 20) then
			npc.gfxHairC = 14
		end

		local item

		if (player:getEquippedItem(EQ_CROWN) ~= nil) then
			item = player:getEquippedItem(EQ_CROWN)
			npc.gfxCrown = item.look
			npc.gfxCrownC = item.lookC

			if(item.allowDye == 1) then
				npc.gfxCrownC = item.lookC+npc.gfxHairC
			else
				npc.gfxCrownC = item.lookC
			end
		else
			npc.gfxCrown = 65535
		end

		if (player:getEquippedItem(EQ_FACEACC) ~= nil) then
			item = player:getEquippedItem(EQ_FACEACC)
			npc.gfxFaceA = item.look
			npc.gfxFaceAC = item.lookC

			if(item.allowDye == 1) then
				npc.gfxFaceAC = item.lookC+npc.gfxHairC
			else
				npc.gfxFaceAC = item.lookC
			end
		else
			npc.gfxFaceA = 65535
		end
		
		player.lastClick = npc.ID
		player.dialogType = 2
		choice = player:menuString("Is this how you would like to dye your hair?", options)
		
		if (choice == "Yes") then

			player.hairColor = npc.gfxHairC
			player:updateState()
			player.money=player.money-3000
			player:sendStatus()

		elseif (choice == "No") then
			player.lastClick = 3221225500
		end

	until (choice == "Yes")

end,
}