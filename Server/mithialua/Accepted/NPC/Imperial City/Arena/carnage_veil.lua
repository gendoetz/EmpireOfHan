carnage_veil = {
cast = function(player)
	local aether = 0--2000
	local duration = 7500000
	
	player:flushDuration()
	
	if (player:hasDuration("carnage_veil")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
		
		player:setDuration("carnage_veil", duration)
		player:sendAnimation(103, 0)
		player:sendAction(6, 20)

		player:calcStat()
		player:refresh()

		player:sendMinitext("Participant status.")
end,

while_cast = function(player)
	if (player.m == 7050 or player.m == 7051 or player.m == 7100 or player.m == 7101 or player.m == 7102 or player.m == 400 or player.m == 7010 or player.m == 7011) then
		--player:setDuration("carnage_veil", 0)
	else
		player:setDuration("carnage_veil", 0)
	end
end,

recast = function(player)
		player.gfxClone = 1

		player.gfxFace = player.face
		player.gfxFaceC = player.faceColor
		player.gfxHair = player.hair
		player.gfxHairC = player.hairColor
		player.gfxSkinC = player.skinColor
		player.gfxDye = player.armorColor
		player.gfxWeap = -1
		player.gfxWeapC = 0
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

	if (player.sex == 0) then
		if (player.baseClass == 1) then
		player.gfxArmor = 12
		elseif (player.baseClass == 2) then
		player.gfxArmor = 4
		elseif (player.baseClass == 3) then
		player.gfxArmor = 10
		elseif (player.baseClass == 4) then
		player.gfxArmor = 20
		elseif (player.baseClass == 0) then
		player.gfxArmor = 10
		end
	else
		if (player.baseClass == 1) then
		player.gfxArmor = 13
		elseif (player.baseClass == 2) then
		player.gfxArmor = 8
		elseif (player.baseClass == 3) then
		player.gfxArmor = 11
		elseif (player.baseClass == 4) then
		player.gfxArmor = 18
		elseif (player.baseClass == 0) then
		player.gfxArmor = 11
		end
	end
			
				local item

				if (player:getEquippedItem(EQ_WEAP) ~= nil) then
					item = player:getEquippedItem(EQ_WEAP)
						player.gfxWeap = item.look
						player.gfxWeapC = item.lookC
				else
						player.gfxWeap = 65535
				end
				
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

				player.gfxDye = player.armorColor

			--player:refresh()
end,

--while_cast = function(player)
--	player:refresh()
--end,

uncast = function(player)
	player.gfxClone = 0
	player:refresh()
end,

requirements = function(player)
	local level = 20
	local items = {}
	local itemAmounts = {}
	local description = {""}
	return level, items, itemAmounts, description
end
}

carnage_resil = {
cast = function(player)
	local aether = 0--2000
	local duration = 7500000
	
	
	if (player:hasDuration("carnage_resil")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
		
		player:setDuration("carnage_resil", duration)
		player:sendAnimation(103, 0)
		player:sendAction(6, 20)

		player:calcStat()
		player:refresh()

		player:sendMinitext("Participant status.")
end,

while_cast = function(player)
	if (player.m == 7050 or player.m == 7100 or player.m == 7101 or player.m == 7102 or player.m == 400) then
		--player:setDuration("carnage_veil", 0)
	else
		player:setDuration("carnage_resil", 0)
	end
end,

requirements = function(player)
	local level = 20
	local items = {}
	local itemAmounts = {}
	local description = {""}
	return level, items, itemAmounts, description
end
}