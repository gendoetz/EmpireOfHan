rep_seer = {
use = async(function(player)
	local ITEM = {graphic = convertGraphic(1025, "item"), color = 0} 
	local npcA = {graphic = convertGraphic(7, "monster"), color = 8}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
	local npcB = {graphic = convertGraphic(4, "monster"), color = 2}
		player.npcGraphic = npcB.graphic
		player.npcColor = npcB.color
	local npcC = {graphic = convertGraphic(226, "monster"), color = 0}
		player.npcGraphic = npcB.graphic
		player.npcColor = npcB.color
		player.dialogType = 0


	local npcs = player:getObjectsInArea(BL_NPC)
		for i = 1, #npcs do
			local NPCid = npcs[i].id

				if (NPCid == NPC(41).id) then
					player.lastClick = NPC(41).ID
					if (player.registry["rQ_seerT1"] == 1) then
						player:dialogSeq({npcA, "What wonderful news! I need to clean my shop, think of all the business coming our way!"}, 0)
					elseif (player.registry["rQ_seerT1"] == 0) then
						player.quest["rQ_Seer"] = player.quest["rQ_Seer"] + 1
						player.registry["rQ_seerT1"] = player.registry["rQ_seerT1"] + 1
						player:dialogSeq({npcA, "Greetings Traveler, what wares can I help you find to-..",
						npcA, "Oh you're not here to buy anything?\n\nYou've come to give me my reading I requested?!",
						npcA, "I thought the Seer was going to come them self, mind you our town is beyond the gate.",
						npcA, "Alright, alright..\n\nSo "..player.name..", what is my fate?",
						ITEM, "I see you coming into great Fortune..",
						npcA, "What?! That's wonderful news!\n\nI thought business was picking up but rightly so! Thank you traveler, your insights are most fruitful!"}, 0)
					end

				elseif (NPCid == NPC(55).id) then
					player.lastClick = NPC(55).ID
					if (player.registry["rQ_seerT2"] == 1) then
						player:dialogSeq({npcB, "*grumbles to himself*\n\nMe, die?! Right..\n\nHahaha.. haha.. haha... ha.."}, 0)
					elseif (player.registry["rQ_seerT2"] == 0) then
						player.quest["rQ_Seer"] = player.quest["rQ_Seer"] + 1
						player.registry["rQ_seerT2"] = player.registry["rQ_seerT2"] + 1
						player:dialogSeq({npcB, "Here for some shiny new jewelery?",
						npcB, "Oh, the Seer is busy? You've come instead?\n\nAlright, well if she sent you in her place you must be good!",
						npcB, "So "..player.name..", what is my fate?",
						ITEM, "A horrible, unfortunate death shall befall you..",
						npcB, "What!!!\n\nGET OUT! How dare you tell me I'm going to die!\n\nHOW DO YOU EVEN KNOW? YOU DON'T!"}, 1)
						player:warp(15, 80, 88)
						player:dialogSeq({npcB, "*pushes you outside in a fluster*"}, 0)
					end

				elseif (NPCid == NPC(97).id) then
					player.lastClick = NPC(97).ID
					if (player.registry["rQ_seerT3"] == 1) then
						player:dialogSeq({npcC, "Her and I?.. No.. But maybe..\n\n*he slashes the head off a chicken, face beaming with glee*"}, 0)
					elseif (player.registry["rQ_seerT3"] == 0) then
						player.quest["rQ_Seer"] = player.quest["rQ_Seer"] + 1
						player.registry["rQ_seerT3"] = player.registry["rQ_seerT3"] + 1
						player:dialogSeq({npcC, "*stares at you*",
						npcC, "What. Did you want something? I'm kind of busy here.",
						npcC, "So the Seer said, 'Hey, I know a good idea. I'll send "..player.name.." to do my rounds instead?",
						npcC, "Fine. What do you have to say "..player.name.."?",
						ITEM, "A romance shall flourish soon between an old friend..",
						npcC, "*His face flushes red*",
						npcC, "Well, I mean, maybe.. *his voice trails off*"}, 0)
					end

				end

		end

end),

}