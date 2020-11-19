magma_beast = {
on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
	setTile(mob.m,mob.x,mob.y,2400)
		setTile(mob.m,mob.x+1,mob.y,2400)
		setTile(mob.m,mob.x+2,mob.y,1089)
		setTile(mob.m,mob.x+3,mob.y,1097)
		setTile(mob.m,mob.x+4,mob.y,43)

		setTile(mob.m,mob.x-1,mob.y,2400)
		setTile(mob.m,mob.x-2,mob.y,1091)
		setTile(mob.m,mob.x-3,mob.y,1098)
		setTile(mob.m,mob.x-4,mob.y,43)

	setTile(mob.m,mob.x,mob.y+1,1090)
		setTile(mob.m,mob.x+1,mob.y+1,1090)
		setTile(mob.m,mob.x+2,mob.y+1,1097)
		setTile(mob.m,mob.x+3,mob.y+1,43)

		setTile(mob.m,mob.x-1,mob.y+1,1090)
		setTile(mob.m,mob.x-2,mob.y+1,1098)
		setTile(mob.m,mob.x-3,mob.y+1,43)

	setTile(mob.m,mob.x,mob.y+2,43)
		setTile(mob.m,mob.x+1,mob.y+2,43)
		setTile(mob.m,mob.x+2,mob.y+2,43)

		setTile(mob.m,mob.x-1,mob.y+2,43)
		setTile(mob.m,mob.x-2,mob.y+2,43)

		--Center and towards upper lavapit
	setTile(mob.m,mob.x,mob.y-1,2400)
		setTile(mob.m,mob.x+1,mob.y-1,2400)
		setTile(mob.m,mob.x+2,mob.y-1,1094)
		setTile(mob.m,mob.x+3,mob.y-1,1099)
		setTile(mob.m,mob.x+4,mob.y-1,43)

		setTile(mob.m,mob.x-1,mob.y-1,2400)
		setTile(mob.m,mob.x-2,mob.y-1,1096)
		setTile(mob.m,mob.x-3,mob.y-1,1100)
		setTile(mob.m,mob.x-4,mob.y-1,43)

	setTile(mob.m,mob.x,mob.y-2,1095)
		setTile(mob.m,mob.x+1,mob.y-2,1095)
		setTile(mob.m,mob.x+2,mob.y-2,1099)
		setTile(mob.m,mob.x+3,mob.y-2,43)

		setTile(mob.m,mob.x-1,mob.y-2,1095)
		setTile(mob.m,mob.x-2,mob.y-2,1100)
		setTile(mob.m,mob.x-3,mob.y-2,43)

	setTile(mob.m,mob.x,mob.y-3,43)
		setTile(mob.m,mob.x+1,mob.y-3,43)
		setTile(mob.m,mob.x+2,mob.y-3,43)

		setTile(mob.m,mob.x-1,mob.y-3,43)
		setTile(mob.m,mob.x-2,mob.y-3,43)
end,

on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)

	mob_ai_basic.move(mob, target)

	setTile(mob.m,mob.x,mob.y,2400)
		setTile(mob.m,mob.x+1,mob.y,2400)
		setTile(mob.m,mob.x+2,mob.y,1089)
		setTile(mob.m,mob.x+3,mob.y,1097)
		setTile(mob.m,mob.x+4,mob.y,43)

		setTile(mob.m,mob.x-1,mob.y,2400)
		setTile(mob.m,mob.x-2,mob.y,1091)
		setTile(mob.m,mob.x-3,mob.y,1098)
		setTile(mob.m,mob.x-4,mob.y,43)

	setTile(mob.m,mob.x,mob.y+1,1090)
		setTile(mob.m,mob.x+1,mob.y+1,1090)
		setTile(mob.m,mob.x+2,mob.y+1,1097)
		setTile(mob.m,mob.x+3,mob.y+1,43)

		setTile(mob.m,mob.x-1,mob.y+1,1090)
		setTile(mob.m,mob.x-2,mob.y+1,1098)
		setTile(mob.m,mob.x-3,mob.y+1,43)

	setTile(mob.m,mob.x,mob.y+2,43)
		setTile(mob.m,mob.x+1,mob.y+2,43)
		setTile(mob.m,mob.x+2,mob.y+2,43)

		setTile(mob.m,mob.x-1,mob.y+2,43)
		setTile(mob.m,mob.x-2,mob.y+2,43)

		--Center and towards upper lavapit
	setTile(mob.m,mob.x,mob.y-1,2400)
		setTile(mob.m,mob.x+1,mob.y-1,2400)
		setTile(mob.m,mob.x+2,mob.y-1,1094)
		setTile(mob.m,mob.x+3,mob.y-1,1099)
		setTile(mob.m,mob.x+4,mob.y-1,43)

		setTile(mob.m,mob.x-1,mob.y-1,2400)
		setTile(mob.m,mob.x-2,mob.y-1,1096)
		setTile(mob.m,mob.x-3,mob.y-1,1100)
		setTile(mob.m,mob.x-4,mob.y-1,43)

	setTile(mob.m,mob.x,mob.y-2,1095)
		setTile(mob.m,mob.x+1,mob.y-2,1095)
		setTile(mob.m,mob.x+2,mob.y-2,1099)
		setTile(mob.m,mob.x+3,mob.y-2,43)

		setTile(mob.m,mob.x-1,mob.y-2,1095)
		setTile(mob.m,mob.x-2,mob.y-2,1100)
		setTile(mob.m,mob.x-3,mob.y-2,43)

	setTile(mob.m,mob.x,mob.y-3,43)
		setTile(mob.m,mob.x+1,mob.y-3,43)
		setTile(mob.m,mob.x+2,mob.y-3,43)

		setTile(mob.m,mob.x-1,mob.y-3,43)
		setTile(mob.m,mob.x-2,mob.y-3,43)
end,

attack = function(mob, target)
	mob_ai_basic.attack(mob, target)
end
}