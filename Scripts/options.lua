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
mod.enabled["phase"] = true

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
	colour = {4, 0},
	active = {4, 1},
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
	colour = {4, 0},
	active = {4, 1},
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
	colour = {4, 0},
	active = {4, 1},
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
	colour = {4, 0},
	active = {4, 1},
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
	colour = {4, 0},
	active = {4, 1},
	tile = {5, 12},
	layer = 20,
}

-- Current highest tile: {5, 12}