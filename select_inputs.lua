function main()
	print("connect all wired modems for circuit inputs in order")
	print("press 'a' ket to exit")

	local file_name = "inputs.txt"

	logPeripheralEvents(file_name, isAKey)

	print("Saved as '"..file_name.."', please rename it to keep it.")
	print("Exiting")


end


require("testlib")
bootstrap(main) -- testlib


-- local file_handle = {}

-- function main()
	-- function next_pin()
		-- local pin = nil
		-- repeat
			-- local event = {os.pullEvent()}
			-- local event_type = event[1]
		
			-- if event_type == "peripheral" then
				-- local peripheral_name = event[2]
				-- pin = peripheral_name
				-- print(pin)
			-- elseif event_type == "key_up" then
				-- local key = event[2]
				-- if key == 65 then
					-- return nil
				-- end
			-- else
				-- os.sleep(0.05)
			-- end
		-- until pin ~= nil
		-- return pin
	-- end

	-- print("connect all wired modems for circuit inputs in order")
	-- print("type 'a' when done")

	-- file_handle = io.open("inputs.txt", "w")	
	-- while true do
		-- local pin_name = next_pin()
		-- if pin_name == nil then
			-- print("Saved as inputs.txt, please rename it to keep it.")
			-- print("Exiting")
			-- return;
		-- end
		
		-- print("new pin ".. pin_name)
		-- file_handle:write(tostring(pin_name), "\n")
	-- end
	
	-- file_handle:flush()
-- end

-- function bootstrap()
	-- local results = {pcall(main)}
	-- if results ~= nil then
		-- if #results > 1 then
			-- for i,v in pairs(results) do
				-- print(v)
			-- end
		-- end
	-- end
-- end

-- pcall(bootstrap)

-- -- make sure file always gets closed
-- if file_handle ~= {} then
	-- local result = io.close(file_handle)
	-- assert(result ~= nil)
-- end

