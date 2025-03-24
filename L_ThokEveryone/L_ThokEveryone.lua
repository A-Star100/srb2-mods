-- Define a custom flag for when a special ability has been executed
local PF_EXECUTED_SPECIAL = 0x10000  -- Arbitrary value that doesn't conflict with existing flags

addHook("AbilitySpecial", function(player)
    -- Ensure the player hasn't already executed a special ability
    if player.pflags & PF_EXECUTED_SPECIAL then
        return true
    end
    
    if player.mo.skin == "sonic" then
        return 
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
    -- Comment the line below if you want the mod to work in 2.1
    player.pflags = $ & ~PF_NOJUMPDAMAGE  

    -- Perform the Thok thrust action
    P_InstaThrust(player.mo, player.mo.angle, actionspd)
    
    -- Spawn the Thok projectile
    P_SpawnThokMobj(player)
    
    -- Play the Thok sound effect
    S_StartSound(player.mo, sfx_thok)

    -- Comment the line below to enable the multithok
    player.pflags = $ | PF_EXECUTED_SPECIAL
    
    -- Prevent the original ability code from running (no default special ability)
    return true
end)

-- Reset the executed special flag when the player spawns
addHook("PlayerSpawn", function(player)
    player.pflags = player.pflags & ~PF_EXECUTED_SPECIAL  -- Reset executed flag
end)

-- Remove this MobjMoveBlocked hook if you want to multithok
addHook("MobjMoveBlocked", function(mo)
    if mo.player then
        mo.player.pflags = $ & ~PF_EXECUTED_SPECIAL
    end
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
