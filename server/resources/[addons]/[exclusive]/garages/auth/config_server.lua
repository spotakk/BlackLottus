
Config = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and args[1] then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)
			local vehPlate = "VEH"..math.random(10000,99999)
			local netExist,netVeh,mHash,myVeh = cRP.serverVehicle(args[1],coords["x"],coords["y"],coords["z"],heading,vehPlate,200,nil,1000)
			if not netExist then
				return
			end

			vCLIENT.createVehicle(-1,mHash,netVeh,1000,nil,false,false,vehName,vehPlate)
			vehSpawn[vehPlate] = { user_id,vehName,netVeh }
			TriggerEvent("engine:tryFuel",vehPlate,100)
			SetPedIntoVehicle(ped,myVeh,-1)

			local vehPlates = GlobalState["vehPlates"]
			vehPlates[vehPlate] = user_id
			GlobalState["vehPlates"] = vehPlates
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id, "Admin") then
            TriggerClientEvent("garages:Delete",source)
        end
    end
end)

RegisterCommand("unlock",function(source)
	local vehicle = vRP.nearVehicle(source,15)
	TriggerEvent("garages:lockVehicle",source,VehToNet(vehicle),GetVehicleNumberPlateText(vehicle))
end)