-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vINV = Tunnel.getInterface("inventory")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("cashmachine",cnVRP)
Tunnel.bindInterface("cashmachine2",cnVRP)
vCLIENT = Tunnel.getInterface("cashmachine")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local machineGlobal = 0
local machineStart = false
local pagamento = math.random(10000,20000)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.startMachine()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local copAmount = vRP.numPermission("Police")
		if parseInt(#copAmount) < 0 then
			TriggerClientEvent("Notify", source, "important", "Atenção","Sistema indisponível no momento.","amarelo", 5000)
			return false
		elseif parseInt(machineGlobal) > 0 then
			TriggerClientEvent("Notify", source, "important", "Atenção","Aguarde "..machineGlobal.." Segundos","amarelo", 5000)
			return false
		else
			if not machineStart then
				machineStart = true
				machineGlobal = 600
				vRP.upgradeStress(user_id,10)
				vRP.wantedTimer(parseInt(user_id),200)
				return true
			end
		end
	end
	return false
end

function cnVRP.hasTimed()
	if parseInt(machineTimer) > 0 then
		return false
	else
		return true
	end
end

function cnVRP.removeC4(user_id,totalName,amount,bool,slot)
	vRP.tryGetInventoryItem(user_id,totalName,amount,bool,slot)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.callPolice(x,y,z)
	local copAmount = vRP.numPermission("Police")
	for k,v in pairs(copAmount) do
		async(function()
			TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Roubo ao Caixa Eletrônico", x = x, y = y, z = z, rgba = {170,80,25} })
		end)
	end
end

function cnVRP.toChannel(v)
	return v["x"] | v["y"]
end

function cnVRP.getGridzone(x,y)
	local gridChunk = vector2(x,y)
	return cnVRP.toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.stopMachine(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if machineStart then
		
			machineStart = false
			local zIndex = z - 1
			TriggerEvent("cashmachine:invExplode",source,"dollarsroll",pagamento,x,y,zIndex)
	
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if parseInt(machineGlobal) > 0 then
			machineGlobal = parseInt(machineGlobal) - 1
			if parseInt(machineGlobal) <= 0 then
				machineStart = false
			end
		end
		Citizen.Wait(1000)
	end
end)