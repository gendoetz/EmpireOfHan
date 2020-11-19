mummy_pl = {
on_spawn = function(mob)
	mob.side = math.random(0, 3)
	mob:sendSide()
end,

on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

after_death = function(mob, attacker, block)
	mob:sendAnimationXY(149,mob.x,mob.y,1)
end,

on_attacked = function(mob,attacker)
	mob_ai_basic.on_attacked(mob, healer)
end,
	
move = function(mob,target)
	mob_ai_basic.move(mob, healer)
end,

attack=function(mob,target)
	mob_ai_basic.attack(mob, healer)
end
}
