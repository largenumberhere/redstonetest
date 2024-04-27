local peripheralevents = require("libredstonetest/peripheralevents")
local keyboardutil = require("libredstonetest/keyboardutil")
local bootstrapper = require("libredstonetest/bootstrapper")

local pincontroller = require("libredstonetest/pincontroller")
local tickcontroller = require("libredstonetest/tickcontroller")

-- release all resources handled by this library
	local function releaseResources()		
		tickcontroller.releaseResources()
	end

	
-- api housekeeping
	local bootstrap = bootstrapper.createBootstrap(releaseResources)

	local libredstonetest = {
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
	
return libredstonetest