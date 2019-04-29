# Baba Is You Patashu's Mods

Modding Baba is You for practice. I'll add more mods in future probably.

To install: Extract the "Scripts" and "Sprites" folders into the world you wish to use the mod with. **Make sure lilybeeveeeeee's modloader is installed! (in #assets-are-share pins on Baba is You Discord server: https://discord.gg/GGbUUse)** Check Scripts/options.lua to enable or disable features!

**LESS** - __Property__ The opposite of MORE. If an object *could* expand to surrounding tiles under MORE rules, then it is destroyed.

**SLIDE** - __Property__ Whenever this object moves, it moves as far as possible. Tested with you, move, shift, push and pull. 'ALL on ICE is SLIDE'  makes ice slippery!

**STUCK** - __Property__ This object cannot be moved by any means (tested: SHIFT, PUSH, PULL, SWAP, MOVE, YOU, FALL). Conditional STUCK can be used to stop movement on certain tiles.

**TOPPLE** - __Property__ When a stack of topplers are on a tile, they eject themselves in the facing direction to form a line (first moves 0 tiles, second moves 1 tile, third moves 2 tiles, etc).

**PHASE** - __Property__ If something would normally block your movement (STOP, an impossible PUSH or PULL) then with PHASE you can walk through it anyway.

**MULTIPLY / DIVIDE** - __Property__ X shaped counterparts to MORE and LESS, growing and shrinking in checkerboard patterns.

**FACEAWAY / FACESIDE** - __Condition (Prefix)__ Counterparts to FACING that check your back and your sides respectively.

**SINGLET / CAPPED / STRAIGHT / CORNER / EDGE / INNER** - __Condition (Prefix)__ True for objects that are surrounded by themselves on 0/1/2 (straight)/2 (corner)/3/4 sides, respectively. Useful for creating multi-tile substances like DROD Tar and Mud.

**STRAFE** - __Property__ Direction cannot change by any means. Like UP/DOWN/LEFT/RIGHT but keeping whatever direction it had instead of forcing it.

**COLLECT** - __Property__ YOU destroys COLLECT it steps on. Then, if that was the last COLLECT, the puzzle is cleared.

**1ST1 / LAST1** - __Property__ When there's more than one of an object, only the (first/last) survives, respectively.

**MAYBE / RARELY / MEGARARE / GIGARARE** - __Condition (Prefix)__ Deterministic RNG (50%, 10%, 1% and 0.1% respectively) based on unit name, x, y, turn count and name of the level - so every time you do the same things, you get the same results, and if the puzzle creator needs a different seed, you can change the level name. (I tried using unitid but it is sadly non-deterministic, I think this is the best I can do.) Note that if nothing happens after waiting a turn, Baba Is You will ignore further waiting inputs, even if a different random thing could happen - so have something changing state every turn (like MOVE).

Baba is You Discord server: https://discord.gg/GGbUUse
