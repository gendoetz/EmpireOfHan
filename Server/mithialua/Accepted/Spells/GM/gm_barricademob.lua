gm_barricademob = { 
on_healed = function(mob, healer)
	--mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
--attacker:sendMinitext("Are you trying to help the other team?")
end,

move = function(mob,target)

end,

attack=function(mob,target)

end,

on_spawn = function(mob)

end,

after_death = function(mob, player)
mob:delete()
end
}
