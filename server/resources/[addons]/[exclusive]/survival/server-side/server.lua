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
cRP = {}
Tunnel.bindInterface("survival",cRP)
vCLIENT = Tunnel.getInterface("survival")

local webhookosgod = "https://discord.com/api/webhooks/1046102176776343552/MZanhbCs8O7zCaoGfQIHDF_VLKE6u_ab093UohM3-gLghETmnpWGzV0yxvIRwtMz4zIM" -- LOG COMANDO GOD
local webhookosgood = " " -- LOG COMANDO GOOD
local webhookosarmour = "https://discord.com/api/webhooks/992173079264493569/tWmNGCVOrBQLNdl85S2Yl7gGi8_7CYeP85kaB-UjEaS2Dpi1YTBdRdELbEg7JvaoReKs" -- LOG COMANDO ARMOUR
local webhookosheal = " " -- LOG COMANDO HEALTH

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand("god",function(source,args,rawCommand)
 	local user_id = vRP.getUserId(source)
 	if user_id then
 		if vRP.hasPermission(user_id,"Admin") then
 			if args[1] then
 				local nplayer = vRP.getUserSource(parseInt(args[1]))
 				if nplayer then
 					vCLIENT._revivePlayer(nplayer,200)
 					-- vRP.upgradeThirst(parseInt(args[1]),100)
 					-- vRP.upgradeHunger(parseInt(args[1]),100)
 					-- vRP.downgradeStress(parseInt(args[1]),100)
 					TriggerClientEvent("resetBleeding",nplayer)
 					TriggerClientEvent("resetDiagnostic",nplayer)
 					SendWebhookMessage(webhookosgod,"```prolog\n[ID]: "..user_id.." \n[DEU GOD]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 				end
 			else
 				vRP.upgradeThirst(user_id,100)
 				vRP.upgradeHunger(user_id,100)
 				vRPclient.setArmour(source,100)
			 	vRP.downgradeStress(user_id,100)
 				vCLIENT._revivePlayer(source,200)
 				TriggerClientEvent("resetBleeding",source)
 				TriggerClientEvent("resetDiagnostic",source)
 				SendWebhookMessage(webhookosgod,"```prolog\n[ID]: "..user_id.." \n[DEU GOD]: em si proprio "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 			end
 		end
 	end
end)

RegisterCommand('kill', function(source, args)
	local playerId = vRP.getUserId(source)
	if playerId and vRP.hasPermission(playerId, 'Admin') then
		local playerToSet = args[1] and tonumber(args[1]) or playerId

		local playerSource = vRP.userSource(playerToSet)
		if playerSource then
			vRPclient.setHealth(playerSource, 101)
		end
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- GOOD
-- -----------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand("good",function(source,args,rawCommand)
 	local user_id = vRP.getUserId(source)
 	if user_id then
 		if vRP.hasPermission(user_id,"Owner") then
 			if args[1] then
 				local nplayer = vRP.getUserSource(parseInt(args[1]))
 				if nplayer then
 					vCLIENT._revivePlayer(nplayer,200)
					vRP.upgradeThirst(parseInt(args[1]),100)
 					vRP.upgradeHunger(parseInt(args[1]),100)
 					vRP.upgradeStress(parseInt(args[1]),100)
 					TriggerClientEvent("resetBleeding",nplayer)
 					TriggerClientEvent("resetDiagnostic",nplayer)
 					SendWebhookMessage(webhookadmingod,"```prolog\n[ID]: "..user_id.." \n[DEU GOD]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 				end
 			else
 				vRP.upgradeThirst(user_id,100)
 				vRP.upgradeHunger(user_id,100)
 				vRP.downgradeStress(user_id,80)
			vRPclient.setArmour(source,100)
 				vCLIENT._revivePlayer(source,200)
 				TriggerClientEvent("resetBleeding",source)
 				TriggerClientEvent("resetDiagnostic",source)
 				SendWebhookMessage(webhookadmingod,"```prolog\n[ID]: "..user_id.." \n[DEU GOD]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
 		end
 	end
 end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("health",function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		if vRP.hasPermission(user_id,"Admin") then
-- 			if args[1] then
-- 				local nplayer = vRP.getUserSource(parseInt(args[1]))
-- 				if nplayer then
-- 					vCLIENT._revivePlayer(nplayer,200)
-- 					TriggerClientEvent("resetBleeding",nplayer)
-- 					TriggerClientEvent("resetDiagnostic",nplayer)
-- 				end
-- 			else
-- 				vCLIENT._revivePlayer(source,200)
-- 				TriggerClientEvent("resetBleeding",source)
-- 				TriggerClientEvent("resetDiagnostic",source)
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("armour",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					vRPclient.setArmour(nplayer,100)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("resetDiagnostic",nplayer)
					SendWebhookMessage(webhookosarmour, "```prolog\n[ARMOUR]\n[ID:] "..user_id.."\n[ID QUE RECEBEU:] ".. parseInt(args[1]) .."\n"..os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			else
				vRPclient.setArmour(source,100)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
				SendWebhookMessage(webhookosarmour, "```prolog\n[ARMOUR]\n[ID:] "..user_id.."\n[ID QUE RECEBEU:] ".. parseInt(args[1]) .."\n"..os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("upgradeStress")
AddEventHandler("upgradeStress",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,parseInt(number))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("re",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Paramedic") or vRP.hasPermission(user_id,"Police") then
			local nplayer = vRPclient.nearestPlayer(source,2)
			if nplayer then
				if not vCLIENT.deadPlayer(source) then
					if vCLIENT.deadPlayer(nplayer) then
						TriggerClientEvent("Progress",source,10000,"Retirando...")
						TriggerClientEvent("cancelando",source,true)
						vRPclient._playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
						SetTimeout(10000,function()
							vRPclient._removeObjects(source)
							vCLIENT._revivePlayer(nplayer,110)
							TriggerClientEvent("resetBleeding",nplayer)
							TriggerClientEvent("cancelando",source,false)
							
						end)
					end
				end
			end
		end
	end
end)

function cRP.ClearGunsAnDead()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("inventory:clearWeapons",user_id)
	end
end	
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.ResetPedToHospital()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		
		local clear = vRP.clearInventory(user_id)
			if clear then
				vRPclient._clearWeapons(source)
				Wait(1000)
			end
		end
	end