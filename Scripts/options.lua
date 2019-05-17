local mod = activemod

---------------------------------------------------
--[[        BLOCK ENABLE/DISABLE OPTIONS       ]]--
---------------------------------------------------
-- !!! PLEASE ONLY ENABLE 6 BLOCKS AT A TIME !!! --
---------------------------------------------------

-- Properties
mod.enabled["less"] = false
mod.enabled["slide"] = false
mod.enabled["stuck"] = false
mod.enabled["topple"] = false
mod.enabled["phase"] = false
mod.enabled["multiply"] = false
mod.enabled["divide"] = false
mod.enabled["faceaway"] = false
mod.enabled["faceside"] = false
mod.enabled["singlet"] = false
mod.enabled["capped"] = false
mod.enabled["straight"] = false
mod.enabled["corner"] = false
mod.enabled["edge"] = false
mod.enabled["inner"] = false
mod.enabled["strafe"] = false
mod.enabled["collect"] = false
mod.enabled["1st1"] = false
mod.enabled["last1"] = false
mod.enabled["maybe"] = false
mod.enabled["rarely"] = false
mod.enabled["megarare"] = false
mod.enabled["gigarare"] = false
mod.enabled["collide"] = false
mod.enabled["saccade"] = false
mod.enabled["destroy"] = false
mod.enabled["send"] = true
mod.enabled["receive"] = true
mod.enabled["crash"] = false
mod.enabled["bounce"] = false
mod.enabled["twist"] = false
mod.enabled["untwist"] = false
mod.enabled["reflect"] = false
mod.enabled["funnel"] = false
mod.enabled["dizzy"] = false
mod.enabled["flinch"] = false
mod.enabled["eventurn"] = false
mod.enabled["oddturn"] = false
mod.enabled["won"] = false
mod.enabled["unwin"] = false
mod.enabled["clear"] = false
mod.enabled["complete"] = false
mod.enabled["strong"] = false
mod.enabled["resend"] = false
mod.enabled["flip"] = false
mod.enabled["yeet"] = false
mod.enabled["moonwalk"] = true
mod.enabled["drunk"] = true
mod.enabled["slip"] = true
mod.enabled["slippery"] = true

---------------------------------------------------
--[[           MECHANIC OPTIONS                ]]--
---------------------------------------------------

--If true, restarting/starting a puzzle will generate a new rng seed for use with MAYBE et all, instead of using the puzzle's name as the seed.
activemod.seed_rng_on_restart = true
--If true, MORE and related properties (LESS, MULTIPLY, DIVIDE, PRINT, MASSPROD) check empty as well as obstacles.
activemod.more_checks_empty = true
--debris copied from lily's mods, probably unnecessary?
activemod.condition_stacking = true
activemod.auto_speed = 20

--------------------------------
--[[ ADVANCED BLOCK OPTIONS ]]--
--------------------------------

mod.tile["less"] = {
	name = "text_less",
	sprite = "text_less",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {2, 1},
	active = {2, 2},
	tile = {1, 12},
	layer = 20,
}

mod.tile["slide"] = {
	name = "text_slide",
	sprite = "text_slide",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {2, 12},
	layer = 20,
}

mod.tile["stuck"] = {
	name = "text_stuck",
	sprite = "text_stuck",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {2, 0},
	active = {2, 1},
	tile = {3, 12},
	layer = 20,
}

mod.tile["topple"] = {
	name = "text_topple",
	sprite = "text_topple",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {3, 0},
	active = {3, 1},
	tile = {4, 12},
	layer = 20,
}

mod.tile["phase"] = {
	name = "text_phase",
	sprite = "text_phase",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {3, 2},
	active = {3, 3},
	tile = {5, 12},
	layer = 20,
}

mod.tile["multiply"] = {
	name = "text_multiply",
	sprite = "text_multiply",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {4, 0},
	active = {4, 1},
	tile = {6, 12},
	layer = 20,
}

