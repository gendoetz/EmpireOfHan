rep_bard = {
use = async(function(player)
	local itemGraphic = {graphic = convertGraphic(1554, "item"), color = 0}
	local npcA = {graphic = 0, color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 0

	local songStr = {}
		songStr[1] = "o/' ~ O the ocean's waves will roll.."
		songStr[2] = "o/' ~ And the stormy winds will blow.."
		songStr[3] = "o/' ~ While we poor sailors go skipping to the top.."
		songStr[4] = "o/' ~ And the landlubbers lie down below.."

	local range = 3

	local npcs = player:getObjectsInArea(BL_NPC)
		for i = 1, #npcs do
			local NPCid = npcs[i].id
			if (NPCid == NPC(129).id) then
				player.lastClick = NPC(129).ID
				if (distance(NPC(129), player) <= range) then
					if (player.quest["rQ_Bard"] >= 2) then
						NPC(129):talk(0, ""..songStr[2].."")
						player:dialogSeq({npcA, "You should go visit the "..NPC(132).name.."."}, 0)
					elseif (player.quest["rQ_Bard"] == 1) then
						player.quest["rQ_Bard"] = player.quest["rQ_Bard"] + 1
						NPC(129):talk(0, "I've seen an instrument like that before, the traveller who had one sang a song..")
						NPC(129):talk(0, ""..songStr[2].."")
						player:dialogSeq({npcA, "You should go visit the "..NPC(132).name.."."}, 0)
					end
				else
					player:dialogSeq({npcA, ""..NPC(129).name.." notices your Performance Aid, you should get closer to them.."}, 0)
				end
			elseif (NPCid == NPC(132).id) then
				player.lastClick = NPC(132).ID
				if (distance(NPC(132), player) <= range) then
					if (player.quest["rQ_Bard"] >= 3) then
						NPC(132):talk(0, ""..songStr[4].."")
						player:dialogSeq({npcA, "You should go visit the "..NPC(133).name.."."}, 0)
					elseif (player.quest["rQ_Bard"] == 2) then
						player.quest["rQ_Bard"] = player.quest["rQ_Bard"] + 1
						NPC(132):talk(0, "I've seen an instrument like that before, the traveller who had one sang a song..")
						NPC(132):talk(0, ""..songStr[4].."")
						player:dialogSeq({npcA, "You should go visit the "..NPC(133).name.."."}, 0)
					end
				else
					player:dialogSeq({npcA, ""..NPC(132).name.." notices your Performance Aid, you should get closer to them.."}, 0)
				end
			elseif (NPCid == NPC(133).id) then
				player.lastClick = NPC(133).ID
				if (distance(NPC(133), player) <= range) then
					if (player.quest["rQ_Bard"] >= 4) then
						NPC(133):talk(0, ""..songStr[1].."")
						player:dialogSeq({npcA, "You should go visit the "..NPC(135).name.."."}, 0)
					elseif (player.quest["rQ_Bard"] == 3) then
						player.quest["rQ_Bard"] = player.quest["rQ_Bard"] + 1
						NPC(133):talk(0, "I've seen an instrument like that before, the traveller who had one sang a song..")
						NPC(133):talk(0, ""..songStr[1].."")
						player:dialogSeq({npcA, "You should go visit the "..NPC(135).name.."."}, 0)
					end
				else
					player:dialogSeq({npcA, ""..NPC(133).name.." notices your Performance Aid, you should get closer to them.."}, 0)
				end
			elseif (NPCid == NPC(135).id) then
				player.lastClick = NPC(135).ID
				if (distance(NPC(135), player) <= range) then
					if (player.quest["rQ_Bard"] >= 5) then
						NPC(135):talk(0, ""..songStr[3].."")
						player:dialogSeq({npcA, "You should go visit the Bard and put the song back together!"}, 0)
					elseif (player.quest["rQ_Bard"] == 4) then
						player.quest["rQ_Bard"] = player.quest["rQ_Bard"] + 1
						NPC(135):talk(0, "I've seen an instrument like that before, the traveller who had one sang a song..")
						NPC(135):talk(0, ""..songStr[3].."")
						player:dialogSeq({npcA, "You should go visit the Bard and put the song back together!"}, 0)
					end
				else
					player:dialogSeq({npcA, ""..NPC(135).name.." notices your Performance Aid, you should get closer to them.."}, 0)
				end
			end
		end
end),

}
