# How to Edit
For information on how to edit Speedy Sonic (and most mods in general) for vanilla SRB2, look [here](https://github.com/A-Star100/srb2-mods/blob/main/CL_SpeedySonic/HOW_TO_EDIT.md).

Unlike vanilla SRB2, SRB2 Kart and Ring Racers modding is much simpler and oriented around character stats more than gameplay mechanics. As such, you don't need to know about the concepts listed in [here](https://github.com/A-Star100/srb2-mods/blob/main/CL_SpeedySonic/HOW_TO_EDIT.md)
unless you're making mods for vanilla SRB2.

I use [SLADE](https://slade.mancubus.net/) to make my SRB2 and SRB2Kart mods, mostly because I use macOS and the editor is very user friendly (for custom characters, anyway).

For simplifying SRB2Kart and Ring Racers modding, I would heavily recommend [KartMaker](https://mb.srb2.org/threads/kartmaker-sprites-to-wad-in-record-time.26207/), it automates everything for you,
so you have little to do in SLADE to polish up your mod. But KartMaker is Windows only, for macOS and Linux you have no choice but to use SLADE, which also isn't a bad choice.

One of the hardest parts of SRB2 modding in general is spriting. I'm not very good at creating sprites, but I am good at programming, so I often use vanilla game sprites and program
new abilities for my characters. This is subject to change though. KartMaker allows you to create the sprites, and then it automatically converts them to the required format (Doom Graphic/PNG patch).

## What you need to know
- **WAD:** Stands for *Where's All The Data*, and is important for SRB2 modding. This is one of the packaging formats your mod can get distributed in. Personally, making SRB2Kart mods with WAD is easier for me, and making SRB2 mods with PK3 is easier for me, but you can use both WADs and PK3s for your mods, they'll still work. [See the difference between WAD and PK3 here](https://mb.srb2.org/threads/i-wonder-which-file-is-better-for-character-mods-wad-or-pk3.34096/#post-558489).
- **PK3:** Stands for *Package-3*, and is just as important as WAD. This is another choice of packaging format for your mod. Unlike WADs, they're compressed by default and use regular ZIP compression for efficiency unlike WAD's wadzip compressor, which is optional and not commonly used.
- **Lumps:** All you really need to know about these is that they're files in your mod. They're referred to as lumps by modders and the game itself.
- **S_SKIN:** Very important for setting up your character, it defines your character's properties and for SRB2 modding, even abilities. In SRB2Kart, though, S_SKIN typically contains mappings to sound effects and properties about the character (kart speed, weight, skin name and screen name).
- **Doom Graphic:** The lump (file) for SRB2 sprites. They don't display in color in editors but the grey, black, and white defines color. If you convert to a PNG you lose the color as a result.

That's it!
