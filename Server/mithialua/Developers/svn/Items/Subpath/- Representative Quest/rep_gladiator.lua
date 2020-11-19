rep_gladiator = {
use = async(function(player)
	local itemGraphic = {graphic = convertGraphic(3963, "item"), color = 17}
		player.npcGraphic = itemGraphic.graphic
		player.npcColor = itemGraphic.color
		player.dialogType = 0 -- 1 Player-Graphic NPC
		                      -- 0 Disguise-Graphic NPC

	if (player.m == 74) then
		if (player.x >= 35 and player.y >= 122 and (player.x <= 57 and player.y <= 130)) then
			local menuChoice1 = player:menuString3("You stare at the mirror..", {"Look at your reflection..", "Put the mirror down."})
				if (menuChoice1 == "Look at your reflection..") then
					if (player.side == 0) then
						player:spawn(300, player.x, (player.y-1), 1) -- if this is not a code with player in the content, npc:spawn, block:spawn etc. ID of monster is 300 for bard player clone
						player_cloneCreate.setup(player, player.x, (player.y-1)) -- ( ) contains the target you want to make a clone of.
					elseif (player.side == 1) then
						player:spawn(300, (player.x+1), player.y, 1) -- if this is not a code with player in the content, npc:spawn, block:spawn etc. ID of monster is 300 for bard player clone
						player_cloneCreate.setup(player, (player.x+1), player.y) -- ( ) contains the target you want to make a clone of.
					elseif (player.side == 2) then
						player:spawn(300, player.x, (player.y+1), 1) -- if this is not a code with player in the content, npc:spawn, block:spawn etc. ID of monster is 300 for bard player clone
						player_cloneCreate.setup(player, player.x, (player.y+1)) -- ( ) contains the target you want to make a clone of.
					elseif (player.side == 3) then
						player:spawn(300, (player.x-1), player.y, 1) -- if this is not a code with player in the content, npc:spawn, block:spawn etc. ID of monster is 300 for bard player clone
						player_cloneCreate.setup(player, (player.x-1), player.y) -- ( ) contains the target you want to make a clone of.
					end		

				elseif (menuChoice1 == "Put the mirror down.") then
					player:dialogSeq({itemGraphic, "You lower the Enchanted Mirror and put it back in your satchel."}, 1)
				end

		else
			player:dialogSeq({itemGraphic, "You need to get closer to the Lava's Edge."}, 1)
		end
	else
		player:dialogSeq({itemGraphic, "You aren't near the Lava pits in Vogt Forest."})
	end
end),

}