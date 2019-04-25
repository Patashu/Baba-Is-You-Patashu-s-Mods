local mod = {}

-- options.lua to edit
mod.enabled = {}
mod.tile = {}
mod.macros = {}

mod.tilecount = 0

local vanillaBlock = block

local function myBlock(small_)
	vanillaBlock(small_)
	-- implement LESS
	
	delthese = {}
	
	local isless = getunitswitheffect("less",delthese)
		
	for id,unit in ipairs(isless) do
		local x,y = unit.values[XPOS],unit.values[YPOS]
		local name = unit.strings[UNITNAME]
		
		if (issafe(unit.fixed) == false) then		
			local could_grow = false
			
			for i=1,4 do
				local drs = ndirs[i]
				ox = drs[1]
				oy = drs[2]
				
				local valid = true
				local obs = findobstacle(x+ox,y+oy)
				local tileid = (x+ox) + (y+oy) * roomsizex
				
				if (#obs > 0) then
					for a,b in ipairs(obs) do
						if (b == -1) then
							valid = false
						elseif (b ~= 0) and (b ~= -1) then
							local bunit = mmf.newObject(b)
							local obsname = bunit.strings[UNITNAME]
							local obstype = bunit.strings[UNITTYPE]
							
							if (obstype == "text") then
								obsname = "text"
							end
							
							local obsstop = hasfeature(obsname,"is","stop",b,x+ox,y+oy)
							local obspush = hasfeature(obsname,"is","push",b,x+ox,y+oy)
							local obspull = hasfeature(obsname,"is","pull",b,x+ox,y+oy)
							
							if (obsstop ~= nil) or (obspush ~= nil) or (obspull ~= nil) or (obsname == name) or (obstype == "text") then
								valid = false
							end
						end
					end
				end
				
				if valid then
					could_grow = true
					break
				end
			end
		
			if (could_grow) then
				local pmult,sound = checkeffecthistory("defeat")
				MF_particles("destroy",x,y,5 * pmult,0,3,1,1)
				table.insert(delthese, unit.fixed)
			end
		end
	end

	delthese,doremovalsound = handledels(delthese,doremovalsound)
end

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
	
	--hook functions
	block = myBlock
end

-- Calls when another world is loaded while this mod is active
function mod.unload(dir)
	-- Remove custom tiles
	loadscript("Data/values")
	
	--unload files
	loadscript("Data/movement")

	--unhook functions
	block = vanillaBlock
end

mod.alltiles = {
	"less",
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