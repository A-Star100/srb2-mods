-- Define a custom flag for when a special ability has been executed
addHook("AbilitySpecial", function(player)

    if player.mo.skin == "knuckles" then
        player.pflags = $ & ~PF_GLIDING
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

    -- Uncomment the line below to disable the multithok
    --player.pflags = $ | PF_EXECUTED_SPECIAL
    
    -- Prevent the original ability code from running (no default special ability)
    return true
end)



-- Remove this ThinkFrame hook if you want the mod to work in 2.1
addHook("ThinkFrame", function()
    for player in players.iterate()
        if player and player.mo and player.mo.valid then
            -- Clear PF_EXECUTED_SPECIAL as well (fixes multi-thok)
            player.pflags = $ & ~PF_NOJUMPDAMAGE
        end
    end
end)
