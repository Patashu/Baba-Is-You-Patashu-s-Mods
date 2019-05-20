local mod = {}

-- options.lua to edit
mod.enabled = {}
mod.tile = {}
mod.macros = {}

mod.tilecount = 0

-- Calls when a world is first loaded
function mod.load(dir)
	-- Load other script for mod config
	loadscript(dir .. "options")

	-- Load mod tiles enabled in options.lua
	for _,v in ipairs(mod.alltiles) do
		if mod.enabled[v] then
			mod.addblock(mod.tile[v])
		end
	end
	
	--load files
	loadscript(dir .. "movement")
	loadscript(dir .. "blocks")
	loadscript(dir .. "conditions")
	loadscript(dir .. "tools")
	loadscript(dir .. "effects")
	loadscript(dir .. "syntax")
	loadscript(dir .. "rules")
	loadscript(dir .. "map")
	loadscript(dir .. "changes")
	loadscript(dir .. "features")
	
	--and new stuff
	loadscript(dir .. "crc32")
end

-- Calls when another world is loaded while this mod is active
function mod.unload(dir)
	-- Remove custom tiles
	loadscript("Data/values")
	
	--unload files
	loadscript("Data/movement")
	loadscript("Data/blocks")
	loadscript("Data/conditions")
	loadscript("Data/tools")
	loadscript("Data/effects")
	loadscript("Data/syntax")
	loadscript("Data/rules")
	loadscript("Data/map")
	loadscript("Data/changes")
	loadscript("Data/features")
end

mod.alltiles = {
	"less",
	"slide",
	"stuck",
	"topple",
	"phase",
	"multiply",
	"divide",
	"faceaway",
	"faceside",
	"singlet",
	"capped",
	"straight",
	"corner",
	"edge",
	"inner",
	"strafe",
	"collect",
	"1st1",
	"last1",
	"maybe",
	"rarely",
	"megarare",
	"gigarare",
	"collide",
	"saccade",
	"destroy",
	"send",
	"receive",
	"crash",
	"bounce",
	"twist",
	"untwist",
	"reflect",
	"funnel",
	"dizzy",
	"flinch",
	"eventurn",
	"oddturn",
	"won",
	"unwin",
	"clear",
	"complete",
	"strong",
	"resend",
	"flip",
	"yeet",
	"moonwalk",
	"drunk",
	"slip",
	"slippery",
	"skip",
	"drunker",
	"stubborn",
	"lazy"
}

function mod.addblock(tile)
	if mod.tilecount >= 6 then
		return
	end

	local tileindex = 120 + mod.tilecount
	local tilename = "object" .. tileindex

	tileslist[tilename] = tile
	tileslist[tilename].grid = {11, mod.tilecount}

	mod.tilecount = mod.tilecount + 1
end

return mod