gm_viewer = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local options = { }

	if (player.gmLevel >= 10) then
	--local p = player
	table.insert(options,"Clear gfxToggle")
	table.insert(options,"Armor Viewer")
	table.insert(options,"Weapon Viewer")
	table.insert(options,"Helm Viewer")
	table.insert(options,"Shield Viewer")
	table.insert(options,"Cape Viewer")
	table.insert(options,"Crown Viewer")
	table.insert(options,"NPC/Monster Viewer")
	table.insert(options,"Spell Viewer")
	table.insert(options,"Sounds")
	table.insert(options,"Dyes")

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local fillblank = 0
	choice = player:menuString("How can I help you? (Please toggle graphics or state change before using options now)", options)
	if (choice == "Clear gfxToggle") then
		player.armorColor=0
		player:sendStatus()
		player:updateState()
		player:speak("/gfxtoggle", 0)
		player.gfxName = player.name
		player.gfxFace = player.face
		player.gfxFaceC = player.faceColor
		player.gfxHair = player.hair
		player.gfxHairC = player.hairColor
		player.gfxSkinC = player.skinColor
		player.gfxDye = player.armorColor
		player.gfxWeap = -1
		player.gfxWeapC = 0
		player.gfxArmor = player.sex
		player.gfxArmorC = 0
		player.gfxShield = -1
		player.gfxShieldC = 0
		player.gfxHelm = -1
		player.gfxHelmC = 0
		player.gfxCape = -1
		player.gfxCapeC = 0
		player.gfxCrown = -1
		player.gfxCrownC = 0
		player.gfxFaceA = -1
		player.gfxFaceAC = 0
		player.gfxFaceAT = -1
		player.gfxFaceATC = 0
		player.gfxNeck = -1
		player.gfxNeckC = 0
		player.gfxBoots = player.sex
		player.gfxBootsC = 0
		player:refresh()
		player:sendMinitext("You may now use graphic change options.")
	elseif (choice == "Dyes") then
		player:dialogSeq({t, "Dye viewer."}, 1)
		fillblank = tonumber(player:input("What number dye would you like?"))
		player.registry["gfx__viewer"] = fillblank
		r_dyeViewer(player)
	elseif (choice == "Sounds") then
		player:dialogSeq({t, "Sounds range in areas 1-125, 300-372, 401-412, 500-514, 700-740. There are no sounds after 740."}, 1)
		fillblank = tonumber(player:input("What number sound do you wish to hear?"))
		player.registry["gfx_sound"] = fillblank
		r_soundViewer(player)
	elseif (choice == "Armor Viewer") then
		fillblank = tonumber(player:input("What number armor do you wish to see? 0-349, 10000+"))
		player.registry["gfx__viewer"] = fillblank
		r_armorViewer(player)
	elseif (choice == "Weapon Viewer") then
		fillblank = tonumber(player:input("What number weapon do you wish to see? 0-400, 10000-10124, 20000-20131, 30000-30020"))
		player.registry["gfx__viewer"] = fillblank
		r_weaponViewer(player)
	elseif (choice == "Helm Viewer") then
		fillblank = tonumber(player:input("What number helm do you wish to see?"))
		player.registry["gfx__viewer"] = fillblank
		r_helmViewer(player)
	elseif (choice == "Shield Viewer") then
		fillblank = tonumber(player:input("What number shield do you wish to see?"))
		player.registry["gfx__viewer"] = fillblank
		r_shieldViewer(player)
	elseif (choice == "Cape Viewer") then
		fillblank = tonumber(player:input("What number cape do you wish to see?"))
		player.registry["gfx__viewer"] = fillblank
		r_capeViewer(player)
	elseif (choice == "Crown Viewer") then
		fillblank = tonumber(player:input("What number crown do you wish to see?"))
		player.registry["gfx__viewer"] = fillblank
		r_crownViewer(player)
	elseif (choice == "NPC/Monster Viewer") then
		fillblank = tonumber(player:input("What number NPC/Monster do you wish to see?"))
		player.registry["gfx__viewer"] = fillblank
		r_npcmonViewer(player)
	elseif (choice == "Spell Viewer") then
		fillblank = tonumber(player:input("What number Spell do you wish to see?"))
		player.registry["gfx__viewer"] = fillblank
		r_spellViewer(player)
	end
else
	player:dialogSeq({t, "I am sorry, you are not powerful enough for me to assist you."}, 1)
end

end)
}

r_dyeViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	player.gfxDye = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Dye #: "..player.registry["gfx__viewer"]..""}, 1)
	r_dyeViewer2(player)
end

r_dyeViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxDye = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Dye #: "..player.registry["gfx__viewer"]..""}, 1)
	r_dyeViewer3(player)
end

r_dyeViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxDye = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Dye #: "..player.registry["gfx__viewer"]..""}, 1)
	r_dyeViewer2(player)
end

