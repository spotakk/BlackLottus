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
Tunnel.bindInterface("service",cRP)
vCLIENT = Tunnel.getInterface("service")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service,Color)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local splitName = splitString(Service,"-")
		local serviceName = splitName[1]
		if vRP.hasPermission(user_id,serviceName) then
			
			if serviceName == "Police" or serviceName == "Policia" or serviceName == "Lspd" or serviceName == "Corrections" or serviceName == "Ranger" or serviceName == "State" then
				vRP.removePermission(user_id,"Police")
				TriggerEvent("blipsystem:serviceExit",source)
				TriggerClientEvent("vRP:PoliceService",source,false)
			end

			if serviceName == "Paramedic" then
				vRP.removePermission(user_id,serviceName)
				TriggerEvent("blipsystem:serviceExit",source)
				TriggerClientEvent("vRP:ParamedicService",source,false)
			end
	
			if serviceName == "Mechanic" then
				vRP.removePermission(user_id,serviceName)
				TriggerEvent("blipsystem:serviceExit",source)
				TriggerClientEvent("vRP:MechanicService",source,false)
			end
			print(serviceName)
			vRP.updatePermission(user_id,serviceName,"wait"..serviceName)
			
			TriggerClientEvent("Notify",source,"check","Sucesso","Saiu de serviço.","verde",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Entrar em Serviço",5000)
		elseif vRP.hasPermission(user_id,"wait"..serviceName) then
			if serviceName == "Lspd" or serviceName == "Police" or serviceName == "Corrections" or serviceName == "Ranger" or serviceName == "State" then
				vRP.insertPermission(source,user_id,"Police")
				TriggerClientEvent("vRP:PoliceService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"POLICE: "..serviceName,Color)
			end

			if serviceName == "Paramedic" then
				vRP.insertPermission(source,user_id,serviceName)
				TriggerClientEvent("vRP:ParamedicService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"Paramedic",Color)
			end

			if serviceName == "Mechanic" then
				vRP.insertPermission(source,user_id,serviceName)
				TriggerClientEvent("vRP:MechanicService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"Mechanic",Color)
			end

			vRP.updatePermission(user_id,"wait"..serviceName,serviceName)
			TriggerClientEvent("Notify",source,"check","Sucesso","Entrou em serviço.","verde",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Sair de Serviço",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("painel",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,args[1]) then
			local playerList = vRP.userList()
			TriggerClientEvent("service:Open",source,args[1])
		end
	end
end)
