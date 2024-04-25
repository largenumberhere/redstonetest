-- open a file for writing relative to the current directory
local function openFileWrite(name)
-- function open_file_write(name)
	assert(type(name)=="string")

	local name_s = shell.resolve(name)
	local file_handle = io.open(name_s, "w")
	if file_handle == nil then 
		error("Failed to open file '"..name_s.."'")
	end
		
	return file_handle
end
	
-- write to the open file
local function writeFileLine(file_handle, str)
	print(file_id)
	local f = file_handle:write(str, "\n")
end

local function closeFile(file_handle) 
	file_handle:close()
end

local keyboardutil = {
	openFileWrite = openFileWrite,
	writeFileLine = writeFileLine,
	closeFile	  = closeFile
}
return keyboardutil