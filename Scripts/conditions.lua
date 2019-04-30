function testcond(conds,unitid,x_,y_)
	local result = true
	
	local x,y,name,dir = 0,0,"",4
	local surrounds = {}
	
	-- 0 = bug, 1 = level, 2 = empty
	
	if (unitid ~= 2) and (unitid ~= 0) and (unitid ~= 1) then
		local unit = mmf.newObject(unitid)
		x = unit.values[XPOS]
		y = unit.values[YPOS]
		name = unit.strings[UNITNAME]
		dir = unit.values[DIR]
		
		if (unit.strings[UNITTYPE] == "text") then
			name = "text"
		end
	elseif (unitid == 2) then
		x = x_
		y = y_
		name = "empty"
	elseif (unitid == 1) then
		name = "level"
		surrounds = parsesurrounds()
		dir = tonumber(surrounds.dir)
	end
	
	if (unitid == 0) then
		print("WARNING!! Unitid is zero!!")
	end
	
	if (conds ~= nil) then
		if (#conds > 0) then
			local valid = false
			
			for i,cond in ipairs(conds) do
				local condtype = cond[1]
				local params = cond[2]
				
				local extras = {}
				
				local isnot = string.sub(condtype, 1, 3)
				
				if (isnot == "not") then
					isnot = string.sub(condtype, 5)
				else
					isnot = condtype
				end
				
				if (condtype ~= "never") then
					local conddata = conditions[isnot]
					if (conddata.argextra ~= nil) then
						extras = conddata.argextra
					end
				end
				
				if (condtype == "never") then
					result = false
					valid = true
				elseif (condtype == "on") then
					valid = true
					local allfound = 0
					local alreadyfound = {}
					
					local tileid = x + y * roomsizex
					
					if (#params > 0) then
						for a,b in ipairs(params) do
							if (unitid ~= 1) then
								if (b ~= "empty") and (b ~= "level") then
									if (unitmap[tileid] ~= nil) then
										for c,d in ipairs(unitmap[tileid]) do
											if (d ~= unitid) then
												local unit = mmf.newObject(d)
												local name_ = getname(unit)
												
												if (name_ == b) and (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
											end
										end
									else
										print("unitmap is nil at " .. tostring(x) .. ", " .. tostring(y) .. " for object " .. unit.strings[UNITNAME] .. " (" .. tostring(unitid) .. ")!")
									end
								elseif (b == "empty") then
									result = false
								elseif (b == "level") then
									alreadyfound[b] = 1
									allfound = allfound + 1
								end
							else
								local ulist = false
								
								if (b ~= "empty") and (b ~= "level") then
									if (unitlists[b] ~= nil) then
										if (#unitlists[b] > 0) then
											ulist = true
										end
									end
								elseif (b == "empty") then
									local empties = findempty()
									
									if (#findempty > 0) then
										ulist = true
									end
								end
								
								if (b ~= "text") and (ulist == false) then
									if (surrounds["o"] ~= nil) then
										for c,d in ipairs(surrounds["o"]) do
											if (d == b) then
												ulist = true
											end
										end
									end
								end
								
								if ulist or (b == "text") then
									if (alreadyfound[b] == nil) then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								end
							end
						end
					else
						print("no parameters given!")
					end
					
					--MF_alert(tostring(allfound) .. ", " .. tostring(#params) .. " for " .. name)
					
					if (allfound ~= #params) then
						result = false
					end
				elseif (condtype == "not on") then
					valid = true
					local tileid = x + y * roomsizex
					
					if (#params > 0) then
						for a,b in ipairs(params) do
							if (unitid ~= 1) then
								if (b ~= "empty") and (b ~= "level") then
									if (unitmap[tileid] ~= nil) then
										for c,d in ipairs(unitmap[tileid]) do
											if (d ~= unitid) then
												local unit = mmf.newObject(d)
												local name_ = getname(unit)
												
												if (name_ == b) then
													result = false
												end
											end
										end
									else
										print("unitmap is nil at " .. tostring(x) .. ", " .. tostring(y) .. "!")
									end
								elseif (b == "empty") then
									local onempty = false

									if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then 
										onempty = true
									end
									
									if onempty then
										result = false
									end
								elseif (b == "level") then
									result = false
								end
							else
								if (b ~= "empty") and (b ~= "level") and (b ~= "text") then
									if (unitlists[b] ~= nil) then
										if (#unitlists[b] > 0) then
											result = false
										end
									end
								elseif (b == "empty") then
									local empties = findempty()
									
									if (#findempty > 0) then
										result = false
									end
								elseif (b == "text") then
									result = false
								end
								
								if result then
									if (surrounds["o"] ~= nil) then
										for c,d in ipairs(surrounds["o"]) do
											if (d == b) then
												result = false
											end
										end
									end
								end
							end
						end
					else
						print("no parameters given!")
					end
				elseif (condtype == "facing") then
					valid = true
					local allfound = 0
					local alreadyfound = {}
					
					local ndrs = ndirs[dir+1]
					local ox = ndrs[1]
					local oy = ndrs[2]
					
					local tileid = (x + ox) + (y + oy) * roomsizex
					
					if (#params > 0) then
						if (name ~= "empty") then
							for a,b in ipairs(params) do
								if (unitid ~= 1) then
									if (b ~= "empty") and (b ~= "level") then
										if (stringintable(b,extras) == false) then
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (name_ == b) and (alreadyfound[b] == nil) then
															alreadyfound[b] = 1
															allfound = allfound + 1
														end
													end
												end
											end
										else
											if ((b == "right") and (dir == 0)) or ((b == "up") and (dir == 1)) or ((b == "left") and (dir == 2)) or ((b == "down") and (dir == 3)) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									elseif (b == "empty") then
										if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then
											if (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									elseif (b == "level") then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								else
									local dirids = {"r","u","l","d"}
									local dirid = dirids[dir + 1]
									
									if (surrounds[dirid] ~= nil) then
										for c,d in ipairs(surrounds[dirid]) do
											if (d == b) and (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									end
								end
							end
						else
							result = false
						end
					else
						print("no parameters given!")
					end
					
					if (allfound ~= #params) then
						result = false
					end
				elseif (condtype == "not facing") then
					valid = true

					local ndrs = ndirs[dir+1]
					local ox = ndrs[1]
					local oy = ndrs[2]
					
					local tileid = (x + ox) + (y + oy) * roomsizex
					
					if (#params > 0) then
						if (name ~= "empty") then
							for a,b in ipairs(params) do
								if (unitid ~= 1) then
									if (b ~= "empty") and (b ~= "level") then
										if (stringintable(b, extras) == false) then
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (name_ == b) then
															result = false
														end
													end
												end
											end
										else
											if ((b == "right") and (dir == 0)) or ((b == "up") and (dir == 1)) or ((b == "left") and (dir == 2)) or ((b == "down") and (dir == 3)) then
												result = false
											end
										end
									elseif (b == "empty") then
										if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then
											result = false
										end
									elseif (b == "level") then
										result = false
									end
								else
									local dirids = {"r","u","l","d"}
									local dirid = dirids[dir + 1]
									
									if (surrounds[dirid] ~= nil) then
										for c,d in ipairs(surrounds[dirid]) do
											if (d == b) and (alreadyfound[b] == nil) then
												result = false
											end
										end
									end
								end
							end
						elseif (name == "empty") then
							result = false
						end
					else
						print("no parameters given!")
					end
				elseif (condtype == "faceaway") then
					valid = true
					local allfound = 0
					local alreadyfound = {}
					
					--gets the opposite direction. don't ask.
					local ndrs = ndirs[(dir+2)%4+1]
					local ox = ndrs[1]
					local oy = ndrs[2]
					
					local tileid = (x + ox) + (y + oy) * roomsizex
					
					if (#params > 0) then
						if (name ~= "empty") then
							for a,b in ipairs(params) do
								if (unitid ~= 1) then
									if (b ~= "empty") and (b ~= "level") then
										if (stringintable(b,extras) == false) then
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (name_ == b) and (alreadyfound[b] == nil) then
															alreadyfound[b] = 1
															allfound = allfound + 1
														end
													end
												end
											end
										else
											if ((b == "right") and (dir == 2)) or ((b == "up") and (dir == 3)) or ((b == "left") and (dir == 0)) or ((b == "down") and (dir == 1)) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									elseif (b == "empty") then
										if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then
											if (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									elseif (b == "level") then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								else
									local dirids = {"r","u","l","d"}
									local dirid = dirids[(dir+2)%4+1]
									
									if (surrounds[dirid] ~= nil) then
										for c,d in ipairs(surrounds[dirid]) do
											if (d == b) and (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									end
								end
							end
						else
							result = false
						end
					else
						print("no parameters given!")
					end
					
					if (allfound ~= #params) then
						result = false
					end
				elseif (condtype == "not faceaway") then
					valid = true

					local ndrs = ndirs[(dir+2)%4+1]
					local ox = ndrs[1]
					local oy = ndrs[2]
					
					local tileid = (x + ox) + (y + oy) * roomsizex
					
					if (#params > 0) then
						if (name ~= "empty") then
							for a,b in ipairs(params) do
								if (unitid ~= 1) then
									if (b ~= "empty") and (b ~= "level") then
										if (stringintable(b, extras) == false) then
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (name_ == b) then
															result = false
														end
													end
												end
											end
										else
											if ((b == "right") and (dir == 2)) or ((b == "up") and (dir == 3)) or ((b == "left") and (dir == 0)) or ((b == "down") and (dir == 1)) then
												result = false
											end
										end
									elseif (b == "empty") then
										if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then
											result = false
										end
									elseif (b == "level") then
										result = false
									end
								else
									local dirids = {"r","u","l","d"}
									local dirid = dirids[(dir+2)%4+1]
									
									if (surrounds[dirid] ~= nil) then
										for c,d in ipairs(surrounds[dirid]) do
											if (d == b) and (alreadyfound[b] == nil) then
												result = false
											end
										end
									end
								end
							end
						elseif (name == "empty") then
							result = false
						end
					else
						print("no parameters given!")
					end
				elseif (condtype == "faceside") then
					valid = true
					local allfound = 0
					local alreadyfound = {}

					local ndrs = ndirs[(dir+1)%4+1]
					local ox = ndrs[1]
					local oy = ndrs[2]
					
					local tileid = (x + ox) + (y + oy) * roomsizex
					
					local ndrs = ndirs[(dir+3)%4+1]
					local ox = ndrs[1]
					local oy = ndrs[2]
					
					local tileid2 = (x + ox) + (y + oy) * roomsizex
					
					if (#params > 0) then
						if (name ~= "empty") then
							for a,b in ipairs(params) do
								if (unitid ~= 1) then
									if (b ~= "empty") and (b ~= "level") then
										if (stringintable(b, extras) == false) then
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (name_ == b) and (alreadyfound[b] == nil) then
															alreadyfound[b] = 1
															allfound = allfound + 1
														end
													end
												end
											end
											if (unitmap[tileid2] ~= nil) then
												for c,d in ipairs(unitmap[tileid2]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (name_ == b) and (alreadyfound[b] == nil) then
															alreadyfound[b] = 1
															allfound = allfound + 1
														end
													end
												end
											end
										else
											if ((b == "right") and (dir == 1 or dir == 3)) or ((b == "up") and (dir == 0 or dir == 2)) or ((b == "left") and (dir == 1 or dir == 3)) or ((b == "down") and (dir == 0 or dir == 2)) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									elseif (b == "empty") then
										if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then
											if (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
										if (unitmap[tileid2] == nil) or (#unitmap[tileid2] == 0) then
											if (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									elseif (b == "level") then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								else
									local dirids = {"r","u","l","d"}
									local dirid = dirids[(dir+1)%4+1]
									
									if (surrounds[dirid] ~= nil) then
										for c,d in ipairs(surrounds[dirid]) do
											if (d == b) and (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									end
									local dirid = dirids[(dir+3)%4+1]
									
									if (surrounds[dirid] ~= nil) then
										for c,d in ipairs(surrounds[dirid]) do
											if (d == b) and (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									end
								end
							end
						else
							result = false
						end
					else
						print("no parameters given!")
					end
					
					if (allfound ~= #params) then
						result = false
					end
				elseif (condtype == "not faceside") then
					valid = true

					local ndrs = ndirs[(dir+1)%4+1]
					local ox = ndrs[1]
					local oy = ndrs[2]
					
					local tileid = (x + ox) + (y + oy) * roomsizex
					
					local ndrs = ndirs[(dir+3)%4+1]
					local ox = ndrs[1]
					local oy = ndrs[2]
					
					local tileid2 = (x + ox) + (y + oy) * roomsizex
					
					if (#params > 0) then
						if (name ~= "empty") then
							for a,b in ipairs(params) do
								if (unitid ~= 1) then
									if (b ~= "empty") and (b ~= "level") then
										if (stringintable(b, extras) == false) then
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (name_ == b) then
															result = false
														end
													end
												end
											end
											if (unitmap[tileid2] ~= nil) then
												for c,d in ipairs(unitmap[tileid2]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (name_ == b) then
															result = false
														end
													end
												end
											end
										else
											if ((b == "right") and (dir == 1 or dir == 3)) or ((b == "up") and (dir == 0 or dir == 2)) or ((b == "left") and (dir == 1 or dir == 3)) or ((b == "down") and (dir == 0 or dir == 2)) then
												result = false
											end
										end
									elseif (b == "empty") then
										if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then
											result = false
										end
										if (unitmap[tileid2] == nil) or (#unitmap[tileid2] == 0) then
											result = false
										end
									elseif (b == "level") then
										result = false
									end
								else
									local dirids = {"r","u","l","d"}
									local dirid = dirids[(dir+1)%4+1]
									
									if (surrounds[dirid] ~= nil) then
										for c,d in ipairs(surrounds[dirid]) do
											if (d == b) and (alreadyfound[b] == nil) then
												result = false
											end
										end
									end
									local dirid = dirids[(dir+3)%4+1]
									
									if (surrounds[dirid] ~= nil) then
										for c,d in ipairs(surrounds[dirid]) do
											if (d == b) and (alreadyfound[b] == nil) then
												result = false
											end
										end
									end
								end
							end
						elseif (name == "empty") then
							result = false
						end
					else
						print("no parameters given!")
					end
				elseif (condtype == "near") then
					valid = true
					local allfound = 0
					local alreadyfound = {}
					
					if (#params > 0) then
						for a,b in ipairs(params) do
							if (unitid ~= 1) then
								if (b ~= "level") then
									for g=-1,1 do
										for h=-1,1 do
											if (b ~= "empty") then
												local tileid = (x + g) + (y + h) * roomsizex
												if (unitmap[tileid] ~= nil) then
													for c,d in ipairs(unitmap[tileid]) do
														if (d ~= unitid) then
															local unit = mmf.newObject(d)
															local name_ = getname(unit)
															
															if (name_ == b) and (alreadyfound[b] == nil) then
																alreadyfound[b] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											else
												local nearempty = false
										
												local tileid = (x + g) + (y + h) * roomsizex
												if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then 
													nearempty = true
												end
												
												if nearempty and (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								elseif (b == "level") then
									alreadyfound[b] = 1
									allfound = allfound + 1
								end
							else
								local ulist = false
							
								if (b ~= "empty") and (b ~= "level") then
									if (unitlists[b] ~= nil) then
										if (#unitlists[b] > 0) then
											ulist = true
										end
									end
								elseif (b == "empty") then
									local empties = findempty()
									
									if (#findempty > 0) then
										ulist = true
									end
								end
								
								if (b ~= "text") and (ulist == false) then
									for e,f in pairs(surrounds) do
										if (e ~= "dir") then
											for c,d in ipairs(f) do
												if (ulist == false) and (d == b) then
													ulist = true
												end
											end
										end
									end
								end
								
								if ulist or (b == "text") then
									if (alreadyfound[b] == nil) then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								end
							end
						end
					else
						print("no parameters given!")
					end

					if (allfound ~= #params) then
						result = false
					end
				elseif (condtype == "not near") then
					valid = true
					
					if (#params > 0) then
						for a,b in ipairs(params) do
							if (unitid ~= 1) then
								if (b ~= "level") then
									for g=-1,1 do
										for h=-1,1 do
											if (b ~= "empty") then
												local tileid = (x + g) + (y + h) * roomsizex
												if (unitmap[tileid] ~= nil) then
													for c,d in ipairs(unitmap[tileid]) do
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (name_ == b) then
															result = false
														end
													end
												end
											else
												local nearempty = false
										
												local tileid = (x + g) + (y + h) * roomsizex
												if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then 
													nearempty = true
												end
												
												if nearempty then
													result = false
												end
											end
										end
									end
								else
									result = false
								end
							else
								local ulist = false
							
								if (b ~= "empty") and (b ~= "level") and (b ~= "text") then
									if (unitlists[b] ~= nil) then
										if (#unitlists[b] > 0) then
											result = false
										end
									end
								elseif (b == "empty") then
									local empties = findempty()
									
									if (#findempty > 0) then
										result = false
									end
								elseif (b == "text") then
									result = false
								end
								
								if (b ~= "text") and result then
									for e,f in pairs(surrounds) do
										if (e ~= "dir") then
											for c,d in ipairs(f) do
												if result and (d == b) then
													result = false
												end
											end
										end
									end
								end
							end
						end
					else
						print("no parameters given!")
					end
				elseif (condtype == "singlet") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = sides == 0
				elseif (condtype == "not singlet") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = sides ~= 0
				elseif (condtype == "capped") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = sides == 1
				elseif (condtype == "not capped") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = sides ~= 1
				elseif (condtype == "straight") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = (sidecount == ((1 << 0) + (1 << 2)) or sidecount == ((1 << 1) + (1 << 3)))
				elseif (condtype == "not straight") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = (sidecount ~= ((1 << 0) + (1 << 2)) and sidecount ~= ((1 << 1) + (1 << 3)))
				elseif (condtype == "corner") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = (sidecount == ((1 << 0) + (1 << 1)) or sidecount == ((1 << 1) + (1 << 2)) or sidecount == ((1 << 2) + (1 << 3)) or sidecount == ((1 << 3) + (1 << 0)))
				elseif (condtype == "not corner") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = (sidecount ~= ((1 << 0) + (1 << 1)) and sidecount ~= ((1 << 1) + (1 << 2)) and sidecount ~= ((1 << 2) + (1 << 3)) and sidecount ~= ((1 << 3) + (1 << 0)))
				elseif (condtype == "edge") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = sides == 3
				elseif (condtype == "not edge") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = sides ~= 3
				elseif (condtype == "inner") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = sides == 4
				elseif (condtype == "not inner") then
					valid = true
					sides, sidecount = countsides(unitid, name, x, y)
					result = sides ~= 4
				elseif (condtype == "maybe") then
					valid = true
					result = deterministic_rng(unitid, name, x, y, 0.5)
				elseif (condtype == "not maybe") then
					valid = true
					result = deterministic_rng(unitid, name, x, y, 1-0.5)
				elseif (condtype == "rarely") then
					valid = true
					result = deterministic_rng(unitid, name, x, y, 0.1)
				elseif (condtype == "not rarely") then
					valid = true
					result = deterministic_rng(unitid, name, x, y, 1-0.1)
				elseif (condtype == "megarare") then
					valid = true
					result = deterministic_rng(unitid, name, x, y, 0.01)
				elseif (condtype == "not megarare") then
					valid = true
					result = deterministic_rng(unitid, name, x, y, 1-0.01)
				elseif (condtype == "gigarare") then
					valid = true
					result = deterministic_rng(unitid, name, x, y, 0.001)
				elseif (condtype == "not gigarare") then
					valid = true
					result = deterministic_rng(unitid, name, x, y, 1-0.001)
				elseif (condtype == "lonely") then
					valid = true
				
					if (unitid ~= 1) then
						local tileid = x + y * roomsizex
						if (unitmap[tileid] ~= nil) then
							for c,d in ipairs(unitmap[tileid]) do
								if (d ~= unitid) then
									result = false
								end
							end
						end
					else
						result = false
					end
				elseif (condtype == "not lonely") then
					valid = true
					
					if (unitid ~= 1) then
						local tileid = x + y * roomsizex
						if (unitmap[tileid] ~= nil) then
							if (#unitmap[tileid] == 1) then
								result = false
							end
						end
					else
						if (surrounds["o"] ~= nil) then
							if (#surrounds["o"] > 0) then
								result = false
							end
						end
					end
				end
			end
			
			if (valid == false) then
				print("invalid condition: " .. tostring(condtype))
				result = true
			end
		end
	end
	
	return result
end

function deterministic_rng(unitid, name, x, y, p)
	local turncount = tostring(#undobuffer)
	--this is different each time you restart :(
	--local stringyid = tostring((unitid-2)*1e21)
	local base_seed
	if (activemod.seed_rng_on_restart) then
		if (rng_seed == -1) then
			rng_seed = math.random()
		end
		base_seed = tostring(rng_seed)
	else
		base_seed = MF_read("level","general","name")
	end
	local seed = CRC32.Hash("turncount:"..turncount.."|name:"..name.."|x:"..x.."|y:"..y.."|levelname:"..base_seed)
	math.randomseed(seed)
	return math.random() <= p
end

function countsides(unitid, name, x, y)
	local sides = 0
	local sidecount = 0
	if (unitid ~= 1) then
		for i = 1,4 do
			local ndrs = ndirs[i]
			local ox = ndrs[1]
			local oy = ndrs[2]
			local tileid = (x + ox) + (y + oy) * roomsizex
			if (unitid ~= 2) then
				if (unitmap[tileid] ~= nil) then
					for c,d in ipairs(unitmap[tileid]) do
						local unit = mmf.newObject(d)
						local name_ = getname(unit)
						if (name_ == name) then
							sides = sides + 1
							sidecount = sidecount + (1 << (i-1))
							break
						end
					end
				end
			else
				if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then 
					sides = sides + 1
					sidecount = sidecount + (1 << (i-1))
				end
			end
		end
	else
		local dirids = {"r","u","l","d"}
		for i = 1,4 do
			local dirid = dirids[i]
			if (surrounds[dirid] ~= nil) then
				for c,d in ipairs(surrounds[dirid]) do
					if (d == unitid) then
						sides = sides + 1
						sidecount = sidecount + (1 << (i-1))
						break
					end
				end
			end
		end
	end
	return sides, sidecount
end