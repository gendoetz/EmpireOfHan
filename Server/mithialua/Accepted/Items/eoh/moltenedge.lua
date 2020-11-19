moltenedge = { 
equip = function(player)
	if (player:canLearnSpell("moltenedge")) then
		player:addSpell("moltenedge")
	end
end,

unequip = function(player)
	if (player:hasSpell("moltenedge")) then
		player:removeSpell(6043)
	end
end,

on_break = function(player)
	if (player:hasSpell("moltenedge")) then
		player:removeSpell(6043)
	end
end,

cast = function(player, target)

	local mcost = 50
	
	if (player.state == 1) then
		player:sendMinitext("Spirits can't do that.")
		return
	end	
	
	if (player.state == 3) then
		player:sendMinitext("You can not cast this spell on a mount.")
		return
	end	
	
	if (target.state == 1) then
		player:sendMinitext("Your target is already dead.")
		return
	end
	if (target.blType == BL_PC) then
		if (target.pvp == 0) then
			player:sendMinitext("Something went wrong.")
			return
		end
	end
	if (player.magic < mcost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:getEquippedDura(168) > 0) then
		player:deductDura(0, 100)
		player:removeMagic(mcost)
	else
		player:sendMinitext("You can not cast this now.")
		return
	end
	
	player:playSound(370)
	player:sendAction(1, 30)
	target:sendAnimation(8)
	player:setAether("moltenedge", 10000)
	local amt = 1250
	target.attacker = player.ID
	target:removeHealthExtend(amt, 1, 1, 0, 1, 0)
end

}