mod.tile["divide"] = {
	name = "text_divide",
	sprite = "text_divide",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {2, 1},
	active = {2, 2},
	tile = {7, 12},
	layer = 20,
}

mod.tile["divide"] = {
	name = "text_divide",
	sprite = "text_divide",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {2, 1},
	active = {2, 2},
	tile = {7, 12},
	layer = 20,
}

mod.tile["faceaway"] = {
	name = "text_faceaway",
	sprite = "text_faceaway",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 7,
	operatortype = "cond_arg",
	colour = {0, 1},
	active = {0, 3},
	tile = {8, 12},
	layer = 20,
}

mod.tile["faceside"] = {
	name = "text_faceside",
	sprite = "text_faceside",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 7,
	operatortype = "cond_arg",
	colour = {0, 1},
	active = {0, 3},
	tile = {9, 12},
	layer = 20,
}

mod.tile["singlet"] = {
	name = "text_singlet",
	sprite = "text_singlet",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {10, 12},
	layer = 20,
}

mod.tile["capped"] = {
	name = "text_capped",
	sprite = "text_capped",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {11, 12},
	layer = 20,
}

mod.tile["straight"] = {
	name = "text_straight",
	sprite = "text_straight",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {12, 12},
	layer = 20,
}

mod.tile["corner"] = {
	name = "text_corner",
	sprite = "text_corner",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {0, 13},
	layer = 20,
}

mod.tile["edge"] = {
	name = "text_edge",
	sprite = "text_edge",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {1, 13},
	layer = 20,
}

mod.tile["inner"] = {
	name = "text_inner",
	sprite = "text_inner",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {2, 13},
	layer = 20,
}

mod.tile["strafe"] = {
	name = "text_strafe",
	sprite = "text_strafe",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 1},
	active = {1, 2},
	tile = {3, 13},
	layer = 20,
}

mod.tile["collect"] = {
	name = "text_collect",
	sprite = "text_collect",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {6, 1},
	active = {2, 4},
	tile = {4, 13},
	layer = 20,
}

mod.tile["1st1"] = {
	name = "text_1st1",
	sprite = "text_1st1",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {2, 1},
	active = {2, 2},
	tile = {5, 13},
	layer = 20,
}

mod.tile["last1"] = {
	name = "text_last1",
	sprite = "text_last1",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {2, 1},
	active = {2, 2},
	tile = {6, 13},
	layer = 20,
}

mod.tile["maybe"] = {
	name = "text_maybe",
	sprite = "text_maybe",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {7, 13},
	layer = 20,
}

mod.tile["rarely"] = {
	name = "text_rarely",
	sprite = "text_rarely",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {9, 13},
	layer = 20,
}

mod.tile["megarare"] = {
	name = "text_megarare",
	sprite = "text_megarare",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {10, 13},
	layer = 20,
}

mod.tile["gigarare"] = {
	name = "text_gigarare",
	sprite = "text_gigarare",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {0, 1},
	active = {0, 3},
	tile = {11, 13},
	layer = 20,
}

mod.tile["collide"] = {
	name = "text_collide",
	sprite = "text_collide",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 1,
	operatortype = "verb",
	colour = {5, 0},
	active = {5, 1},
	tile = {12, 13},
	layer = 20,
}

mod.tile["saccade"] = {
	name = "text_saccade",
	sprite = "text_saccade",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 1},
	active = {1, 2},
	tile = {13, 13},
	layer = 20,
}

mod.tile["destroy"] = {
	name = "text_destroy",
	sprite = "text_destroy",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {2, 1},
	active = {2, 2},
	tile = {0, 14},
	layer = 20,
}

mod.tile["send"] = {
	name = "text_send",
	sprite = "text_send",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {4, 0},
	active = {4, 1},
	tile = {1, 14},
	layer = 20,
}

mod.tile["receive"] = {
	name = "text_receive",
	sprite = "text_receive",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {4, 0},
	active = {4, 1},
	tile = {2, 14},
	layer = 20,
}

