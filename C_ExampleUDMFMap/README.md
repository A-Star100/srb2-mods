# ExampleUDMFMap
A simple UDMF map made in SLADE3 with the ZDBSP nodebuilder (used in ZDoom, but works well with SRB2 too).

## Things you need to know
### Sectors
Sectors can be anything: Floors, ceilings, whatever.
To make a rectangular sector, click on the **Lines Mode** icon (the yellow rod), then click on the **Shapes Mode** icon (the square with a dotted outline), then click the blue square (**Sectors** icon).
You should see a green cursor underneath your mouse. Drag the cursor and it should create a square. To spawn it inside the map (so it is visible), left-click inside the square. To undo, right-click.

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
