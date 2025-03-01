

local webaddcar = ""
local webhookgive = ""
local webnc = ""
local webhookkick = ""
local webhookban = ""
local webhookosfix = ""
local webhookostpto = ""
local webhookostptome = ""
local webhookostpway = ""
local webgroup = ""
local webhookadminwl = ""
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO PARA CHECAR OS GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vgroups',function(source,args)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,'Admin') and args[1] then
	
		local groups = vRP.getDatatable(args[1],'Datatable')
		

		if groups["perm"] then
			local text = ''
			for group, _ in pairs(groups["perm"]) do
				text = text .. ' <br>'..group..' ' 
			end
			TriggerClientEvent('Notify',source,'check',"Sucesso",'O jogador tem os seguintes grupos: '..text,"verde", 10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local ID = parseInt(args[1])
			local Amount = parseInt(args[2])
			local identity = vRP.userIdentity(ID)
			if identity then
				vRP.execute("accounts/infosUpdategems",{ steam = identity["steam"], gems = Amount })
				local steam = vRP.getIdentities(source)
				local userGems = vRP.userGemstone(steam)
				TriggerClientEvent("hud:gems",source,userGems)
				TriggerEvent("discordLogs","Gemstones","**Passaporte:** "..ID.."\n**Recebeu:** "..Amount.." Gemas\n**Horário:** "..os.date("%H:%M:%S"),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO PREFEITURA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciar",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
            local message = vRP.prompt(source,"Mensagem:","")
            if not message or message == "" then
                return
            end
            TriggerClientEvent("Notify",-1,"warn","Mensagem enviada pela Prefeitura",message,15000)
            TriggerClientEvent("sounds:source",-1,"notification",0.5)
        end
    end
	
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("h",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasGroup(user_id,"Admin") then
        local otherPlayer = vRPC.nearestPlayer(source,0.8)
        if otherPlayer then 
            TriggerClientEvent("toggleCarry",otherPlayer,source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("admin:vehicleTuning",source)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparinv", function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Suporte") or vRP.hasPermission(user_id,"Moderador") or vRP.hasPermission(user_id,"Admin") then
            if args[1] then
                local nuser_id = parseInt(args[1])
                vRP.clearInventory(nuser_id)
                TriggerClientEvent("Notify",source,"important","Atenção","Inventario limpo do id: "..args[1] ,"amarelo" ,5000)
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISOMEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("avisomec",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Bennys") or vRP.hasPermission(user_id,"Admin") then
            local message = vRP.prompt(source,"Mensagem:","")
            if message == "" then
                return
            end
			
            TriggerClientEvent("Notify",-1,"mechanic","Mensagem enviada pela Mecanica",message,"verde",15000)
            TriggerClientEvent("sounds:source",-1,"notification",0.5)
        end
    end
end)


RegisterCommand("setdim",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Admin") then
			SetPlayerRoutingBucket(source, args[1])
        end
    end
end)

RegisterCommand("getdim",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Admin") then
			local inteiro = GetPlayerRoutingBucket(source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISOMED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("avisomed",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Paramedic") or vRP.hasPermission(user_id,"Admin") then
            local message = vRP.prompt(source,"Mensagem:","")
            if message == "" then
                return
            end
			
            TriggerClientEvent("Notify",-1,"hospital","Mensagem enviada pelo Hospital",message,"verde",15000)
            TriggerClientEvent("sounds:source",-1,"notification",0.5)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO Pon
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pon",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") then
		local users = vRP.getPlayesOn()

		local playersTable = {}

		for player, _ in pairs(users) do
			table.insert(playersTable, player)
		end	

		local players = table.concat(playersTable, ', ')
		local quantidade = #playersTable


		
		TriggerClientEvent('Notify', source, 'check', 'Sucesso', 'Total onlines: '..quantidade..' <br> IDs onlines '..players,"verde", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Suporte") or vRP.hasPermission(user_id,"Admin") then
			vRP.execute("accounts/setwl",{ id = tostring(args[1]), whitelist = 1 })
			TriggerClientEvent("Notify",source,"check","Sucesso","Você aprovou a Hex "..args[1]..".","verde",5000)
			SendWebhookMessage(webhookadminwl,"```prolog\n[ID]: "..user_id.."\n[APROVOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blips",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			vRPC.blipsAdmin(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] then
				local nuser_id = parseInt(args[1])
				local otherPlayer = vRP.userSource(nuser_id)
				if otherPlayer then
					vRP.upgradeThirst(nuser_id,100)
					vRP.upgradeHunger(nuser_id,100)
					vRP.downgradeStress(nuser_id,100)
					vRPC.revivePlayer(otherPlayer,200)
					TriggerClientEvent("resetBleeding",source)
					TriggerClientEvent("paramedic:Reset",nuser_id)
				end
			else
		--		vRP.setArmour(source,100)
				vRPC.revivePlayer(source,200)
				vRP.upgradeThirst(user_id,100)
				vRP.upgradeHunger(user_id,100)
				vRP.downgradeStress(user_id,100)
				TriggerClientEvent("paramedic:Reset",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] and args[2] and itemBody(args[1]) ~= nil then
				vRP.generateItem(user_id,args[1],parseInt(args[2]),true)
				SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.."\n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..parseInt(args[2]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("priority",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and parseInt(args[1]) > 0 then
		if vRP.hasGroup(user_id,"Admin") then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				TriggerClientEvent("Notify",source,"check","Sucesso","Prioridade adicionada.","verde",5000)
				vRP.execute("accounts/setPriority",{ steam = identity["steam"], priority = 99 })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasGroup(user_id,"Admin") then
			local nuser_id = parseInt(args[1])
			vRP.execute("characters/removeCharacters",{ id = nuser_id })
			TriggerClientEvent("Notify",source,"check","Sucesso","Personagem <b>"..nuser_id.."</b> deletado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") then
			vRPC.noClip(source)
			SendWebhookMessage(webnc,"```prolog\n[ID]: "..user_id.." Deu NC"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
RegisterCommand("spectate",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id,"Admin") then
            local nSource = vRP.userSource(parseInt(args[1]))
            if Spectate[user_id] then
                TriggerClientEvent("admin:resetSpectate",source)
                local ped = GetPlayerPed(Spectate[user_id])
                if DoesEntityExist(ped) then
                    SetEntityDistanceCullingRadius(ped,0.0)
                end
                Spectate[user_id] = false
                TriggerClientEvent("Notify",source,"important","Atenção","Desativado.","amarelo",5000)
            elseif args[1] then 
                Spectate[user_id] = nSource
                local ped = GetPlayerPed(nSource)
                if DoesEntityExist(ped) then
                    SetEntityDistanceCullingRadius(ped,999999999.0)
                    Wait(1000)
                    TriggerClientEvent("admin:initSpectate",source,nSource)
                    TriggerClientEvent("Notify",source,"check","Sucesso","Ativado.","verde",5000)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") and parseInt(args[1]) > 0 then
			TriggerClientEvent("Notify",source,"important","Atenção","Passaporte <b>"..args[1].."</b> expulso.",5000)
			vRP.kick(args[1],"Expulso da cidade.")
			SendWebhookMessage(webhookkick,"```prolog\n[ID]: "..user_id.."\n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)

RegisterCommand("pd",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
			vRP.kick(parseInt(args[1]),"A historia do seu personagem chegou ao fim...")
				TriggerClientEvent("Notify",source,"important","Atenção","PD aplicado com sucesso ID: "..args[1],"amarelo" ,5000)
			SendWebhookMessage(webhookkick,"```prolog\n[ID]: "..user_id.."\n[TOMOU PD]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				vRP.kick(nuser_id,"Banido.")
				vRP.execute("banneds/insertBanned",{ steam = identity["steam"] })
				TriggerClientEvent("Notify",source,"important","Atenção","Passaporte <b>"..nuser_id.."</b> banido por <b>"..time.." dias.","amarelo",5000)
				SendWebhookMessage(webhookban,"```prolog\n[ID]: "..user_id.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				vRP.execute("banneds/removeBanned",{ steam = identity["steam"] })
				TriggerClientEvent("Notify",source,"check","Sucesso","Passaporte "..nuser_id.." desbanido.","verde",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPARAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limpararea",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("syncarea",-1,x,y,z)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id,"Admin") then
            --local fcoords =  vRP.prompt(source,"Insira as coordenadas para telepotar:")
			local fcoords =  vRP.prompt(source,"Insira as coordenadas para teleportar:","")
			if not fcoords then
					return
			end
			local coords = {}
			for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
				table.insert(coords,coord)
			end
            vRP.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			local Ped = GetPlayerPed(source)
			local coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vRP.prompt(source,"CORDENADAS","PEGAR CORDENADAS.",mathLegth(coords["x"])..","..mathLegth(coords["y"])..","..mathLegth(coords["z"])..","..mathLegth(heading))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local permissions = exports['vrp']:permissions()

		if args[2] and not permissions[args[2]] then
			return TriggerClientEvent('Notify', source, 'vermelho', 'Grupo inexistente', 5000)
		end

		--if vRP.hasGroup(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") or user_id == 1 and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"check","Sucesso","Adicionado "..args[2].." ao passaporte "..args[1]..".","verde",5000)
			SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.."\n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..parseInt(args[2]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			vRP.setPermission(args[1],args[2])
		--end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"check","Sucesso","Removido "..args[2].." ao passaporte "..args[1]..".","verde",5000)
			vRP.remPermission(args[1],args[2])
			if vRP.hasPermission(user_id,"wait"..args[2]) then
				vRP.remPermission(user_id,"wait"..args[2])
			end
			TriggerEvent("blipsystem:serviceExit",source)
			LocalPlayer["state"][args[2]] = false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
			local otherPlayer = vRP.userSource(args[1])
			if otherPlayer then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)

				vRP.teleport(otherPlayer,coords["x"],coords["y"],coords["z"])
				SendWebhookMessage(webhookostptome, "```prolog\n[TPTOME]\n[ID:] "..user_id.."\n[PLAYER:] ".. parseInt(args[1]) .."\n"..os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") and parseInt(args[1]) > 0 then
			local otherPlayer = vRP.userSource(args[1])
			if otherPlayer then
				local ped = GetPlayerPed(otherPlayer)
				local coords = GetEntityCoords(ped)
				vRP.teleport(source,coords["x"],coords["y"],coords["z"])
				SendWebhookMessage(webhookostpto, "```prolog\n[TPTO]\n[ID:] "..user_id.."\n[PLAYER:] ".. parseInt(args[1]) .."\n"..os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			clientAPI.teleportWay(source)
			SendWebhookMessage(webhookostpway, "```prolog\n[TPWAY]\n[ID:] "..user_id.."\n"..os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and vRP.getHealth(source) <= 101 then
			clientAPI.teleportLimbo(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local vehicle = vRPC.vehicleHash(source)
			if vehicle then
				vRP.prompt(source,"Hash do veículo:",vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local vehicle,vehNet,vehPlate = vRPC.vehList(source,10)
			if vehicle then
				local activePlayers = vRPC.activePlayers(source)
				for _,v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("inventory:repairAdmin",v,vehNet,vehPlate)
					end)
					SendWebhookMessage(webhookosfix,"```prolog\n[ID]: "..user_id.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			local activePlayers = vRPC.activePlayers(source)
			for _,v in ipairs(activePlayers) do
				async(function()
					TriggerClientEvent("syncarea",v,coords["x"],coords["y"],coords["z"],100)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			TriggerClientEvent("Notify",source,"check","Atenção","Jogadores Conectados: "..GetNumPlayerIndices(),"verde",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUGESTÃO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sugestao",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local suggestion = vRP.prompt(source,"Sugestão:")
		if not suggestion then
			return
		end
		
		local identity = vRP.userIdentity(user_id)
		if identity then
			TriggerEvent("discordLogs","Suggestions","**Enviado pelo ID: **"..parseFormat(user_id).."**.\nHorário: **"..os.date("%H:%M:%S").."**\nSugestão: **"..suggestion[1].."**.",13541152)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.buttonTxt()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			vRP.updateTxt(user_id..".txt",mathLegth(coords.x)..","..mathLegth(coords.y)..","..mathLegth(coords.z)..","..mathLegth(heading))
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds2",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id,"Moderator") then
            local Ped = GetPlayerPed(source)
            local coords = GetEntityCoords(Ped)
            local heading = GetEntityHeading(Ped)

            vRP.prompt(source,"Cordenadas:","[x]="..mathLegth(coords["x"])..",[y]="..mathLegth(coords["y"])..",[z]="..mathLegth(coords["z"]))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and args[1] then
			TriggerClientEvent("chatME",-1,"^6ALERTA^9Governador^0"..rawCommand:sub(9))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local messagetype = vRP.prompt(source,"Tipo da mensagem: (default, azul, amarelo, verde, vermelho)","")
			if messagetype == "" then
				return
			end
			
			
			local message = vRP.prompt(source,"Mensagem:","")
			if message == "" then
				return
			end
			
			
			local timer = vRP.prompt(source,"Duração da mensagem:","")
			if timer == "" then
				return
			end
			
			TriggerClientEvent("Notify",-1,messagetype,message,timer)
			TriggerClientEvent("sounds:source",-1,"notification",0.5)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO PM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("avisopm",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Admin") then
            local message = vRP.prompt(source,"Mensagem:","")
            if message == "" then
                return
            end
            
            TriggerClientEvent("Notify",-1,"pm","Mensagem enviada pela Policia",message,"verde",15000)
            TriggerClientEvent("sounds:source",-1,"notification",0.5)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,args,rawCommand)
	if source == 0 then
		TriggerClientEvent("chatME",-1,"^6ALERTA^9Governador^0"..rawCommand:sub(9))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source,args,rawCommand)
	if source == 0 then
		local playerList = vRP.userList()
		for k,v in pairs(playerList) do
			vRP.kick(k,"A Cidade reiniciou para correçoes de bugs e atualizaçoes.")
			Wait(100)
		end
		TriggerEvent("admin:KickAll")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemp",function(source,args,rawCommand)
    local user_id = parseInt(args[1])
    if user_id then
		vRP.generateItem(user_id,tostring(args[2]),parseInt(args[3]),true)

		TriggerClientEvent("Notify",source,"check","Sucesso","Envio concluído.","verde",10000)

    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("enviar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local playerList = vRP.userList()
			for k,v in pairs(playerList) do
				async(function()
					vRP.generateItem(k,tostring(args[1]),parseInt(args[2]),true)
				end)
			end

			TriggerClientEvent("Notify",source,"check","Sucesso","Envio concluído.","verde",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local checkPoints = 0
function src.raceCoords(vehCoords,leftCoords,rightCoords)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		checkPoints = checkPoints + 1

		vRP.updateTxt("races.txt","["..checkPoints.."] = {")

		vRP.updateTxt("races.txt","{ "..mathLegth(vehCoords["x"])..","..mathLegth(vehCoords["y"])..","..mathLegth(vehCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(leftCoords["x"])..","..mathLegth(leftCoords["y"])..","..mathLegth(leftCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(rightCoords["x"])..","..mathLegth(rightCoords["y"])..","..mathLegth(rightCoords["z"]).." }")

		vRP.updateTxt("races.txt","},")
	end
end

------------------ ADD CAR

RegisterCommand("addcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") and args[1] and args[2] then
			vRP.execute("vehicles/addVehicles",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlate(), work = tostring(false) })
		--	vRP.execute("vRP/add_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlateNumber(), phone = vRP.getPhone(args[1]), work = tostring(false) })
			TriggerClientEvent("Notify",args[1],"verde","Recebido o veículo "..args[2].." em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"check","Sucesso","Adicionado o veiculo "..args[2].." na garagem de ID <b>"..args[1]..".","verde",10000)
			SendWebhookMessage(webaddcar,"```prolog\n[ID]: "..user_id.." \n[Para Id:]: "..args[1].."\n[Carro:]: "..args[2]..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)

----------------- REM CAR (Para remover o carro)

RegisterCommand("remcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") and args[1] and args[2] then
			local nuser_id = parseInt(args[1])
			vRP.execute("vehicles/removeVehicles",{ user_id = parseInt(args[1]), vehicle = args[2]})
		--	vRP.execute("vRP/add_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlateNumber(), phone = vRP.getPhone(args[1]), work = tostring(false) })
			TriggerClientEvent("Notify",nuser_id,"check","Sucesso","Removido o veículo "..args[2].."em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"check","Sucesso","Removido o veiculo "..args[2].."na garagem de ID "..args[1]..".",10000)
			SendWebhookMessage(webaddcar,"```prolog\n[ID]: "..user_id.." \n[Para Id:]: "..args[1].."\n[Carro Removido:]: "..args[2]..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("admindebug",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)

AddEventHandler('vRP:playerSpawn',function(user_id,source,firstspawn)
	if user_id then
		local playerData = vRP.getUData(user_id,'Vip')
		local time = json.decode(playerData) or 0

		if os.time() <= time then
			vRP.removePermission(user_id,'group')
		end
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^1=========================================")
        print("^2Base: ^3Vazado por Five Community")
        print("^2Discord: ^4discord.gg/fivecommunity")
        print("^2Aviso: ^1Base vazada da Five Community!")
        print("^1=========================================")
    end
end) 