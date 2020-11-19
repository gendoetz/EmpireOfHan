gm_npcsummon = {
cast = function (player)
	local nP = player.question
	local str, t
	if (nP~=nil) then
		if (string.byte(nP) <= 57) and (string.byte(nP) >= 48) then--num
			t = NPC(nP)
			t:warp(player.m, player.x, player.y)
			player:refresh()
		else
			player:sendMinitext("ID expected. Can not use ynames to summon.")
		end
	end
end,

requirements = function(player)
	local level = 37
	local items = {}
	local itemAmounts = {}
	local description = {"NPC Summon brings an npc to you. This NPC will disappear from where they started. DANGER as some npcs have special scripts."}
	return level, items, itemAmounts, description
end
}