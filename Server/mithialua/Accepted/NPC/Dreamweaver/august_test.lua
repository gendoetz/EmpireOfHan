august_test = {
click = async(function(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.dialogType = 0
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	--player:addItem("echo_charm", 1, 0, 2, "Echo: Mage")

	--player:addItem("r50q2", 1, 0, 2, "", 1)
	--player:addItem("r50q2", 1, 0, 2, "")
	--player:addItem("r50q2", 1, 0, 2)
	--player:spawn(300, player.x, player.y-1, 1) -- if this is not a code with player in the content, npc:spawn, block:spawn etc. ID of monster is 300 for bard player clone
	--player_cloneCreate.setup(player, player.x, player.y-1) -- ( ) contains the target you want to make a clone of.
	--npc.actionTime = 30000

	--npc:addNPC("testcrash", player.m, player.x, player.y, 5000, 5000)
	Player(50):bankDeposit(274, 1, 0, "", 0)

	player:dialogSeq({t, "Test Functions NPC: "..player.shieldVal}, 1)
	--mob:warp(mob.startM, mob.startX, mob.startY)
end),

action = function(npc)
	--npc:talk(0, "Ritual: "..npc.actionTime)
	--npc:addNPC("frost_SpiritDance", 1001, math.random(4, 11), math.random(9, 10), 4000, 80000)
end,
}

--[[pinyan_rab = {
click = async(function(player, mob)
	local t = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
	player.dialogType = 0
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	--player:addItem("echo_charm", 1, 0, 2, "Echo: Mage")
	--player:spawn(300, player.x, player.y, 1) -- if this is not a code with player in the content, npc:spawn, block:spawn etc. ID of monster is 300 for bard player clone
	--player_cloneCreate.setup(player) -- ( ) contains the target you want to make a clone of.
	--mob:setPermSpawn(mob.mobID, 25, 25, 0)
	player:dialogSeq({t, "Test."..mob.mobID}, 1)
	--mob:warp(mob.startM, mob.startX, mob.startY)
end)	
}--]]

testcrash = {
action = function(npc)
	npc:delete()
end,

endAction = function(npc)
	npc:delete()
end,
}