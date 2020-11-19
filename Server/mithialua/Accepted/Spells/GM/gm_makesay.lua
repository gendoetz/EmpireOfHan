gm_makesay = {
cast = async(function (player)

		if(player.id ~= 2) then
			player:sendMinitext("You don't have the required access.")
			return
		end
	
		local t = {graphic = convertGraphic(654,"monster"),color=15}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local who=player:input("Who shall be affected? (Enter player name)")
		if(Player(who)==nil) then
			player:dialogSeq({t,"They are not online."})
			return
		end
		local makesay=player:input("Say what?")
		Player(who):talk(0,""..Player(who).name..": "..makesay.."")
end),
	
requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Pigify turns a player into a cute little pig where they are less annoying and all the more improved."}
	return level, items, itemAmounts, description
end    
}