mod.tile["crash"] = {
	name = "text_crash",
	sprite = "text_crash",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 0},
	active = {1, 1},
	tile = {3, 14},
	layer = 20,
}

mod.tile["bounce"] = {
	name = "text_bounce",
	sprite = "text_bounce",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {4, 14},
	layer = 20,
}

mod.tile["twist"] = {
	name = "text_twist",
	sprite = "text_twist",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {5, 14},
	layer = 20,
}

mod.tile["untwist"] = {
	name = "text_untwist",
	sprite = "text_untwist",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {6, 14},
	layer = 20,
}

mod.tile["reflect"] = {
	name = "text_reflect",
	sprite = "text_reflect",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {7, 14},
	layer = 20,
}

mod.tile["funnel"] = {
	name = "text_funnel",
	sprite = "text_funnel",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {8, 14},
	layer = 20,
}

mod.tile["dizzy"] = {
	name = "text_dizzy",
	sprite = "text_dizzy",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 1},
	active = {1, 2},
	tile = {9, 14},
	layer = 20,
}

mod.tile["flinch"] = {
	name = "text_flinch",
	sprite = "text_flinch",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 1},
	active = {1, 2},
	tile = {10, 14},
	layer = 20,
}

mod.tile["eventurn"] = {
	name = "text_eventurn",
	sprite = "text_eventurn",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {3, 2},
	active = {3, 3},
	tile = {11, 14},
	layer = 20,
}

mod.tile["oddturn"] = {
	name = "text_oddturn",
	sprite = "text_oddturn",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {3, 2},
	active = {3, 3},
	tile = {12, 14},
	layer = 20,
}

mod.tile["won"] = {
	name = "text_won",
	sprite = "text_won",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {6, 1},
	active = {2, 4},
	tile = {13, 14},
	layer = 20,
}

mod.tile["unwin"] = {
	name = "text_unwin",
	sprite = "text_unwin",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 1},
	active = {1, 2},
	tile = {14, 14},
	layer = 20,
}

mod.tile["clear"] = {
	name = "text_clear",
	sprite = "text_clear",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {6, 1},
	active = {2, 4},
	tile = {0, 15},
	layer = 20,
}

mod.tile["complete"] = {
	name = "text_complete",
	sprite = "text_complete",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 3,
	operatortype = "cond_start",
	colour = {6, 1},
	active = {2, 4},
	tile = {1, 15},
	layer = 20,
}

mod.tile["strong"] = {
	name = "text_strong",
	sprite = "text_strong",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {5, 2},
	active = {5, 3},
	tile = {2, 15},
	layer = 20,
}

mod.tile["resend"] = {
	name = "text_resend",
	sprite = "text_resend",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {4, 0},
	active = {4, 1},
	tile = {3, 15},
	layer = 20,
}

mod.tile["flip"] = {
	name = "text_flip",
	sprite = "text_flip",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {4, 15},
	layer = 20,
}

mod.tile["yeet"] = {
	name = "text_yeet",
	sprite = "text_yeet",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 1,
	operatortype = "verb",
	colour = {0, 1},
	active = {0, 3},
	tile = {5, 15},
	layer = 20,
}

mod.tile["moonwalk"] = {
	name = "text_moonwalk",
	sprite = "text_moonwalk",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {6, 15},
	layer = 20,
}

mod.tile["drunk"] = {
	name = "text_drunk",
	sprite = "text_drunk",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {7, 15},
	layer = 20,
}

mod.tile["slip"] = {
	name = "text_slip",
	sprite = "text_slip",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {8, 15},
	layer = 20,
}

mod.tile["slippery"] = {
	name = "text_slippery",
	sprite = "text_slippery",
	sprite_in_root = false,
	unittype = "text",
	tiling = -1,
	type = 2,
	colour = {1, 3},
	active = {1, 4},
	tile = {9, 15},
	layer = 20,
}