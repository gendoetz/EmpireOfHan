red_tower = { 
on_healed = function(mob, healer)
	--mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	
	if (attacker.critChance == 0) then
		return
	end
	if (attacker.armorColor == 65) then
			mob:addHealth(-20)
	else
		attacker:sendMinitext("Are you trying to help the other team?")
	end
end,

move = function(mob,target)

end,

attack=function(mob,target)

end,

on_spawn = function(mob)

end,

after_death = function(mob, player)
		mob:dropItem(71, 1, 0)
end
}
