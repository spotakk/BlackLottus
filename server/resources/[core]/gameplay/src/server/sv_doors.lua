-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.doorsStatistics(doorNumber,doorStatus)
	local Doors = GlobalState["Doors"]

	Doors[doorNumber]["lock"] = doorStatus

	if Doors[doorNumber]["other"] ~= nil then
		local doorSecond = Doors[doorNumber]["other"]
		Doors[doorSecond]["lock"] = doorStatus
	end

	GlobalState["Doors"] = Doors
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function src.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["Doors"][doorNumber]["perm"] ~= nil then
			if type(GlobalState["Doors"][doorNumber]["perm"]) == "string" then 
				if vRP.hasGroup(user_id,GlobalState["Doors"][doorNumber]["perm"]) then
					return true
				else
					local consultItem = vRP.getInventoryItemAmount(user_id,"lockpick")
					if consultItem[1] >= 1 then
						if math.random(100) >= 50 then
							vRP.removeInventoryItem(user_id,consultItem[2],1,true)
							vRP.generateItem(user_id,"brokenpick",1,false)
						end

						local taskResult = vTASKBAR.taskLockpick(source)
						if taskResult then
							return true
						end
					end
				end
			else
				if vRP.hasGroup(user_id,GlobalState["Doors"][doorNumber]["perm"][1]) or vRP.hasPermission(user_id,GlobalState["Doors"][doorNumber]["perm"][2]) then
					return true
				else
					local consultItem = vRP.getInventoryItemAmount(user_id,"lockpick")
					if consultItem[1] >= 1 then
						if math.random(100) >= 50 then
							vRP.removeInventoryItem(user_id,consultItem[2],1,true)
							vRP.generateItem(user_id,"brokenpick",1,false)
						end

						local taskResult = vTASKBAR.taskLockpick(source)
						if taskResult then
							return true
						end
					end
				end
			end 
		end
	end

	return false
end