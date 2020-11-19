gm_playerapproach = {
cast=function(player, target)
	local question=Player(player.question)

	if(question == nil) then
		player:sendMinitext("They are not online.")
	else
		--if (player.region == question.region) then
			player:warp(question.m, question.x, question.y)
		--end
	end
end,

requirements = function(player)
	local level = 28
	local items = {}
	local itemAmounts = {}
	local description = {"Approach brings you to a person that is in the same region as you."}
	return level, items, itemAmounts, description
end
}