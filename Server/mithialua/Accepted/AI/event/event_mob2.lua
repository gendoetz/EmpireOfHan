event_mob2 = {
after_death = function(mob, attacker, block)
--[[local drop_per = math.random(1, 100)
if (drop_per <= 10) then
	mob:dropItemXY(436, 1, mob.m, mob.x, mob.y, attacker.id)
end
if (drop_per <= 20 and drop_per > 10) then
	mob:dropItemXY(437, 1, mob.m, mob.x, mob.y, attacker.id)
end
if (drop_per <= 30 and drop_per > 20) then
	mob:dropItemXY(438, 1, mob.m, mob.x, mob.y, attacker.id)
end
if (drop_per <= 40 and drop_per > 30) then
	mob:dropItemXY(439, 1, mob.m, mob.x, mob.y, attacker.id)
end]]
end,

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
	mob_ai_basic.attack(mob, target)
end
}