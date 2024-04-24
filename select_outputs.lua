function main()
	print("connect all wired modems for circuit outputs in order")
	print("press 'a' ket to exit")

	local file_name = "outputs.txt"

	logPeripheralEvents(file_name, isAKey)

	print("Saved as '"..file_name.."', please rename it to keep it.")
	print("Exiting")


end


require("testlib")
bootstrap(main) -- testlib


