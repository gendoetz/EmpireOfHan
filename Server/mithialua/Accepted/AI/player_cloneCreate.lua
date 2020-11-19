
--player:spawn(300, player.x, player.y, 1) -- if this is not a code with player in the content, npc:spawn, block:spawn etc. ID of monster is 300 for bard player clone
--player_cloneCreate.setup(player) -- ( ) contains the target you want to make a clone of.

player_cloneCreate = {
setup = function(block, x, y)
	local D = block:getObjectsInCell(block.m, x, y, BL_MOB)
	Mob(D[1].ID).owner = block.id
	Mob(D[1].ID).target = block.id
	Mob(D[1].ID).summon = true
	Mob(D[1].ID).side = block.side
	Mob(D[1].ID):sendSide()

				if (block:getEquippedItem(EQ_WEAP) ~= nil) then
					item = block:getEquippedItem(EQ_WEAP)
					Mob(D[1].ID).gfxWeap = item.look
					Mob(D[1].ID).gfxWeapC = item.lookC
					Mob(D[1].ID).sound = item.sound
					Mob(D[1].ID).minDam = block.minDam
					Mob(D[1].ID).maxDam = block.maxDam
					Mob(D[1].ID).invis = block.rage
				else 
					Mob(D[1].ID).gfxWeap = 65535
				end
				
				if (block:getEquippedItem(EQ_ARMOR) ~= nil) then
					item = block:getEquippedItem(EQ_ARMOR)
					Mob(D[1].ID).gfxArmor = item.look
					Mob(D[1].ID).gfxArmorC = item.lookC

					if(item.allowDye == 1 and block:getEquippedItem(EQ_COAT) == nil) then
						Mob(D[1].ID).gfxDye = block.armorColor
					else
						Mob(D[1].ID).gfxDye = 0
					end
				else
					if (block.sex == 1) then
						Mob(D[1].ID).gfxArmor = 58
						Mob(D[1].ID).gfxArmorC = 29
					else
						Mob(D[1].ID).gfxArmor = 57
						Mob(D[1].ID).gfxArmorC = 29
					end

				end
				
				if (block:getEquippedItem(EQ_COAT) ~= nil) then
					item = block:getEquippedItem(EQ_COAT)
					Mob(D[1].ID).gfxArmor = item.look
					Mob(D[1].ID).gfxArmorC = item.lookC

					if(item.allowDye == 1) then
						Mob(D[1].ID).gfxDye = block.armorColor
					else
						Mob(D[1].ID).gfxDye = 0
					end
				end
				
				if (block:getEquippedItem(EQ_SHIELD) ~= nil) then
					item = block:getEquippedItem(EQ_SHIELD)
					Mob(D[1].ID).gfxShield = item.look
					Mob(D[1].ID).gfxShieldC = item.lookC
				else
					Mob(D[1].ID).gfxShield = 65535
				end

				
				if (block:getEquippedItem(EQ_HELM) ~= nil and (block.settings - (block.settings % 8192)) / 8192 == 1) then
					item = block:getEquippedItem(EQ_HELM)
					Mob(D[1].ID).gfxHelm = item.look
					Mob(D[1].ID).gfxHelmC = item.lookC
				else
					Mob(D[1].ID).gfxHelm = 255
				end
				
				if (block:getEquippedItem(EQ_FACEACC) ~= nil) then
					item = block:getEquippedItem(EQ_FACEACC)
					Mob(D[1].ID).gfxFaceA = item.look
					Mob(D[1].ID).gfxFaceAC = item.lookC
				else
					Mob(D[1].ID).gfxFaceA = 65535
				end
				
				Mob(D[1].ID).gfxFaceAT = 65535
				
				if (block:getEquippedItem(EQ_CROWN) ~= nil) then
					item = block:getEquippedItem(EQ_CROWN)
					Mob(D[1].ID).gfxCrown = item.look
					Mob(D[1].ID).gfxCrownC = item.lookC
				else
					Mob(D[1].ID).gfxCrown = 65535
				end
				
				if (block:getEquippedItem(EQ_MANTLE) ~= nil) then
					item = block:getEquippedItem(EQ_MANTLE)
					Mob(D[1].ID).gfxCape = item.look
					Mob(D[1].ID).gfxCapeC = item.lookC
				else
					Mob(D[1].ID).gfxCape = 65535
				end
				
				if (block:getEquippedItem(EQ_NECKLACE) ~= nil) then
					item = block:getEquippedItem(EQ_NECKLACE)
					Mob(D[1].ID).gfxNeck = item.look
					Mob(D[1].ID).gfxNeckC = item.lookC
				else
					Mob(D[1].ID).gfxNeck = 65535
				end
				
				if (block:getEquippedItem(EQ_BOOTS) ~= nil) then
					item = block:getEquippedItem(EQ_BOOTS)
					Mob(D[1].ID).gfxBoots = item.look
					Mob(D[1].ID).gfxBootsC = item.lookC
				else
					Mob(D[1].ID).gfxBoots = block.sex
				end
				
				Mob(D[1].ID).gfxFace = block.face
				Mob(D[1].ID).gfxHair = block.hair
				Mob(D[1].ID).gfxHairC = block.hairColor
				Mob(D[1].ID).gfxFaceC = block.faceColor
				Mob(D[1].ID).gfxSkinC = block.skinColor

				
				Mob(D[1].ID).gfxName = block.name
				Mob(D[1].ID).gfxClone = 1

				local blockPC = block:getObjectsInArea(BL_PC)
				if (#blockPC > 0) then
					for i = 1, #blockPC do
						blockPC[i]:refresh()
					end
				end
end,
}