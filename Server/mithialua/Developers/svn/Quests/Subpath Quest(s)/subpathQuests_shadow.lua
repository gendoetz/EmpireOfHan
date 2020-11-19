subpathQuests_shadow = {
click = function(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic=t.graphic
		player.npcColor=t.color
		player.dialogType = 0

	local sG_CoatM = {graphic = convertGraphic(2719, "item"), color = 18}
	local sG_CoatF = {graphic = convertGraphic(2720, "item"), color = 18}
	local sG_Weapon = {graphic = convertGraphic(4166, "item"), color = 20}

	local subCoat = player.quest["subitem_Coat"]
	local subWeapon = player.quest["subitem_Weapon"]

	local className = "Shadow"

	local subCM_Name = "Shadow-weave Vest"
	local subCM_NameY = "subcoat_shadowM"
	local subCF_Name = "Shadow-weave Skirt"
	local subCF_NameY = "subcoat_shadowF"
	local subW_Name = "Requiem"
	local subW_NameY = "shadow_99w"

	-- Sacrifices
		-- Coat
		local subC_Exp = 50000000
		local subC_Gold = 50000
		-- Weapon
		local subW_ItemA = "Bloodseeker"
		local subW_ItemAy = "rogue_95w"
		local subW_Exp = 200000000
		local subW_Stat = 5
		local subW_Gold = 100000

		-- Replacement Armor
		local subC2_Exp = 200000
		local subC2_Stat = 5
		local subC2_Gold = 100000
		-- Replacement Weapon
		local subW2_Exp = 100000
		local subW2_Stat = 5
		local subW2_Gold = 50000

	local equipOpts = {}
		if (subWeapon == 5) then
			--table.insert(equipOpts, "- Replacement Weapon")
		else
			table.insert(equipOpts, "Weapon")
		end
		if (subCoat == 3) then
			--table.insert(equipOpts, "- Replacement Coat")
		else
			table.insert(equipOpts, "Coat")
		end

	local sI_Menu = player:menuString2("Which would you like to attempt forging?", equipOpts)
		if (sI_Menu == "Coat") then
			if (subCoat == 0) then
				player:dialogSeq({t,"So, you seek to have a garment of your own? One that shows you to be a devote follower of the "..className.."'s?",
					t, "With great admiration, comes great responsibility.\n\nYou have to sacrifice if you seek to gain..",
					t, "First, you will need to sacrifice something you have worked hard to gain; hard earned experience."}, 1)
					player.quest["subitem_Coat"] = player.quest["subitem_Coat"] + 1
				player:dialogSeq({t, "Return to me when you have at least; 50,000,000 experience to spare."}, 0)
			elseif (subCoat == 1) then
				if (player.exp >= subC_Exp) then
					player.exp = player.exp - subC_Exp
					player:calcStat()
					player:refresh()
					player.quest["subitem_Coat"] = player.quest["subitem_Coat"] + 1
					player:dialogSeq({t, "Now we will need a small fee to offer the elders. They're the ones binding the garment after all; 50,000 coins should be enough."}, 0)
				else
					player:dialogSeq({t, "You seem to be missing some experience; go out into the world and aquire more.\n\n((You are missing "..(subC_Exp-player.exp).." experience.))"}, 0)
				end
			elseif (subCoat == 2) then
				if (player.money >= 50000) then
					if (player.sex == 0) then
						player:removeGold(50000)
						player:refresh()
						player.quest["subitem_Coat"] = player.quest["subitem_Coat"] + 1
						player:dialogSeq({t, "Alright, just give me one moment..",
							sG_CoatM, "Tada! Here it is, your new shiny "..subCM_Name..".\n\nBe sure to take good care of it. If you need a replacement in the future, you can always return to get one.."}, 1)
						player:addItem(subCM_NameY, 1, 0, player.id) --adds item to player, owner and engrave optional
						player:dialogSeq({t, "However it will still require a cost.\n\n*The walker smiles and ushers you to try on the new clothes.*"}, 0)
					elseif (player.sex == 1) then	
						player:removeGold(50000)
						player:refresh()
						player.quest["subitem_Coat"] = player.quest["subitem_Coat"] + 1
						player:dialogSeq({t, "Alright, just give me one moment..",
							sG_CoatF, "Tada! Here it is, your new shiny "..subCF_Name..".\n\nBe sure to take good care of it. If you need a replacement in the future, you can always return to get one.."}, 1)
						player:addItem(subCF_NameY, 1, 0, player.id) --adds item to player, owner and engrave optional
						player:dialogSeq({t, "However it will still require a cost.\n\n*The walker smiles and ushers you to try on the new clothes.*"}, 0)
					end
				else
					player:dialogSeq({t, "You do not seem to have enough coins to proceed, please aquire more before visiting me again."}, 0)
				end

			end
		elseif (sI_Menu == "Weapon") then
			if (subWeapon == 0) then
				player:dialogSeq({sG_Weapon,"So, you seek to have a weapon of your own? One that shows you to be a devote follower of the "..className.."'s?",
					t, "With great admiration, comes great responsibility.\n\nYou have to sacrifice if you seek to gain..",
					t, "First, you will need to sacrifice something you have worked hard to gain; experience."}, 1)
					player.quest["subitem_Weapon"] = player.quest["subitem_Weapon"] + 1
				player:dialogSeq({t, "Return to me when you have at least; 200,000,000 experience to spare."}, 0)
			elseif (subWeapon == 1) then
				if (player.exp >= subW_Exp) then
					player.exp = player.exp - subW_Exp
					player:calcStat()
					player:refresh()
					player.quest["subitem_Weapon"] = player.quest["subitem_Weapon"] + 1
					player:dialogSeq({t, "Wonderful, the next thing you shall be required to sacrifice is some of your strength. Not too much, but enough to enchant the weapon.",
					t, "Return to me when you have at least; ("..subW_Stat..") Might, Grace and Will to offer.\n\n((Combined; 15 stats in total.))"}, 0)
				else
					player:dialogSeq({t, "You seem to be missing some experience; go out into the world and aquire more.\n\n((You are missing "..(subW_Exp-player.exp).." experience.))"}, 0)
				end
			elseif (subWeapon == 2) then
				if (player.basemight >= 10) then
					if (player.basegrace >= 10) then
						if (player.basewill >= 10) then
							player.basemight = player.basemight - 5
							player.basegrace = player.basegrace - 5
							player.basewill = player.basewill - 5
							player.quest["subitem_Weapon"] = player.quest["subitem_Weapon"] + 1
							player:dialogSeq({t, "As you expect, the experience and statistics are what make your weapon great. They shall do wonders to it..",
								t, "Now we will need a small fee to offer the elders. They're the ones binding everything together after all; 100,000 coins should be enough."}, 0)
						else
							player:dialogSeq({t, "You do not seem to have enough will to proceed, please aquire more before visiting me again."}, 0)
						end
					else
						player:dialogSeq({t, "You do not seem to have enough grace to proceed, please aquire more before visiting me again."}, 0)
					end
				else
					player:dialogSeq({t, "You do not seem to have enough might to proceed, please aquire more before visiting me again."}, 0)
				end
			elseif (subWeapon == 3) then
				if (player.money >= 100000) then
					player:removeGold(100000)
					player:calcStat()
					player:refresh()
					player.quest["subitem_Weapon"] = player.quest["subitem_Weapon"] + 1
					player:dialogSeq({t, "Finally, all we require the strongest weapon you can weild currently.",
						t, "Do not worry, it shall be melded into the basic form of your new weapon so it is not leaving you completely.",
						t, "Letting old become new, bring me one of those "..subW_ItemA.."."}, 0)
				else
					player:dialogSeq({t, "You do not seem to have enough coins to proceed, please aquire more before visiting me again."}, 0)
				end
			elseif (subWeapon == 4) then
				if (player:hasItem(subW_ItemAy, 1, player.id) == true) then
					player:removeItem(subW_ItemAy, 1, 0, player.id)
					player.quest["subitem_Weapon"] = player.quest["subitem_Weapon"] + 1
					player:dialogSeq({t, "Alright, just give me one moment..",
						sG_Weapon, "Tada! Here it is, your new shiny "..subW_Name..".\n\nBe sure to take good care of it. If you need a replacement in the future, you can always return to get one.."}, 1)
					player:addItem(subW_NameY, 1, 0, player.id) --adds item to player, owner and engrave optional
					player:dialogSeq({t, "However it will still require a cost.\n\n*The walker smiles and ushers you to try on the new weapon.*"}, 0)
				elseif (player:hasItem(subW_ItemAy, 1) == true) then
					player:removeItem(subW_ItemAy, 1)
					player.quest["subitem_Weapon"] = player.quest["subitem_Weapon"] + 1
					player:dialogSeq({t, "Alright, just give me one moment..",
						sG_Weapon, "Tada! Here it is, your new shiny "..subW_Name..".\n\nBe sure to take good care of it. If you need a replacement in the future, you can always return to get one.."}, 1)
					player:addItem(subW_NameY, 1, 0, player.id) --adds item to player, owner and engrave optional
					player:dialogSeq({t, "However it will still require a cost.\n\n*The walker smiles and ushers you to try on the new weapon.*"}, 0)
				else
					player:dialogSeq({t, "I am still waiting on you to bring me your old "..subW_ItemA..", return to me when you have it in hand."}, 0)
				end
			end
		end
end,
}
