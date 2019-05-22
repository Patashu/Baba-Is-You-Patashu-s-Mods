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
					local condname = unitreference["text_" .. isnot]
					
					local conddata = conditions[condname] or {}
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
							local pname = b
							local pnot = false
							if (string.sub(b, 1, 4) == "not ") then
								pnot = true
								pname = string.sub(b, 5)
							end
							
							if (unitid ~= 1) then
								if (b ~= "empty") and (b ~= "level") then
									if (unitmap[tileid] ~= nil) then
										for c,d in ipairs(unitmap[tileid]) do
											if (d ~= unitid) then
												local unit = mmf.newObject(d)
												local name_ = getname(unit)
												
												if (pnot == false) then
													if (name_ == pname) and (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												else
													if (name_ ~= pname) and (alreadyfound[b] == nil) and (name_ ~= "text") then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
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
									if (pnot == false) then
										if (unitlists[b] ~= nil) then
											if (#unitlists[b] > 0) then
												ulist = true
											end
										end
									else
										for c,d in pairs(unitlists) do
											if (c ~= pname) and (#d > 0) then
												ulist = true
												break
											end
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
											if (pnot == false) then
												if (d == pname) then
													ulist = true
												end
											else
												if (d ~= pname) then
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
				elseif (condtype == "not on") then
					valid = true
					local allfound = 0
					local alreadyfound = {}
					
					local tileid = x + y * roomsizex
					
					if (#params > 0) then
						for a,b in ipairs(params) do
							local pname = b
							local pnot = false
							if (string.sub(b, 1, 4) == "not ") then
								pnot = true
								pname = string.sub(b, 5)
							end
							
							if (unitid ~= 1) then
								if (b ~= "empty") and (b ~= "level") then
									if (unitmap[tileid] ~= nil) then
										for c,d in ipairs(unitmap[tileid]) do
											if (d ~= unitid) then
												local unit = mmf.newObject(d)
												local name_ = getname(unit)
												
												if (pnot == false) then
													if (name_ == pname) and (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												else
													if (name_ ~= pname) and (name_ ~= "text") and (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
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
									
									if onempty and (alreadyfound[b] == nil) then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								elseif (b == "level") and (alreadyfound[b] == nil) then
									alreadyfound[b] = 1
									allfound = allfound + 1
								end
							else
								if (b ~= "empty") and (b ~= "level") and (b ~= "text") then
									if (pnot == false) then
										if (unitlists[b] ~= nil) then
											if (#unitlists[b] > 0) and (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									else
										for c,d in pairs(unitlists) do
											if (c ~= pname) and (#d > 0) and (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
												break
											end
										end
									end
								elseif (b == "empty") then
									local empties = findempty()
									
									if (#empties > 0) and (alreadyfound[b] == nil) then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								elseif (b == "text") and (alreadyfound[b] == nil) then
									alreadyfound[b] = 1
									allfound = allfound + 1
								end
								
								if result then
									if (surrounds["o"] ~= nil) then
										for c,d in ipairs(surrounds["o"]) do
											if (pnot ~= false) then
												if (d == b) and (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
											else
												if (d ~= b) and (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
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
					
					if (allfound == #params) then
						result = false
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
								local pname = b
								local pnot = false
								if (string.sub(b, 1, 4) == "not ") then
									pnot = true
									pname = string.sub(b, 5)
								end
								
								if (unitid ~= 1) then
									if (pname ~= "empty") and (b ~= "level") then
										if (stringintable(pname, extras) == false) then
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[b] == nil) then
																alreadyfound[b] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[b] == nil) and (name_ ~= "text") then
																alreadyfound[b] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											if (pnot == false) then
												if ((pname == "right") and (dir == 0)) or ((pname == "up") and (dir == 1)) or ((pname == "left") and (dir == 2)) or ((pname == "down") and (dir == 3)) then
													if (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												end
											else
												if ((pname == "right") and (dir ~= 0)) or ((pname == "up") and (dir ~= 1)) or ((pname == "left") and (dir ~= 2)) or ((pname == "down") and (dir ~= 3)) then
													if (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												end
											end
										end
									elseif (pname == "empty") then
										if (pnot == false) then
											if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then
												if (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
											end
										else
											if (unitmap[tileid] ~= nil) and (#unitmap[tileid] > 0) then
												if (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
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
											if (pnot == false) then
												if (d == pname) and (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
											else
												if (d ~= pname) and (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
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
					
					local allfound = 0
					local alreadyfound = {}

					local ndrs = ndirs[dir+1]
					local ox = ndrs[1]
					local oy = ndrs[2]
					
					local tileid = (x + ox) + (y + oy) * roomsizex
					
					if (#params > 0) then
						if (name ~= "empty") then
							for a,b in ipairs(params) do
								local pname = b
								local pnot = false
								if (string.sub(b, 1, 4) == "not ") then
									pnot = true
									pname = string.sub(b, 5)
								end
								
								if (unitid ~= 1) then
									if (pname ~= "empty") and (b ~= "level") then
										if (stringintable(pname, extras) == false) then
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[b] == nil) then
																alreadyfound[b] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (name_ ~= "text") and (alreadyfound[b] == nil) then
																alreadyfound[b] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											if (pnot == false) then
												if ((pname == "right") and (dir == 0)) or ((pname == "up") and (dir == 1)) or ((pname == "left") and (dir == 2)) or ((pname == "down") and (dir == 3)) then
													if (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												end
											else
												if ((pname == "right") and (dir ~= 0)) or ((pname == "up") and (dir ~= 1)) or ((pname == "left") and (dir ~= 2)) or ((pname == "down") and (dir ~= 3)) then
													if (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												end
											end
										end
									elseif (pname == "empty") then
										if (pnot == false) then
											if (unitmap[tileid] == nil) or (#unitmap[tileid] == 0) then
												if (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
											end
										else
											if (unitmap[tileid] ~= nil) and (#unitmap[tileid] > 0) then
												if (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
											end
										end
									elseif (b == "level") and (alreadyfound[b] == nil) then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								else
									local dirids = {"r","u","l","d"}
									local dirid = dirids[dir + 1]
									
									if (surrounds[dirid] ~= nil) then
										for c,d in ipairs(surrounds[dirid]) do
											if (pnot == false) then
												if (d == pname) and (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
											else
												if (d ~= pname) and (alreadyfound[b] == nil) then
													alreadyfound[b] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (name == "empty") then
							-- TÄSSÄ KESKEN
							result = false
						end
					else
						print("no parameters given!")
					end
					
					if (allfound == #params) then
						result = false
					end
				elseif (condtype == "near") then
					valid = true
					local allfound = 0
					local alreadyfound = {}
					
					if (#params > 0) then
						for a,b in ipairs(params) do
							local pname = b
							local pnot = false
							if (string.sub(b, 1, 4) == "not ") then
								pnot = true
								pname = string.sub(b, 5)
							end
							
							if (unitid ~= 1) then
								if (b ~= "level") then
									for g=-1,1 do
										for h=-1,1 do
											if (pname ~= "empty") then
												local tileid = (x + g) + (y + h) * roomsizex
												if (unitmap[tileid] ~= nil) then
													for c,d in ipairs(unitmap[tileid]) do
														if (d ~= unitid) then
															local unit = mmf.newObject(d)
															local name_ = getname(unit)
															
															if (pnot == false) then
																if (name_ == pname) and (alreadyfound[b] == nil) then
																	alreadyfound[b] = 1
																	allfound = allfound + 1
																end
															else
																if (name_ ~= pname) and (alreadyfound[b] == nil) and (name_ ~= "text") then
																	alreadyfound[b] = 1
																	allfound = allfound + 1
																end
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
												
												if (pnot == false) then
													if nearempty and (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												else
													if (nearempty == false) and (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
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
									if (pnot == false) then
										if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
											ulist = true
										end
									else
										for c,d in pairs(unitlists) do
											if (c ~= pname) then
												ulist = true
												break
											end
										end
									end
								elseif (b == "empty") then
									local empties = findempty()
									
									if (#empties > 0) then
										ulist = true
									end
								end
								
								if (b ~= "text") and (ulist == false) then
									for e,f in pairs(surrounds) do
										if (e ~= "dir") then
											for c,d in ipairs(f) do
												if (pnot == false) then
													if (ulist == false) and (d == pname) then
														ulist = true
													end
												else
													if (ulist == false) and (d ~= pname) then
														ulist = true
													end
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
					
					local allfound = 0
					local alreadyfound = {}
					
					if (#params > 0) then
						for a,b in ipairs(params) do
							local pname = b
							local pnot = false
							if (string.sub(b, 1, 4) == "not ") then
								pnot = true
								pname = string.sub(b, 5)
							end
							
							if (unitid ~= 1) then
								if (b ~= "level") then
									for g=-1,1 do
										for h=-1,1 do
											if (pname ~= "empty") then
												local tileid = (x + g) + (y + h) * roomsizex
												if (unitmap[tileid] ~= nil) then
													for c,d in ipairs(unitmap[tileid]) do
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (d ~= unitid) and (alreadyfound[b] == nil) then
																alreadyfound[b] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (d ~= unitid) and (name_ ~= "text") and (alreadyfound[b] == nil) then
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
												
												if (pnot == false) then
													if nearempty and (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												else
													if (nearempty == false) and (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												end
											end
										end
									end
								else
									if (alreadyfound[b] == nil) then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								end
							else
								local ulist = false
							
								if (b ~= "empty") and (b ~= "level") and (b ~= "text") then
									if (pnot == false) then
										if (unitlists[b] ~= nil) then
											if (#unitlists[b] > 0) and (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
											end
										end
									else
										for c,d in pairs(unitlists) do
											if (c ~= pname) and (alreadyfound[b] == nil) then
												alreadyfound[b] = 1
												allfound = allfound + 1
												break
											end
										end
									end
								elseif (b == "empty") then
									local empties = findempty()
									
									if (#empties > 0) and (alreadyfound[b] == nil) then
										alreadyfound[b] = 1
										allfound = allfound + 1
									end
								elseif (b == "text") and (alreadyfound[b] == nil) then
									alreadyfound[b] = 1
									allfound = allfound + 1
								end
								
								if (p ~= "text") and (alreadyfound[b] == nil) then
									for e,f in pairs(surrounds) do
										if (e ~= "dir") then
											for c,d in ipairs(f) do
												if (pnot == false) then
													if (d == pname) and (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
												else
													if (d ~= pname) and (alreadyfound[b] == nil) then
														alreadyfound[b] = 1
														allfound = allfound + 1
													end
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
					
					if (allfound == #params) then
						result = false
					end
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
				elseif (condtype == "idle") then
					valid = true
					
					if (last_key ~= 4) then
						result = false
					end
				elseif (condtype == "not idle") then
					valid = true
					
					if (last_key == 4) then
						result = false
					end
				end
			end
			
			if (valid == false) then
				print("invalid condition: " .. condtype)
				result = true
			end
		end
	end
	
	return result
end