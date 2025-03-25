# How to edit
You might be wondering, how the heck did I make this?

Well I'll tell you. It's with [Slade](https://slade.mancubus.net/), a Doom mod editor that supports Sonic Robo Blast 2 along with Doom and more (it isn't good for map making, use [Ultimate Zone
Builder](https://mb.srb2.org/addons/ultimate-zone-builder.6126/) (SRB2-only) for that instead).

Slade may seem daunting at first, but here are a few core concepts you should know before starting off:

- **Lumps:** These are, in fact, just regular files most of the time without a file extension. They are parts of the ZIP your mod is packaged in. PK3 archives are ZIP files at their core, so most unzipping software can unzip its contents (although you should use a Doom mod editor (like Slade) to edit the mod).
  
- **[Lua](https://www.lua.org/):** A programming and scripting language that is often used in video games and supported Sonic Robo Blast 2 for adding gameplay abilities to your character without needing to create a whole mod with a Doom mod editor. It's how I added the multithok ability to Speedy Sonic (the boost ability is built-in for SRB2, called DASHMODE).
  
- **[SOC](https://wiki.srb2.org/wiki/SOC):** Sonic Object Configuration is a type of config file for Sonic Robo Blast 2 that is used in mods to define how your character will appear both in-game and in the character select screen. Unlike Lua, it is not as capable in adding gameplay abilites, and mostly meant for styling and adding some objects.
  
- **S_SKIN and SOC_PLAY:** These two lumps are very important for your character. These are **required** for your SRB2 mod, or else the game will show an error and refuse to launch the mod. Both of these specify important information about your character, such as the default color they use, the abilities they have, and more.
  
- **Doom Graphics:** Doom graphics are also extremely crucial to your mod. Without them, your character will appear blank. For simplicity, I decided to stick with the default Sonic sprites the PK3 template I used had.
  
- **PK3 and WAD archives:** These are the two most commonly used types of archives for SRB2 mods (and Doom mods in general). These archives are compressed versions of the contents of your mod (which at the end of the day is just a regular folder with mod details). [See the difference here](https://mb.srb2.org/threads/i-wonder-which-file-is-better-for-character-mods-wad-or-pk3.34096/#post-558489).

If you're still confused, take a look at the [SLADE Wiki](https://slade.mancubus.net/index.php?page=wiki) or the [SRB2 Wiki](https://wiki.srb2.org/wiki/Category:Editing) (Editing section). 
