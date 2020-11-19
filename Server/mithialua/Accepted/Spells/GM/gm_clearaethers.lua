gm_clearaethers = {
	cast=function(player,target)
	local x
		
		if(player.gmLevel<1) then
			player:sendMinitext("You do not understand how to use this spell.")
			return
		end

		target:flushAether(5)
		target:sendAnimation(106)
		player:playSound(13)

		if(player.ID~=target.ID) then
			player:sendMinitext("GM "..player.name.." dissipated your aethers.")
		end

		player:sendMinitext("You dissipated "..target.name.."'s aethers.")
		player:sendAction(6,35)
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Clear Aethers removed a targets entire amount of spell aethers."}
	return level, items, itemAmounts, description
end
}