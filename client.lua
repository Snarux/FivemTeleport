local player = GetPlayerPed(-1)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

Citizen.CreateThread(function ()
    while true do
			
			Citizen.Wait(5)
			local player = GetPlayerPed(-1)
			local playerLoc = GetEntityCoords(player)

			IsClose=false;

			for _,location in ipairs(positions) do
				
				loc1 = {
					x=location[1][1],
					y=location[1][2],
					z=location[1][3],
					heading=location[1][4]
				}
				
				loc2 = {
					x=location[2][1],
					y=location[2][2],
					z=location[2][3],
					heading=location[2][4]
				}
				
				DrawMarker(1, loc1.x, loc1.y, loc1.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.50, location[3][1], location[3][2], location[3][3], 200, 0, 0, 0, 0)
				DrawMarker(1, loc2.x, loc2.y, loc2.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.50, location[3][1], location[3][2], location[3][3], 200, 0, 0, 0, 0)

				if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then     				

					if IsControlJustReleased(1, teleport_key) then
						if IsPedInAnyVehicle(player, true) then
							SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
							SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
						else
							SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
							SetEntityHeading(player, loc2.heading)
						end
					end
					
					IsClose=true;	

				elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then               

					
					if IsControlJustReleased(1, teleport_key) then
						if IsPedInAnyVehicle(player, true) then
							SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
							SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
						else
							SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
							SetEntityHeading(player, loc1.heading)
						end
					end
					
					IsClose=true;	
					
				else  
				
					print("IsClose");
					if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 20) then	
						IsClose=true;
					end	

					if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 20) then	
						IsClose=true;
					end						
							
				end            
			end
		
		
		if IsClose == false then
		
			Citizen.Wait(5000)
		
		end
		
    end
end) 
