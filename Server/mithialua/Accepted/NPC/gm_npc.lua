gm_npc = {
f1click = function(player,npc)
	local optsgm = {}
	local gfx = {graphic = convertGraphic(654,"monster"),color=15}
	local menuOption
	local opts = {}
	local spellopts = {}

	
	player.npcGraphic = gfx.graphic
	player.npcColor = gfx.color
	player.dialogType = 0

	if(player.gmLevel == 99 and player.id == 2) then
		table.insert(optsgm, "Alter Stats")
		table.insert(optsgm, "Change Path")
		table.insert(optsgm, "Gold")
		table.insert(optsgm, "What time?")
		table.insert(optsgm, "Elixir Part")
		--table.insert(optsgm, "Spell Options")
		--table.insert(optsgm, "Grant GM Spell Permission")
		--table.insert(spellopts, "Grant GM Spell Permission")
		--table.insert(spellopts, "Remove All Spells")
		--table.insert(optsgm, "Remove GM Spell Permission")
		--table.insert(optsgm, "Remove All Spells")
		table.insert(optsgm, "Summon GM Viewer NPC")
		table.insert(optsgm, "Set Faith")
		table.insert(optsgm, "Legend Mark")
		table.insert(optsgm, "Make a person GM")
		table.insert(optsgm, "Immortals Clan")
		table.insert(optsgm, "No Clan")
		table.insert(optsgm, "Repair Item")
	end
	--if(player.gmLevel == 90) then
	--	table.insert(optsgm, "Edit Stats")
	--end
	if(player.gmLevel == 91 or player.id == 3) then
		table.insert(optsgm, "Alter Stats")
		table.insert(optsgm, "Gold")
		--table.insert(optsgm, "Repair Item")
		table.insert(optsgm, "Change Path")
		table.insert(optsgm, "Summon GM Viewer NPC")
	end

	if(player.id == 6 or player.id == 756) then
		table.insert(optsgm, "Alter Stats")
		table.insert(optsgm, "Change Path")
		table.insert(optsgm, "Archon")
	end

	
	if (player.gmLevel >= 1) then
		dialog="Welcome "..player.name..", how may I be of service?"
		table.insert(optsgm, "Character Info")
		table.insert(optsgm, "Where am I?")
		table.insert(optsgm, "Obtain Char ID")
		--table.insert(optsgm, "Clear gfxToggle")
		--table.insert(optsgm, "Summon GM Viewer NPC")
		table.insert(optsgm, "View Legend Icons")
		table.insert(optsgm, "Remove Legend Icons")
		--table.insert(optsgm, "[Lv1] GM Spells")
			--if (player.registry["gm_spell_lv"] >= 1) then
			--	table.insert(optsgm, "[Lv1] GM Spells")
			--end
			--if (player.registry["gm_spell_lv"] >= 2) then
			--	table.insert(optsgm, "[Lv2] GM Spells")
			--end
	else

		dialog="Hacker."
		if (player:checkOnline('august') == 1) then
			player:msg(8, player.name.." attempting to hack GM functions.", 2)
		elseif (player:checkOnline('sgrios') == 1) then
			player:msg(8, player.name.." attempting to hack GM functions.", 46)
		elseif (player:checkOnline('ghari') == 1) then
			player:msg(8, player.name.." attempting to hack GM functions.", 6)
		elseif (player:checkOnline('erebus') == 1) then
			player:msg(8, player.name.." attempting to hack GM functions.", 160)
		elseif (player:checkOnline('namash') == 1) then
			player:msg(8, player.name.." attempting to hack GM functions.", 208)
		end
	end

	menuOption = player:menuString(dialog,optsgm)
	if(menuOption=="Gold" and player.gmLevel >= 99) then
		player:addGold(60000)
	elseif(menuOption=="Set Faith" and player.gmLevel >= 99) then
		player.registry["totem_faith"] = 200
	elseif(menuOption=="What time?" and player.gmLevel >= 99) then
		player:dialogSeq({gfx, "Current Time: "..curTime()..""})
	elseif (menuOption == "Repair Item") then
		local gfx = {graphic = convertGraphic(654,"monster"),color=15}
		local testerchoice=player:input("Which character? (Enter player name)")
		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end

		if (testerchoice == player.name) then
					local t = {graphic = convertGraphic(654,"monster"),color=15}
					player.npcGraphic = t.graphic
					player.npcColor = t.color
					player.dialogType = 0
					local repairList= { }

					for x=0,(player.maxInv - 1) do
						local item=player:getInventoryItem(x)
						if(item ~= nil) then
							if(item.price>0) then
								if(item.type>2 and item.type<17) then
									if(item.dura<item.maxDura) then
										table.insert(repairList,x)
									end
								end
							end
						end
					end

					if(#repairList==0) then
						player:dialogSeq({t, "You have nothing to repair."})
					return end

					local choice=player:sell2("What shall I repair?",repairList)
					local item=player:getInventoryItem(choice-1)
					local cost=math.ceil((item.price/item.maxDura)*(item.maxDura-item.dura)*0.30)
					local nchoice=player:menuString("Are you certain this is the item you wish to repair?",{"Yes","No"})
					if(nchoice=="Yes") then
							item.dura=item.maxDura
							player:updateInv()
							player:sendStatus()
							item.repairCheck = 0
					else
					end
		else
		gm_npc.repair_free(Player(testerchoice, npc))
		end

	elseif (menuOption == "Character Info") then
		local testerchoice=player:input("Which character? (Enter player name)")
		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end
		local popup = ""
		local vitastr = tostring(Player(testerchoice).vRegenAmount)
		local manastr = tostring(Player(testerchoice).mRegenAmount)
		local vitafind = string.find(vitastr, "%p")
		local manafind = string.find(manastr, "%p")
		if (vitafind ~= nil) then
			vitafind = vitafind + 1
		end
		if (manafind ~= nil) then
			manafind = manafind + 1
		end
		vitastr = string.sub(vitastr, 0, vitafind)
		manastr = string.sub(manastr, 0, manafind)
		local pkstr = ""
		local pkdurastr = ""
		if (Player(testerchoice).PK == 0) then
			pkstr = "Normal"
		elseif (Player(testerchoice).PK == 1) then
			pkstr = "PK"
			if (Player(testerchoice).durationPK / 1000 > 120) then
				pkdurastr = "\nPK Duration: "..tostring((Player(testerchoice).durationPK / 1000) / 60)
			else
				pkdurastr = "\nPK Duration: "..tostring(Player(testerchoice).durationPK / 1000)
			end
		else
			pkstr = "Bounty"
			if (Player(testerchoice).durationPK / 1000 > 120) then
				pkdurastr = "\nPK Duration: "..tostring((Player(testerchoice).durationPK / 1000) / 60)
			else
				pkdurastr = "\nPK Duration: "..tostring(Player(testerchoice).durationPK / 1000)
			end
		end
		local expSold = Player(testerchoice).expSold
		local quantifier
		if (expSold < 1000000) then
			quantifier = "K"
			expSold = expSold / 1000
		elseif (expSold < 1000000000) then
			quantifier = "M"
			expSold = expSold / 1000000
		else
			quantifier = "B"
			expSold = expSold / 1000000000
		end
		expSold = string.format("%.2f", expSold)
		popup = popup.."<b>"..Player(testerchoice).name.."'s Base Stats\n\nVita/Mana: "..Player(testerchoice).baseHealth.."/"..Player(testerchoice).baseMagic
		popup = popup.."\n\n<b>Current Stats\n\nLevel: "..Player(testerchoice).level.."\nClass: "..Player(testerchoice).className.."\nWeapon Damage: "..Player(testerchoice).minDam.." - "..Player(testerchoice).maxDam.."\nVita/Mana: "..Player(testerchoice).health.."/"..Player(testerchoice).magic
		popup = popup.."\nMight/Grace/Will: "..Player(testerchoice).might.."/"..Player(testerchoice).grace.."/"..Player(testerchoice).will.."\nHit/Miss/Dam: "..Player(testerchoice).hit.."/"..(Player(testerchoice).miss / 100).."/"..Player(testerchoice).dam.."\nArmor/AC: "..math.floor(Player(testerchoice).armor + .5).."/"..math.floor(Player(testerchoice).ac + .5)
		popup = popup.."\nProtection: "..Player(testerchoice).protection.."\nWisdom: "..Player(testerchoice).wisdom.."\nCon: "..Player(testerchoice).con.."\nVita/Mana per 5s: "..vitastr.."/"..manastr.."\nPK Status: "..pkstr..pkdurastr.."\nFaith: "..Player(testerchoice).registry["totem_faith"]
		
		popup = popup.."\n\nExp Sold: "..expSold.." "..quantifier
		player:popUp(popup)
	elseif(menuOption=="Archon" and player.gmLevel >= 50) then
		player.class = 14
		player:sendStatus()
	elseif(menuOption=="Change Path" and player.gmLevel >= 50) then

	local testerchoice=player:input("Who shall be affected? (Enter player name)")
	local changepath = {}

		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end

		table.insert(changepath, "Warrior")
		table.insert(changepath, "Rogue")
		table.insert(changepath, "Mage")
		table.insert(changepath, "Poet")

		table.insert(changepath, "Knight")
		table.insert(changepath, "Gladiator")
		table.insert(changepath, "Shadow")
		table.insert(changepath, "Archer")
		table.insert(changepath, "Elementalist")
		table.insert(changepath, "Seer")
		table.insert(changepath, "Druid")
		table.insert(changepath, "Bard")

		if(player.gmLevel == 99 and (player.id == 2 or player.id == 3)) then
			table.insert(changepath, "Dreamweaver")
			table.insert(changepath, "Archon")
		end
		--table.insert(changepath, "Archon")
		local choice = player:menuString("Which path will they become?", changepath)
		if(choice == "Warrior") then
			Player(testerchoice).class = 1
			Player(testerchoice):sendStatus()
		elseif(choice == "Rogue") then
			Player(testerchoice).class = 2
			Player(testerchoice):sendStatus()
		elseif(choice == "Mage") then
			Player(testerchoice).class = 3
			Player(testerchoice):sendStatus()
		elseif(choice == "Poet") then
			Player(testerchoice).class = 4
			Player(testerchoice):sendStatus()
		elseif(choice == "Dreamweaver") then
			Player(testerchoice).class = 5
			Player(testerchoice):sendStatus()
		elseif(choice == "Knight") then
			Player(testerchoice).class = 6
			Player(testerchoice):sendStatus()
		elseif(choice == "Gladiator") then
			Player(testerchoice).class = 7
			Player(testerchoice):sendStatus()
		elseif(choice == "Shadow") then
			Player(testerchoice).class = 8
			Player(testerchoice):sendStatus()
		elseif(choice == "Archer") then
			Player(testerchoice).class = 9
			Player(testerchoice):sendStatus()
		elseif(choice == "Elementalist") then
			Player(testerchoice).class = 10
			Player(testerchoice):sendStatus()
		elseif(choice == "Seer") then
			Player(testerchoice).class = 11
			Player(testerchoice):sendStatus()
		elseif(choice == "Druid") then
			Player(testerchoice).class = 12
			Player(testerchoice):sendStatus()
		elseif(choice == "Bard") then
			Player(testerchoice).class = 13
			Player(testerchoice):sendStatus()
		elseif(choice == "Archon") then
			Player(testerchoice).class = 14
			Player(testerchoice):sendStatus()
		end
	elseif(menuOption=="Elixir Part" and player.gmLevel >= 50) then

	local testerchoice=player:input("Who shall be affected? (Enter player name)")
	local changepath = {}

		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end

		local participations=tonumber(player:input("How many participations? #"))
		Player(testerchoice).registry["elixirParticipations"] = participations
		Player(testerchoice):removeLegendbyName("elixirParticipations")

			if (participations == 1) then
				Player(testerchoice):addLegend("Participated in "..participations.." Elixir War.", "elixirParticipations", 1, 16)
			else
				Player(testerchoice):addLegend("Participated in "..participations.." Elixir Wars.", "elixirParticipations", 1, 16)
			end

		Player(testerchoice):sendStatus()
		Player(testerchoice):updateState()
		
	elseif(menuOption == "Immortals Clan") then
		local testerchoice=player:input("Who shall be affected? (Enter player name)")
		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end
		Player(testerchoice).clan = 2
		Player(testerchoice):sendStatus()
	elseif(menuOption == "No Clan") then
		local testerchoice=player:input("Who shall be affected? (Enter player name)")
		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end
		Player(testerchoice).clan = 0
		Player(testerchoice):sendStatus()
	elseif(menuOption=="View Legend Icons" and player.gmLevel >= 20) then
		local legendnumber = tonumber(player:input("Enter a number in increments of 1 - 10 - 20"))
			player:removeLegendbyName("legendmarkicontest")
			player:addLegend(" ID#"..legendnumber.."","legendmarkicontest",legendnumber, 16)
			player:addLegend(" ID#"..(legendnumber + 1).."","legendmarkicontest",(legendnumber + 1), legendnumber + 1)
			player:addLegend(" ID#"..(legendnumber + 2).."","legendmarkicontest",(legendnumber + 2), legendnumber + 2)
			player:addLegend(" ID#"..(legendnumber + 3).."","legendmarkicontest",(legendnumber + 3), legendnumber + 3)
			player:addLegend(" ID#"..(legendnumber + 4).."","legendmarkicontest",(legendnumber + 4), legendnumber + 4)
			player:addLegend(" ID#"..(legendnumber + 5).."","legendmarkicontest",(legendnumber + 5), legendnumber + 5)
			player:addLegend(" ID#"..(legendnumber + 6).."","legendmarkicontest",(legendnumber + 6), legendnumber + 6)
			player:addLegend(" ID#"..(legendnumber + 7).."","legendmarkicontest",(legendnumber + 7), legendnumber + 7)
			player:addLegend(" ID#"..(legendnumber + 8).."","legendmarkicontest",(legendnumber + 8), legendnumber + 8)
			player:addLegend(" ID#"..(legendnumber + 9).."","legendmarkicontest",(legendnumber + 9), legendnumber + 9)
			player:addLegend(" ID#"..(legendnumber + 10).."","legendmarkicontest",(legendnumber + 10), legendnumber + 10)
	elseif(menuOption=="Summon GM Viewer NPC" and player.gmLevel >= 90) then
			player:dialogSeq({gfx,"This option will allow you to summon the Viewer NPC for graphics, please note that this NPC can only be in one place at a time."}, 1)
			t = NPC(69)
			t:warp(player.m, player.x, player.y)
	elseif(menuOption=="Remove Legend Icons" and player.gmLevel >= 20) then
			player:removeLegendbyName("legendmarkicontest")
	elseif(menuOption=="Spell Options" and player.gmLevel >= 99) then
		menuOption3 = player:menuString(dialog,spellopts)
			if(menuOption3=="Grant GM Spell Permission") then
				local grantchoice=player:input("Who shall be affected? (Enter player name)")
				local spell_level=tonumber(player:input("What level of spells will you grant? (Only enter 1, or 2)"))
				if(Player(grantchoice)==nil) then
					player:dialogSeq({t,"He is not online."})
				return
				end
				Player(grantchoice).registry["gm_spell_lv"] = spell_level
				player:dialogSeq({t,""..Player(grantchoice).name.." can now access level "..Player(grantchoice).registry["gm_spell_lv"].." GM spells."})
			elseif(menuOption3=="Remove All Spells") then
				local removespellsplayer=player:input("Who shall be affected? (Enter player name)")

				if(Player(removespellsplayer)==nil) then
					player:dialogSeq({t,"He is not online."})
					return
				end
					local spells = Player(removespellsplayer):getSpells()
				
					for x = 1, #spells do
							Player(removespellsplayer):removeSpell(spells[x])
					end
			end
	elseif(menuOption=="[Lv1] GM Spells" and player.gmLevel >= 20) then
		player:addSpell("approach")
		player:addSpell("summon")
		player:addSpell("gm_sage")
		player:addSpell("gm_res")
	elseif(menuOption=="Remove All Spells" and player.gmLevel >= 99 and player.name == "August") then
	local removespellsplayer=player:input("Who shall be affected? (Enter player name)")

		if(Player(removespellsplayer)==nil) then
			player:dialogSeq({t,"He is not online."})
			return
		end
			local spells = Player(removespellsplayer):getSpells()
		
			for x = 1, #spells do
					Player(removespellsplayer):removeSpell(spells[x])
			end
	elseif(menuOption=="Obtain Char ID" and player.gmLevel >= 20) then
		local charname
		charname=player:input("Whose do you need?")
		player:sendMinitext(""..getOfflineID(charname).."")
	elseif(menuOption=="Legend Mark" and player.gmLevel==99) then
		local legendtest = {}
		table.insert(legendtest,"Add Legend")
		table.insert(legendtest,"Add Imperial Legend")
		table.insert(legendtest,"Remove Imperial Legend")
		table.insert(legendtest,"Add Arrived Legend")
		table.insert(legendtest,"Remove Arrived Legend")
		table.insert(legendtest,"Remove Bugged Legend")
		local testerchoice=player:input("Who shall be affected? (Enter player name)")
		if(Player(testerchoice)==nil) then
			player:dialogSeq({t,"He is not online."})
			return
		end
		local testermenu=player:menuString2("Which applies?",legendtest)
		if(testermenu=="Add Legend" and Player(testerchoice)~=nil) then
			Player(testerchoice):removeLegendbyName("legendmarkicontest")
			Player(testerchoice):addLegend("What does this icon look like?","legendmarkicontest",172,108)
			Player(testerchoice):addLegend("What does this icon look like?","legendmarkicontest",173,109)
			Player(testerchoice):addLegend("What does this icon look like?","legendmarkicontest",174,110)
			Player(testerchoice):addLegend("What does this icon look like?","legendmarkicontest",175,111)
			Player(testerchoice):addLegend("What does this icon look like?","legendmarkicontest",176,112)
			Player(testerchoice):addLegend("What does this icon look like?","legendmarkicontest",177,113)
			Player(testerchoice):addLegend("What does this icon look like?","legendmarkicontest",178,114)
			Player(testerchoice):addLegend("What does this icon look like?","legendmarkicontest",179,115)
			Player(testerchoice):sendMinitext("You have been recognized by the Gods.")
			return
		elseif(testermenu=="Add Imperial Legend" and Player(testerchoice)~=nil) then
			Player(testerchoice):removeLegendbyName("royaltymark")
			Player(testerchoice):addLegend("Born of Imperial blood, member of the Imperial family.","royaltymark",35,5)
		elseif(testermenu=="Remove Imperial Legend" and Player(testerchoice)~=nil) then
			Player(testerchoice):removeLegendbyName("royaltymark")
		elseif(testermenu=="Add Arrived Legend" and Player(testerchoice)~=nil) then
			Player(testerchoice):removeLegendbyName("arrived")
			Player(testerchoice):addLegend("Washed up on the Pinyan shore. "..curT(), "arrived", 0, 16)
		elseif(testermenu=="Remove Arrived Legend" and Player(testerchoice)~=nil) then
			Player(testerchoice):removeLegendbyName("legendmarkicontest")
			Player(testerchoice):removeLegendbyName("arrived")
			Player(testerchoice):removeLegendbyName("born")
			--Player(testerchoice):sendMinitext("The Gods have forsaken you.")
		elseif(testermenu=="Remove Bugged Legend" and Player(testerchoice)~=nil) then
			Player(testerchoice):removeLegendbyName("legendmarkicontest")
			Player(testerchoice):removeLegendbyName("arrived")
			Player(testerchoice):removeLegendbyName("born")
			Player(testerchoice):removeLegendbyName("pathchoice")

			return
		end
	elseif(menuOption=="Where am I?") then
		player:sendMinitext("You are located at:")
		player:sendMinitext("Map: "..player.m.." \a X: "..player.x.." \a Y: "..player.y)
	elseif(menuOption=="Make a person GM" and player.gmLevel==99) then
		targetof=player:input("Who shall I make a GM?")
		levelof=player:input("What level of GM should "..targetof.." be?")
		Player(targetof).gmLevel = levelof * 1
		Player(targetof):sendMinitext("You are now a GM!")
		player:sendMinitext(Player(targetof).name .. " has been made a GM!")
	--[[elseif(menuOption=="Edit Stats" and player.gmLevel==90) then
		targetof=player.name
		stat=player:input("Which stat should "..targetof..
		" have changed?\n(Level, Vita, Mana, Might, Will, Grace, Exp, Gender, Reset, TNL)")
		lstat = string.lower(stat)
		if (lstat=="level")then
			quantity=player:input("Set "..stat.." to: ")
			Player(targetof).level = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="vita")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).baseHealth = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="mana")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).baseMagic = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="might")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).basemight = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="will")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).basewill = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="grace")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).basegrace = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="exp")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).exp = quantity * 1
			Player(targetof):giveXP(1)
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif(lstat=="gender")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).sex = quantity * 1
			Player(targetof):updateState()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="tnl")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).tnl = quantity * 1
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="reset")then
			Player(targetof).exp = 0
			Player(targetof):giveXP(1)
			Player(targetof).baseMight = 1
			Player(targetof).baseGrace = 1
			Player(targetof).baseWill = 1
			Player(targetof).baseAC = 75
			Player(targetof).baseResist = 75
			Player(targetof).baseHealth = 100
			Player(targetof).baseMagic = 100
			Player(targetof).baseRegen = 0
			Player(targetof).baseVRegen = 0
			Player(targetof).baseMRegen = 0
			Player(targetof).baseMinDam = 0
			Player(targetof).baseMaxDam = 0
			Player(targetof).basePhysDeduct = 0
			Player(targetof).baseProtection = 0
			Player(targetof).baseSpeed = 80
			Player(targetof).weapDuraMod = 1
			Player(targetof).armorDuraMod = 1
			Player(targetof).registry["base_might"] = 0
			Player(targetof).registry["base_grace"] = 0
			Player(targetof).registry["base_will"] = 0
			Player(targetof).registry["base_ac"] = 0
			Player(targetof).registry["base_mr"] = 0
			Player(targetof).registry["base_vita"] = 0
			Player(targetof).registry["base_mana"] = 0
			Player(targetof).registry["base_regen"] = 0
			Player(targetof).registry["base_vregen"] = 0
			Player(targetof).registry["base_mregen"] = 0
			Player(targetof).registry["base_mindam"] = 0
			Player(targetof).registry["base_maxdam"] = 0
			Player(targetof).registry["base_pd"] = 0
			Player(targetof).registry["base_prot"] = 0
			Player(targetof).registry["base_speed"] = 0
			Player(targetof).registry["base_wdm"] = 0
			Player(targetof).registry["base_adm"] = 0
			Player(targetof).ap = 0
			Player(targetof).sp = 0
			Player(targetof).level = 1
			Player(targetof).class = 0
			Player(targetof):calcStat()
			Player(targetof).health = Player(targetof).maxHealth
			Player(targetof).magic = Player(targetof).maxMagic
			player:sendMinitext(Player(targetof).name .. " has been reset to level 1.")
		else
			player:sendMinitext("Error.")
		end]]
	elseif(menuOption=="Alter Stats" and (player.gmLevel >= 90 or player.id == 6 or player.id == 756)) then
		local targetof=player:input("Who shall have their stats altered?")
		stat=player:input("Which stat should "..targetof..
		" have changed?\n(Level, Vita, Mana, Might, Will, Grace, Exp, Regen, vRegen, mRegen, Skin, Gender, Title, armorDuraMod, weapDuraMod, reset, tnl)")
		lstat = string.lower(stat)
		if (lstat=="level")then
			quantity=player:input("Set "..stat.." to: ")
			Player(targetof).level = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="vita")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).baseHealth = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="mana")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).baseMagic = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="might")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).basemight = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="will")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).basewill = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="grace")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).basegrace = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="exp")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).exp = quantity * 1
			Player(targetof):giveXP(1)
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="regen")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).regen = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="vregen")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).vRegen = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="mregen")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).mRegen = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="regentime")or(lstat=="regent")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).regenTime = quantity * 1
			Player(targetof):calcStat()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif(lstat=="skin")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).skinColor = quantity * 1
			Player(targetof):updateState()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif(lstat=="gender")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).sex = quantity * 1
			Player(targetof):updateState()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif(lstat=="title")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).title = quantity
			Player(targetof):updateState()
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="weapDuraMod")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).weapDuraMod = quantity * 1
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="armorDuraMod")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).armorDuraMod = quantity * 1
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="tnl")then
			quantity=player:input("Set "..lstat.." to: ")
			Player(targetof).tnl = quantity * 1
			player:sendMinitext(Player(targetof).name .. "'s "..lstat.." has been set to "..quantity)
		elseif (lstat=="reset")then
			Player(targetof).exp = 0
			Player(targetof):giveXP(1)
			Player(targetof).baseMight = 1
			Player(targetof).baseGrace = 1
			Player(targetof).baseWill = 1
			Player(targetof).baseAC = 75
			Player(targetof).baseResist = 75
			Player(targetof).baseHealth = 100
			Player(targetof).baseMagic = 100
			Player(targetof).baseRegen = 0
			Player(targetof).baseVRegen = 0
			Player(targetof).baseMRegen = 0
			Player(targetof).baseMinDam = 0
			Player(targetof).baseMaxDam = 0
			Player(targetof).basePhysDeduct = 0
			Player(targetof).baseProtection = 0
			Player(targetof).baseSpeed = 80
			Player(targetof).weapDuraMod = 1
			Player(targetof).armorDuraMod = 1
			Player(targetof).registry["base_might"] = 0
			Player(targetof).registry["base_grace"] = 0
			Player(targetof).registry["base_will"] = 0
			Player(targetof).registry["base_ac"] = 0
			Player(targetof).registry["base_mr"] = 0
			Player(targetof).registry["base_vita"] = 0
			Player(targetof).registry["base_mana"] = 0
			Player(targetof).registry["base_regen"] = 0
			Player(targetof).registry["base_vregen"] = 0
			Player(targetof).registry["base_mregen"] = 0
			Player(targetof).registry["base_mindam"] = 0
			Player(targetof).registry["base_maxdam"] = 0
			Player(targetof).registry["base_pd"] = 0
			Player(targetof).registry["base_prot"] = 0
			Player(targetof).registry["base_speed"] = 0
			Player(targetof).registry["base_wdm"] = 0
			Player(targetof).registry["base_adm"] = 0
			Player(targetof).ap = 0
			Player(targetof).sp = 0
			Player(targetof).level = 1
			Player(targetof).class = 0
			Player(targetof):calcStat()
			Player(targetof).health = Player(targetof).maxHealth
			Player(targetof).magic = Player(targetof).maxMagic
			player:sendMinitext(Player(targetof).name .. " has been reset to level 1.")
		else
			player:sendMinitext("Error.")
		end
	elseif (menuOption == "Clear gfxToggle" and player.gmLevel >= 1) then
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
	end
	return
end,

repair_free=async(function(player, npc)
	local t = {graphic = convertGraphic(654,"monster"),color=15}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	local repairList= { }

	for x=0,(player.maxInv - 1) do
		local item=player:getInventoryItem(x)
		if(item ~= nil) then
			if(item.price>0) then
				if(item.type>2 and item.type<17) then
					if(item.dura<item.maxDura) then
						table.insert(repairList,x)
					end
				end
			end
		end
	end

	if(#repairList==0) then
		player:dialogSeq({t, "You have nothing to repair."})
	return end

	local choice=player:sell2("What shall I repair?",repairList)
	local item=player:getInventoryItem(choice-1)
	local cost=math.ceil((item.price/item.maxDura)*(item.maxDura-item.dura)*0.30)
	local nchoice=player:menuString("Are you certain this is the item you wish to repair?",{"Yes","No"})
	if(nchoice=="Yes") then
			item.dura=item.maxDura
			player:updateInv()
			player:sendStatus()
			item.repairCheck = 0
	else
	end

end),
}