imperial_training = {

action = function(npc)

	local rand = math.random(15)
	local trainingdummy = npc:getObjectsInCell(npc.m, npc.x - 1, npc.y, BL_NPC)

	npc:sendAction(1, 20)

	if (rand == 1 or rand == 2) then
		if (#trainingdummy > 0) then
			for i = 1, #trainingdummy do
				trainingdummy[i]:sendAnimation(6, 0)
				npc:playSound(87)
			end
		end
		npc:talk(0, "Imperial Soldier: For the empire! *huah*")
		npc.actionTime = math.random(10000, 30000)
	elseif (rand == 3 or rand == 4) then
		if (#trainingdummy > 0) then
			for i = 1, #trainingdummy do
				trainingdummy[i]:sendAnimation(6, 0)
				npc:playSound(87)
			end
		end
		npc:talk(0, "Imperial Soldier: My blood for the empress!")
		npc.actionTime = math.random(10000, 30000)
	end
	npc:playSound(347)
	npc:playSound(353)
end

}
