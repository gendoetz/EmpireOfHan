gm_remove_voice = {
cast = function(player,target)
		
		if(player.gmLevel < 1) then
			player:sendMinitext("You do not understand how to use this spell.")
			return
		end

		if(target:hasDuration("gm_remove_voice")) then
			player:sendMinitext("This spell is already in effect.")
			return
		end

		target:setDuration("gm_remove_voice", 100000)
		target:sendStatus()
		player:playSound(1)
		target:sendAnimation(1)

		player:sendMinitext("You removed "..target.name.."'s voice and replaced their speech.")
		player:sendAction(6,35)
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"GM only."}
	return level, items, itemAmounts, description
end
}