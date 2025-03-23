# ThokEveryone
This Lua script is a modification of CobaltBW's Lua script tutorial for thokking, but this time, you can thok with every base-game character that has a spin animation 
(this means that Tails and Knuckles can also thok now).
You can find the original Lua [here](https://mb.srb2.org/threads/lua-thok-scripting-example.30555/).

## Bugs
Characters this custom thok is applied to lose rings instead of damaging enemies if they're hit in the middle of a thok.
This is because no enemy handling has been added, so the default is used, which is to get damaged.
