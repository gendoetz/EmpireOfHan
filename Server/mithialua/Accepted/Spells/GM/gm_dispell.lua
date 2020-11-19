gm_dispell = {
	cast=function(player,target)
		
		if(player.gmLevel < 1) then
			player:sendMinitext("You do not understand how to use this spell.")
			return
		end

		target:flushDuration(5)
		target:sendStatus()
		target:sendAnimation(10)
		player:playSound(34)

		if (player.ID ~= target.ID) then
			--target:sendMinitext("GM "..player.name .." casts Dispell on you.")
		end

		player:sendMinitext("You dispelled "..target.name..".")
		player:sendAction(6,35)
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Dispell removes all spells on a target that are running."}
	return level, items, itemAmounts, description
end
}