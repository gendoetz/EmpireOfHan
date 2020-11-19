gm_clearspells = {
cast=async(function(player,target)
	if(player.ID==2) then
		local nameofPlayer=player:input("Who shall lose their spells?")
		local target = Player(nameofPlayer)
		if (target == nil) then
			return
		end
		for i = 1, 6999 do
			target:removeSpell(i)
		end
	else
		player:sendMinitext("You are too weak and feable to cast this spell.")
	end
end),

requirements = function(player)
	local level = 37
	local items = {}
	local itemAmounts = {}
	local description = {"Clear Spells removes all spells of a person named."}
	return level, items, itemAmounts, description
end
}