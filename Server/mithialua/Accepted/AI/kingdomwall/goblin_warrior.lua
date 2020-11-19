goblin_warrior = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	mob_ai_basic.attack(mob, target)
	mob:flank()
end
}