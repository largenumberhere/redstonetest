function main()
	local testlib = require("testlib")

	testlib.freezeGame()
	
	local input_pins = testlib.loadInputPins("inputs16x2.txt")	-- include 32 pins numbered left-to-right, bottom to top
	local output_pins = testlib.loadOutputPins("outputs16x1.txt")	-- number pins in same direction for the back but exclude the upper 16

	local rs_ticks_allowed = 1

	-- reset everything
	testlib.clearPins(input_pins, output_pins)
	testlib.stepRedstoneTicks(10)	

	local i_max = 3
	for i=1, i_max, 1 do
		print("Iteration", i, "of", i_max)
		io.write("Test 1: ")
		-- test 1:	
			-- assert that this gate produces (true = true|true) and (false = false | false), in alternation
			-- done in alternation to highlight an possible signal bleed across gates
			-- assert that it does so in 2 redstone ticks
			testlib.setInputPins(input_pins, 
			{
				[ 1] = true,	-- i01 = 1
				[ 2] = false,	-- i02 = 0
				[ 3] = true,	-- i03 = 1
				[ 4] = false,   -- i04 = 0
				[ 5] = true,	-- i05 = 1
				[ 6] = false,	-- i06 = 0 
				[ 7] = true,	-- i07 = 1
				[ 8] = false,	-- i08 = 0
				[ 9] = true,	-- i09 = 1
				[10] = false,	-- i10 = 0
				[11] = true,	-- i11 = 1
				[12] = false,	-- i12 = 0
				[13] = true,	-- i13 = 1
				[14] = false,	-- i14 = 0
				[15] = true,	-- i15 = 1
				[16] = false,	-- i16 = 0
				
				[17] = true,	-- i17 = 1
				[18] = false,	-- i18 = 0
				[19] = true,	-- i19 = 1
				[20] = false,	-- i20 = 0
				[21] = true,	-- i21 = 1
				[22] = false,	-- i22 = 0
				[23] = true,	-- i23 = 1
				[24] = false,	-- i24 = 0
				[25] = true,	-- i25 = 1
				[26] = false,	-- i26 = 0
				[27] = true,	-- i27 = 1
				[28] = false,	-- i28 = 0
				[29] = true,	-- i29 = 1
				[30] = false,	-- i30 = 0
				[31] = true,	-- i31 = 1
				[32] = false	-- i32 = 0
			})

			testlib.stepRedstoneTicks(rs_ticks_allowed)
			
			testlib.assertOutputPins(output_pins, {
				[ 1] = true,	-- o01 = i01 | i17
				[ 2] = false,	-- o02 = i02 | i18
				[ 3] = true,	-- o03 = i03 | i19
				[ 4] = false,	-- o04 = i04 | i20
				[ 5] = true,	-- o05 = i05 | i21
				[ 6] = false,	-- o06 = i06 | i22
				[ 7] = true,	-- o07 = i07 | i23
				[ 8] = false,	-- o08 = i08 | i24
				[ 9] = true,	-- o09 = i09 | i25
				[10] = false,	-- o10 = i10 | i26
				[11] = true,	-- o11 = i11 | i27
				[12] = false,	-- o12 = i12 | i28
				[13] = true,	-- o13 = i13 | i29
				[14] = false,	-- o14 = i14 | i30
				[15] = true,	-- o15 = i15 | i31
				[16] = false,	-- o16 = i16 | i32
			})
			
			
			print("OK")
		
		io.write("Test 2: ")
		-- test 2
			-- check that it handles (true = false | true) correcty
			testlib.setInputPins(input_pins, 
			{
				[ 1] = false,	-- i01 = 0
				[ 2] = false,	-- i02 = 0
				[ 3] = false,	-- i03 = 0
				[ 4] = false,   -- i04 = 0
				[ 5] = false,	-- i05 = 0
				[ 6] = false,	-- i06 = 0 
				[ 7] = false,	-- i07 = 0
				[ 8] = false,	-- i08 = 0
				[ 9] = false,	-- i09 = 0
				[10] = false,	-- i10 = 0
				[11] = false,	-- i11 = 0
				[12] = false,	-- i12 = 0
				[13] = false,	-- i13 = 0
				[14] = false,	-- i14 = 0
				[15] = false,	-- i15 = 0
				[16] = false,	-- i16 = 0
				
				[17] = true,	-- i17 = 1
				[18] = true,	-- i18 = 1
				[19] = true,	-- i19 = 1
				[20] = true,	-- i20 = 1
				[21] = true,	-- i21 = 1
				[22] = true,	-- i22 = 1
				[23] = true,	-- i23 = 1
				[24] = true,	-- i24 = 1
				[25] = true,	-- i25 = 1
				[26] = true,	-- i26 = 1
				[27] = true,	-- i27 = 1
				[28] = true,	-- i28 = 1
				[29] = true,	-- i29 = 1
				[30] = true,	-- i30 = 1
				[31] = true,	-- i31 = 1
				[32] = true		-- i32 = 1
			})

			testlib.stepRedstoneTicks(rs_ticks_allowed)
			
			testlib.assertOutputPins(output_pins, {
				[ 1] = true,	-- o01 = i01 | i17
				[ 2] = true,	-- o02 = i02 | i18
				[ 3] = true,	-- o03 = i03 | i19
				[ 4] = true,	-- o04 = i04 | i20
				[ 5] = true,	-- o05 = i05 | i21
				[ 6] = true,	-- o06 = i06 | i22
				[ 7] = true,	-- o07 = i07 | i23
				[ 8] = true,	-- o08 = i08 | i24
				[ 9] = true,	-- o09 = i09 | i25
				[10] = true,	-- o10 = i10 | i26
				[11] = true,	-- o11 = i11 | i27
				[12] = true,	-- o12 = i12 | i28
				[13] = true,	-- o13 = i13 | i29
				[14] = true,	-- o14 = i14 | i30
				[15] = true,	-- o15 = i15 | i31
				[16] = true,	-- o16 = i16 | i32
			})
			
			print("OK")
			
		
		io.write("Test 3: ")
		-- test 3
			--  check that it handles (true = true | false) correctly
			testlib.setInputPins(input_pins, 
			{
				[ 1] = true,	-- i01 = 1
				[ 2] = true,	-- i02 = 1
				[ 3] = true,	-- i03 = 1
				[ 4] = true,   	-- i04 = 1
				[ 5] = true,	-- i05 = 1
				[ 6] = true,	-- i06 = 1 
				[ 7] = true,	-- i07 = 1
				[ 8] = true,	-- i08 = 1
				[ 9] = true,	-- i09 = 1
				[10] = true,	-- i10 = 1
				[11] = true,	-- i11 = 1
				[12] = true,	-- i12 = 1
				[13] = true,	-- i13 = 1
				[14] = true,	-- i14 = 1
				[15] = true,	-- i15 = 1
				[16] = true,	-- i16 = 1
				
				[17] = false,	-- i17 = 0
				[18] = false,	-- i18 = 0
				[19] = false,	-- i19 = 0
				[20] = false,	-- i20 = 0
				[21] = false,	-- i21 = 0
				[22] = false,	-- i22 = 0
				[23] = false,	-- i23 = 0
				[24] = false,	-- i24 = 0
				[25] = false,	-- i25 = 0
				[26] = false,	-- i26 = 0
				[27] = false,	-- i27 = 0
				[28] = false,	-- i28 = 0
				[29] = false,	-- i29 = 0
				[30] = false,	-- i30 = 0
				[31] = false,	-- i31 = 0
				[32] = false	-- i32 = 0
			})

			testlib.stepRedstoneTicks(rs_ticks_allowed)
			
			testlib.assertOutputPins(output_pins, {
				[ 1] = true,	-- o01 = i01 | i17
				[ 2] = true,	-- o02 = i02 | i18
				[ 3] = true,	-- o03 = i03 | i19
				[ 4] = true,	-- o04 = i04 | i20
				[ 5] = true,	-- o05 = i05 | i21
				[ 6] = true,	-- o06 = i06 | i22
				[ 7] = true,	-- o07 = i07 | i23
				[ 8] = true,	-- o08 = i08 | i24
				[ 9] = true,	-- o09 = i09 | i25
				[10] = true,	-- o10 = i10 | i26
				[11] = true,	-- o11 = i11 | i27
				[12] = true,	-- o12 = i12 | i28
				[13] = true,	-- o13 = i13 | i29
				[14] = true,	-- o14 = i14 | i30
				[15] = true,	-- o15 = i15 | i31
				[16] = true,	-- o16 = i16 | i32
			})
		
			print("OK")
	end
	
	-- reset everything
	testlib.clearPins(input_pins, output_pins)
	testlib.stepRedstoneTicks(10)	
	
	commands.say("or16test finished")
end

local testlib = require("testlib")

testlib.bootstrap(main)