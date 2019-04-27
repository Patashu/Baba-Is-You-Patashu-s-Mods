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
mod.enabled["faceaway"] = true
mod.enabled["faceside"] = true

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