rep_shadowglove = {
use = async(function(player)
	local npcA = {graphic = convertGraphic(961, "monster"), color = 0}
	local target = getTargetFacing(player, BL_NPC)	

	if (player.quest["rQ_Shadow"] <= 1 and (target.id == 140)) then
		if (player.state ~= 2) then
			player:dialogSeq({npcA, "You cannot sneak up on the "..target.name.." in your current state."}, 0)
		else
			if (NPC(140).registry["cooldown"] >= 1) then
				player:dialogSeq({npcA, ""..target.name.." has already been calmed down by "..Player(target.owner).name.."."}, 0)

			else
				player:dialogSeq({npcA, "You sneak up on the bird.."}, 1)
				local menuChoice1 = player:menuString("What will you do?", {"Do nothing.", "Pluck a feather."})
				if (menuChoice1 == "Do nothing.") then
					player:dialogSeq({npcA, "You saddle up next to the bird, staring at it with a puzzled look."}, 0)
				elseif (menuChoice1 == "Pluck a feather.") then
					if (player:hasSpace("rep_shadowfeather", 1) == false) then
						player:dialogSeq({npcA, "Your pack seems to be too full. Come back when you lighten your satchel."}, 0)

					elseif (player:hasSpace("rep_shadowfeather", 1) == true) then
						player:addItem("rep_shadowfeather", 1)
						player.quest["rQ_Shadow"] = player.quest["rQ_Shadow"] + 1
						NPC(140).registry["cooldown"] = 2
						NPC(140).owner = player.id
						player:dialogSeq({npcA, "You pluck a feather from the bird, confusing it in the process."}, 0)
					end
				end
			end
		end
	end

end),

}	