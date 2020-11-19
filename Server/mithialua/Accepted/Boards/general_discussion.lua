general_discussion = {
check = function(player)
		player.boardWrite = 1

	if (player.gmLevel >= 50 or player.registry["moderator"] == 1) then
		player.boardDel = 1
	end
end
}