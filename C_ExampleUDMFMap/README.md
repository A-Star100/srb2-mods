# ExampleUDMFMap
A simple UDMF map made in SLADE3 with the ZDBSP nodebuilder (used in ZDoom, but works well with SRB2 too).

## Things you need to know
### Sectors
Sectors can be: Floors, ceilings, and Normals.
To make a rectangular sector, click on the **Lines Mode** icon (the yellow rod), then click on the **Shapes Mode** icon (the square with a dotted outline), then click the blue square (**Sectors** icon).
You should see a green cursor underneath your mouse. Drag the cursor and it should create a square. To spawn it inside the map (so it is visible), left-click inside the square. To undo, right-click.

### Things
Things can be anything: Rings, Eggman monitors, Chaos Emeralds, CTF flags, and more.
To create a thing, click on the **Things** icon (the red circle with the arrow like in Google Maps), then right-click and click *Create Thing* in the context menu. It will create a Thing immediately wherever you are. Click on the Thing you just created, then you will see a side menu. Click the + icon, and name your new property *type*, and remember, it must be an integer.
Types are a bit confusing in SRB2, but to help you, type **1** is the starting point for Player 1, type **300** is a singular ring, type **316** is a cyan Chaos Emerald, a ring monitor with ten rings is type **400**, and an Eggman monitor is type **410**. You may need to recreate the **type** property every time you go in and out of the Map Editor. It is completely OK to recreate it in the editor, it will simply replace the old value.

### Nodebuilder
Nodes in maps tell the game about its structure. Without nodes, sectors can't be fully realized and SRB2 crashes with an error: "Your level does not have any nodes (does it have at least two sectors?)"l.
SLADE by default lacks any nodebuilder, so you will need to compile ZDBSP from source (which is very easy).

```shell
git clone https://github.com/rheit/zdbsp.git
cd zdbsp
```

After this, go ahead and change the `CMAKELists.txt` file to require a newer version of CMake:

```shell
# change:
cmake_minimum_required( VERSION 2.4 )
# to:
cmake_minimum_required( VERSION 3.20 )
# (or your version of choice)
```

Then run:

```shell
cmake . && make
```

After this, a `zdbsp` binary should have been created. Then, go to SLADE, open any map, then go to `Edit > Settings (or Preferences) > Map Editor > Node Builder`.
Select the Node Builder `ZDBSP`, and the `Path` should be the file path of the `zdbsp` binary you just created.

After this, you should be ready to go with nodes.
