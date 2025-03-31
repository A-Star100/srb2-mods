--[[
Scripted by CobaltBW
]]

addHook("AbilitySpecial", function(player)
	if player.mo.skin ~= "sonic"
		return 
	end
	
	if player.pflags&PF_THOKKED 
		return true 
	end
	
	
	local actionspd = FixedMul(player.mo.scale, player.actionspd)
	if player.mo.eflags & MFE_UNDERWATER
		actionspd = $/2 
	end

	-- Set PF_NOJUMPDAMAGE before the Thok occurs for proper collision handling
    -- Comment the line below if you want the mod to work in 2.1
    player.pflags = $ & ~PF_NOJUMPDAMAGE  

	P_InstaThrust(player.mo, player.mo.angle, actionspd)

	
	P_SpawnThokMobj(player)
	
	S_StartSound(player.mo, sfx_thok)

	return true
end)


addHook("PlayerSpawn", function()
	if player.mo.skin ~= "sonic"
		return
	end
)

-- Remove this ThinkFrame hook if you want the mod to work in 2.1
addHook("ThinkFrame", function()
    for player in players.iterate()
        if player and player.mo and player.mo.valid then
            player.pflags = $ & ~PF_NOJUMPDAMAGE  
        end
    end
end)
