--[[
Scripted by CobaltBW

This is a recreation of Sonic's thok, made entirely through lua.
The purpose of this script is to help teach newcomers the fundamentals of lua
and ease the transition of learning its rules and syntax.

Please make sure you are using an editor that can highlight code syntax, as this
will make the tutorial (and code in general!) easier to read.

--]]


--[[
	Let's begin by creating a hook.
	
	Think of hooks as "events". Some hooks, like MobjThinker, PlayerThink,
	and ThinkFrame, run on every frame. Other hooks, like MobjSpawn, JumpSpecial,
	and MobjDamage, will only run on special conditions, like when the object is
	spawning, or when the player is trying to jump, or when an object is taking
	damage.
	
	A hook generally takes the format of: addHook("hook name", function, object)
	...where 'function' can refer to an existing function or can be created inline e.g.:
			function(arg1, arg2)
				<code block>
			end
		
	
	See this link for a list of hooks, the arguments they take, and information
	on when they're executed.
	https:--wiki.srb2.org/wiki/Lua/Hooks
	
	For this example, we need to modify the behavior of a player character that
	is trying to perform their midair ability. The "AbilitySpecial" hook is best
	equipped for this, since it takes place just before the ability is executed.
	In this case, AbilitySpecial's arg 2 function takes one argument, which is
	the player instance. It takes nothing for argument 3, so we won't include it.

	In effect, it will look like this:
			addHook("AbilitySpecial", function(player)
				<code block>
			end)
			
	Note: When calling function(), you can name these arguments anything you
	want; the important thing is that you know what those arguments represent
	when scripting the rest of your function. 
]]

addHook("AbilitySpecial", function(player)
	--The rest of this body will write out the contents of the function.
	
	--Let's make things easier for ourselves by printing a message to console,
	--telling us that a certain line of code is being run. This is a good habit
	--for when you need to troubleshoot why a certain piece of code doesn't work.
	--CONS_Printf(player,"Trying lua thok event")
	
	
	--First let's make sure we're using the right character skin.
	if player.mo.skin ~= "sonic"
		return 
	end
	
	--[[	"return" exits the function. You can optionally return a value, such as a
	boolean (true or false), an integer (1, 2, 3), or an object or player, etc.
	
	In the case of hooks, a boolean return value often determines whether
	an event should continue its original code after the lua hook has ended, or
	if the original code should be prevented from running. Here we return
	nothing AKA "nil", and so the ability code continues as normal. In this
	case, the ability code runs like normal if the player character is one other
	than Sonic. ]]
	
	--Let's now check our player's flags to make sure we haven't thokked yet
	if player.pflags&PF_THOKKED --This looks up player.pflags to see if the
								--flag for PF_THOKKED is enabled.
		--CONS_Printf(player,"Sonic has already thokked; exiting")
		return true --Exit script. "True" in this case overrides the vanilla
					--event handler for AbilitySpecial, i.e. Sonic will do nothing
					--after this hook is run.
	end
	
	--We've run all the checks we need, so let's execute the ability.
	--CONS_Printf(player,"All checks passed, performing thok")
	
	--Now do InstaThrust, which resets the object's XY speed and thrusts it in
	--a specified angle and a specified speed amount
	local actionspd = FixedMul(player.mo.scale, player.actionspd)
		-- We multiply player's actionspd by the player object's scale. This
		-- means that if the player is shrunk or enlarged, their thok speed
		-- will be accurate to the player object's new size.
	if player.mo.eflags & MFE_UNDERWATER
		actionspd = $/2 -- We cut actionspd in half if travelling underwater.
	end

	-- Set PF_NOJUMPDAMAGE before the Thok occurs for proper collision handling
    -- Comment the line below if you want the mod to work in 2.1
    player.pflags = $ & ~PF_NOJUMPDAMAGE  

	P_InstaThrust(player.mo, player.mo.angle, actionspd)
	
	--Note: player.actionspd is a copy of the skin's actionspd value, which is
	--typically used for determining the speed of certain ability attributes.
	--If we just wanted a fixed integer amount, we would write it out as
	-- 60*FRACUNIT (i.e. 60 fracunits)
	
	--This simple function spawns whichever object is set to the skin's thokmobj.
	P_SpawnThokMobj(player)
	
	--Now we'll produce the sound effect at the player object's position.
	S_StartSound(player.mo, sfx_thok)
	
	--We did it!
	--CONS_Printf(player, "Thokked!")
	--Let's return true, which will close this hook and, in this case, prevent 
	--the typical ability code from running after this hook.
	return true
end)

--[[
	Hopefully this script makes the process of working with lua a little easier
	to understand. The wiki should hopefully have all the info you need, but
	I've compiled a small collection of links that should make navigating the
	lua sections slightly less confusing.
	
	https:--wiki.srb2.org/wiki/User:CobaltBW/Sandbox
	
	The official SRB2 discord's #scripting channel is also a good place for help
	if you need assistance troubleshooting a script, or if you just want to
	show off something you made.
	
	Lua is a powerful tool when mastered but may take a while to get used to
	if you don't have a lot of scripting experience, so it's good to start
	small on your projects. Best of luck, and have fun!
]]

addHook("PlayerSpawn", function()
	--First let's make sure we're using the right character skin.
	if player.mo.skin ~= "sonic"
		CONS.PrintF("Skin is not Sonic, exiting; Load the MultiThokEveryone mod to use multithok with other characters.")
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
