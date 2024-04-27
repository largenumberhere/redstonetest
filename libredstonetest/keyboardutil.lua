	-- this is an example function to put into waitEvent
	local function isAKey(event_details) 
		local event_name = event_details[1]
		
		if event_name == "key_up" then
			local key_id = event_details[2]
			if key_id == 65 then -- A key on US-keyboard
				return true
			end
		end
		
		return false
	end
	
	return {isAKey=isAKey}