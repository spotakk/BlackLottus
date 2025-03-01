-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentService()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,2)
		local value = math.random(330,380)
		vRP.generateItem(user_id,"dollars",value,true)

		if vRP.userPremium(user_id) then
			vRP.generateItem(user_id,"dollars",value * 0.10,true)
		end
	end
end

function cRP.modelPlayer()
	local source = source
	local ped = GetPlayerPed(source)
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		return "mp_m_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		return "mp_f_freemode_01"
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initService(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if status then
			vRP.insertPermission(source,user_id,"Taxi")
		else
			vRP.removePermission(user_id,"Taxi")
		end
	end

	return true
end