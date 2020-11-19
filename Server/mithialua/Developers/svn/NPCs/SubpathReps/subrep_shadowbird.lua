subrep_shadowbird = {
click = async(function(player, npc)
	local npcA = {graphic = convertGraphic(961, "monster"), color = 0}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 0

	if (npc.registry["cooldown"] >= 1) then
		player:dialogSeq({npcA, "The bird seems calm."}, 1)
	else
		player:dialogSeq({npcA, "The bird flaps its wings about frantically."}, 1)
	end
end),

action = function(npc)
	if (npc.registry["cooldown"] == 2) then
		npc:talk(2, "The bird settles down.")
		npc.registry["cooldown"] = 1
		npc.side = 2
		npc:sendSide()
		npc.actionTime = 30000

	elseif (npc.registry["cooldown"] == 1) then
		npc:talk(2, "The bird snaps back into a frenzy.")
		npc.registry["cooldown"] = 0
		npc.actionTime = 250

	elseif (npc.registry["cooldown"] == 0) then
		local target = getTargetFacing(npc, BL_PC)	
		if (target == nil) then
			subrep_shadowbird.move(npc)	
		end	
		if (target.state == 0) then
			if(npc.side==0) then
			local checkplayernorth=npc:getObjectsInCell(npc.m,npc.x,npc.y-2,BL_PC)
			local checkmobnorth=npc:getObjectsInCell(npc.m,npc.x,npc.y-2,BL_MOB)
			local checknpcnorth=npc:getObjectsInCell(npc.m,npc.x,npc.y-2,BL_NPC)
			local checkplayereast=npc:getObjectsInCell(npc.m,npc.x+1,npc.y-1,BL_PC)
			local checkmobeast=npc:getObjectsInCell(npc.m,npc.x+1,npc.y-1,BL_MOB)
			local checknpceast=npc:getObjectsInCell(npc.m,npc.x+1,npc.y-1,BL_NPC)
			local checkplayerwest=npc:getObjectsInCell(npc.m,npc.x-1,npc.y-1,BL_PC)
			local checkmobwest=npc:getObjectsInCell(npc.m,npc.x-1,npc.y-1,BL_MOB)
			local checknpcwest=npc:getObjectsInCell(npc.m,npc.x-1,npc.y-1,BL_NPC)
			if(#checkplayernorth+#checkmobnorth+#checknpcnorth==0 and npc:objectCanMove(npc.x,npc.y-2,0)==true and getPass(npc.m,npc.x,npc.y-2)==0) then
				target:warp(npc.m,npc.x,npc.y-2)
				target:sendAnimation(10)
			elseif(#checkplayereast+#checkmobeast+#checknpceast==0 and npc:objectCanMove(npc.x+1,npc.y-1,1)==true and getPass(npc.m,npc.x+1,npc.y-1)==0) then
				target:warp(npc.m,npc.x+1,npc.y-1)
				target:sendAnimation(10)
			elseif(#checkplayerwest+#checkmobwest+#checknpcwest==0 and npc:objectCanMove(npc.x-1,npc.y-1,3)==true and getPass(npc.m,npc.x-1,npc.y-1)==0) then
				target:warp(npc.m,npc.x-1,npc.y-1)
				target:sendAnimation(10)
			else
				target:sendAnimation(10)
				return
			end
			--Facing East
			elseif(npc.side==1) then
			local checkplayereast=npc:getObjectsInCell(npc.m,npc.x+2,npc.y,BL_PC)
			local checkmobeast=npc:getObjectsInCell(npc.m,npc.x+2,npc.y,BL_MOB)
			local checknpceast=npc:getObjectsInCell(npc.m,npc.x+2,npc.y,BL_NPC)
			local checkplayernorth=npc:getObjectsInCell(npc.m,npc.x+1,npc.y-1,BL_PC)
			local checkmobnorth=npc:getObjectsInCell(npc.m,npc.x+1,npc.y-1,BL_MOB)
			local checknpcnorth=npc:getObjectsInCell(npc.m,npc.x+1,npc.y-1,BL_NPC)
			local checkplayersouth=npc:getObjectsInCell(npc.m,npc.x+1,npc.y+1,BL_PC)
			local checkmobsouth=npc:getObjectsInCell(npc.m,npc.x+1,npc.y+1,BL_MOB)
			local checknpcsouth=npc:getObjectsInCell(npc.m,npc.x+1,npc.y+1,BL_NPC)
			if(#checkplayereast+#checkmobeast+#checknpceast==0 and npc:objectCanMove(npc.x+2,npc.y,1)==true and getPass(npc.m,npc.x+2,npc.y)==0) then
				target:warp(npc.m,npc.x+2,npc.y)
				target:sendAnimation(10)
			elseif(#checkplayernorth+#checkmobnorth+#checknpcnorth==0 and npc:objectCanMove(npc.x+1,npc.y-1,0)==true and getPass(npc.m,npc.x+1,npc.y-1)==0) then
				target:warp(npc.m,npc.x+1,npc.y-1)
				target:sendAnimation(10)
			elseif(#checkplayersouth+#checkmobsouth+#checknpcsouth==0 and npc:objectCanMove(npc.x+1,npc.y+1,2)==true and npc:objectCanMove(npc.x+1,npc.y,0)==true and getPass(npc.m,npc.x+1,npc.y+1)==0) then
				target:warp(npc.m,npc.x+1,npc.y+1)
				target:sendAnimation(10)
			else
				target:sendAnimation(10)
				return
			end
			--Facing South
			elseif(npc.side==2) then
			local checkplayersouth=npc:getObjectsInCell(npc.m,npc.x,npc.y+2,BL_PC)
			local checkmobsouth=npc:getObjectsInCell(npc.m,npc.x,npc.y+2,BL_MOB)
			local checknpcsouth=npc:getObjectsInCell(npc.m,npc.x,npc.y+2,BL_NPC)
			local checkplayereast=npc:getObjectsInCell(npc.m,npc.x+1,npc.y+1,BL_PC)
			local checkmobeast=npc:getObjectsInCell(npc.m,npc.x+1,npc.y+1,BL_MOB)
			local checknpceast=npc:getObjectsInCell(npc.m,npc.x+1,npc.y+1,BL_NPC)
			local checkplayerwest=npc:getObjectsInCell(npc.m,npc.x-1,npc.y+1,BL_PC)
			local checkmobwest=npc:getObjectsInCell(npc.m,npc.x-1,npc.y+1,BL_MOB)
			local checknpcwest=npc:getObjectsInCell(npc.m,npc.x-1,npc.y+1,BL_NPC)
			if(#checkplayersouth+#checkmobsouth+#checknpcsouth==0 and npc:objectCanMove(npc.x,npc.y+2,2)==true and npc:objectCanMove(npc.x,npc.y+1,0)==true and getPass(npc.m,npc.x,npc.y+2)==0) then
				target:warp(npc.m,npc.x,npc.y+2)
				target:sendAnimation(10)
			elseif(#checkplayereast+#checkmobeast+#checknpceast==0 and npc:objectCanMove(npc.x+1,npc.y+1,1)==true and getPass(npc.m,npc.x+1,npc.y+1)==0) then
				target:warp(npc.m,npc.x+1,npc.y+1)
				target:sendAnimation(10)
			elseif(#checkplayerwest+#checkmobwest+#checknpcwest==0 and npc:objectCanMove(npc.x-1,npc.y+1,3)==true and getPass(npc.m,npc.x-1,npc.y+1)==0) then
				target:warp(npc.m,npc.x-1,npc.y+1)
				target:sendAnimation(10)
			else
				target:sendAnimation(10)
				return
			end
			--Facing West
			elseif(npc.side==3) then
			local checkplayerwest=npc:getObjectsInCell(npc.m,npc.x-2,npc.y,BL_PC)
			local checkmobwest=npc:getObjectsInCell(npc.m,npc.x-2,npc.y,BL_MOB)
			local checknpcwest=npc:getObjectsInCell(npc.m,npc.x-2,npc.y,BL_NPC)
			local checkplayernorth=npc:getObjectsInCell(npc.m,npc.x-1,npc.y-1,BL_PC)
			local checkmobnorth=npc:getObjectsInCell(npc.m,npc.x-1,npc.y-1,BL_MOB)
			local checknpcnorth=npc:getObjectsInCell(npc.m,npc.x-1,npc.y-1,BL_NPC)
			local checkplayersouth=npc:getObjectsInCell(npc.m,npc.x-1,npc.y+1,BL_PC)
			local checkmobsouth=npc:getObjectsInCell(npc.m,npc.x-1,npc.y+1,BL_MOB)
			local checknpcsouth=npc:getObjectsInCell(npc.m,npc.x-1,npc.y+1,BL_NPC)
			if(#checkplayerwest+#checkmobwest+#checknpcwest==0 and npc:objectCanMove(npc.x-2,npc.y,3)==true and getPass(npc.m,npc.x-2,npc.y)==0) then
				target:warp(npc.m,npc.x-2,npc.y)
				target:sendAnimation(10)
			elseif(#checkplayernorth+#checkmobnorth+#checknpcnorth==0 and npc:objectCanMove(npc.x-1,npc.y-1,0)==true and getPass(npc.m,npc.x-1,npc.y-1)==0) then
				target:warp(npc.m,npc.x-1,npc.y-1)
				target:sendAnimation(10)
			elseif(#checkplayersouth+#checkmobsouth+#checknpcsouth==0 and npc:objectCanMove(npc.x-1,npc.y+1,2)==true and npc:objectCanMove(npc.x-1,npc.y,0)==true and getPass(npc.m,npc.x-1,npc.y+1)==0) then
				target:warp(npc.m,npc.x-1,npc.y+1)
				target:sendAnimation(10)
			else
				target:sendAnimation(10)
				return
			end
			end
			target:sendMinitext("The Bird is startled by you, screeching, causing you to fly back.")
			npc:talk(2, "Chirp!")
		end
		subrep_shadowbird.move(npc)
	end
end,

move = function(npc)
	local oldside = npc.side
		npc.side=math.random(0,3)
		npc:sendSide()
	if(npc.side == oldside) then
		subrep_shadowbird.move(npc)
	end
end,

}