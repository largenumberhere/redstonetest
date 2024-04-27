-- calls a function and logs any errors without crashing
local function bootstrap2(function_name)
	local results = {pcall(function_name)}
	if results ~= nil then
		if #results > 1 then
			print("error:")
			for i,v in pairs(results) do
				print("  "..tostring(v))
			end
		end
	end
	
end

-- Call this function with a function.
-- returns a function which you can call your main function with.
-- the bootstrap function ensures that the passed in function is always called regardless of if the main function exits with an error
--
-- example usage:
-- ```
-- local function main()
--   print("doing something useful")
-- end
-- local boostrapper = require("boostrapper")
-- function a()
--     print("program done")
-- end
-- 
-- local bootsrap = boostrapper.createBootstrap(a)
-- bootsrap(main)
--``
local function createBootstrap(resource_removal_fn)		

	-- call the function, logging all errors and then always releases files from openFileWrite. You don't need to call cleanup after this
	-- warning: this changes the program context - for example, you will need to import libredstonetest again inside your main function
	local function bootstrap(function_name)
		-- run the program
		pcall(bootstrap2, function_name)
		resource_removal_fn()
	end
	
	return bootstrap
		
end

local bootstrapper = {
	createBootstrap = createBootstrap
}

return bootstrapper