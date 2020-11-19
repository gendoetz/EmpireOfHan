celebration_han = {
click = async(function(player, npc)
	local npcG = {graphic = convertGraphic(8, "monster"), color = 6}
	local opts = { }
	local repeater = 0
	local starter = 1

	npc.registry["timer"] = os.time() + 2
	npc.registry["seq"] = 0
	player.npcGraphic = npcG.graphic
	player.npcColor = npcG.color
	player:dialogSeq({npcG, "I love fireworks!"}, 1)
end),

say = function(player, npc)
	local speech = string.lower(player.speech)

	if ((string.find(speech, "(.*)celebrate(.*)"))) then
			celebration_han.click(player, npc)
			--player:warp(68, 3, 6)
	end
	if ((string.find(speech, "(.*)fireworks(.*)"))) then
			celebration_han.click(player, npc)
	end
end,

action = function(npc)
	if (npc.registry["timer"] < os.time() and npc.registry["timer"] > 0) then
		
		if (npc.registry["seq"] == 0) then
		npc:sendAnimationXY(278, 22, 39, 1)
		npc:sendAnimationXY(278, 29, 39, 1)

		npc:sendAnimationXY(278, 21, 39, 1)
		npc:sendAnimationXY(278, 19, 39, 1)
		npc:sendAnimationXY(278, 30, 39, 1)
		npc:sendAnimationXY(278, 32, 39, 1)

		npc:sendAnimationXY(278, 20, 40, 1)
		npc:sendAnimationXY(278, 31, 40, 1)
		npc.registry["seq"] = 1
		elseif (npc.registry["seq"] == 1) then
		npc:sendAnimationXY(278, 21, 39, 1)
		npc:sendAnimationXY(278, 19, 39, 1)
		npc:sendAnimationXY(278, 30, 39, 1)
		npc:sendAnimationXY(278, 32, 39, 1)

		npc:sendAnimationXY(278, 20, 40, 1)
		npc:sendAnimationXY(278, 31, 40, 1)

		npc:sendAnimationXY(337, 24, 40, 1)
		npc:sendAnimationXY(337, 27, 40, 1)
		npc.registry["seq"] = 2
		elseif (npc.registry["seq"] == 2) then
		npc:sendAnimationXY(278, 22, 39, 1)
		npc:sendAnimationXY(278, 29, 39, 1)
		npc:sendAnimationXY(337, 25, 40, 1)
		npc:sendAnimationXY(337, 26, 40, 1)
		npc.registry["seq"] = 3
		elseif (npc.registry["seq"] == 3) then
		npc:sendAnimationXY(278, 22, 39, 1)
		npc:sendAnimationXY(278, 29, 39, 1)

		npc:sendAnimationXY(337, 22, 40, 1)
		npc:sendAnimationXY(337, 23, 40, 1)
		npc:sendAnimationXY(337, 24, 40, 1)
		npc:sendAnimationXY(337, 25, 40, 1)
		npc:sendAnimationXY(337, 26, 40, 1)
		npc:sendAnimationXY(337, 27, 40, 1)
		npc:sendAnimationXY(337, 28, 40, 1)
		npc:sendAnimationXY(337, 29, 40, 1)
		npc.registry["seq"] = 4
		elseif (npc.registry["seq"] == 4) then
		npc:sendAnimationXY(278, 21, 39, 1)
		npc:sendAnimationXY(278, 19, 39, 1)
		npc:sendAnimationXY(278, 30, 39, 1)
		npc:sendAnimationXY(278, 32, 39, 1)

		npc:sendAnimationXY(278, 20, 40, 1)
		npc:sendAnimationXY(278, 31, 40, 1)

		npc:sendAnimationXY(337, 24, 40, 1)
		npc:sendAnimationXY(337, 27, 40, 1)
		npc.registry["timer"] = 0
		npc.registry["seq"] = 0
		end 
	end
end,

}

