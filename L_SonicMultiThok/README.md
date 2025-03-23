# SonicMultiThok
This Lua script is a modification of CobaltBW's Lua script tutorial for thokking, but the prevention of spamming the thok is disabled to bring back the infamous multi-thok ability.
You can find the original Lua [here](https://mb.srb2.org/threads/lua-thok-scripting-example.30555/).

## Description
The multi-thok finally returns to Sonic Robo Blast 2. Uncontrollably thok in broken goodness.

And guess what! **This mod works in 2.1 as well as 2.2!**.

## Bugs
Sonic will lose rings instead of damaging enemies if they're hit in the middle of a thok.
This is because no enemy handling has been added, so the default is used, which is to get damaged since we're overwriting the original handling.
