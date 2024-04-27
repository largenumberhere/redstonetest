local delay_time = 0.05 -- increase this if your computer is slow, it may not be able to handle the requests being fired off this fast

local tick_steps_count = 0

local function assertTickCommandPresent()
	if commands == nil then
		error("The stepTick function requires a command computer. This one doest not appear to be one, because commands is nil")
	end
	
	if commands.tick == nil then
		error("The '/step tick' command is not likely present. Please install carpet-mod to provide this command")
	end
	
	if commands.native == nil then
		error("Missing api function. Perhaps this version of compuercraft/cc:tweaked is not recent enough? This program requires:'commands.native'")
	end
	
	if commands.native.exec == nil then
		error("Missing api function. Perhaps this version of compuercraft/cc:tweaked is not recent enough? This program requires:'commands.native.exec'")
	end
	
end

local function delay()
	os.sleep(delay_time)	-- give the game some time to catch up after a command
end

-- todo: add assertions to all commands made to ensure they can't fail silently

local function stepRedstoneTick()
	-- suprisingly, I have more reliable results when these are called repeatedly instead of passing in a number
	commands.native.exec("/tick step")
	commands.native.exec("/tick step")

	tick_steps_count = tick_steps_count + 2
end


local function unfreezeGame()
	commands.native.exec("/tick freeze off")
	delay()
end

local function stepRedstoneTicks(count)
	assertTickCommandPresent()
	
	assert(type(count) == "number")
	-- commands.native.exec("/tick step "..count)
	
	for i=1, count, 1 do
		stepRedstoneTick()
	end
	
	delay()	-- give world a moment to update
	delay()
end

local function freezeGame()
	assertTickCommandPresent()
	
	commands.native.exec("/tick freeze on")
	delay()
end


local function releaseResources()
	unfreezeGame()
end

local tickcontroller = {
	freezeGame = freezeGame,
	stepRedstoneTicks = stepRedstoneTicks,
	releaseResources = releaseResources
}

return tickcontroller
