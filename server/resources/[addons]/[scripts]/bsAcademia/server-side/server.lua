-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("gregos-exercicios",cRP)
vCLIENT = Tunnel.getInterface("gregos-exercicios")
vPLAYER = Tunnel.getInterface("player")


-- function cRP.startAnim(anim,b,prop)
-- 	local source = source
-- 	if source ~= nil then
-- 		vRPC.playAnim(source,false,{anim,b},false)
-- 		TriggerClientEvent("inventory:Cancel",source,true)
-- 	end
-- end

-- function cRP.stopAnim()
-- 	local source = source
-- 	if source ~= nil then
-- 		vRPC.stopAnim(source,false)
-- 		TriggerClientEvent("inventory:Cancel",source,false)
-- 		FreezeEntityPosition(source,false)
-- 	end
-- end

function cRP.startExercice(qtd)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		vRP.setWeight(user_id,qtd)
		TriggerClientEvent("Notify", source, "acad","Mochila","Adquirido "..qtd.."KG na mochila", "verde", 8000)
	end
end

function cRP.stopExercice()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		TriggerClientEvent("Notify", source, "acad","Mochila","Sessão de exercícios finalizada!", "verde", 8000)

		TriggerClientEvent("inventory:blockButtons",source,false)
		FreezeEntityPosition(source,false)
	end
end
 function cRP.checkBackpack()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getWeight(user_id) >= 100 then 
			TriggerClientEvent("Notify", source, "acad","Mochila","Sua mochila atingiu o limite máximo","amarelo",5000)
			return false
		else 
			return true
		end
	end
 end

 function cRP.checkBackpack2()
	local source = source
	TriggerClientEvent("player:Commands",source,true)
	TriggerClientEvent("inventory:Buttons",source,true)
end

function cRP.checkBackpack3()
	local source = source
	TriggerClientEvent("player:Commands",source,false)
	TriggerClientEvent("inventory:Buttons",source,false)
end

