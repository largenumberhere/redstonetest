
-- event utils
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
			filecontrol.writeFileLine(file_id, pin_name)	-- testlib
		end
	end

	local function releaseResources()
	
	end