-- Global variables for customization
local thokSpeed = 60 * FRACUNIT  -- Default thok speed (can be adjusted)
local enableMultithok = true    -- Default to enabling multithok
local thokEnabled = true        -- Default to having thok enabled

-- Command to control thok speed
addCommand("setthokspeed", function(player, speed)
    if player ~= consoleplayer then
        return
    end
    -- Check if speed is a valid number
    local newSpeed = tonumber(speed)
    if newSpeed then
        thokSpeed = newSpeed * FRACUNIT  -- Convert speed to fracunits
        CONS_Printf(player, "Thok speed set to %d\n", thokSpeed)
    else
        CONS_Printf(player, "Invalid speed. Please enter a number.\n")
    end
end)

-- Command to enable or disable multithok
addCommand("setmultithok", function(player, state)
    if player ~= consoleplayer then
        return
    end
    -- Enable or disable multithok based on the input state
    if state == "on" then
        enableMultithok = true
        CONS_Printf(player, "Multithok enabled.\n")
    elseif state == "off" then
        enableMultithok = false
        CONS_Printf(player, "Multithok disabled.\n")
    else
        CONS_Printf(player, "Invalid state. Use 'on' or 'off'.\n")
    end
end)

-- Command to disable thok entirely
addCommand("disablethok", function(player, state)
    if player ~= consoleplayer then
        return
    end
    -- Enable or disable thok ability
    if state == "off" then
        thokEnabled = false
        CONS_Printf(player, "Thok disabled.\n")
    elseif state == "on" then
        thokEnabled = true
        CONS_Printf(player, "Thok enabled.\n")
    else
        CONS_Printf(player, "Invalid state. Use 'on' or 'off'.\n")
    end
end)

--[[ AbilitySpecial hook to modify thok behavior ]]
addHook("AbilitySpecial", function(player)
    -- Check if thok is enabled
    if not thokEnabled then
        return true  -- Exit the function without doing anything if thok is disabled
    end
    
    -- Make sure the character is Sonic
    if player.mo.skin ~= "sonic" then
        return
    end
    
    -- Check if Sonic has already thokked
    if player.pflags & PF_THOKKED then
        return true
    end
    
    -- Execute the thok
    -- Adjust the thok speed based on the thokSpeed variable
    local actionspd = FixedMul(player.mo.scale, thokSpeed)
    
    if player.mo.eflags & MFE_UNDERWATER then
        actionspd = actionspd / 2  -- Reduce speed underwater
    end
    
    -- Perform the thok thrust
    P_InstaThrust(player.mo, player.mo.angle, actionspd)


	P_SpawnThokMobj(player)  -- Spawn a single thok mobj
    
    -- Play thok sound effect
    S_StartSound(player.mo, sfx_thok)

	    -- If multithok is enabled, spawn additional thok projectiles
		if enableMultithok then
			-- You can customize this part based on the number of additional thoks
			player.pflags = $|PF_THOKKED --The | operator turns on the PF_THOKKED flag
		end
    
    return true  -- Prevent the original ability code from running
end)

--[[ 
    Now you can use the following commands in the game console to control the thok behavior:
    - `setthokspeed <speed>`: Change the speed of the thok (e.g., `setthokspeed 100`).
    - `setmultithok <on|off>`: Enable or disable multithok (e.g., `setmultithok on`).
    - `disablethok <on|off>`: Enable or disable the thok ability entirely (e.g., `disablethok off`).
]] 
