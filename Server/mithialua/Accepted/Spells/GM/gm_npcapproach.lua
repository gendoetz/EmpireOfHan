gm_npcapproach = {
cast = function (player)
	local nP = player.question
	local str, t
	if (nP ~= nil) then
		if (NPC(nP) ~= nil) then
			t = NPC(nP)
			player:warp(t.m, t.x, t.y)
		else
			player:sendMinitext("Does not exist")
		end
	end
end,

requirements = function(player)
	local level = 37
	local items = {}
	local itemAmounts = {}
	local description = {"NPC Approach allows you to pop up on a map where a npc is located."}
	return level, items, itemAmounts, description
end
}