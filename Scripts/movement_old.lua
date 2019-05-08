function movecommand(ox,oy,dir_,playerid_)
	statusblock()
	movelist = {}
	
	local take = 1
	local takecount = 3
	local finaltake = false
	
	local still_moving = {}
	
	local levelpush = -1
	local levelpull = -1
	local levelmove = findfeature("level","is","you")
	if (levelmove ~= nil) then
		local valid = false
		
		for i,v in ipairs(levelmove) do
			if (valid == false) and testcond(v[2],1) then
				valid = true
			end
		end
		
		if valid then
			local ndrs = ndirs[dir_ + 1]
			local ox,oy = ndrs[1],ndrs[2]
			
			addundo({"levelupdate",Xoffset,Yoffset,Xoffset + ox * tilesize,Yoffset + oy * tilesize,mapdir,dir_})
			MF_scrollroom(ox * tilesize,oy * tilesize)
			mapdir = dir_
			updateundo = true
		end
	end
	
	while (take <= takecount) or finaltake do
		local moving_units = {}
		local been_seen = {}
		
		if (finaltake == false) then
			if (dir_ ~= 4) and (take == 1) then
				local players = {}
				local empty = {}
				local playerid = 1
				
				if (playerid_ ~= nil) then
					playerid = playerid_
				end
				
				if (playerid == 1) then
					players,empty = findallfeature(nil,"is","you")
				elseif (playerid == 2) then
					players,empty = findallfeature(nil,"is","you2")
					
					if (#players == 0) then
						players,empty = findallfeature(nil,"is","you")
					end
				end
				
				for i,v in ipairs(players) do
					local sleeping = false
					
					if (v ~= 2) then
						local unit = mmf.newObject(v)
						
						local unitname = getname(unit)
						local sleep = hasfeature(unitname,"is","sleep",v)
						
						if (sleep ~= nil) then
							sleeping = true
						else
							updatedir(v, dir_)
						end
					else
						local thisempty = empty[i]
						
						for a,b in pairs(thisempty) do
							local x = a % roomsizex
							local y = math.floor(a / roomsizex)
							
							local sleep = hasfeature("empty","is","sleep",2,x,y)
							
							if (sleep ~= nil) then
								thisempty[a] = nil
							end
						end
					end
					
					if (sleeping == false) then
						if (been_seen[v] == nil) then
							local x,y = -1,-1
							if (v ~= 2) then
								local unit = mmf.newObject(v)
								x,y = unit.values[XPOS],unit.values[YPOS]
								
								table.insert(moving_units, {unitid = v, reason = "you", state = 0, moves = 1, dir = dir_, xpos = x, ypos = y})
								been_seen[v] = #moving_units
							else
								local thisempty = empty[i]
								
								for a,b in pairs(thisempty) do
									x = a % roomsizex
									y = math.floor(a / roomsizex)
								
									table.insert(moving_units, {unitid = 2, reason = "you", state = 0, moves = 1, dir = dir_, xpos = x, ypos = y})
									been_seen[v] = #moving_units
								end
							end
						else
							local id = been_seen[v]
							local this = moving_units[id]
							--this.moves = this.moves + 1
						end
					end
				end
			end
			
			if (take == 2) then
				local movers,mempty = findallfeature(nil,"is","move")
				moving_units,been_seen = add_moving_units("move",movers,moving_units,been_seen,mempty)
				
				local chillers,cempty = findallfeature(nil,"is","chill")
				moving_units,been_seen = add_moving_units("chill",chillers,moving_units,been_seen,cempty)
				
				local fears,empty = findallfeature(nil,"fear",nil)
				
				for i,v in ipairs(fears) do
					local valid,feardir = findfears(v)
					local sleeping = false
					
					if valid then
						if (v ~= 2) then
							local unit = mmf.newObject(v)
						
							local unitname = getname(unit)
							local sleep = hasfeature(unitname,"is","sleep",v)
							
							if (sleep ~= nil) then
								sleeping = true
							else
								updatedir(v, feardir)
							end
						else
							local thisempty = empty[i]
							
							for a,b in pairs(thisempty) do
								local x = a % roomsizex
								local y = math.floor(a / roomsizex)
								
								local sleep = hasfeature("empty","is","sleep",2,x,y)
								
								if (sleep ~= nil) then
									thisempty[a] = nil
								end
							end
						end
						
						if (sleeping == false) then
							if (been_seen[v] == nil) then
								local x,y = -1,-1
								if (v ~= 2) then
									local unit = mmf.newObject(v)
									x,y = unit.values[XPOS],unit.values[YPOS]
									
									table.insert(moving_units, {unitid = v, reason = "you", state = 0, moves = 1, dir = feardir, xpos = x, ypos = y})
									been_seen[v] = #moving_units
								else
									local thisempty = empty[i]
								
									for a,b in pairs(thisempty) do
										x = a % roomsizex
										y = math.floor(a / roomsizex)
									
										table.insert(moving_units, {unitid = 2, reason = "you", state = 0, moves = 1, dir = feardir, xpos = x, ypos = y})
										been_seen[v] = #moving_units
									end
								end
							else
								local id = been_seen[v]
								local this = moving_units[id]
								this.moves = this.moves + 1
							end
						end
					end
				end
			elseif (take == 3) then
				local shifts = findallfeature(nil,"is","shift",true)
				
				for i,v in ipairs(shifts) do
					if (v ~= 2) then
						local affected = {}
						local unit = mmf.newObject(v)
						
						local x,y = unit.values[XPOS],unit.values[YPOS]
						local tileid = x + y * roomsizex
						
						if (unitmap[tileid] ~= nil) then
							if (#unitmap[tileid] > 1) then
								for a,b in ipairs(unitmap[tileid]) do
									if (b ~= v) and floating(b,v) then
										local newunit = mmf.newObject(b)
										
										updatedir(b, unit.values[DIR])
										--newunit.values[DIR] = unit.values[DIR]
										
										if (been_seen[b] == nil) then
											table.insert(moving_units, {unitid = b, reason = "shift", state = 0, moves = 1, dir = unit.values[DIR], xpos = x, ypos = y})
											been_seen[b] = #moving_units
										else
											local id = been_seen[b]
											local this = moving_units[id]
											this.moves = this.moves + 1
										end
									end
								end
							end
						end
					end
				end
				
				local levelshift = findfeature("level","is","shift")
				
				if (levelshift ~= nil) then
					local leveldir = mapdir
						
					for a,unit in ipairs(units) do
						local x,y = unit.values[XPOS],unit.values[YPOS]
						
						if floating_level(unit.fixed) then
							updatedir(unit.fixed, leveldir)
							table.insert(moving_units, {unitid = unit.fixed, reason = "shift", state = 0, moves = 1, dir = unit.values[DIR], xpos = x, ypos = y})
						end
					end
				end
			end
		else
			for i,data in ipairs(still_moving) do
				if (data.unitid ~= 2) then
					local unit = mmf.newObject(data.unitid)
					
					table.insert(moving_units, {unitid = data.unitid, reason = data.reason, state = data.state, moves = data.moves, dir = unit.values[DIR], xpos = unit.values[XPOS], ypos = unit.values[YPOS]})
				else
					table.insert(moving_units, {unitid = data.unitid, reason = data.reason, state = data.state, moves = data.moves, dir = data.dir, xpos = -1, ypos = -1})
				end
			end
			
			still_moving = {}
		end
		
		local unitcount = #moving_units
			
		for i,data in ipairs(moving_units) do
			if (i <= unitcount) then
				if (data.unitid == 2) and (data.xpos == -1) and (data.ypos == -1) then
					local positions = getemptytiles()
					
					for a,b in ipairs(positions) do
						local x,y = b[1],b[2]
						table.insert(moving_units, {unitid = 2, reason = data.reason, state = data.state, moves = data.moves, dir = data.dir, xpos = x, ypos = y})
					end
				end
			else
				break
			end
		end
		
		local done = false
		local state = 0
		
		while (done == false) do
			local smallest_state = 99
			local delete_moving_units = {}
			
			for i,data in ipairs(moving_units) do
				local solved = false
				smallest_state = math.min(smallest_state,data.state)
				
				if (data.unitid == 0) then
					solved = true
				end
				
				if (data.state == state) and (data.moves > 0) and (data.unitid ~= 0) then
					local unit = {}
					local dir,name = 4,""
					local x,y = data.xpos,data.ypos
					
					if (data.unitid ~= 2) then
						unit = mmf.newObject(data.unitid)
						dir = unit.values[DIR]
						name = getname(unit)
						x,y = unit.values[XPOS],unit.values[YPOS]
					else
						dir = data.dir
						name = "empty"
					end
					
					if (x ~= -1) and (y ~= -1) then
						local result = -1
						solved = false
						
						if (state == 0) then
							if (data.reason == "chill") then
								dir = math.random(0,3)
								
								if (data.unitid ~= 2) then
									updatedir(data.unitid, dir)
									--unit.values[DIR] = dir
								end
							end
							
							if (data.reason == "move") and (data.unitid == 2) then
								dir = math.random(0,3)
							end
						elseif (state == 3) then
							if ((data.reason == "move") or (data.reason == "chill")) then
								dir = rotate(dir)
								
								if (data.unitid ~= 2) then
									updatedir(data.unitid, dir)
									--unit.values[DIR] = dir
								end
							end
						end
						
						local ndrs = ndirs[dir + 1]
						local ox,oy = ndrs[1],ndrs[2]
						local pushobslist = {}
						
						local obslist,allobs,specials = check(data.unitid,x,y,dir,false,data.reason)
						local pullobs,pullallobs,pullspecials = check(data.unitid,x,y,dir,true,data.reason)
						
						local swap = hasfeature(name,"is","swap",data.unitid,x,y)
						
						for c,obs in pairs(obslist) do
							if (solved == false) then
								if (obs == 0) then
									if (state == 0) then
										result = math.max(result, 0)
									else
										result = math.max(result, 0)
									end
								elseif (obs == -1) then
									result = math.max(result, 2)
									
									local levelpush_ = findfeature("level","is","push")
									
									if (levelpush_ ~= nil) then
										for e,f in ipairs(levelpush_) do
											if testcond(f[2],1) then
												levelpush = dir
											end
										end
									end
								else
									if (swap == nil) then
										if (#allobs == 0) then
											obs = 0
										end
										
										if (obs == 1) then
											local thisobs = allobs[c]
											local solid = true
											
											for f,g in pairs(specials) do
												if (g[1] == thisobs) and (g[2] == "weak") then
													solid = false
													obs = 0
													result = math.max(result, 0)
												end
											end
											
											if solid then
												if (state < 2) then
													data.state = math.max(data.state, 2)
													result = math.max(result, 2)
												else
													result = math.max(result, 2)
												end
											end
										else
											if (state < 1) then
												data.state = math.max(data.state, 1)
												result = math.max(result, 1)
											else
												table.insert(pushobslist, obs)
												result = math.max(result, 1)
											end
										end
									else
										result = math.max(result, 0)
									end
								end
							end
						end
						
						local result_check = false
						
						while (result_check == false) and (solved == false) do
							if (result == 0) then
								if (state > 0) then
									for j,jdata in pairs(moving_units) do
										if (jdata.state >= 2) then
											jdata.state = 0
										end
									end
								end
								
								table.insert(movelist, {data.unitid,ox,oy,dir,specials})
								--move(data.unitid,ox,oy,dir,specials)
								
								local swapped = {}
								
								if (swap ~= nil) then
									for a,b in ipairs(allobs) do
										if (b ~= -1) and (b ~= 2) and (b ~= 0) then
											addaction(b,{"update",x,y,nil})
											swapped[b] = 1
										end
									end
								end
								
								local swaps = findfeatureat(nil,"is","swap",x+ox,y+oy)
								if (swaps ~= nil) then
									for a,b in ipairs(swaps) do
										if (swapped[b] == nil) then
											addaction(b,{"update",x,y,nil})
										end
									end
								end
								
								local finalpullobs = {}
								
								for c,pobs in ipairs(pullobs) do
									if (pobs < -1) or (pobs > 1) then
										local paobs = pullallobs[c]
										
										local hm = trypush(paobs,ox,oy,dir,true,x,y,data.reason,data.unitid)
										if (hm == 0) then
											table.insert(finalpullobs, paobs)
										end
									elseif (pobs == -1) then
										local levelpull_ = findfeature("level","is","pull")
									
										if (levelpull_ ~= nil) then
											for e,f in ipairs(levelpull_) do
												if testcond(f[2],1) then
													levelpull = dir
												end
											end
										end
									end
								end
								
								for c,pobs in ipairs(finalpullobs) do
									pushedunits = {}
									dopush(pobs,ox,oy,dir,true,x,y,data.reason,data.unitid)
								end
								
								solved = true
							elseif (result == 1) then
								if (state < 1) then
									data.state = math.max(data.state, 1)
									result_check = true
								else
									local finalpushobs = {}
									
									for c,pushobs in ipairs(pushobslist) do
										local hm = trypush(pushobs,ox,oy,dir,false,x,y,data.reason)
										if (hm == 0) then
											table.insert(finalpushobs, pushobs)
										elseif (hm == 1) or (hm == -1) then
											result = math.max(result, 2)
										else
											MF_alert("HOO HAH")
											return
										end
									end
									
									if (result == 1) then
										for c,pushobs in ipairs(finalpushobs) do
											pushedunits = {}
											dopush(pushobs,ox,oy,dir,false,x,y,data.reason)
										end
										result = 0
									end
								end
							elseif (result == 2) then
								if (state < 2) then
									data.state = math.max(data.state, 2)
									result_check = true
								else
									if (state < 3) then
										data.state = math.max(data.state, 3)
										result_check = true
									else
										if ((data.reason == "move") or (data.reason == "chill")) and (state < 4) then
											data.state = math.max(data.state, 4)
											result_check = true
										else
											local weak = hasfeature(name,"is","weak",data.unitid,x,y)
											
											if (weak ~= nil) then
												delete(data.unitid,x,y)
												generaldata.values[SHAKE] = 3
												
												local pmult,sound = checkeffecthistory("weak")
												MF_particles("destroy",x,y,5 * pmult,0,3,1,1)
												setsoundname("removal",1,sound)
												data.moves = 1
											end
											solved = true
										end
									end
								end
							else
								result_check = true
							end
						end
					else
						solved = true
					end
				end
				
				if solved then
					data.moves = data.moves - 1
					data.state = 10
					
					local tunit = mmf.newObject(data.unitid)
					
					if (data.moves == 0) then
						--print(tunit.strings[UNITNAME] .. " - removed from queue")
						table.insert(delete_moving_units, i)
					else
						if (data.unitid ~= 2) or ((data.unitid == 2) and (data.xpos == -1) and (data.ypos == -1)) then
							table.insert(still_moving, {unitid = data.unitid, reason = data.reason, state = data.state, moves = data.moves, dir = data.dir, xpos = data.xpos, ypos = data.ypos})
						end
						--print(tunit.strings[UNITNAME] .. " - removed from queue")
						table.insert(delete_moving_units, i)
					end
				end
			end
			
			local deloffset = 0
			for i,v in ipairs(delete_moving_units) do
				local todel = v - deloffset
				table.remove(moving_units, todel)
				deloffset = deloffset + 1
			end
			
			if (#movelist > 0) then
				for i,data in ipairs(movelist) do
					move(data[1],data[2],data[3],data[4],data[5])
				end
			end
			
			movelist = {}
			
			if (smallest_state > state) then
				state = state + 1
			else
				state = smallest_state
			end
			
			if (#moving_units == 0) then
				doupdate()
				done = true
			end
		end

		if (#still_moving > 0) then
			finaltake = true
			moving_units = {}
		else
			finaltake = false
		end
		
		if (finaltake == false) then
			take = take + 1
		end
	end
	
	if (levelpush >= 0) then
		local ndrs = ndirs[levelpush + 1]
		local ox,oy = ndrs[1],ndrs[2]
		
		mapdir = levelpush
		
		addundo({"levelupdate",Xoffset,Yoffset,Xoffset + ox * tilesize,Yoffset + oy * tilesize,mapdir,levelpush})
		MF_scrollroom(ox * tilesize,oy * tilesize)
		updateundo = true
	end
	
	if (levelpull >= 0) then
		local ndrs = ndirs[levelpull + 1]
		local ox,oy = ndrs[1],ndrs[2]
		
		mapdir = levelpush
		
		addundo({"levelupdate",Xoffset,Yoffset,Xoffset + ox * tilesize,Yoffset + oy * tilesize,mapdir,levelpull})
		MF_scrollroom(ox * tilesize,oy * tilesize)
		updateundo = true
	end
	
	doupdate()
	code()
	conversion()
	doupdate()
	code()
	moveblock()
	
	if (dir_ ~= nil) then
		MF_mapcursor(ox,oy,dir_)
	end
end

function check(unitid,x,y,dir,pulling_,reason)
	local pulling = false
	if (pulling_ ~= nil) then
		pulling = pulling_
	end
	
	local dir_ = dir
	if pulling then
		dir_ = rotate(dir)
	end
	
	local ndrs = ndirs[dir_ + 1]
	local ox,oy = ndrs[1],ndrs[2]
	
	local result = {}
	local results = {}
	local specials = {}
	
	local emptystop = hasfeature("empty","is","stop",2,x+ox,y+oy)
	local emptypush = hasfeature("empty","is","push",2,x+ox,y+oy)
	local emptypull = hasfeature("empty","is","pull",2,x+ox,y+oy)
	local emptyswap = hasfeature("empty","is","swap",2,x+ox,y+oy)
	
	local unit = {}
	local name = ""
	
	if (unitid ~= 2) then
		unit = mmf.newObject(unitid)
		name = getname(unit)
	else
		name = "empty"
	end
	
	local lockpartner = ""
	local open = hasfeature(name,"is","open",unitid,x,y)
	local shut = hasfeature(name,"is","shut",unitid,x,y)
	local eat = hasfeature(name,"eat",nil,unitid,x,y)
	
	if (open ~= nil) then
		lockpartner = "shut"
	elseif (shut ~= nil) then
		lockpartner = "open"
	end
	
	local obs = findobstacle(x+ox,y+oy)
	
	if (#obs > 0) then
		for i,id in ipairs(obs) do
			if (id == -1) then
				table.insert(result, -1)
				table.insert(results, -1)
			else
				local obsunit = mmf.newObject(id)
				local obsname = getname(obsunit)
				
				local alreadymoving = findupdate(id,"update")
				local valid = true
				
				local localresult = 0
				
				if (#alreadymoving > 0) then
					for a,b in ipairs(alreadymoving) do
						local nx,ny = b[3],b[4]
						
						if ((nx ~= x) and (ny ~= y)) and ((reason == "shift") and (pulling == false)) then
							valid = false
						end
						
						if ((nx == x) and (ny == y + oy * 2)) or ((ny == y) and (nx == x + ox * 2)) then
							valid = false
						end
					end
				end
				
				if (lockpartner ~= "") and (pulling == false) then
					local partner = hasfeature(obsname,"is",lockpartner,id)
					
					if (partner ~= nil) and ((issafe(id) == false) or (issafe(unitid) == false)) and (floating(id, unitid)) then
						valid = false
						table.insert(specials, {id, "lock"})
					end
				end
				
				if (eat ~= nil) and (pulling == false) then
					local eats = hasfeature(name,"eat",obsname,unitid)
					
					if (eats ~= nil) and (issafe(id) == false) then
						valid = false
						table.insert(specials, {id, "eat"})
					end
				end
				
				local weak = hasfeature(obsname,"is","weak",id)
				if (weak ~= nil) and (pulling == false) then
					if (issafe(id) == false) then
						--valid = false
						table.insert(specials, {id, "weak"})
					end
				end
				
				local added = false
				
				if valid then
					--MF_alert("checking for solidity for " .. obsname .. " by " .. name .. " at " .. tostring(x) .. ", " .. tostring(y))
					
					local isstop = hasfeature(obsname,"is","stop",id)
					local ispush = hasfeature(obsname,"is","push",id)
					local ispull = hasfeature(obsname,"is","pull",id)
					local isswap = hasfeature(obsname,"is","swap",id)
					
					--MF_alert(obsname .. " -- stop: " .. tostring(isstop) .. ", push: " .. tostring(ispush))
					
					if (isstop ~= nil) and (obsname == "level") and (obsunit.visible == false) then
						isstop = nil
					end
					
					if (((isstop ~= nil) and (ispush == nil) and ((ispull == nil) or ((ispull ~= nil) and (pulling == false)))) or ((ispull ~= nil) and (pulling == false) and (ispush == nil))) and (isswap == nil) then
						if (weak == nil) then
							table.insert(result, 1)
							table.insert(results, id)
							localresult = 1
							added = true
						end
					end
					
					if (localresult ~= 1) and (localresult ~= -1) then
						if (ispush ~= nil) and (pulling == false) and (isswap == nil) then
							--MF_alert(obsname .. " added to push list")
							table.insert(result, id)
							table.insert(results, id)
							added = true
						end
						
						if (ispull ~= nil) and pulling then
							table.insert(result, id)
							table.insert(results, id)
							added = true
						end
					end
				end
				
				if (added == false) then
					table.insert(result, 0)
					table.insert(results, id)
				end
			end
		end
	else
		local localresult = 0
		local valid = true
		local bname = "empty"
		
		if (eat ~= nil) and (pulling == false) then
			local eats = hasfeature(name,"eat",bname,unitid,x+ox,y+oy)
			
			if (eats ~= nil) and (issafe(2,x+ox,y+oy) == false) then
				valid = false
				table.insert(specials, {2, "eat"})
			end
		end
		
		if (lockpartner ~= "") and (pulling == false) then
			local partner = hasfeature(bname,"is",lockpartner,2,x+ox,y+oy)
			
			if (partner ~= nil) and ((issafe(2,x+ox,y+oy) == false) or (issafe(unitid) == false)) then
				valid = false
				table.insert(specials, {2, "lock"})
			end
		end
		
		local weak = hasfeature(bname,"is","weak",2,x+ox,y+oy)
		if (weak ~= nil) and (pulling == false) then
			if (issafe(2,x+ox,y+oy) == false) then
				--valid = false
				table.insert(specials, {2, "weak"})
			end
		end
		
		local added = false
		
		if valid and (emptyswap == nil) then
			if (emptystop ~= nil) or ((emptypull ~= nil) and (pulling == false)) then
				localresult = 1
				table.insert(result, 1)
				table.insert(results, 2)
				added = true
			end
			
			if (localresult ~= 1) then
				if (emptypush ~= nil) or ((emptypull ~= nil) and pulling) then
					table.insert(result, 2)
					table.insert(results, 2)
				end
				added = true
			end
		end
		
		if (added == false) then
			table.insert(result, 0)
			table.insert(results, 2)
		end
	end
	
	if (#results == 0) then
		result = {0}
		results = {0}
	end
	
	return result,results,specials
end

function trypush(unitid,ox,oy,dir,pulling_,x_,y_,reason,pusherid)
	local x,y = 0,0
	local unit = {}
	local name = ""
	
	if (unitid ~= 2) then
		unit = mmf.newObject(unitid)
		x,y = unit.values[XPOS],unit.values[YPOS]
		name = getname(unit)
	else
		x = x_
		y = y_
		name = "empty"
	end
	
	local pulling = pulling_ or false
	
	local weak = hasfeature(name,"is","weak",unitid,x_,y_)

	if (weak == nil) or pulling then
		local hmlist,hms,specials = check(unitid,x,y,dir,false,reason)
		
		local result = 0
		
		for i,hm in pairs(hmlist) do
			local done = false
			
			while (done == false) do
				if (hm == 0) then
					result = math.max(0, result)
					done = true
				elseif (hm == 1) or (hm == -1) then
					if (pulling == false) or (pulling and (hms[i] ~= pusherid)) then
						result = math.max(1, result)
						done = true
					else
						result = math.max(0, result)
						done = true
					end
				else
					if (pulling == false) then
						hm = trypush(hm,ox,oy,dir,pulling,x+ox,y+oy,reason,unitid)
					else
						result = math.max(0, result)
						done = true
					end
				end
			end
		end
		
		return result
	else
		return 0
	end
end

function dopush(unitid,ox,oy,dir,pulling_,x_,y_,reason,pusherid)
	local pid2 = tostring(ox + oy * roomsizex) .. tostring(unitid)
	pushedunits[pid2] = 1
	
	local x,y = 0,0
	local unit = {}
	local name = ""
	local pushsound = false
	
	if (unitid ~= 2) then
		unit = mmf.newObject(unitid)
		x,y = unit.values[XPOS],unit.values[YPOS]
		name = getname(unit)
	else
		x = x_
		y = y_
		name = "empty"
	end
	
	local pulling = false
	if (pulling_ ~= nil) then
		pulling = pulling_
	end
	
	local swaps = findfeatureat(nil,"is","swap",x+ox,y+oy)
	if (swaps ~= nil) and ((unitid ~= 2) or ((unitid == 2) and (pulling == false))) then
		for a,b in ipairs(swaps) do
			if (pulling == false) or (pulling and (b ~= pusherid)) then
				local alreadymoving = findupdate(b,"update")
				local valid = true
				
				if (#alreadymoving > 0) then
					valid = false
				end
				
				if valid then
					addaction(b,{"update",x,y,nil})
				end
			end
		end
	end
	
	if pulling then
		local swap = hasfeature(name,"is","swap",unitid,x,y)
		
		if swap then
			local swapthese = findallhere(x+ox,y+oy)
			
			for a,b in ipairs(swapthese) do
				local alreadymoving = findupdate(b,"update")
				local valid = true
				
				if (#alreadymoving > 0) then
					valid = false
				end
				
				if valid then
					addaction(b,{"update",x,y,nil})
					pushsound = true
				end
			end
		end
	end

	local hm = 0
	
	if (HACK_MOVES < 10000) then
		local hmlist,hms,specials = check(unitid,x,y,dir,false,reason)
		local pullhmlist,pullhms,pullspecials = check(unitid,x,y,dir,true,reason)
		local result = 0
		
		local weak = hasfeature(name,"is","weak",unitid,x_,y_)
		
			--MF_alert(name .. " is looking... (" .. tostring(unitid) .. ")" .. ", " .. tostring(pulling))
		for i,obs in pairs(hmlist) do
			local done = false
			while (done == false) do
				if (obs == 0) then
					result = math.max(0, result)
					done = true
				elseif (obs == 1) or (obs == -1) then
					if (pulling == false) or (pulling and (hms[i] ~= pusherid)) then
						result = math.max(2, result)
						done = true
					else
						result = math.max(0, result)
						done = true
					end
				else
					if (pulling == false) or (pulling and (hms[i] ~= pusherid)) then
						result = math.max(1, result)
						done = true
					else
						result = math.max(0, result)
						done = true
					end
				end
			end
		end
			
		local finaldone = false
		
		while (finaldone == false) and (HACK_MOVES < 10000) do
			if (result == 0) then
				table.insert(movelist, {unitid,ox,oy,dir,specials})
				--move(unitid,ox,oy,dir,specials)
				pushsound = true
				finaldone = true
				hm = 0
				
				if (pulling == false) then
					for i,obs in ipairs(pullhmlist) do
						if (obs < -1) or (obs > 1) and (obs ~= pusherid) then
							if (obs ~= 2) then
								table.insert(movelist, {obs,ox,oy,dir,pullspecials})
								pushsound = true
								--move(obs,ox,oy,dir,specials)
							end
							
							local pid = tostring(x-ox + (y-oy) * roomsizex) .. tostring(obs)
							
							if (pushedunits[pid] == nil) then
								pushedunits[pid] = 1
								hm = dopush(obs,ox,oy,dir,true,x-ox,y-oy,reason,unitid)
							end
						end
					end
				end
			elseif (result == 1) then
				for i,v in ipairs(hmlist) do
					if (v ~= -1) and (v ~= 0) and (v ~= 1) then
						local pid = tostring(x+ox + (y+oy) * roomsizex) .. tostring(v)
						
						if (pulling == false) or (pulling and (hms[i] ~= pusherid)) and (pushedunits[pid] == nil) then
							pushedunits[pid] = 1
							hm = dopush(v,ox,oy,dir,false,x+ox,y+oy,reason,unitid)
						end
					end
				end
				
				if (hm == 0) then
					result = 0
				else
					result = 2
				end
			elseif (result == 2) then
				hm = 1
				
				if (weak ~= nil) then
					delete(unitid,x,y)
					
					local pmult,sound = checkeffecthistory("weak")
					setsoundname("removal",1,sound)
					generaldata.values[SHAKE] = 3
					MF_particles("destroy",x,y,5 * pmult,0,3,1,1)
					result = 0
					hm = 0
				end
				
				finaldone = true
			end
		end
		
		if pulling and (HACK_MOVES < 10000) then
			hmlist,hms,specials = check(unitid,x,y,dir,pulling,reason)
			hm = 0
			
			for i,obs in pairs(hmlist) do
				if (obs < -1) or (obs > 1) then
					if (obs ~= 2) then
						table.insert(movelist, {obs,ox,oy,dir,specials})
						pushsound = true
						--move(obs,ox,oy,dir,specials)
					end
					
					local pid = tostring(x-ox + (y-oy) * roomsizex) .. tostring(obs)
					
					if (pushedunits[pid] == nil) then
						pushedunits[pid] = 1
						hm = dopush(obs,ox,oy,dir,pulling,x-ox,y-oy,reason,unitid)
					end
				end
			end
		end
		
		if pushsound and (generaldata2.strings[TURNSOUND] == "") then
			setsoundname("turn",5)
		end
	end
	
	HACK_MOVES = HACK_MOVES + 1
	
	return hm
end

function move(unitid,ox,oy,dir,specials_,instant_,simulate_)
	local instant = instant_ or false
	local simulate = simulate_ or false
	
	if (unitid ~= 2) then
		local unit = mmf.newObject(unitid)
		local x,y = unit.values[XPOS],unit.values[YPOS]
		
		local specials = {}
		if (specials_ ~= nil) then
			specials = specials_
		end
		
		local gone = false
		
		for i,v in pairs(specials) do
			if (gone == false) then
				local b = v[1]
				local reason = v[2]
				local dodge = false
				
				local bx,by = 0,0
				if (b ~= 2) then
					local bunit = mmf.newObject(b)
					bx,by = bunit.values[XPOS],bunit.values[YPOS]
					
					if (bx ~= x+ox) or (by ~= y+oy) then
						dodge = true
					else
						for c,d in ipairs(movelist) do
							if (d[1] == b) then
								local nx,ny = d[2],d[3]
								
								--print(tostring(nx) .. "," .. tostring(ny) .. " --> " .. tostring(x+ox) .. "," .. tostring(y+oy) .. " (" .. tostring(bx) .. "," .. tostring(by) .. ")")
								if (nx ~= x+ox) or (ny ~= y+oy) then
									dodge = true
								end
							end
						end
					end
				else
					bx,by = x+ox,y+oy
				end
				
				if (dodge == false) then
					if (reason == "lock") then
						local unlocked = false
						local valid = true
						local soundshort = ""
						
						if (b ~= 2) then
							local bunit = mmf.newObject(b)
							
							if bunit.flags[DEAD] then
								valid = false
							end
						end
						
						if unit.flags[DEAD] then
							valid = false
						end
						
						if valid then
							local pmult = 1.0
							local effect1 = false
							local effect2 = false
							
							if (issafe(b,bx,by) == false) then
								delete(b,bx,by)
								unlocked = true
								effect1 = true
							end
							
							if (issafe(unitid) == false) then
								delete(unitid,x,y)
								unlocked = true
								gone = true
								effect2 = true
							end
							
							if effect1 or effect2 then
								local pmult,sound = checkeffecthistory("unlock")
								soundshort = sound
							end
							
							if effect1 then
								MF_particles("unlock",bx,by,15 * pmult,2,4,1,1)
								generaldata.values[SHAKE] = 8
							end
							
							if effect2 then
								MF_particles("unlock",x,y,15 * pmult,2,4,1,1)
								generaldata.values[SHAKE] = 8
							end
						end
						
						if unlocked then
							setsoundname("turn",7,soundshort)
						end
					elseif (reason == "eat") then
						local pmult,sound = checkeffecthistory("eat")
						MF_particles("eat",bx,by,10 * pmult,0,3,1,1)
						generaldata.values[SHAKE] = 3
						delete(b,bx,by)
						
						setsoundname("removal",1,sound)
					elseif (reason == "weak") then
						--[[
						MF_particles("destroy",bx,by,5,0,3,1,1)
						generaldata.values[SHAKE] = 3
						delete(b,bx,by)
						]]--
					end
				end
			end
		end
		
		if (gone == false) and (simulate == false) then
			if instant then
				update(unitid,x+ox,y+oy,dir)
				MF_alert("Instant movement on " .. tostring(unitid))
			else
				addaction(unitid,{"update",x+ox,y+oy,dir})
			end
			
			if unit.visible and (#movelist < 700) then
				if (generaldata.values[DISABLEPARTICLES] == 0) then
					local effectid = MF_effectcreate("effect_bling")
					local effect = mmf.newObject(effectid)
					
					local midx = math.floor(roomsizex * 0.5)
					local midy = math.floor(roomsizey * 0.5)
					local mx = x - midx
					local my = y - midy
					
					local c1,c2 = getcolour(unitid)
					MF_setcolour(effectid,c1,c2)
					
					local xvel,yvel = 0,0
					
					if (ox ~= 0) then
						xvel = 0 - ox / math.abs(ox)
					end
					
					if (oy ~= 0) then
						yvel = 0 - oy / math.abs(oy)
					end
					
					local dx = mx + 0.5
					local dy = my + 0.75
					local dxvel = xvel
					local dyvel = yvel
					
					if (generaldata2.values[ROOMROTATION] == 90) then
						dx = my + 0.75
						dy = 0 - mx - 0.5
						dxvel = yvel
						dyvel = 0 - xvel
					elseif (generaldata2.values[ROOMROTATION] == 180) then
						dx = 0 - mx - 0.5
						dy = 0 - my - 0.75
						dxvel = 0 - xvel
						dyvel = 0 - yvel
					elseif (generaldata2.values[ROOMROTATION] == 270) then
						dx = 0 - my - 0.75
						dy = mx + 0.5
						dxvel = 0 - yvel
						dyvel = xvel
					end
					
					effect.values[ONLINE] = 3
					effect.values[XPOS] = Xoffset + (midx + (dx) * generaldata2.values[ZOOM]) * tilesize * spritedata.values[TILEMULT]
					effect.values[YPOS] = Yoffset + (midy + (dy) * generaldata2.values[ZOOM]) * tilesize * spritedata.values[TILEMULT]
					effect.scaleX = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
					effect.scaleY = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
					
					effect.values[XVEL] = dxvel * math.random(10,30) * 0.1 * spritedata.values[TILEMULT] * generaldata2.values[ZOOM]
					effect.values[YVEL] = dyvel * math.random(10,30) * 0.1 * spritedata.values[TILEMULT] * generaldata2.values[ZOOM]
				end
				
				if (unit.values[TILING] == 2) then
					unit.values[VISUALDIR] = ((unit.values[VISUALDIR] + 1) + 4) % 4
				end
			end
		end
		
		return gone
	end
end

function add_moving_units(rule,newdata,data,been_seen,empty_)
	local result = data
	local seen = been_seen
	local empty = empty_ or {}
	
	for i,v in ipairs(newdata) do
		local sleeping = false
		
		if (v ~= 2) then
			local unit = mmf.newObject(v)
			local unitname = getname(unit)
			local sleep = hasfeature(unitname,"is","sleep",v)
			
			if (sleep ~= nil) then
				sleeping = true
			end
		else
			local thisempty = empty[i]
			
			for a,b in pairs(thisempty) do
				local x = a % roomsizex
				local y = math.floor(a / roomsizex)
				
				local sleep = hasfeature("empty","is","sleep",2,x,y)
				
				if (sleep ~= nil) then
					thisempty[a] = nil
				end
			end
		end
		
		if (sleeping == false) then
			if (seen[v] == nil) then
				-- Dir set only for the purposes of Empty
				local dir_ = math.random(0,3)
				
				local x,y = -1,-1
				if (v ~= 2) then
					local unit = mmf.newObject(v)
					x,y = unit.values[XPOS],unit.values[YPOS]
					
					table.insert(result, {unitid = v, reason = rule, state = 0, moves = 1, dir = dir_, xpos = x, ypos = y})
					seen[v] = #result
				else
					local thisempty = empty[i]
				
					for a,b in pairs(thisempty) do
						x = a % roomsizex
						y = math.floor(a / roomsizex)
					
						table.insert(result, {unitid = 2, reason = rule, state = 0, moves = 1, dir = dir_, xpos = x, ypos = y})
						seen[v] = #result
					end
				end
			else
				local id = seen[v]
				local this = result[id]
				this.moves = this.moves + 1
			end
		end
	end
	
	return result,seen
end