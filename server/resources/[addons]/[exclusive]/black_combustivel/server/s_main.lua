RegisterServerEvent("q_fuel:pagamento")
AddEventHandler("q_fuel:pagamento",function(price,galao,vehicle,fuel,fuel2,plate)
	local user_id = vRP.getUserId(source)
	if user_id and price > 0 then
		if vRP.paymentBank(user_id,price) then
			if galao then
				TriggerClientEvent('q_fuel:galao',source)
				TriggerClientEvent("Notify",source,"important","Atenção","Pagou <b>$"..parseFormat(price).." dólares</b> pelo <b>Galão</b>.","amarelo",8000)
			else
				TriggerEvent("engine:tryFuel",plate,fuel)
				TriggerClientEvent("Notify",source,"important","Atenção","Pagou <b>$"..parseFormat(price).." dólares</b> em combustível.","amarelo",8000)
			end
		else
			TriggerClientEvent('q_fuel:insuficiente',source,vehicle,fuel2)
			TriggerClientEvent("Notify",source,"important","Atenção","Dinheiro insuficiente.","amarelo",8000)
		end
	end
end)

RegisterServerEvent("q_fuel:DeleteRope")
AddEventHandler("q_fuel:DeleteRope",function(bomba)
	TriggerClientEvent('q_fuel:syncDeleteRope',-1,bomba)
end)

RegisterServerEvent("q_fuel:createRope")
AddEventHandler("q_fuel:createRope",function(bomba,NearPump,pedPos,propPos)
	TriggerClientEvent('q_fuel:syncRope',-1,bomba,NearPump,pedPos,propPos)
end)

function vRPReceiver.getMoney()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.getBank(user_id)
	end
	return 0
end

function vRPReceiver.paymentFuelCost(valor)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.paymentBank(user_id,parseInt(valor)) then
			TriggerClientEvent("Notify", source, "important", "Atenção", "Pagou <b>$"..valor.." dólares</b> em combustível.","amarelo",8000)
		else
			TriggerClientEvent("Notify", source, "important", "Atenção", "Dinheiro insuficiente.","amarelo",8000)
		end
	end
end