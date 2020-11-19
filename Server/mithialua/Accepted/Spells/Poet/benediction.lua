benediction = {
cast = function(player, target)
	local aether = 12000
	local heal = (player.maxMagic * 1.35)
	local magicCost = (player.maxMagic * .19)
	
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
	
	player:sendAction(6, 20)
	player:setAether("benediction", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Benediction.")
	player:playSound(101)
	target:sendAnimation(64, 0)
	--target:sendAnimation(166, 0)
	target.attacker = player.ID
	target:addHealthExtend(heal, 0, 0, 0, 0, 0)
	target:sendMinitext(player.name.." casts Benediction on you.")
end,

requirements = function(player)
	local level = 99
	local items = {}
	local itemAmounts = {}
	local description = {"Benediction is a powerful healing spell that allows you to heal others for a percentage of your mana."}
	return level, items, itemAmounts, description
end
}