function main()
	local testlib = require("libredstonetest")

	print("connect all wired modems for circuit outputs in order")
	print("press 'a' key to exit")

	local file_name = "outputs.txt"

	testlib.logPeripheralEvents(file_name, testlib.isAKey)

	print("Saved as '"..file_name.."', please rename it to keep it.")
	print("Exiting")


end

local testlib = require("libredstonetest")
testlib.bootstrap(main)


