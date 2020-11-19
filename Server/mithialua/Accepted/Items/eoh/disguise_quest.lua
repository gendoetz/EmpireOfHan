disguise_pack = {
use = function(player)

local package = {graphic = convertGraphic(3058, "item"), color = 0}
player.dialogType = 0
player.npcGraphic=package.graphic
player.npcColor=package.color

	if (player.m == 174) then
		local randomhair = math.random(1,3)
		local randomhaircolor = math.random(11,14)
		local randomdresscolor = math.random(3, 7)
		player.registry["quest_var2"] = randomhaircolor
		player.registry["quest_var3"] = randomdresscolor
		if (randomhair == 1) then
			player.registry["quest_var1"] = 54
		elseif (randomhair == 2) then
			player.registry["quest_var1"] = 53
		elseif (randomhair == 3) then
			player.registry["quest_var1"] = 67
		end
		disguise_quest.cast(player)
	else
		player:dialogSeq({package, "You cannot use the disguise here, you must be in the storehouse."}, 1)
	end
end
}

disguise_quest = {
cast = function(player)
	local aether = 0
	local duration = 1800000
	local casttime = os.time()
	
	if (player:hasDuration("disguise_quest")) then
		player:sendMinitext("You are already wearing the disguise.")
		return
	end
		
		player:setDuration("disguise_quest", duration)
		player:sendAnimation(103, 0)
		player:sendAction(6, 20)

		player:playSound(40)
		player.gfxClone = 1

		player.gfxFace = player.face
		player.gfxFaceC = player.faceColor
		player.gfxHair = player.registry["quest_var1"]
		player.gfxHairC = player.registry["quest_var2"]
		player.gfxSkinC = player.skinColor
		--player.gfxDye = player.armorColor
		player.gfxWeap = -1
		player.gfxWeapC = 0
		player.gfxArmor = 76
		player.gfxArmorC = player.registry["quest_var3"]
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
		player.gfxName = ""

		local item

				if (player:getEquippedItem(EQ_WEAP) ~= nil) then
					item = player:getEquippedItem(EQ_WEAP)
						player.gfxWeap = item.look
						player.gfxWeapC = item.lookC
				else
						player.gfxWeap = -1
						player.gfxWeapC = 0
				end

					player.gfxArmor = 76
					player.gfxArmorC = player.registry["quest_var3"]
				
				if (player:getEquippedItem(EQ_SHIELD) ~= nil) then
					item = player:getEquippedItem(EQ_SHIELD)
					player.gfxShield = item.look
					player.gfxShieldC = item.lookC
				else
					player.gfxShield = 65535
				end
				
				if (player:getEquippedItem(EQ_FACEACC) ~= nil) then
					item = player:getEquippedItem(EQ_FACEACC)
					player.gfxFaceA = item.look
					player.gfxFaceAC = item.lookC
				else
					player.gfxFaceA = 65535
				end
				
				player.gfxFaceAT = 65535
				
				if (player:getEquippedItem(EQ_CROWN) ~= nil) then
					item = player:getEquippedItem(EQ_CROWN)
					player.gfxCrown = item.look
					player.gfxCrownC = item.lookC
				else
					player.gfxCrown = 65535
				end
				
				if (player:getEquippedItem(EQ_MANTLE) ~= nil) then
					item = player:getEquippedItem(EQ_MANTLE)
					player.gfxCape = item.look
					player.gfxCapeC = item.lookC
				else
					player.gfxCape = 65535
				end
				
				if (player:getEquippedItem(EQ_NECKLACE) ~= nil) then
					item = player:getEquippedItem(EQ_NECKLACE)
					player.gfxNeck = item.look
					player.gfxNeckC = item.lookC
				else
					player.gfxNeck = 65535
				end
				
				if (player:getEquippedItem(EQ_BOOTS) ~= nil) then
					item = player:getEquippedItem(EQ_BOOTS)
					player.gfxBoots = item.look
					player.gfxBootsC = item.lookC
				else
					player.gfxBoots = player.sex
				end

				--if (player:getEquippedItem(EQ_COAT) == nil) then
				--	player.gfxDye = player.armorColor
				--end
		
		--player:sendMinitext("You were hit by a beauty bomb.")
		player:refresh()
		player:calcStat()
end,

while_cast = function(block)
	if (block.m == 174 or block.m == 175) then

	else
		block:setDuration("disguise_quest", 0)
	end
end,

recast = function(block)

		block.gfxFace = block.face
		block.gfxFaceC = block.faceColor
		block.gfxHair = block.registry["quest_var1"]
		block.gfxHairC = block.registry["quest_var2"]
		block.gfxSkinC = block.skinColor
		--block.gfxDye = block.armorColor
		block.gfxWeap = -1
		block.gfxWeapC = 0
		--block.gfxArmor = 0
		--block.gfxArmorC = 0
		block.gfxShield = -1
		block.gfxShieldC = 0
		block.gfxHelm = -1
		block.gfxHelmC = 0
		block.gfxCape = -1
		block.gfxCapeC = 0
		block.gfxCrown = -1
		block.gfxCrownC = 0
		block.gfxFaceA = -1
		block.gfxFaceAC = 0
		block.gfxFaceAT = -1
		block.gfxFaceATC = 0
		block.gfxNeck = -1
		block.gfxNeckC = 0
		block.gfxBoots = block.sex
		block.gfxBootsC = 0
		block.gfxName = ""
			
				local item

				if (block:getEquippedItem(EQ_WEAP) ~= nil) then
					item = block:getEquippedItem(EQ_WEAP)
						block.gfxWeap = item.look
						block.gfxWeapC = item.lookC
				else
						block.gfxWeap = -1
						block.gfxWeapC = 0
				end

					block.gfxArmor = 76
					block.gfxArmorC = player.registry["quest_var3"]
				
				if (block:getEquippedItem(EQ_SHIELD) ~= nil) then
					item = block:getEquippedItem(EQ_SHIELD)
					block.gfxShield = item.look
					block.gfxShieldC = item.lookC
				else
					block.gfxShield = 65535
				end
				
				if (block:getEquippedItem(EQ_FACEACC) ~= nil) then
					item = block:getEquippedItem(EQ_FACEACC)
					block.gfxFaceA = item.look
					block.gfxFaceAC = item.lookC
				else
					block.gfxFaceA = 65535
				end
				
				block.gfxFaceAT = 65535
				
				if (block:getEquippedItem(EQ_CROWN) ~= nil) then
					item = block:getEquippedItem(EQ_CROWN)
					block.gfxCrown = item.look
					block.gfxCrownC = item.lookC
				else
					block.gfxCrown = 65535
				end
				
				if (block:getEquippedItem(EQ_MANTLE) ~= nil) then
					item = block:getEquippedItem(EQ_MANTLE)
					block.gfxCape = item.look
					block.gfxCapeC = item.lookC
				else
					block.gfxCape = 65535
				end
				
				if (block:getEquippedItem(EQ_NECKLACE) ~= nil) then
					item = block:getEquippedItem(EQ_NECKLACE)
					block.gfxNeck = item.look
					block.gfxNeckC = item.lookC
				else
					block.gfxNeck = 65535
				end
				
				if (block:getEquippedItem(EQ_BOOTS) ~= nil) then
					item = block:getEquippedItem(EQ_BOOTS)
					block.gfxBoots = item.look
					block.gfxBootsC = item.lookC
				else
					block.gfxBoots = block.sex
				end

				--if (block:getEquippedItem(EQ_COAT) == nil) then
				--	block.gfxDye = block.armorColor
				--end
				block.gfxClone = 1
end,

uncast = function(block)
	block.gfxClone = 0
	block:refresh()
end,

requirements = function(player)
	local level = 20
	local items = {}
	local itemAmounts = {}
	local description = {"Illusion."}
	return level, items, itemAmounts, description
end
}