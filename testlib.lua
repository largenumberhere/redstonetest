local open_files = {}
local tick_frozen = false
local tick_steps_count = 0

-- file utils
	-- quick and dirty way to open a file. Only useful if opening a file for the lifetime of a program. Is relative to working directory
	-- returns number
	local function openFileWrite(name)
	-- function open_file_write(name)
		assert(type(name)=="string")

		local name_s = shell.resolve(name)
		local file_handle = io.open(name_s, "w")
		if file_handle == nil then 
			error("Failed to open file '"..name_s.."'")
		end
			
		table.insert(open_files, file_handle)
		
		local file_id = table.maxn(open_files)
		
		return file_id -- integer
	end

	local function write_file_line(file_id, str)
		print(file_id)
		local f = open_files[file_id]:write(str, "\n")
	end

-- event utils
	-- this is an example function to put into waitEvent
	local function isAKey(event_details) 
		local event_name = event_details[1]
		
		if event_name == "key_up" then
			local key_id = event_details[2]
			if key_id == 65 then -- A key on US-keyboard
				return true
			end
		end
		
		return false
	end

	-- wait for the specified event, or until the function fn_is_interrupt returns true 
	-- fn_is_interrupt is a function which takes a table with all the event details
	local function waitEvent(fn_is_interrupt, event_name)		
		while true do
			local event = {os.pullEvent()}
			local event_name_given = event[1]

			if event_name_given == event_name then
				return event
			elseif fn_is_interrupt(event) == true then
				return nil
			else
				-- nothing we care about happened, wait a bit
				os.sleep(0.05)
			end
		end
	end

	-- wait for a peripheral event (occours when a peripheral is connected to a connected wired network)
	-- fn_is_interrupt is a function which takes a table with event details
	local function waitForPeripheralEvent(fn_is_interrupt)		
		local event =  waitEvent(fn_is_interrupt, "peripheral")
		if event == nil then
			return nil
		else
			local peripheral_name = event[2]
			return peripheral_name
		end
		
		-- print("pin: "..tostring(pin))
		return pin
	end

	-- fn_is_interrupt is a function which takes a table with event details
	-- logs the name of each peripheral that is connected to the given file
	local function logPeripheralEvents(output_file_path, fn_is_interrupt)	
		local file_id = openFileWrite(output_file_path)	-- testlib	
		while true do
			local pin_name = waitForPeripheralEvent(fn_is_interrupt) --testlib
			if pin_name == nil then
				return;
			end
			
			print("new pin ".. pin_name)
			write_file_line(file_id, pin_name)	-- testlib
		end
	end

-- program resource-safety	
	-- call the function and log any errors it has
	local function bootstrap2(function_name)
		local results = {pcall(function_name)}
		if results ~= nil then
			if #results > 1 then
				for i,v in pairs(results) do
					print(v)
				end
			end
		end
		
	end

	-- release all resources handled by this library
	local function cleanup()
		-- release file handles
		for i,v in pairs(open_files) do
			v:flush()
			v:close()
			-- print("released file number "..tostring(i))
		end
		
		-- make sure the game is not frozen
		if tick_frozen == true then
			unfreezeTicks()
		end
	end
	
	-- call the function, logging all errors and then always releases files from open_file_write. You don't need to call cleanup after this
	-- warning: this changes the program context - for example, you will need to import testlib again inside your main function
	local function bootstrap(function_name)
		-- run the program
		pcall(bootstrap2, function_name)
		cleanup()
	end
	

-- world commands
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

-- peripheral utils
	--unteseted
	local function loadPeripheralsFromFile(filePath)
		local name_s = shell.resolve(name)
		local file_handle = io.open(name_s, "r")
		
		local lns = file_handle:lines()
		local peripherals = {}
		
		for i,line in lns do
			local per = peripheral.wrap(line)
			if per == nil then
				error("failed to load peripherals from file on line", i)
			end

			table.insert(peripherals, per)
		end
		
		return peripherals
	end
	
	local function newPin(peripheral_handle, pin_number, pin_purpose, peripheral_name, pending_state)
		--TODO
	
	end
	
	-- returns array with each item being:
	-- TODO: make this table into a non-hideos-mess
	--	{peripheral:table, pin_number:number, pin_purpose:"input"|"output", per_name:string, pending_state:0|1|2|3|4}
	-- pending_state 0 - is an output-pin, does not require updating ever
	-- pending_state 1 - no updates to push
	-- pending_state 2 - in default state (has not been initialized, value is undefined)
	-- pending_state 3 - requires seting to HIGH
	-- pending_state 4 - requires seting to LOW
	local function loadPinsFromFile(filePath, inputOrOutput) 
		local input = "input"
		local output = "output"
		if inputOrOutput ~= input and inputOrOutput ~= output then
			error("inputOrOutput must be a string with the value 'input' or 'output'")
		end
		

		local peripherals = loadPeripheralsFromFile(filePath)
		local out = {}
		for i, per in  pairs(peripherals) do
			local redstone_integrator = {}
			redstone_integrator.peripheral = per
			redstone_integrator.pin_number = i
			redstone_integrator.pin_purpose = inputOrOutput
			redstone_integrator.per_name = peripheral.getName(per)
			if redstone_integrator.pin_purpose == "input" then
				redstone_integrator.pending_state = "default"
			end
			
			if peripheral.getType(redstone_integrator.name) ~= "redstone_integrator" then
				error("a non-redstone_integrator was found in the pins file")
			end
			
			table.insert(out, redstone_integrator)
		end
	end
	
	local function logOutputPinsState(filePath, pins)
		
		for i,v in pairs(pins) do
			
		end
	end
	
	local function logInputPinsState(filePath, pins)
		local file = open_file_write(filePath)
		
		for i,redstone_integrator in pairs(pins) do
			-- TODO: work out how to store pins first
			-- local per = redstone_integrator.per
			-- local pin_number = redstone_integrator.pin_number
			-- local pin_purpose = redstone_integrator.pin_purpose
			-- local per_name = redstone_integrator.per_name
			-- local state = "none"
			-- if redstone_integrator.pin_purpose == "input" then
				-- state = redstone_integrator.pending_state
			-- end
			
			-- if state == "none" then
				-- error("input pin without pending state")
			-- end
			
			
		end
	end
	
	local function assertOutputPinState(pins, pin_number) 
	
	end
	
	local function queueInputPinState()
		
	end
	
	local function pushInputPinState()
	
	end
	
	

-- uncategorized
	local function delay()
		os.sleep(0.05)
	end
	
	
-- api housekeeping
	local testlib = {
		openFileWrite = openFileWrite,
		-- write_file_line = write_file_line,
		isAKey = isAKey,
		-- waitEvent = waitEvent,
		-- waitForPeripheralEvent = waitForPeripheralEvent,
		logPeripheralEvents = logPeripheralEvents,
		bootstrap = bootstrap,
		cleanup = cleanup,
		-- stepTick = stepTick,
		-- stepRedstoneTick = stepRedstoneTick,
		-- stepRedstoneTicks = stepRedstoneTicks,
		-- freezeTicks = freezeTicks,
		-- unfreezeTicks = unfreezeTicks,
		-- loadPeripheralsFromFile = loadPeripheralsFromFile
		
	}
	
return testlib