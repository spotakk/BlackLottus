-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_stockade",cnVRP)
vCLIENT = Tunnel.getInterface("vrp_stockade")
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local stockadePlates = {}
local blockStockades = {}
local stockadeItem = "card05"

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkPolice(vehPlate)
	if blockStockades[vehPlate] ~= nil then
		return false
	end

	local source = source
	local police = vRP.numPermission("Police")
	if parseInt(#police) < 0 then
		TriggerClientEvent("Notify",source,"azul","Sistema indisponível no momento, tente mais tarde.",5000)
		return false
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.withdrawMoney(vehPlate,vehNet)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,stockadeItem) --Linha 44
		if not stockadePlates[vehPlate] then
			local taskResult = vTASKBAR.taskThree(source)
			if taskResult then
				if vRP.tryGetInventoryItem(user_id,stockadeItem,1,true) then
					stockadePlates[vehPlate] = 30
					TriggerClientEvent("vrp_stockade:Destroy",-1,vehNet)
					TriggerClientEvent("Notify",source,"check","Sucesso","Sistema violado com sucesso as autoridades foram notificadas.","verde",5000)

					local x,y,z = vRPclient.getPositions(source)
					local copAmount = vRP.numPermission("Police")
					for k,v in pairs(copAmount) do
						async(function()
							TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M"), code = "QRU", title = "Roubo ao Carro Forte", x = x, y = y, z = z, rgba = {75,100,160} })
						end)
					end
				else
					TriggerClientEvent("Notify",source,"important","Atenção","Você não pode roubar porque não possúi "..itemName(stockadeItem)..".","amarelo",5000)
				end
			else
				TriggerClientEvent("Notify",source,"cancel","Negado","Você não conseguiu roubar, tente novamente.","vermelho",5000)
			end
		else
			if stockadePlates[vehPlate] > 0 then
				vRP.wantedTimer(user_id,30)
				vCLIENT.freezePlayers(source,true)
				TriggerClientEvent("cancelando",source,true)
				stockadePlates[vehPlate] = stockadePlates[vehPlate] - 1
				TriggerClientEvent("Progress",source,7000,"Roubando...")
				vRPclient._playAnim(source,false,{ task = "PROP_HUMAN_BUM_BIN" },true)

				Citizen.Wait(7000)

				vRPclient._stopAnim(source,false)
				vCLIENT.freezePlayers(source,false)
				TriggerClientEvent("cancelando",source,false)
				vRP.giveInventoryItem(user_id,"dollarsroll",math.random(750,1500),true)
			else
				TriggerClientEvent("Notify",source,"vermelho","O carro forte está vazio.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_stockade:inputVehicle")
AddEventHandler("vrp_stockade:inputVehicle",function(vehPlate)
	blockStockades[vehPlate] = true
	TriggerClientEvent("vrp_stockade:Client",-1,blockStockades)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_stockade:Client",source,blockStockades)
end)