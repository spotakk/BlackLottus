-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("checkin",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--[[ if vRP.getHealth(source) <= 101 then ]]
			if vRP.request(source,"Prosseguir o tratamento por <b>$750</b> dólares?","Sim","Não") then
				if vRP.paymentFull(user_id,750) then
					vRP.upgradeHunger(user_id,20)
					vRP.upgradeThirst(user_id,20)
					vRP.upgradeStress(user_id,10)
					TriggerEvent("Repose",source,user_id,900)

					return true
				else

					TriggerClientEvent("Notify",source,"cancel","Negado","<b>Dólares</b> insuficientes.","vermelho",5000)
				end
			end
		--[[ end ]]
	end

	return false
end


function cRP.checkParamedicServices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local copAmount = vRP.numPermission("Paramedic")
		if parseInt(#copAmount)>= 1 then 

			TriggerClientEvent("Notify",source,"important","Negado","Existem paramedicos em serviço","amarelo",5000)

			return true

		else
			local valor  =  1000
			if vRP.request(source,"Desejar pagar <strong>$"..valor.."</strong> para iniciar o Tratamento?") then
				vRP.paymentFull(user_id,valor)
				return 
			else
				return true
			end
		end
	end
	return false
end