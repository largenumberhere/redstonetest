-- a tiny abstraction over files

local open_files = {}

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
	
	-- write to the open file
	local function writeFileLine(file_id, str)
		print(file_id)
		local f = open_files[file_id]:write(str, "\n")
	end

	-- close all open files
	local function releaseResources()
		for i,v in pairs(open_files) do
			v:flush()
			v:close()
		end
	end