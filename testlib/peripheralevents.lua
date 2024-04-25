local writefile = require("testlib/writefile")


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
	local file_handle = writefile.openFileWrite(output_file_path)	-- testlib	
	while true do
		local pin_name = waitForPeripheralEvent(fn_is_interrupt)
		if pin_name == nil then
			return;
		end
		
		print("new pin ".. pin_name)
		writefile.writeFileLine(file_handle, pin_name)
	end
	
	writefile.closeFile(file_handle)
end


local peripheralevents = {
	logPeripheralEvents = logPeripheralEvents
}
return peripheralevents