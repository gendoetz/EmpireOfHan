simple_axe = {
on_hit = function(player, target)
	if (target and target.blType == BL_MOB and target.mobID == 7) then
		player:flushDuration(1)
	end
end
}