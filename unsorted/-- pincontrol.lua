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