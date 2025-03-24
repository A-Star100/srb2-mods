-- Define a custom flag for when a special ability has been executed
local PF_EXECUTED_SPECIAL = 0x10000  -- Arbitrary value that doesn't conflict with existing flags

addHook("AbilitySpecial", function(player)
    -- Ensure the player hasn't already executed a special ability
    if player.pflags & PF_EXECUTED_SPECIAL then
        return true
    end

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
    player.pflags = $ & ~PF_NOJUMPDAMAGE  

    player.mo.state = S_PLAY_ROLL

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

-- Reset the executed special flag when the player spawns
addHook("PlayerSpawn", function(player)
    player.pflags = player.pflags & ~PF_EXECUTED_SPECIAL  -- Reset executed flag
end)


addHook("ThinkFrame", function()
    for player in players.iterate()
        if player and player.mo and player.mo.valid then
            -- Maintain the rolling animation if the character can't spindash
            if not skins[player.mo.skin].abilities.spindash then
                player.mo.state = S_PLAY_ROLL
            end
        end
    end
end)
