styling = {
click = async(function(player, comb)
	local npc = styling.getFreeStylistNPC(player)
	
	local hairStyles = {}
	local styleToCraft = 0

	local options = {"Yes", "No"}
	local choice = ""

	player.lastClick = npc.ID
	

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

	stylist.setup(npc, player)
	player.dialogType = 2

	repeat
	styleToCraft = player:menu("What hair style would you like?", hairStyles)
	
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
		npc.gfxHair = fail
	end
	
	if (styleToCraft == #hairStyles) then
		return
	end
	
	choice = player:menuString("Is this how you would like to style your hair?", options)
	
	if (choice == "Yes") then

		player.hair = npc.gfxHair

		player:removeItem("comb", 1)
		player:updateState()

	elseif (choice == "No") then
	end
	until (choice == "Yes")

end),

getFreeStylistNPC = function(stylist)
	local npcsInBlock = {}
	
	stylist:addNPC("stylist", stylist.m, stylist.x, stylist.y, 0, 5000)
	npcsInBlock = stylist:getObjectsInCell(stylist.m, stylist.x, stylist.y, BL_NPC)
	
	if (#npcsInBlock > 0) then
		for i = 1, #npcsInBlock do
			if (npcsInBlock[i].yname == "stylist") then
				npcsInBlock[i].state = 0
				return npcsInBlock[i]
			end
		end
	end
end
}

stylist = {
setup = function(npc, target)
	local item
	
	if (target:getEquippedItem(EQ_WEAP) ~= nil) then
		item = target:getEquippedItem(EQ_WEAP)
		npc.gfxWeap = item.look
		npc.gfxWeapC = item.lookC
	else 
		npc.gfxWeap = 65535
	end
	
	if (target:getEquippedItem(EQ_ARMOR) ~= nil) then
		item = target:getEquippedItem(EQ_ARMOR)

		npc.gfxArmor = item.look
		npc.gfxArmorC = item.lookC

		if(item.allowDye == 1) then
			if (item.lookC < 0) then
				npc.gfxArmorC = item.lookC+target.armorColor
			else
				npc.gfxArmorC = target.armorColor
			end
		else
			npc.gfxArmorC = 0
		end
	else
		npc.gfxArmor = target.sex
	end
	
	if (target:getEquippedItem(EQ_COAT) ~= nil) then
		item = target:getEquippedItem(EQ_COAT)
		npc.gfxArmor = item.look
		npc.gfxArmorC = item.lookC

		if(item.allowDye == 1) then
			if (item.lookC < 0) then
				npc.gfxArmorC = item.lookC+target.armorColor
			else
				npc.gfxArmorC = target.armorColor
			end
		else
			npc.gfxArmorC = 0
		end
	end
	
	if (target:getEquippedItem(EQ_SHIELD) ~= nil) then
		item = target:getEquippedItem(EQ_SHIELD)
		npc.gfxShield = item.look
		npc.gfxShieldC = item.lookC
	else
		npc.gfxShield = 65535
	end
	
	npc.gfxHelm = 65535
	
	if (target:getEquippedItem(EQ_FACEACC) ~= nil) then
		item = target:getEquippedItem(EQ_FACEACC)
		npc.gfxFaceA = item.look
		npc.gfxFaceAC = item.lookC

		if(item.allowDye == 1) then
			npc.gfxFaceAC = item.lookC+target.hairColor
		else
			npc.gfxFaceAC = item.lookC
		end
	else
		npc.gfxFaceA = 65535
	end
	
	npc.gfxFaceAT = 65535
	
	if (target:getEquippedItem(EQ_CROWN) ~= nil) then
		item = target:getEquippedItem(EQ_CROWN)
		npc.gfxCrown = item.look
		npc.gfxCrownC = item.lookC

		if(item.allowDye == 1) then
			npc.gfxCrownC = item.lookC+target.hairColor
		else
			npc.gfxCrownC = item.lookC
		end
	else
		npc.gfxCrown = 65535
	end
	
	if (target:getEquippedItem(EQ_MANTLE) ~= nil) then
		item = target:getEquippedItem(EQ_MANTLE)
		npc.gfxCape = item.look
		npc.gfxCapeC = item.lookC
	else
		npc.gfxCape = 65535
	end
	
	if (target:getEquippedItem(EQ_NECKLACE) ~= nil) then
		item = target:getEquippedItem(EQ_NECKLACE)
		npc.gfxNeck = item.look
		npc.gfxNeckC = item.lookC
	else
		npc.gfxNeck = 65535
	end
	
	if (target:getEquippedItem(EQ_BOOTS) ~= nil) then
		item = target:getEquippedItem(EQ_BOOTS)
		npc.gfxBoots = item.look
		npc.gfxBootsC = item.lookC
	else
		npc.gfxBoots = target.sex
	end
	
	npc.gfxFace = target.face
	npc.gfxHair = target.hair
	npc.gfxHairC = target.hairColor
	npc.gfxFaceC = target.faceColor
	npc.gfxSkinC = target.skinColor
	--npc.gfxDye = target.armorColor
	npc.gfxName = ""

	--target:talk(1,"Value: "..npc.gfxCrownC)
end,

endAction = function(npc)
	npc:delete()
end
}

styling_dye = {
click = async(function(player, hair_dye)
	local npc = styling.getFreeStylistNPC(player)
	
	local hairColors = {}
	local styleToCraft = 0

	local options = {"Yes", "No"}
	local choice = ""

	player.lastClick = npc.ID

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

	stylist.setup(npc, player)
	player.dialogType = 2

	repeat
	styleToCraft = player:menu("What hair color would you like?", hairColors)
	
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
	
	
	choice = player:menuString("Is this how you would like to dye your hair?", options)
	
	if (choice == "Yes") then

		player.hairColor = npc.gfxHairC

		player:removeItem("hair_dye", 1)
		player:updateState()

	elseif (choice == "No") then
	end
	until (choice == "Yes")

end),

getFreeStylistNPC = function(stylist)
	local npcsInBlock = {}
	
	stylist:addNPC("stylist", stylist.m, stylist.x, stylist.y, 0, 300000)
	npcsInBlock = stylist:getObjectsInCell(stylist.m, stylist.x, stylist.y, BL_NPC)
	
	if (#npcsInBlock > 0) then
		for i = 1, #npcsInBlock do
			if (npcsInBlock[i].yname == "stylist") then
				npcsInBlock[i].state = 0
				return npcsInBlock[i]
			end
		end
	end
end
}

styling_face = {
click = async(function(player)
	local npc = styling_face.getFreeStylistNPC(player)
	
	local faces = {}
	local styleToCraft = 0

	local options = {"Yes", "No"}
	local choice = ""

	player.lastClick = npc.ID

		table.insert(faces,"Fearless")
		table.insert(faces,"Mischievous")
		table.insert(faces,"Wide eyed")
		table.insert(faces,"Foxy")
		table.insert(faces,"Brows")
		table.insert(faces,"Modest")
		table.insert(faces,"Hopeful")
		table.insert(faces,"Blanked")
		table.insert(faces,"Cherry")
		table.insert(faces,"Intense")
		table.insert(faces,"Doubtful")
		table.insert(faces,"Sad")
		table.insert(faces,"Satisfied")
		table.insert(faces,"Jumpy")
		table.insert(faces,"Tired")
		table.insert(faces,"Squinty")
		table.insert(faces,"Joyful")
		table.insert(faces,"Naughty")
		table.insert(faces,"Mysterious")
		table.insert(faces,"Passionate")

	stylist.setup(npc, player)
	player.dialogType = 2

	repeat
	styleToCraft = player:menu("What facial features interest you?", faces)
	
	if (styleToCraft == 1) then
		npc.gfxFace = 201
	elseif (styleToCraft == 2) then
		npc.gfxFace = 202
	elseif (styleToCraft == 3) then
		npc.gfxFace = 203
	elseif (styleToCraft == 4) then
		npc.gfxFace = 204
	elseif (styleToCraft == 5) then
		npc.gfxFace = 205
	elseif (styleToCraft == 6) then
		npc.gfxFace = 207
	elseif (styleToCraft == 7) then
		npc.gfxFace = 208
	elseif (styleToCraft == 8) then
		npc.gfxFace = 209
	elseif (styleToCraft == 9) then
		npc.gfxFace = 210
	elseif (styleToCraft == 10) then
		npc.gfxFace = 211
	elseif (styleToCraft == 11) then
		npc.gfxFace = 212
	elseif (styleToCraft == 12) then
		npc.gfxFace = 213
	elseif (styleToCraft == 13) then
		npc.gfxFace = 214
	elseif (styleToCraft == 14) then
		npc.gfxFace = 215
	elseif (styleToCraft == 15) then
		npc.gfxFace = 216
	elseif (styleToCraft == 16) then
		npc.gfxFace = 217
	elseif (styleToCraft == 17) then
		npc.gfxFace = 218
	elseif (styleToCraft == 18) then
		npc.gfxFace = 224
	elseif (styleToCraft == 19) then
		npc.gfxFace = 225
	elseif (styleToCraft == 20) then
		npc.gfxFace = 229
	end
	
	
	choice = player:menuString("Is this how you would like your face to look?", options)
	
	if (choice == "Yes") then

		player.face = npc.gfxFace
		player:updateState()

	elseif (choice == "No") then
	end
	until (choice == "Yes")

end),

getFreeStylistNPC = function(stylist)
	local npcsInBlock = {}
	
	stylist:addNPC("stylist", stylist.m, stylist.x, stylist.y, 0, 300000)
	npcsInBlock = stylist:getObjectsInCell(stylist.m, stylist.x, stylist.y, BL_NPC)
	
	if (#npcsInBlock > 0) then
		for i = 1, #npcsInBlock do
			if (npcsInBlock[i].yname == "stylist") then
				npcsInBlock[i].state = 0
				return npcsInBlock[i]
			end
		end
	end
end
}