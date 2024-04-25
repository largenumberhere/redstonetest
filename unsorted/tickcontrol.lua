local tick_frozen = false
local tick_steps_count = 0

-- utilities related to controlling game tick rates
	local function delay()
		os.sleep(0.05)
	end
	

	local function stepTick()
		if commands == nil then
			error("the stepTick function requires a command computer. This one doest not appear to be one, because commands is nil")
		end
		
		if commands.tick == nil then
			error("the '/step tick' command is not likely present. Please install carpet-mod to provide this command")
		end
		
		commands.native.exec("/tick step")		
		delay()	-- give game a moment to update
		
		tick_steps_count = tick_steps_count + 1
	end

	
	local function stepRedstoneTick()
		if commands == nil then
			error("the stepTick function requires a command computer. This one doest not appear to be one, because commands is nil")
		end
		
		if commands.tick == nil then
			error("the '/step tick' command is not likely present. Please install carpet-mod to provide this command")
		end
		
		commands.native.exec("/tick step")		
		commands.native.exec("/tick step")		
		delay()	-- give world a moment to update
		delay()
		tick_steps_count = tick_steps_count + 2
	end
	
	local function stepRedstoneTicks(count)
		if commands == nil then
			error("the stepTick function requires a command computer. This one doest not appear to be one, because commands is nil")
		end
		
		if commands.tick == nil then
			error("the '/step tick' command is not likely present. Please install carpet-mod to provide this command")
		end
		
		for i=1, count, 1 do
			commands.native.exec("/tick step")		
			commands.native.exec("/tick step")					
		end
		
		delay()	-- give game a moment to update
		delay()		
		
		tick_steps_count = tick_steps_count + (count*2)
	end

	
	local function freezeTicks()
		if commands == nil then
			error("the stepTick function requires a command computer. This one doest not appear to be one, because commands is nil")
		end
		
		if commands.tick == nil then
			error("the '/step tick' command is not likely present. Please install carpet-mod to provide this command")
		end
		
		commands.native.exec("/tick freeze on")
		tick_frozen = true
		delay()	-- give game a moment to update
	end
	
	local function unfreezeTicks()
		if commands == nil then
			error("the stepTick function requires a command computer. This one doest not appear to be one, because commands is nil")
		end
		
		if commands.tick == nil then
			error("the '/step tick' command is not likely present. Please install carpet-mod to provide this command")
		end
		
		commands.native.exec("/tick freeze off")
		tick_frozen = false
		delay()	-- give game a moment to update
	end

	local function releaseResources()
		-- make sure the game is not frozen
		if tick_frozen == true then
			unfreezeTicks()
		end
	end