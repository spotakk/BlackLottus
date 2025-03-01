-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:SERVERMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chat:ServerMessage")
AddEventHandler("chat:ServerMessage",function(Message,Mode)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		local Identity = vRP.userIdentity(Passport)
		local Messages = Message:gsub("[<>]","")
		TriggerClientEvent("chat:ClientMessage",source,Identity["name"].." "..Identity["name2"],Mode,Messages)

		local Players = vRPC.nearestPlayers(source,10)
		for _, v in pairs(Players) do
			if (v[1] < 10) then
				async(function()
					TriggerClientEvent("chat:ClientMessage", v[2], Identity["name"].." "..Identity["name2"],Mode,Messages)
				end)
			end
		end
	end
end)