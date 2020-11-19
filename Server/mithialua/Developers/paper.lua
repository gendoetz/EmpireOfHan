paper_test = {
use = async(function(player)
	--player:msg(8, "Rewards:\nGold: 800\nExp: 7500", player.ID)
	--player:paper("The cave looks very dark.. It would be way too dangerous to try and travel in there.", 15, 20)
	local savethis = player:paperWrite("", 15, 20)
end)
}