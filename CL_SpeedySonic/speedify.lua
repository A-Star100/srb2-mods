-- Speedify.lua - Adds SF_DASHMODE and spammable multi-speed thok to characters via command

-- Register a console command
COM_AddCommand("speedify", function(player, character)
    if not player or not player.mo then return end  -- Ensure player is valid

    -- Search for character skins
    local found = false
    for skin, info in pairs(skins) do
        if string.lower(skin) == string.lower(character) then
            player.mo.skin = skin
            found = true
            break
        end
    end

    if not found then
        CONS_Printf(player, "Character not found: " .. character)
        return
    end

    -- Apply SF_DASHMODE and adjust player speed mechanics
    player.pflags = $ | PF_THOKKED -- Ensures thok state is possible
    player.powers[pw_dashmode] = 1 -- Enable Dash Mode

    -- Custom thok logic for spammable speed boost
    addHook("PlayerThink", function(player)
        if not (player and player.mo) then return end
        
        if player.cmd.buttons & BT_CUSTOM1 then -- Trigger with custom button (e.g., Spin)
            local speedBoost = 20 * FRACUNIT  -- Example speed boost factor
            player.mo.momx = $ + FixedMul(cos(player.mo.angle), speedBoost)
            player.mo.momy = $ + FixedMul(sin(player.mo.angle), speedBoost)
            player.pflags = $ & ~PF_THOKKED -- Allow spammable thok by resetting flag
        end
    end)

    CONS_Printf(player, "Character " .. character .. " has been speedified!")
end)
