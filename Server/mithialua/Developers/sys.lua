_errhandler = function(str)
	return debug.traceback(str)
end

async = function(func)
	return function(player, ...)
		local args = { ... }
		_async(player, function()
			func(player, unpack(args))
			_asyncDone(player)
		end)
	end
end

convertGraphic = function(value, class)
	if class == "monster" then
		return 128*256+value
	elseif class == "item" then
		return 192*256+value
	end
	return value
end

getDialog = function(player, dialog)
	if (player.registry["languageSelection"] == 0) then
		return dialogs.english[dialog]
	elseif (player.registry["languageSelection"] == 1) then
		return dialogs.spanish[dialog]
	elseif (player.registry["languageSelection"] == 2) then
		return dialogs.french[dialog]
	elseif (player.registry["languageSelection"] == 3) then
		return dialogs.chinese[dialog]
	elseif (player.registry["languageSelection"] == 4) then
		return dialogs.portuguese[dialog]
	elseif (player.registry["languageSelection"] == 5) then
		return dialogs.indonesian[dialog]
	else
		return dialogs.english[dialog]
	end
end

checkBoard = function(player)
	local del=player.registry["board" .. player.board .. "del"]
	local write=player.registry["board" .. player.board .. "write"]
	player.boardDel=del
	player.boardWrite=write
end

sleep = function(n)
	os.execute("sleep "..tonumber(n))
end

acPerArmor = 127 / 142462

armorPerAC = 142462 / 127

f1Block = NPC(F1_NPC)

smoke = 34

healthMinitext = "You are not healthy enough."

magicMinitext = "Your mind is too weak."

noTargetMinitext = "You strike at nothingness and decide you look silly."

alreadyCastMinitext = "That spell is already cast."

successMinitext = function(spellDescription)
	return "You cast "..spellDescription.."."
end

genericAttacker = Mob(1073743399)

instances = {}

openingSceneUsedMaps = {}

openingSceneQueue = {}

advice = {"Is this your first time visiting the realm? Read the public boards for helpful advice! ",
"Your legend is the history of your character, it marks all of your accomplishments in the realm.",
"Press 'F1' if you seek additional assistance.",
"You may visit a Spirit Healer to return to life should you find yourself without legs.",
"Be courteous and mindful of those around you, obey the laws of the land.",
"Seek assistance from fellow adventurers and form friendships!",
"There is greater knowledge to be obtained, seek out a path master when you are stronger.",
"Exploring and trying new things will benefit you in these lands.",
"Found a bug/error? Press 'b' to open the boards and report the issue!"}


getCurSeason = function()
	local season = curSeason()

	if (season == 1) then
		return "Winter"
	elseif (season == 2) then
		return "Spring"
	elseif (season == 3) then
		return "Summer"
	else
		return "Fall"
	end
end

minL = function(amount, limit)
	if (amount < limit) then
		return limit
	else
		return amount
	end
end

maxL = function(amount, limit)
	if (amount > limit) then
		return limit
	else
		return amount
	end
end

secondsToClock = function(totalSeconds)
	local hours, minutes, seconds
	
	if totalSeconds == 0 then
		return "00:00:00"
	else
		hours = string.format("%02.f", math.floor(totalSeconds / 3600))
		minutes = string.format("%02.f", math.floor(totalSeconds / 60 - (hours * 60)))
		seconds = string.format("%02.f", math.floor(totalSeconds - hours * 3600 - minutes * 60))
		return hours..":"..minutes..":"..seconds
	end
end
