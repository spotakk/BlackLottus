-----------------------------------------------------------------------------------------------------------------------------------------
-- /e
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,args,rawCommand)
	local source = source
	--if vARENA.arenaStatus(source) then
	--	TriggerClientEvent("Notify",source,"vermelho","As animações são bloqueadas dentro da <b>Arena</b>.",6000)
	--	return 
	--end
	
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRPC.getNearestPlayer(source,1)	
	if nplayer and not vRPC.isInVehicle(nplayer) and not vRPC.isHandcuffed(nplayer) and vRPC.getHealth(nplayer) > 101 then
		if args[1] == "beijar" then
			if vRP.request(nplayer,"Deseja beijar <b>"..identity["name"].." "..identity["firstname"].."</b> ?",5) then
				TriggerClientEvent("syncAnim",source,1.3)
				TriggerClientEvent("syncAnimAll",source,"beijar")
				TriggerClientEvent("syncAnimAll",nplayer,"beijar")
			else
				TriggerClientEvent("Notify",source,"vermelho","A pessoa negou o beijo.")
			end
		elseif args[1] == "abracar" then
			if vRP.request(nplayer,"Deseja abraçar <b>"..identity["name"].." "..identity["firstname"].."</b> ?",5) then
				TriggerClientEvent("syncAnim",source,0.8)
				TriggerClientEvent("syncAnimAll",source,"abracar")
				TriggerClientEvent("syncAnimAll",nplayer,"abracar")
			else
				TriggerClientEvent("Notify",source,"vermelho","A pessoa negou o abraço.")
			end
		elseif args[1] == "abracar2" then
			if vRP.request(nplayer,"Deseja abraçar <b>"..identity["name"].." "..identity["firstname"].."</b> ?",5) then
				TriggerClientEvent("syncAnim",source,1.2)
				TriggerClientEvent("syncAnimAll",source,"abracar2")
				TriggerClientEvent("syncAnimAll",nplayer,"abracar2")
			else
				TriggerClientEvent("Notify",source,"vermelho","A pessoa negou o abraço.")
			end
		elseif args[1] == "abracar3" then
			if vRP.request(nplayer,"Deseja abraçar <b>"..identity["name"].." "..identity["firstname"].."</b> ?",5) then
				TriggerClientEvent("syncAnim",source,0.8)
				TriggerClientEvent("syncAnimAll",source,"abracar3")
				TriggerClientEvent("syncAnimAll",nplayer,"abracar3")
			else
				TriggerClientEvent("Notify",source,"vermelho","A pessoa negou o abraço.")
			end
		elseif args[1] == "abracar4" then
			if vRP.request(nplayer,"Deseja abraçar <b>"..identity["name"].." "..identity["firstname"].."</b> ?",5) then
				TriggerClientEvent("syncAnim",source,1.4)
				TriggerClientEvent("syncAnimAll",source,"abracar4")
				TriggerClientEvent("syncAnimAll",nplayer,"abracar4")
			else
				TriggerClientEvent("Notify",source,"vermelho","A pessoa negou o abraço.")
			end
		elseif args[1] == "dancar257" then
			if vRP.request(nplayer,"Deseja dançar com <b>"..identity["name"].." "..identity["firstname"].."</b> ?",5) then
				TriggerClientEvent("syncAnim",source,1.0)
				TriggerClientEvent("syncAnimAll",source,"dancar257")
				TriggerClientEvent("syncAnimAll",nplayer,"dancar257")
				Citizen.Wait(13000)
				vRPC._DeletarObjeto(source)
				vRPC._DeletarObjeto(nplayer)
			else
				TriggerClientEvent("Notify",source,"vermelho","A pessoa negou a dança.")
			end
		elseif args[1] == "dancar258" then
			if vRP.request(nplayer,"Deseja dançar com <b>"..identity["name"].." "..identity["firstname"].."</b> ?",5) then
				TriggerClientEvent("syncAnim",source,1.0)
				TriggerClientEvent("syncAnimAll",source,"dancar258")
				TriggerClientEvent("syncAnimAll",nplayer,"dancar258")
				Citizen.Wait(12000)
				vRPC._DeletarObjeto(source)
				vRPC._DeletarObjeto(nplayer)
			else
				TriggerClientEvent("Notify",source,"vermelho","A pessoa negou a dança.")
			end
		elseif args[1] == "dancar259" then
			if vRP.request(nplayer,"Deseja dançar com <b>"..identity["name"].." "..identity["firstname"].."</b> ?",5) then
				TriggerClientEvent("syncAnim",source,1.0)
				TriggerClientEvent("syncAnimAll",source,"dancar259")
				TriggerClientEvent("syncAnimAll",nplayer,"dancar259")
				Citizen.Wait(11000)
				vRPC._DeletarObjeto(source)
				vRPC._DeletarObjeto(nplayer)
			else
				TriggerClientEvent("Notify",source,"vermelho","A pessoa negou a dança.")
			end
		elseif args[1] == "casal" then
			if vRP.request(nplayer,"Deseja casal com <b>"..identity["name"].." "..identity["firstname"].."</b> ?",5) then
				TriggerClientEvent("syncAnim",source,0.3)
				TriggerClientEvent("syncAnimAll",source,"casal",1)
				TriggerClientEvent("syncAnimAll",nplayer,"casal",2)
			else
				TriggerClientEvent("Notify",source,"vermelho","A pessoa negou o casal.")
			end
		end		
	end
	TriggerClientEvent("emotes",source,args[1])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /e2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('e2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local nplayer = vRPC.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent("emotes",nplayer,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PANO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryclean")
AddEventHandler("tryclean",function(nveh)
	TriggerClientEvent("syncclean",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC PARTICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trySyncParticle")
AddEventHandler("trySyncParticle",function(asset,v)
    TriggerClientEvent("startSyncParticle",-1,asset,v)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOP SYNC PARTICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryStopParticle")
AddEventHandler("tryStopParticle",function(v)
    TriggerClientEvent("stopSyncParticle",-1,v)
end)