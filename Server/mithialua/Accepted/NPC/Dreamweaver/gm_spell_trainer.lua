gm_spell_trainer = {
click = async(function(player, npc)
	local t = {graphic = convertGraphic(61, "monster"), color = 20}
	local menuOptions = {}
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	
	if (player.gmLevel >= 20) then
		table.insert(menuOptions, "Learn Spell")
	end

	
	table.insert(menuOptions, "Forget Spell")

	local choice = player:menuString("How may I assist you "..player.name.."?", menuOptions)
	if (choice == "Learn Spell") then
		player:learnSpell(t)
	elseif (choice == "Forget Spell") then
		player:forgetSpell(t)	
	end
	player:calcStat()
end),
}