-- Define a custom flag for when a special ability has been executed
local PF_EXECUTED_SPECIAL = 0x10000  -- Arbitrary value that doesn't conflict with existing flags

addHook("AbilitySpecial", function(player)
    
    -- Make sure the player hasn't already executed a special ability
    if player.pflags & PF_EXECUTED_SPECIAL then
        return true
    end
    
    -- Force the player to perform a thok special ability
    local actionspd = FixedMul(player.mo.scale, 60 * FRACUNIT)  -- Adjust for size
    
    -- If the player is underwater, reduce speed
    if player.mo.eflags & MFE_UNDERWATER then
        actionspd = actionspd / 2
    end
    
    -- Perform the thok thrust action
    P_InstaThrust(player.mo, player.mo.angle, actionspd)
    
    -- Spawn the thok mobj (the projectile representing the thok)
    P_SpawnThokMobj(player)
    
    -- Play the thok sound effect
    S_StartSound(player.mo, sfx_thok)

     -- comment the line below to enable the multithok.
    player.pflags = $|PF_EXECUTED_SPECIAL --The | operator turns on the PF_EXECUTED_SPECIAL flag
    
    -- Prevent the original ability code from running (no default special ability)
    return true
end)

addHook("MobjCollide", function(player, enemy)
    -- Ensure the player is in thok state and enemy is actually an enemy
    if player.player and (player.player.pflags & PF_EXECUTED_SPECIAL) then
        if enemy.flags & MF_ENEMY then
            -- Damage the enemy instead of the player
            P_DamageMobj(enemy, player, player) -- Inflict damage on the enemy
            P_KillMobj(enemy, player, player)   -- Optionally destroy the enemy
            return true  -- Prevent the enemy from damaging the player
        end
    end
end, MT_PLAYER)  -- Hook for player objects only



-- Reset the executed special flag when the player spawns
addHook("PlayerSpawn", function(player)
    player.pflags = player.pflags & ~PF_EXECUTED_SPECIAL  -- Reset the executed special flag when the player spawns
end)
