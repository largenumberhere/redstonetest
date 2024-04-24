local open_files = {}

-- quick and dirty way to open a file. Only useful if opening a file for the lifetime of a program. Is relative to working directory
-- returns number
function open_file_write(name)
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

function write_file_line(file_id, str)
	print(file_id)
	local f = open_files[file_id]:write(str, "\n")
end

-- this is an example function to put into waitEvent
function isAKey(event_details) 
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
function waitEvent(fn_is_interrupt, event_name)		
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
function waitForPeripheralEvent(fn_is_interrupt)		
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
function logPeripheralEvents(output_file_path, fn_is_interrupt)	
	local file_id = open_file_write(output_file_path)	-- testlib	
	while true do
		local pin_name = waitForPeripheralEvent(fn_is_interrupt) --testlib
		if pin_name == nil then
			return;
		end
		
		print("new pin ".. pin_name)
		write_file_line(file_id, pin_name)	-- testlib
	end
end

-- call the main function as directed
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


-- catch any errors and print them and then release resources regardless
function bootstrap(function_name)
	pcall(bootstrap2, function_name)
	
	for i,v in pairs(open_files) do
		v:flush()
		v:close()
		print("released file number "..tostring(i))
	end
end


