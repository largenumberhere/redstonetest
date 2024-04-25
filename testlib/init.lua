local peripheralevents = require("testlib/peripheralevents")
local keyboardutil = require("testlib/keyboardutil")
local bootstrapper = require("testlib/bootstrapper")
	
	-- release all resources handled by this library
	local function releaseResources()		
		-- todo: release tick resources
	end
	
	
-- api housekeeping
	local bootstrap = bootstrapper.createBootstrap(releaseResources)

	local testlib = {
		isAKey = keyboardutil.isAKey,
		logPeripheralEvents = peripheralevents.logPeripheralEvents,
		bootstrap = bootstrap,
		cleanup = releaseResources,
	}
	
return testlib