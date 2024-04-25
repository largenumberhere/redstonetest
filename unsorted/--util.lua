-- functions which are fairly short, rely on no state and have no side-effects (exc. system calls) and don't resemble classes

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
	
	