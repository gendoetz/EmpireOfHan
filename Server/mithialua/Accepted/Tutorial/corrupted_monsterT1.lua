corrupted_monsterT1 = {	
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob)
	mob_ai_basic.move(mob, target)
end,

attack=function(mob,target)
	mob_ai_basic.attack(mob, target)
end,

after_death = function(mob, player)
local killcount = player.registry["corruption_killcount"]
	if (player.quest["path_choice_quest"] >= 1) then
		killcount = killcount + 1
		player.registry["corruption_killcount"] = killcount
	end
end
}