r_soundViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player:playSound(player.registry["gfx_sound"])
	player:dialogSeq({t, "Sound #: "..player.registry["gfx_sound"]..""}, 1)
	r_soundViewer2(player)
end

r_soundViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx_sound"] = player.registry["gfx_sound"] + 1
	player:playSound(player.registry["gfx_sound"])
	player:dialogSeq({t, "Sound #: "..player.registry["gfx_sound"]..""}, 1)
	r_soundViewer3(player)
end

r_soundViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx_sound"] = player.registry["gfx_sound"] + 1
	player:playSound(player.registry["gfx_sound"])
	player:dialogSeq({t, "Sound #: "..player.registry["gfx_sound"]..""}, 1)
	r_soundViewer2(player)
end

r_spellViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player:selfAnimation(player.ID, player.registry["gfx__viewer"], 0)
	player:dialogSeq({t, "Spell #: "..player.registry["gfx__viewer"]..""}, 1)
	r_spellViewer2(player)
end

r_spellViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player:selfAnimation(player.ID, player.registry["gfx__viewer"], 0)
	player:dialogSeq({t, "Spell #: "..player.registry["gfx__viewer"]..""}, 1)
	r_spellViewer3(player)
end

r_spellViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player:selfAnimation(player.ID, player.registry["gfx__viewer"], 0)
	player:dialogSeq({t, "Spell #: "..player.registry["gfx__viewer"]..""}, 1)
	r_spellViewer2(player)
end

r_armorViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	player.gfxArmor = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Armor #: "..player.registry["gfx__viewer"]..""}, 1)
	r_armorViewer2(player)
end

r_armorViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxArmor = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Armor #: "..player.registry["gfx__viewer"]..""}, 1)
	r_armorViewer3(player)
end

r_armorViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxArmor = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Armor #: "..player.registry["gfx__viewer"]..""}, 1)
	r_armorViewer2(player)
end

r_weaponViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	player.gfxWeap = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Weapon #: "..player.registry["gfx__viewer"]..""}, 1)
	r_weaponViewer2(player)
end

r_weaponViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxWeap = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Weapon #: "..player.registry["gfx__viewer"]..""}, 1)
	r_weaponViewer3(player)
end

r_weaponViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxWeap = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Weapon #: "..player.registry["gfx__viewer"]..""}, 1)
	r_weaponViewer2(player)
end

r_helmViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	player.gfxHelm = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Helm #: "..player.registry["gfx__viewer"]..""}, 1)
	r_helmViewer2(player)
end

r_helmViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxHelm = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Helm #: "..player.registry["gfx__viewer"]..""}, 1)
	r_helmViewer3(player)
end

r_helmViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxHelm = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Helm #: "..player.registry["gfx__viewer"]..""}, 1)
	r_helmViewer2(player)
end

r_shieldViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	player.gfxShield = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Shield #: "..player.registry["gfx__viewer"]..""}, 1)
	r_shieldViewer2(player)
end

r_shieldViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxShield = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Shield #: "..player.registry["gfx__viewer"]..""}, 1)
	r_shieldViewer3(player)
end

r_shieldViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxShield = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Shield #: "..player.registry["gfx__viewer"]..""}, 1)
	r_shieldViewer2(player)
end

r_capeViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	player.gfxCape = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Cape #: "..player.registry["gfx__viewer"]..""}, 1)
	r_capeViewer2(player)
end

r_capeViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxCape = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Cape #: "..player.registry["gfx__viewer"]..""}, 1)
	r_capeViewer3(player)
end

r_capeViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxCape = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Cape #: "..player.registry["gfx__viewer"]..""}, 1)
	r_capeViewer2(player)
end

r_crownViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	player.gfxCrown = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Crown #: "..player.registry["gfx__viewer"]..""}, 1)
	r_crownViewer2(player)
end

r_crownViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxCrown = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Crown #: "..player.registry["gfx__viewer"]..""}, 1)
	r_crownViewer3(player)
end

r_crownViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.gfxCrown = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "Crown #: "..player.registry["gfx__viewer"]..""}, 1)
	r_crownViewer2(player)
end

r_npcmonViewer = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	player.disguise = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "NPC/Monster #: "..player.registry["gfx__viewer"]..""}, 1)
	r_npcmonViewer2(player)
end

r_npcmonViewer2 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.disguise = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "NPC/Monster #: "..player.registry["gfx__viewer"]..""}, 1)
	r_npcmonViewer3(player)
end

r_npcmonViewer3 = function(player)
	local t={graphic=convertGraphic(51,"monster"),color=20}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.registry["gfx__viewer"] = player.registry["gfx__viewer"] + 1
	player.disguise = player.registry["gfx__viewer"]
	player:refresh()
	player:dialogSeq({t, "NPC/Monster #: "..player.registry["gfx__viewer"]..""}, 1)
	r_npcmonViewer2(player)
end