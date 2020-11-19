EoDestiny = {
click = async(function(player,npc)
	local t = {graphic = convertGraphic(952, "monster"), color = 28}
	local opts = {"Open the Portal", "Sacrifice Items"}
	local sacopts = {"Kyanite", "Bewitched Stone Fragments"}
	local menuOption
	local m = player.m

	if (player.name == "August") then
		table.insert(opts, "GM: Open the Portal")
		table.insert(opts, "GM: Close the Portal")
	end

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("I am the spirit of Zodiac Destiny. What is it you wish?", opts)
	
	if (menuOption == "Open the Portal") then
				player:dialogSeq({t, "The magic that binds this portal to Zodiac Island has faded and the nearby temple crystals have been exhausted for years.",
				t, "If I had enough magical energy to power the portal it could stay open for a short duration.",
				t, "The cost of opening the portal is quite great. You should seek the assistance of fellow kin if you seek to open the portal."}, 1)
		if (npc.registry["portalcostcrystals"] <= 0 and npc.registry["portalcostmagicditems"] <= 0) then
			if (m == 37) then
				npc:sendAnimationXY(105, 32, 24, 1)
				npc:sendAnimationXY(105, 31, 24, 1)
				npc:playSound(64)
				setObject(37, 30, 24, 12667)
				setObject(37, 31, 24, 12668)
				setObject(37, 32, 24, 12669)
				setObject(37, 33, 24, 12670)
				npc.registry["portal_status"] = 2
				broadcast(npc.m, "The portal to Zodiac Island has opened.")
			end
		else
			player:dialogSeq({t, "I do not have the required magic to open this portal yet..."}, 1)
		end
	elseif (menuOption == "Sacrifice Items") then
			menuOption2 = player:menuString("What will you sacrifice?", sacopts)
				if (menuOption2 == "Kyanite") then
					local portalitem = player:hasItem("rough_kyanite", 9999)
					if(npc.registry["portalcostcrystals"] <= 0) then
						player:dialogSeq({t, "I no longer require any Kyanite."}, 1)
						return
					end
					--broadcast(npc.m, ""..player.name.." has: "..portalitem.." Kyanites.")
					if (player:hasItem("rough_kyanite", portalitem) == true) then
						player:removeItem("rough_kyanite", npc.registry["portalcostcrystals"])
						npc.registry["portalcostcrystals"] = npc.registry["portalcostcrystals"] - portalitem
							if (npc.registry["portalcostcrystals"] <= 0) then
								player:dialogSeq({t, "You have provided me with all the Rough Kyanite I need."}, 1)
							else
								player:dialogSeq({t, "I still require "..npc.registry["portalcostcrystals"].." Rough Kyanite to proceed with opening the portal."}, 1)
							end
					else
						player:dialogSeq({t, "I still require "..npc.registry["portalcostcrystals"].." Rough Kyanite to proceed with opening the portal."}, 1)
					end
				elseif (menuOption2 == "Bewitched Stone Fragments") then
					local portalitem = player:hasItem("bw_stone_frags", 9999)
					if(npc.registry["portalcostmagicditems"] <= 0) then
						player:dialogSeq({t, "I no longer require any Bewitched Stone Fragments."}, 1)
						return
					end
					--broadcast(npc.m, ""..player.name.." has: "..portalitem.." Kyanites.")
					if (player:hasItem("bw_stone_frags", portalitem) == true) then
						player:removeItem("bw_stone_frags", npc.registry["portalcostmagicditems"])
						npc.registry["portalcostmagicditems"] = npc.registry["portalcostmagicditems"] - portalitem
							if (npc.registry["portalcostmagicditems"] <= 0) then
								player:dialogSeq({t, "You have provided me with all the Bewitched Stone Fragments I need."}, 1)
							else
								player:dialogSeq({t, "I still require "..npc.registry["portalcostmagicditems"].." Bewitched Stone Fragments to proceed with opening the portal."}, 1)
							end
					else
						player:dialogSeq({t, "I still require "..npc.registry["portalcostmagicditems"].." Bewitched Stone Fragments to proceed with opening the portal."}, 1)
					end
				end
	elseif (menuOption == "GM: Close the Portal") then
					if (m == 37) then
						npc:sendAnimationXY(105, 32, 24, 1)
						npc:sendAnimationXY(105, 31, 24, 1)
						npc:playSound(64)
						setObject(37, 30, 24, 12628)
						setObject(37, 31, 24, 12629)
						setObject(37, 32, 24, 12630)
						setObject(37, 33, 24, 12631)
						npc.registry["portal_status"] = 0
						broadcast(npc.m, "The portal to Zodiac Island has faded.")
					end
	elseif (menuOption == "GM: Open the Portal") then
					if (m == 37) then
						npc:sendAnimationXY(105, 32, 24, 1)
						npc:sendAnimationXY(105, 31, 24, 1)
						npc:playSound(64)
						setObject(37, 30, 24, 12667)
						setObject(37, 31, 24, 12668)
						setObject(37, 32, 24, 12669)
						setObject(37, 33, 24, 12670)
						npc.registry["portal_status"] = 2
						broadcast(npc.m, "The portal to Zodiac Island has opened.")
					end
	end
end),

action = function(npc)
local portalopentimeset = 10
	if (npc.registry["portal_status"] == 0) then
		npc.registry["portalcostcrystals"] = 40
		npc.registry["portalcostmagicditems"] = 40
		npc.registry["portal_status"] = 1
		--Cost of items goes here--
	elseif (npc.registry["portal_status"] == 2) then
		npc.registry["portalopentime"] = os.time()
		npc.registry["portal_status"] = 3
		--Starting the countdown to shut down the portal.
	elseif (npc.registry["portal_status"] == 3 and os.time() >= npc.registry["portalopentime"] + portalopentimeset) then
			npc:sendAnimationXY(105, 32, 24, 1)
			npc:sendAnimationXY(105, 31, 24, 1)
			npc:playSound(64)
			setObject(37, 30, 24, 12628)
			setObject(37, 31, 24, 12629)
			setObject(37, 32, 24, 12630)
			setObject(37, 33, 24, 12631)
			npc.registry["portal_status"] = 0
			broadcast(npc.m, "The portal to Zodiac Island has faded.")
	end
end,

portalwarpcheck = function(player, npc)
npc = player:getObjectsInCell(37, 33, 25, BL_NPC)
	if (npc[1].registry["portal_status"] >= 2) then
			if (player.x == 31 and player.y == 24) then
				player:warp(60, 19, 36)
			elseif (player.x == 32 and player.y == 24) then
				player:warp(60, 20, 36)
			end
	else
		player:sendMinitext("You sense a great power in this area.")
	end
end

}