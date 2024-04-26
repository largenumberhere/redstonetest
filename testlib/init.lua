local peripheralevents = require("testlib/peripheralevents")
local keyboardutil = require("testlib/keyboardutil")
local bootstrapper = require("testlib/bootstrapper")

local pincontroller = require("testlib/pincontroller")
local tickcontroller = require("testlib/tickcontroller")

-- release all resources handled by this library
	local function releaseResources()		
		tickcontroller.releaseResources()
	end

	
-- api housekeeping
	local bootstrap = bootstrapper.createBootstrap(releaseResources)

	local testlib = {
		isAKey = keyboardutil.isAKey,
		logPeripheralEvents = peripheralevents.logPeripheralEvents,
		bootstrap = bootstrap,
		cleanup = releaseResources,
		
		freezeGame = tickcontroller.freezeGame,
		stepRedstoneTicks = tickcontroller.stepRedstoneTicks,
		
		loadOutputPins = pincontroller.loadOutputPins,
		loadInputPins = pincontroller.loadInputPins,
		setInputPins = pincontroller.setInputPins,
		clearPins = pincontroller.clearPins,
		assertOutputPins = pincontroller.assertOutputPins,
		logPins = pincontroller.logPins
		
		
	}
	
return testlib