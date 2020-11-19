
imperial_legion_throne = {
click = async(function(player,npc)
	local clannumber=1

	if (player.registry["clan"..clannumber.."kindredlevel"] == 6 and (player.x == 4 or player.x == 2) and player.y == 5) then
		player:warp(68, 3, 6)
	elseif (player.registry["clan"..clannumber.."kindredlevel"] == 6 and player.x == 3 and player.y == 6) then
		player:warp(68, 4, 5)
	end
end),

say = function(player, npc)
	local speech = string.lower(player.speech)

	if ((string.find(speech, "(.*)sit(.*)"))) then
			imperial_legion_throne.click(player, npc)
			--player:warp(68, 3, 6)
	end
	if ((string.find(speech, "(.*)stand(.*)"))) then
			imperial_legion_throne.click(player, npc)
	end
end
}

