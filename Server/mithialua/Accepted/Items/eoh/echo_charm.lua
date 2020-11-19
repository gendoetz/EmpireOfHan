echo_charm = {
use = async(function(player)
	local echo = {graphic = convertGraphic(980, "item"), color = 13}

	if(player.state==1) then
		player:sendMinitext("You cannot do that while dead.")
		return
	elseif (player.state == 3) then
		player:sendMinitext("Can't do that while riding.")
		return
	end

	if(player.region==100) then
		player:sendMinitext("You cannot do that while in jail.")
		return
	end

	if(player.region==5) then
		player:sendMinitext("You cannot do that while in an event.")
		return
	end

	if (player.registry["love_r_timer"] < os.time()) then
		player.registry["love_r_timer"] = os.time() + 5
	else
		local timeremaining = (math.floor(player.registry["love_r_timer"] - os.time()))
		local ftimeremaining = math.modf(timeremaining)
		player:sendMinitext("You must wait before using this item again. "..ftimeremaining.." seconds left.")
		return
	end


	local item = player:getInventoryItem(player.invSlot)
	local itemRealName = item.realName
	local findPlayerName = string.match(itemRealName, ": (.*)")

	local findPlayerID = getOfflineID(findPlayerName)
	local playerisOnline = Player(findPlayerID)


	

		if(playerisOnline == nil) then
			player:sendMinitext("They are not online.")
			return
		end

	

		if(playerisOnline ~= nil) then -- Check to see if player is 99 and they are trying to approach their mentor, if so break.
				if (player.level == 99 and playerisOnline.level == 99) then -- Always first check if either player is 99 and destroy
						player:sendMinitext("The echo fades from you.")
						player:removeItemSlot(player.invSlot, 1)
						return
				end

				if(playerisOnline.state == 1) then
					player:sendMinitext("You cannot do that while your friend is dead.")
					return
				end

				local npc = echo_charm.makefriendNPC(player)

				makefriendClone.setup(npc, playerisOnline)
				player.lastClick = npc.ID
				player.dialogType = 2

				local choice = player:menuString3(playerisOnline.name.."'s Level: "..playerisOnline.level.."\nLocation: "..playerisOnline.mapTitle.."\n\nWould you like to journey through the magic of the echo to your friends location?", {"Yes", "No", "", "Echo Enchantment", "", "", "Destroy Echo"})
				if (choice == "Yes") then
					findPlayerID = getOfflineID(findPlayerName)
					playerisOnline = Player(findPlayerID)
					if(playerisOnline == nil) then
						player:sendMinitext("They are not online.")
						return
					end
					if(playerisOnline ~= nil) then
						if(playerisOnline.region==100) then
							player:sendMinitext("You cannot do that while your friend is in jail.")
						return
						end

						if(playerisOnline.region == 5) then
							player:sendMinitext("Your friend is in an event at this time.")
							return
						end

						if (playerisOnline.mapRegistry["bondedRing_levelReq"] > 0 and playerisOnline.mapRegistry["bondedRing_levelReq"] > player.level) then
							player:sendMinitext("Your friend is in a place too dangerous for you.")
							return
						end

						--check vita/mana requirements
						if (playerisOnline.mapRegistry["bondedRing_levelReq"] > 0) then
							if (playerisOnline.mapRegistry["bondedRing_vitaReq"] > player.maxHealth and playerisOnline.mapRegistry["bondedRing_manaReq"] > player.maxMagic) then
								player:sendMinitext("Your friend is in a place too dangerous for you.")
								return
							end
						end

						if (playerisOnline.mapRegistry["bondedRing_levelReq"] == 0 and playerisOnline.mapRegistry["bondedRing_vitaReq"] == 0 and playerisOnline.mapRegistry["bondedRing_manaReq"] == 0) then
							player:sendMinitext("Your friend is in a place the magic of this charm cannot reach.")
							return
						end

						--if (math.abs(player.level - playerisOnline.level) > 10) then
						--	player:sendMinitext("Your friend's level differs from yours too greatly...")
						--	return
						--end

						if(player.region ~= 5 or playerisOnline.region ~= 5) then
							--if (player.registry["love_r_timer"] < os.time()) then
								--player.registry["love_r_timer"] = os.time() + 5

								-- New Ambush code
								local rand_dir = math.random(0, 3)

								if (rand_dir == 0) then
								local passCheck = getPass(playerisOnline.m, playerisOnline.x+1, playerisOnline.y)
								local mobCheck = player:getObjectsInCell(playerisOnline.m, playerisOnline.x+1, playerisOnline.y, BL_MOB)
								local playerCheck = player:getObjectsInCell(playerisOnline.m, playerisOnline.x+1, playerisOnline.y, BL_PC)

									if (passCheck == 0 and #mobCheck == 0 and #playerCheck == 0) then
										if ((playerisOnline.x+1) > playerisOnline.xmax) then
											player:sendMinitext("This will not work now.")
											return
										end
										player:warp(playerisOnline.m, playerisOnline.x+1, playerisOnline.y)
									else
										player:sendMinitext("This area is too crowded.")
										return
									end
									
								elseif (rand_dir == 1) then
								local passCheck = getPass(playerisOnline.m, playerisOnline.x, playerisOnline.y+1)
								local mobCheck = player:getObjectsInCell(playerisOnline.m, playerisOnline.x, playerisOnline.y+1, BL_MOB)
								local playerCheck = player:getObjectsInCell(playerisOnline.m, playerisOnline.x, playerisOnline.y+1, BL_PC)

									if (passCheck == 0 and #mobCheck == 0 and #playerCheck == 0) then
										if ((playerisOnline.y+1) > playerisOnline.ymax) then
											player:sendMinitext("This will not work now.")
											return
										end
										player:warp(playerisOnline.m, playerisOnline.x, playerisOnline.y+1)
									else
										player:sendMinitext("This area is too crowded.")
										return
									end
								elseif (rand_dir == 2) then
								local passCheck = getPass(playerisOnline.m, playerisOnline.x-1, playerisOnline.y)
								local mobCheck = player:getObjectsInCell(playerisOnline.m, playerisOnline.x-1, playerisOnline.y, BL_MOB)
								local playerCheck = player:getObjectsInCell(playerisOnline.m, playerisOnline.x-1, playerisOnline.y, BL_PC)

									if (passCheck == 0 and #mobCheck == 0 and #playerCheck == 0) then
										if ((playerisOnline.x-1) < 0) then
											player:sendMinitext("This will not work now.")
											return
										end
										player:warp(playerisOnline.m, playerisOnline.x-1, playerisOnline.y)
									else
										player:sendMinitext("This area is too crowded.")
										return
									end
								elseif (rand_dir == 3) then
								local passCheck = getPass(playerisOnline.m, playerisOnline.x, playerisOnline.y-1)
								local mobCheck = player:getObjectsInCell(playerisOnline.m, playerisOnline.x, playerisOnline.y-1, BL_MOB)
								local playerCheck = player:getObjectsInCell(playerisOnline.m, playerisOnline.x, playerisOnline.y-1, BL_PC)

									if (passCheck == 0 and #mobCheck == 0 and #playerCheck == 0) then
										if ((playerisOnline.y-1) < 0) then
											player:sendMinitext("This will not work now.")
											return
										end
										player:warp(playerisOnline.m, playerisOnline.x, playerisOnline.y-1)
									else
										player:sendMinitext("This area is too crowded.")
										return
									end
								end
								
								--canAmbush(player, playerisOnline)
								--player:sendMinitext("Test.")
							--else
							--	local timeremaining = (math.floor(player.registry["love_r_timer"] - os.time()))
							--	local ftimeremaining = math.modf(timeremaining)
							--	player:sendMinitext("You must wait before using this item again. "..ftimeremaining.." seconds left.")
							--end
						else
							player:sendMinitext("This will not work now.")
						end
					end
				elseif (choice == "No") then

				elseif (choice == "Echo Enchantment") then
					player:dialogSeq({echo, "The power of the Echo allows you to enchant your friend with a minor boost in Might, Grace, Will, and a heal over time."}, 1)
					findPlayerID = getOfflineID(findPlayerName)
					playerisOnline = Player(findPlayerID)
					if(playerisOnline == nil) then
						player:sendMinitext("They are not online.")
						return
					end
					if(playerisOnline ~= nil) then
						if (playerisOnline:hasDuration("echo_enchantment")) then
							player:dialogSeq({echo, "Your friend is currently empowered with this enchantment."}, 0)
							return
						end

						if (playerisOnline.level == 99) then
							player:sendMinitext("The player is too powerful for the echo to work..")
							return
						end

						if (distance(player, playerisOnline) <= 5) then
						
						player:sendAction(6, 20)
						player:sendMinitext("You grant the Echo Enchantment.")
						playerisOnline:setDuration("echo_enchantment", 1800000)
						playerisOnline:playSound(77)
						playerisOnline:sendAnimation(106, 0)
						playerisOnline:sendMinitext(player.name.." grants you the power of the Echo.")

						playerisOnline:calcStat()
						else
							player:dialogSeq({echo, "Your friend is too far at the moment..."}, 0)
							return
						end
					end
				elseif (choice == "Destroy Echo") then
					player.npcGraphic=echo.graphic
					player.npcColor=echo.color
					player.dialogType = 0
					local destroy = player:menuString3("Are you absolutely certain you wish to destroy this echo? You may never obtain one for your friend again...", {"Yes", "No"})
					--player:dialogSeq({echo,"I can assist you if you would like to alter your facial features. It will cost you 2,000 coins."},1)
					if (destroy == "Yes") then
						player:removeItemSlot(player.invSlot, 1)
						player:sendMinitext("The echo fades from you.")
						return
					elseif (destroy == "No") then
						player:dialogSeq({echo,"Understood."},1)
					end
				end
		end
end),

makefriendNPC = function(friend)
	local npcsInBlock = {}
	
	friend:addNPC("makefriendClone", friend.m, friend.x, friend.y, 0, 2000)
	npcsInBlock = friend:getObjectsInCell(friend.m, friend.x, friend.y, BL_NPC)
	
	if (#npcsInBlock > 0) then
		for i = 1, #npcsInBlock do
			if (npcsInBlock[i].yname == "makefriendClone") then
				npcsInBlock[i].state = 0
				return npcsInBlock[i]
			end
		end
	end
end
}

makefriendClone = {
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
		--target:talk(0,"Item Value: "..item.allowDye)
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
		target.gfxArmor = target.sex
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
	--npc.gfxName = ""
end,

endAction = function(npc)
	npc:delete()
end
}

echo_enchantment = {
recast = function(block)
	block.might = block.might + 5
	block.will = block.will + 5
	block.grace = block.grace + 5
end,

while_cast = function(block, caster)
		if(block.state==1 or block.health==0) then
			if (block:hasDuration("echo_enchantment")) then
				block:setDuration("echo_enchantment", 0)
			end
			return
		end
		block:addHealth2(50)
end,

uncast = function(block)
	block:calcStat()
end,
}