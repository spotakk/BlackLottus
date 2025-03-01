----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local deliveryPackage = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkExist()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if deliveryPackage[user_id] then
			if vRP.userPremium(user_id) then
				if deliveryPackage[user_id] >= 5 then
					TriggerClientEvent("Notify",source,"amarelo","Atenção","Atingiu o limite diário.",5000)
					return true
				end
			else
				if deliveryPackage[user_id] >= 4 then
					TriggerClientEvent("Notify",source,"amarelo","Atenção","Atingiu o limite diário.",5000)
					return true
				end
			end
		end

		return false
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
---------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if deliveryPackage[user_id] == nil then
			deliveryPackage[user_id] = 0
		end

		vRP.generateItem(user_id,"plasticbottle",math.random(8,12),true)
		vRP.generateItem(user_id,"glassbottle",math.random(8,12),true)
		vRP.generateItem(user_id,"elastic",math.random(8,12),true)
		vRP.generateItem(user_id,"metalcan",math.random(8,12),true)
		vRP.generateItem(user_id,"battery",math.random(8,12),true)
		vRP.generateItem(user_id,"fabric",math.random(4,6),true)

		deliveryPackage[user_id] = deliveryPackage[user_id] + 1
	end
end