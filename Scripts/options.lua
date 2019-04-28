local mod = activemod

---------------------------------------------------
--[[        BLOCK ENABLE/DISABLE OPTIONS       ]]--
---------------------------------------------------
-- !!! PLEASE ONLY ENABLE 6 BLOCKS AT A TIME !!! --
---------------------------------------------------

-- Properties
mod.enabled["less"] = true
mod.enabled["slide"] = true
mod.enabled["stuck"] = true
mod.enabled["topple"] = true
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
mod.enabled["1st1"] = true
mod.enabled["last1"] = true

---------------------------------------------------
--[[           MECHANIC OPTIONS                ]]--
---------------------------------------------------

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