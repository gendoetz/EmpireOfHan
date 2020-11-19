cosmos_nuisance = { 
say = function(player,npc)
	local npcA = {graphic = convertGraphic(993, "monster"), color = 26}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 0 -- 1 Player-Graphic NPC
		                      -- 0 Disguise-Graphic NPC

	local reasons = {}
		reasons[1] = "The Gods need to get back to work."
		reasons[2] = "Causing a scene and being a disruptive."
		reasons[3] = "Harassing another player in the room."
		reasons[4] = "Snoring for a prolonged amount of time."	
		reasons[5] = "The Gods need to get back to work."

	local name=player:input("Who do you wish to boot?")
	if (Player(name) == nil) then
		player:dialogSeq({npcA, name.." is not online."}, 1)
		return
	elseif (Player(name).m ~= npc.m ) then
		player:dialogSeq({npcA, name.." isn't in this room."}, 1)
		return
	elseif (Player(name).m == npc.m ) then
		local reason = player:menuString("Why should they be removed?", {"Cosmos Working", "Disruption", "Harassment", "Asleep"})
		if ( reason == "Cosmos Working" ) then
			if	(string.lower(name) == string.lower(player.name)) then
				player:dialogSeq({npcA,"You cannot nuisance yourself."})
				return
			end
			removalreason = reasons[1]
			if (Player(name).gmLevel >= 1) then
				Player(name):warp(0, 5, 3)
			else
				Player(name):warp(39, 15, 5)
			end
			broadcast(1001, "<  "..name.." has been removed from "..player.mapTitle.." by "..player.name..".  >")
			Player(name):msg(8, "[Reason for Removal]\n\n"..removalreason.."\n\n- "..player.name.."", Player(name).ID)

		elseif ( reason == "Disruption" ) then
			if(string.lower(name) == string.lower(player.name)) then
				player:dialogSeq({npcA,"You cannot nuisance yourself."})
				return
			end
			removalreason = reasons[2]
			if (Player(name).gmLevel >= 1) then
				Player(name):warp(0, 5, 3)
			else
				Player(name):warp(39, 15, 5)
			end
			broadcast(1001, "<  "..name.." has been removed from "..player.mapTitle.." by "..player.name..".  >")
			Player(name):msg(8, "[Reason for Removal]\n\n"..removalreason.."\n\n- "..player.name.."", Player(name).ID)

		elseif ( reason == "Harassment" ) then
			if	(string.lower(name) == string.lower(player.name)) then
				player:dialogSeq({npcA,"You cannot nuisance yourself."})
				return
			end
			removalreason = reasons[3]
			if (Player(name).gmLevel >= 1) then
				Player(name):warp(0, 5, 3)
			else
				Player(name):warp(39, 15, 5)
			end
			broadcast(1001, "<  "..name.." has been removed from "..player.mapTitle.." by "..player.name..".  >")
			Player(name):msg(8, "[Reason for Removal]\n\n"..removalreason.."\n\n- "..player.name.."", Player(name).ID)

		elseif ( reason == "Asleep" ) then
			if	(string.lower(name) == string.lower(player.name)) then
				player:dialogSeq({npcA,"You cannot nuisance yourself."})
				return
			end
			removalreason = reasons[4]
			if (Player(name).gmLevel >= 1) then
				Player(name):warp(0, 5, 3)
			else
				Player(name):warp(39, 15, 5)
			end
			broadcast(1001, "<  "..name.." has been removed from "..player.mapTitle.." by "..player.name..".  >")
			Player(name):msg(8, "[Reason for Removal]\n\n"..removalreason.."\n\n- "..player.name.."", Player(name).ID)

		end
	end
end,
}