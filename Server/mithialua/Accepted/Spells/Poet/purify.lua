purify = {
cast = function(player,target)
		local magicCost = 500

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		if (target.state == 1) then
			player:sendMinitext("That cannot save them now.")
			return
		end

			if (target:hasDuration("hindrance")) then
				player:sendMinitext("You cast Purify: Removed Hindrance")
				target:setDuration("hindrance", 0)
			elseif (target:hasDuration("hindrance2")) then
				player:sendMinitext("You cast Purify: Removed Hindrance II")
				target:setDuration("hindrance2", 0)
			elseif (target:hasDuration("hindrance3")) then
				player:sendMinitext("You cast Purify: Removed Hindrance III")
				target:setDuration("hindrance3", 0)
			elseif (target:hasDuration("doom")) then
				player:sendMinitext("You cast Purify: Removed Doom")
				target:flushDurationNoUncast(6061)
			end

			player.magic = player.magic - magicCost
			if (target.y ~= 0) then
				target:sendAnimationXY(75, target.x, target.y-1, 0)
			end
			player:playSound(67)
			player:sendAction(6, 35)
			target:sendStatus()

			--player:sendMinitext("You cast Purify.")

			if(target.blType==BL_PC) then
				target:sendMinitext(player.name .." casts Purify on you.")
			end
			

end,

requirements = function(player)
	local level = 55
	local items = {}
	local itemAmounts = {}
	local description = {"Purify removes curses of weakness, death, and snare from a target."}
	return level, items, itemAmounts, description
end      
}