# Baba Is You Patashu's Mods

To install: Extract the "Scripts" and "Sprites" folders into the world you wish to use the mod with. **Make sure lilybeeveeeeee's modloader is installed! (in #assets-are-share pins on Baba is You Discord server: https://discord.gg/GGbUUse)** Check Scripts/options.lua to enable or disable features!

This will be the **final** version except to fix critical bugs. My next project will be the Mega Mod Pack, that merges all existing mods into one github repository that everyone can use, after which I may make new words again.

**LESS / MULTIPLY / DIVIDE** - __Property__ LESS is the opposite of MORE. If an object *could* expand to surrounding tiles under MORE rules, then it is destroyed. MULTIPLY and DIVIDE are X shaped counterparts to MORE and LESS, growing and shrinking in checkerboard patterns. MORE/LESS and MULTIPLY/DIVIDE cancel out, while MORE/MULTIPLY and LESS/DIVIDE if combined give 8-way growing/shrinking respectively!

**SLIDE** - __Property__ Whenever this object moves, it moves as far as possible. Tested with you, move, shift, push and pull. 'ALL on ICE is SLIDE'  makes ice slippery!

**STUCK** - __Property__ This object cannot be moved by any means (tested: SHIFT, PUSH, PULL, SWAP, MOVE, YOU, FALL). Conditional STUCK can be used to stop movement on certain tiles.

**TOPPLE** - __Property__ When a stack of topplers are on a tile, they eject themselves in the facing direction to form a line (first moves 0 tiles, second moves 1 tile, third moves 2 tiles, etc).

**PHASE** - __Property__ If something would normally block your movement (STOP, an impossible PUSH or PULL) then with PHASE you can walk through it anyway.

**MULTIPLY / DIVIDE** - __Property__ X shaped counterparts to MORE and LESS, growing and shrinking in checkerboard patterns.

**FACEAWAY / FACESIDE** - __Condition (Prefix)__ Counterparts to FACING that check your back and your sides respectively.

**SINGLET / CAPPED / STRAIGHT / CORNER / EDGE / INNER** - __Condition (Prefix)__ True for objects that are surrounded by themselves on 0/1/2 (straight)/2 (corner)/3/4 sides, respectively. Useful for creating multi-tile substances like DROD Tar and Mud.

**STRAFE** - __Property__ Direction cannot change by any means. Like UP/DOWN/LEFT/RIGHT but keeping whatever direction it had instead of forcing it.

**COLLECT** - __Property__ YOU destroys COLLECT it steps on. Then, if that was the last COLLECT, the puzzle is cleared. (Unlike WIN, you can simultaneously die and win by getting the last COLLECT.)

**1ST1 / LAST1** - __Property__ When there's more than one of an object, only the (first/last) survives, respectively.

**MAYBE / RARELY / MEGARARE / GIGARARE** - __Condition (Prefix)__ Deterministic RNG (50%, 10%, 1% and 0.1% respectively) based on unit name, x, y, turn count, seed (name of the level if 'activemod.seed_rng_on_restart' is false, randomly generated each restart otherwise), maybe name/x/y. Undoing and repeating the same moves gives you the same results. Correlate 2+ RNGs by having them use the same MAYBE - both statements will be true or false together. Put a NOT before one of the statements to have it inversely correlated (exactly one is true). Use distinct MAYBEs to have statements that are uncorrelated (can be any combination of true/false individually). (NOTE: Include something in the level that changes every turn, or else if nothing happens after waiting a turn, Baba Is You will prevent the player from waiting, even if MAYBE could cause a different outcome eventually.)

**COLLIDE** - __Verb__ x COLLIDE y means y acts as STOP to x.

**SACCADE / DIZZY / FLINCH** - __Property__ SACCADE Randomly faces a direction before any movement for the turn. DIZZY picks any direction except the one previously faced. FLINCH picks any direction that doesn't face the unit towards a solid or another unit sharing its name. Uses deterministic RNG like MAYBE.

**DESTROY** - __Property__ Objects that are DESTROY are destroyed immediately.

**SEND / RECEIVE / RESEND** - __Property_ LEVEL IS SEND/TEXT IS SEND/TEXT NEAR TILE IS SEND sends all matching rules to the next level you enter, LEVEL IS RECEIVE/TEXT IS RECEIVE causes them to take effect. RESEND sends received rules to the next level (even if they are not RECEIVED!) - but rules sent back to the level they came from are ignored (no infinite stacking). Create meta puzzles spanning multiple levels!

**CRASH** - __Property__ If YOU is on CRASH, Baba Is You crashes.

**BOUNCE / TWIST / UNTWIST / REFLECT / FUNNEL** - __Property__ Any objects entering these tiles (even in the middle of a long SLIDE move) will have their direction altered as follows: BOUNCE rotates it 180 degrees, TWIST rotates it 90 degrees clockwise, UNTWIST rotates it 90 degrees counterclockwise, REFLECT mirrors it along the UL-DR axis if the REFLECT is facing horizontally or the DL-UR axis if the REFLECT is facing vertically (make appropriate sprites to indicate this), FUNNEL points it in the direction of the funnel. Put SLIDE-ing ice under the tile if you then want it to make a move in that direction!

**EVENTURN / ODDTURN** - __Condition (Prefix)__ True only on even numbered turns and odd numbered turns respectively.

**WON / CLEAR / COMPLETE** - __Condition (Prefix)__ - For a level noun: True if that level has been won/cleared/completed. For anything else: True if the level currently being played has been won/cleared/completed. (e.g. you can use this for meta-puzzles where cleared levels affect the map, or to make a puzzle easier/harder/different after being beaten)

**UNWIN** - __Property__ If YOU is on UNWIN, the currently played level becomes unbeaten, refunding you the flower puff you earned.

**STRONG** - __Property__ STRONG objects behave as though everything else is WEAK to them. STRONG objects bulldoze walls and annihilate each other. (Use SAFE if you also want STRONG things to be indestructible!)

**FLIP** - __Property__ Flips facing direction 180 degrees before any movement for the turn.

**YEET** - __Verb__ x YEET y means y is SHIFTed by x 99 times.

**DMOONWALK / DRUNK / DRUNKER / SKIP** - __Property__ Causes movement (YOU/MOVE/PUSH/PULL/SHIFT/SLIDE/SLIP/SLIPPERY) to be 180, 90 or 45 degrees 'wrong' respectively. SKIP makes movements go 2 tiles instead of 1! All 4 stack with each other and themselves!

**SLIP / SLIPPERY** - __Property__ Like slow SLIDE! Involuntary movement in the faced direction; prevents voluntary movement (YOU, MOVE) while you are slipping. Try 'ICE IS SLIPPERY' or ALL ON ICE IS SLIP' for ice physics!

**STUBBORN** - __Property__ Something that is MOVE and STUBBORN doesn't turn around when it hits a wall.

**LAZY** - __Property__ Something that is LAZY can't push or pull. ROCK IS PUSH AND LAZY gives you sokoban style 'max 1' pushing. KEKE IS MOVE AND LAZY gives you moving actors that don't shive things around with them.

Baba is You Discord server: https://discord.gg/GGbUUse

You may use these mods in your mod pack or custom world with attribution!
