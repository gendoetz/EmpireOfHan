siege_rez = {
click = async(function(player, npc)
	if (player.state == 1) then
		player.state = 0
		player.health = player.maxHealth
		player.magic = player.maxMagic
		carnage_veil.cast(player)
		player:updateState()
		player:sendStatus()
		npc:talk(0, "Battle Healer: The battlefield awaits warrior!")
		return
	end
end),

action = function(player, npc)
local players = npc:getObjectsInSameMap(BL_PC)
for i = 1, #players do
	if (players[i].state == 1) then
		player.state = 0
		player.health = player.maxHealth
		player.magic = player.maxMagic
		carnage_veil.cast(player)
		player:updateState()
		player:sendStatus()
		npc:talk(0, "Battle Healer: The battlefield awaits warrior!")
	end
end
end
}