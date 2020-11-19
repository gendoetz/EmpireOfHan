great_protector_ent = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local spirit = {graphic = convertGraphic(654,"monster"),color=15}
	local rabbit = {graphic = convertGraphic(21, "monster"), color = 28}
	local opts = {"The Druid Subpath", "Nothing"}
	local optsjoin = {"Join the Druid Subpath", "I need to think some more..."}

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	player:dialogSeq({t,"Intentions... noble?"}, 1)

	--[[if(player.registry["join_Druid"] == 1 and player.class == 4) then
		player:dialogSeq({t,"Poet, heal.. heal friend. Heal tree. Poet friend."}, 1)

		local menuOption=player:menuString("Poet join Druid?",opts)
		if(menuOption=="The Druid Subpath") then
		player:dialogSeq({spirit, "Hello young one! You have become quite strong while adventuring in these lands and it seems that you are ready to decide your fate.",
				spirit, "The Poet path branches into seperate subpaths, the decision before you is one that cannot be undone. Once you have accepted your fate it is final so please consider carefully.",
				spirit, "You have helped to heal the Elder Spirit Tree and the spirits of the forest have taken note of this deed, it is not often that the great Ents of the forest speak to strangers.  The Ents consider the Druids their kin.",
				spirit, "Druids are a path that communes with the forest spirits and strives to protect them drawing their power from nature and using it to support their allies and to vanquish those that would do them or those they protect harm.",
				spirit, "If you know that the Druid path is the one that resides within your heart my friend The Ancient Oak Ent will help you."}, 1)
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				local menuOption2=player:menuString("Poet join Druid?",optsjoin)
				if(menuOption2=="Join the Druid Subpath") then
					player.class=12
					player.registry["join_Druid"] = 0
					player:dialogSeq({t,"Family now.. heal tree more.. tree open way to home."}, 1)
				elseif(menuOption2=="I need to think some more...") then
					player:dialogSeq({t,"*The Ancient Oak Ent nods firmly*"}, 1)
				end
		end
	end]]
end),

action = function(npc)
if(npc.mapRegistry["druidentrance"] >= 1) then
	npc:sendAnimationXY(2, 54, 101, 2)
	npc:sendAnimationXY(2, 55, 101, 2)
end
great_protector_ent.move(npc)
end,

portalwarpcheck = function(player, npc)
if(player.mapRegistry["druidentrance"] >= 1 and player.class==12) then
	player:warp(2012, 9, 18)
end
end,

move = function(npc)
	--local found
	--local moved=true
	local oldside = npc.side
	local checkmove = math.random(0,10)

	--if (math.abs(npc.x - npc.startX) >= 2 or math.abs(npc.y - npc.startY) >= 2) then
	--	npc:warp(npc.startM, npc.startX, npc.startY)
	--end

	if ((npc.x - npc.startX) >= 2) then
		npc.side=3
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.x - npc.startX) <= -2) then
		npc.side=1
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.y - npc.startY) >= 2) then
		npc.side=0
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.y - npc.startY) <= -2) then
		npc.side=2
		npc:sendSide()
		npc:move()
		return
	end

	if(checkmove >= 4) then
		npc.side=math.random(0,3)
		npc:sendSide()
		if(npc.side == oldside) then
			npc:move()
		end
	else
		npc:move()
	end
end,
}