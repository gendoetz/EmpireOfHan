diffuse = {
cast=function(player)

	local aether = 90000

	if not (player:hasDuration("hindrance") or player:hasDuration("hindrance2") or player:hasDuration("hindrance3")) then
		player:sendMinitext("You have no curse to remove.")
		return
	end

	if (player:hasDuration("hindrance")) then
		player:setDuration("hindrance", 0)
	end

	if (player:hasDuration("hindrance2")) then
		player:setDuration("hindrance2", 0)
	end

	if (player:hasDuration("hindrance3")) then
		player:setDuration("hindrance3", 0)
	end
	player:setAether("diffuse", aether)
	player:sendAction(6, 20)
	player:sendStatus()
	player:sendAnimation(58)
	player:playSound(34)

end,

requirements = function(player)
	local level = 60
	local items = {}
	local itemAmounts = {}
	local description = {"Diffuse removes all forms of hinderance on you."}
	return level, items, itemAmounts, description
end
}