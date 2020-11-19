conjure_mana = {
cast = function(player)
	local aether = 25000
	local duration = 20000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasDuration("conjure_mana")) then
		player:sendMinitext("That spell is already in effect.")
		return
	end
	
	player:sendAction(6, 20)
	--player:setAether("regenerate", aether)
	player:setDuration("conjure_mana", duration)
	player:setAether("conjure_mana", aether)
	player:playSound(111)
	player:sendAnimation(133, 0)
	player:sendStatus()
	player:sendMinitext("Your mana begins to regenerate.")
end,

while_cast = function(player)
	local manavalue = (player.maxMagic / 20)

	player.magic = player.magic + manavalue
	player:sendStatus()
	--player:addMagic(manavalue)
	--player:sendMinitext("test")
end,

uncast = function(player)
	player:sendAnimation(133, 0)
	player:sendMinitext("Your mana stops regenerating.")
end,

requirements = function(player)
	local level = 18
	local items = {}
	local itemAmounts = {}
	local description = {"Conjure Mana slowly returns mana to you over time.  To learn this spell you must sacrifice (5) Rough Kyanite (10) Crystaline Fox Hide and (1) Stone Doll Husk."}
	return level, items, itemAmounts, description
end
}