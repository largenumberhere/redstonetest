local writefile = require("testlib/writefile") 

local function delay()
	os.sleep(0.1)
end

local function loadPeripheralsFromFile(filePath)

	local name_s = shell.resolve(filePath)
	-- local file_handle = io.open(name_s, "r")
	local file_handle = io.open(name_s, "r")
	assert(file_handle)
	
	local peripherals = {}
	
	local file_line = {}
	
	for file_line in file_handle:lines() do
		local per = peripheral.wrap(file_line)
		if per == nil then
			error("failed to load peripherals from file on line", i)
		end

		table.insert(peripherals, per)
	end
	
	file_handle:close()
	
	return peripherals
end

-- from the file provided, load the pins
-- assumes the peripheral names are all valid and numbered starting at 1
local function loadOutputPins(file_name)
	local peripherals = loadPeripheralsFromFile(file_name)
	
	-- ensure they're all redstone_integrators
	for i,per in pairs(peripherals) do
		peripherals[i].pin_id = i
		peripherals[i].peripheral_name = peripheral.getName(per)
		peripherals[i].pin_purpose = "output"
		peripherals[i].pin_facing = "NORTH"
		
		if peripheral.getType(per.peripheral_name) ~= "redstone_integrator" then
			error("a non-redstone_integrator was found in the provided pins file")
		end
	end
	
	return peripherals
end

local function assertAreInputPins(pins)
	for i,pin in pairs(pins) do
		if pin.pin_purpose ~= "input" then
			error("input pin was expected")
		end
	end
end

local function assertAreOutputPins(pins)
	for i,pin in pairs(pins) do
		if pin.pin_purpose ~= "output" then
			error("input pin was expected")
		end
	end
end



-- from the file provided, load the pins
-- assumes the peripheral names are all valid and numbered starting at 1
local function loadInputPins(file_name)
	local peripherals = loadPeripheralsFromFile(file_name)
	
	-- ensure they're all redstone_integrators
	for i,per in pairs(peripherals) do
		peripherals[i].pin_id = i
		peripherals[i].peripheral_name = peripheral.getName(per)
		peripherals[i].pin_purpose = "input"
		peripherals[i].pin_facing = "SOUTH"
		
		if peripheral.getType(per.peripheral_name) ~= "redstone_integrator" then
			error("a non-redstone_integrator was found in the provided pins file")
		end
	end
	
	return peripherals
end

local function setPin(pin, state)
	pin.setOutput(pin.pin_facing, state)
end

local function setPinHigh(pin)
	pin.setOutput(pin.pin_facing, true)
end


local function setPinLow(pin)
	pin.setOutput(pin.pin_facing, false)
end

-- set the pins to the states given. states is a table like 
-- 	{0: true, 1: false, 2: true, ...}
-- inputs must be the same length
local function setInputPins(input_pins, states)
	assert(#input_pins == #states)
	
	for i,pin in pairs(input_pins) do
		setPin(pin, states[i])
	end

	delay()
end

-- set all the pins to off
local function clearPins(input_pins, output_pins)
	assertAreInputPins(input_pins)
	assertAreOutputPins(output_pins)
	
	for i, pin in pairs(input_pins) do
		setPinLow(pin)
	end
	
	for i, pin in pairs(output_pins) do
		setPinLow(pin)
	end
	
	delay()
end

local function readPin(pin)
	return pin.getInput(pin.pin_facing)
end

-- check the state of all the given pins and error if they are not as expected. optional comment
-- 	{0: true, 1: false, 2: true, ...}
-- output_pins and states must be the same length
local function assertOutputPins(output_pins, states, failure_message)
	assertAreOutputPins(output_pins)
	assert(#output_pins == #states)
	
	local failure_message = failure_message or "assertOutputPins failed"
	local fail_pins = {}
	
	for i, pin in pairs(output_pins) do
		local state = readPin(pin)
		if state ~= states[i] then
			table.insert(fail_pins, {[1]=pin, [2]=state})
		end
	end
	
	if #fail_pins > 0 then
		local pins = ""
		print("Pin test failed. Offending output pins: ")
		for _,v in pairs(fail_pins) do
			io.write(tostring(v[1].pin_id), "=", tostring(v[2]), ",\t")
		end
	
		error(failure_message)
	end
end


-- log the pins's states to file along with an optional comment to document the logs' purpose. Truncates the file
local function logPins(input_pins, output_pins, file_name, comment)
	assertAreInputPins(input_pins)
	assertAreOutputPins(output_pins)
	assert(type(file_name) == "string")
	comment = comment or ""
	
	local file = writefile.openFileWrite(file_name)
	assert(file ~= nil)
	
	-- error("todo")
	
	for i, pin in pairs(input_pins) do
		local pin_state = readPin(pin)
		writefile.writeFileLine(file, "Input Pin  "..tostring(i)..":\t"..tostring(pin_state).. tostring(comment))
	end
	
	for i, pin in pairs(output_pins) do
		local pin_state = readPin(pin)
		writefile.writeFileLine(file, "Output Pin "..tostring(i)..":\t"..tostring(pin_state)..tostring(comment))	
	end
	
	writefile.closeFile(file)
	
end



local pincontroller = {
	loadOutputPins = loadOutputPins,
	loadInputPins = loadInputPins,
	setInputPins = setInputPins,
	clearPins = clearPins,
	assertOutputPins = assertOutputPins,
	logPins = logPins
}

return pincontroller