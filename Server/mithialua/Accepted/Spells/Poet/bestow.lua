bestow = {
cast = function(player, target)
	local aether = 3000
	local magicCost = (player.maxMagic - 500)
	local givemana = 0
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	local givemana = player.magic - 500

	if (givemana < 0) then
		givemana = 0
	end
	
	player:sendAction(6, 20)
	player:setAether("bestow", aether)
	player:playSound(50)
	target:sendAnimation(74, 0)

	if ((target.magic + givemana) > target.maxMagic) then
		target.magic = target.maxMagic
	else
		target.magic = target.magic + givemana
	end

	target:sendStatus()
	player.magic = 500
	player:sendStatus()
	player:sendMinitext("You cast Bestow on "..target..".")
	target:sendMinitext(player.." casts Bestow on you.")
end,

requirements = function(player)
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Bestow grants your mana to another person."}
	return level, items, itemAmounts, description
end
}