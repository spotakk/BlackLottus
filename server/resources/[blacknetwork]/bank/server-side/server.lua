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
Tunnel.bindInterface("bank",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}

local webhookDeposito = "https://discord.com/api/webhooks/1053747374075433090/BJllbv_nfyI9paJd0nSloTD2xXLQnw9SYAj_nVT6DO-K8qMcKj1xzSERH2ZkCGODbX1m"
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestWanted()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if exports["hud_v2"]:Wanted(user_id,source) then
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankDeposit(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and actived[user_id] == nil then
		actived[user_id] = true

		if parseInt(amount) > 0 then
			if vRP.tryGetInventoryItem(user_id,"dollars",amount,true) then
				vRP.addBank(user_id,amount)
				SendWebhookMessage(webhookDeposito,"```prolog\n[ID]: "..user_id.."\n[DEPOSITOU]]: "..amount.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"cancel","Negado","Dólares insuficientes.","vermelho",5000)
			end
		end

		actived[user_id] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankWithdraw(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and actived[user_id] == nil then
		actived[user_id] = true

		if vRP.getFines(user_id) > 0 then 
			TriggerClientEvent("Notify",source,"important","Atenção","Multas pendentes encontradas.","amarelo",3000)
		
			actived[user_id] = nil

			return false
		end

		local value = parseInt(amount)
		if (vRP.inventoryWeight(user_id) + (itemWeight("dollars") * value)) <= vRP.getWeight(user_id) then
			if not vRP.withdrawCash(user_id,value) then 
				TriggerClientEvent("Notify",source,"important","Atenção","Dólares insuficientes.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)

		end

		actived[user_id] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- consultar multas
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.consultMultas()
	local source = source
	local user_id = vRP.getUserId(source)
	local consult = vRP.query("characters/getUsers",{id = user_id})
	if user_id and actived[user_id] == nil then
		actived[user_id] = true
		local value = parseInt(consult[1]["fines"])
		if vRP.getFines(user_id) > 0 then 
			TriggerClientEvent("Notify",source,"check","Sucesso","Você tem R$"..value..",00 em multas a pagar.","verde",5000)
			TriggerClientEvent("Notify",source,"check","Sucesso","Pague agora apertando em 'Pagar multas'","verde",5000)

			actived[user_id] = nil
		else
			TriggerClientEvent("Notify",source,"important","Atenção","Você não tem multas a pagar","amarelo",3000)
		
			actived[user_id] = nil
		end	
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- pagar multas
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.payMultas()
	local source = source
	local user_id = vRP.getUserId(source)
	local consult = vRP.query("characters/getUsers",{id = user_id})
	if user_id and actived[user_id] == nil then
		actived[user_id] = true

		if vRP.getFines(user_id) <= 0 then
			actived[user_id] = nil
			return false
		end
		
		local value = parseInt(consult[1]["fines"])
		
		if parseInt(vRP.getBank(user_id)) < value then  
			TriggerClientEvent("Notify",source,"cancel","Negado","Dólares insuficientes.","vermelho",3000)
			actived[user_id] = nil
			return false
		else
			TriggerClientEvent("Notify",source,"check","Sucesso","Você tinha R$"..value..",00 de multa, sendo esse o total pago.","verde",5000)

			vRP.paymentFull(user_id,value)
			vRP.delFines(user_id,value)
		end
		
		actived[user_id] = nil
	end
end