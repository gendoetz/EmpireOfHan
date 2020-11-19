equip_illusion = {
cast = function(player, target)
	local aether = 0
	local duration = 1800000
	local casttime = os.time()
	
	if (target:hasDuration("equip_illusion")) then
		player:sendMinitext("Has duration of this.")
		return
	end

		if(target.blType==BL_MOB) then
			player:sendMinitext("Cannot use this spell on monsters.")
			return
		end
		
		target:setDuration("equip_illusion", duration)
		target:sendAnimation(51, 0)
		player:sendAction(6, 20)

		player:playSound(29)
		target.gfxClone = 1

		target.gfxFace = 221
		target.gfxFaceC = target.faceColor
		target.gfxHair = 91
		target.gfxHairC = 18
		target.gfxSkinC = target.skinColor
		--target.gfxDye = target.armorColor
		target.gfxWeap = -1
		target.gfxWeapC = 0
		target.gfxArmor = 0
		target.gfxArmorC = 0
		target.gfxShield = -1
		target.gfxShieldC = 0
		target.gfxHelm = -1
		target.gfxHelmC = 0
		target.gfxCape = -1
		target.gfxCapeC = 0
		target.gfxCrown = -1
		target.gfxCrownC = 0
		target.gfxFaceA = -1
		target.gfxFaceAC = 0
		target.gfxFaceAT = -1
		target.gfxFaceATC = 0
		target.gfxNeck = -1
		target.gfxNeckC = 0
		target.gfxBoots = target.sex
		target.gfxBootsC = 0
		target.gfxName = ""

		local item

				if (target:getEquippedItem(EQ_WEAP) ~= nil) then
					item = target:getEquippedItem(EQ_WEAP)
						target.gfxWeap = item.look
						target.gfxWeapC = item.lookC
				else
						target.gfxWeap = 65535
				end

				if (target:getEquippedItem(EQ_ARMOR) ~= nil) then
					item = target:getEquippedItem(EQ_ARMOR)
					target.gfxArmor = 10324
					target.gfxArmorC = 0
					--target:talk(0,"Item Value: "..item.allowDye)
					if(item.allowDye == 1 and target:getEquippedItem(EQ_COAT) == nil) then
						target.gfxDye = 0
					else
						target.gfxDye = 0
					end
				else
					target.gfxArmor = 10324
				end

				if (target:getEquippedItem(EQ_COAT) ~= nil) then
					item = target:getEquippedItem(EQ_COAT)
					target.gfxArmor = 10324
					target.gfxArmorC = 0

					if(item.allowDye == 1) then
						target.gfxDye = 0
					else
						target.gfxDye = 0
					end
				end
				
				if (target:getEquippedItem(EQ_SHIELD) ~= nil) then
					item = target:getEquippedItem(EQ_SHIELD)
					target.gfxShield = item.look
					target.gfxShieldC = item.lookC
				else
					target.gfxShield = 65535
				end
				
				if (target:getEquippedItem(EQ_FACEACC) ~= nil) then
					item = target:getEquippedItem(EQ_FACEACC)
					target.gfxFaceA = item.look
					target.gfxFaceAC = item.lookC
				else
					target.gfxFaceA = 65535
				end
				
				target.gfxFaceAT = 65535
				
				if (target:getEquippedItem(EQ_CROWN) ~= nil) then
					item = target:getEquippedItem(EQ_CROWN)
					target.gfxCrown = item.look
					target.gfxCrownC = item.lookC
				else
					target.gfxCrown = 65535
				end
				
				if (target:getEquippedItem(EQ_MANTLE) ~= nil) then
					item = target:getEquippedItem(EQ_MANTLE)
					target.gfxCape = item.look
					target.gfxCapeC = item.lookC
				else
					target.gfxCape = 65535
				end
				
				if (target:getEquippedItem(EQ_NECKLACE) ~= nil) then
					item = target:getEquippedItem(EQ_NECKLACE)
					target.gfxNeck = item.look
					target.gfxNeckC = item.lookC
				else
					target.gfxNeck = 65535
				end
				
				if (target:getEquippedItem(EQ_BOOTS) ~= nil) then
					item = target:getEquippedItem(EQ_BOOTS)
					target.gfxBoots = item.look
					target.gfxBootsC = item.lookC
				else
					target.gfxBoots = target.sex
				end

				--if (target:getEquippedItem(EQ_COAT) == nil) then
				--	target.gfxDye = target.armorColor
				--end
		
		--target:sendMinitext("You were hit by a beauty bomb.")
		target:refresh()
		target:calcStat()
end,

recast = function(block)

		block.gfxFace = 221
		block.gfxFaceC = block.faceColor
		block.gfxHair = 91
		block.gfxHairC = 18
		block.gfxSkinC = block.skinColor
		--block.gfxDye = block.armorColor
		block.gfxWeap = -1
		block.gfxWeapC = 0
		block.gfxArmor = 0
		block.gfxArmorC = 0
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
						block.gfxWeap = 65535
				end

				if (block:getEquippedItem(EQ_ARMOR) ~= nil) then
					item = block:getEquippedItem(EQ_ARMOR)
					block.gfxArmor = 10324
					block.gfxArmorC = 0

					if(item.allowDye == 1 and block:getEquippedItem(EQ_COAT) == nil) then
						block.gfxDye = 0
					else
						block.gfxDye = 0
					end
				else
					block.gfxArmor = 10324
				end

				if (block:getEquippedItem(EQ_COAT) ~= nil) then
					item = block:getEquippedItem(EQ_COAT)
					block.gfxArmor = 10324
					block.gfxArmorC = 0

					if(item.allowDye == 1) then
						block.gfxDye = 0
					else
						block.gfxDye = 0
					end
				end
				
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