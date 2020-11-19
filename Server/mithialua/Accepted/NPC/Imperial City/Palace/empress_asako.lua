empress_asako = {
click = async(function(player, npc)
	local empress = {graphic = 0, color = 0}

	player.npcGraphic = empress.graphic
	player.npcColor = empress.color
	player.dialogType = 1
	
	--Player(6).shieldVal = 10
	--toXYdirect(player, 11, 10)

	player:dialogSeq({empress, "*You hear a beautiful voice humming a tune from the balcony above, the Empress doesn't even notice that you are here.*"}, 1)
	
end),

action = function(npc)
empress_asako.move(npc)
end,

move = function(npc)

	local oldside = npc.side
	local checkmove = math.random(0,10)

	if ((npc.x - npc.startX) >= 5) then
		npc.side=3
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.x - npc.startX) <= -5) then
		npc.side=1
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.y - npc.startY) >= 5) then
		npc.side=0
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.y - npc.startY) <= -5) then
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