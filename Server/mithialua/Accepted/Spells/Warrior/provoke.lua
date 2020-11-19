provoke = {
on_learn = function(player)
	if (player:hasSpell("taunt")) then
		player:removeSpell("taunt")
	end
	
	if (player:hasSpell("shout")) then
		player:removeSpell("shout")
	end
	
	player.registry["learned_taunt"] = 1
	player.registry["learned_shout"] = 1
end,

cast = function(player, target)
	local mobBlocks = player:getObjectsInArea(BL_MOB)
	local targets = {}
	local threat = 4000
	local damage = 10
	local distance = 1
	local aether = 10000
	local magicCost = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	player:sendAction(6, 20)
	player:setAether("provoke", aether)
	player:playSound(52)
	player:sendAnimation(363, 0)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Provoke.")
	
	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (distanceSquare(target, mobBlocks[i], distance)) then
				if(mobBlocks[i].protection ~= 1) then
					table.insert(targets, mobBlocks[i])
				end
			end
		end
	end
	
	if (#targets > 0) then
		for i = 1, #targets do
			player:addThreat(targets[i].ID, threat)
			targets[i].attacker = player.ID
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			targets[i]:sendAnimation(326, 0)
		end
	end
end,

requirements = function(player)
	local level = 8
	local items = {}
	local itemAmounts = {}
	local description = {"Forces enemies in an area around a target to attack you."}
	return level, items, itemAmounts, description
end
}