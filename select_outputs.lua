function main()
	local testlib = require("testlib")

	print("connect all wired modems for circuit outputs in order")
	print("press 'a' ket to exit")

	local file_name = "outputs.txt"

	testlib.logPeripheralEvents(file_name, testlib.isAKey)

	print("Saved as '"..file_name.."', please rename it to keep it.")
	print("Exiting")


end

local testlib = require("testlib")
testlib.bootstrap(main)


