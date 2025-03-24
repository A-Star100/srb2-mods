-- Define a custom flag for when a special ability has been executed
--local PF_EXECUTED_SPECIAL = 0x10000  -- Arbitrary value that doesn't conflict with existing flags

addHook("AbilitySpecial", function(player)
    -- Ensure the player hasn't already executed a special ability
    if player.pflags & PF_THOKKED then
        print("Already Thokked!") -- Debug
        return true
    end


    if player.mo.skin == "knuckles" then
        player.pflags = $ & ~PF_GLIDING
    end
        

    
    if player.mo.skin == "sonic" then
        return 
    end
    
    -- Force the player to perform a Thok special ability
    local actionspd = FixedMul(player.mo.scale, 60 * FRACUNIT)  -- Adjust for size
    
    -- If the player is underwater, reduce speed
    if player.mo.eflags & MFE_UNDERWATER then
        actionspd = actionspd / 2
    end

    -- Set PF_NOJUMPDAMAGE before the Thok occurs for proper collision handling
    -- Comment the line below if you want the mod to work in 2.1
    player.pflags = $ & ~PF_NOJUMPDAMAGE  

    -- Perform the Thok thrust action
    P_InstaThrust(player.mo, player.mo.angle, actionspd)
    
    -- Spawn the Thok projectile
    P_SpawnThokMobj(player)
    
    -- Play the Thok sound effect
    S_StartSound(player.mo, sfx_thok)

    -- Comment the line below to enable the multithok
    player.pflags = $ | PF_THOKKED
    print("Multithok Disabled!")  -- Debug
    
    -- Prevent the original ability code from running (no default special ability)
    return true
end)


-- Remove this ThinkFrame hook if you want the mod to work in 2.1
addHook("ThinkFrame", function()
    for player in players.iterate()
        if player and player.mo and player.mo.valid then
            player.pflags = $ & ~PF_NOJUMPDAMAGE
        end
    end
end)
