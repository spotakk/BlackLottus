-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Boxes = 0
local Cooldown = os.time()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Helicrash"] = false
GlobalState["HelicrashCooldown"] = os.time()
GlobalState["Firework"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do 
		if Timers[os.date("%H:%M")] and os.time() >= Cooldown then
			Boxes = 0
			local Selected = math.random(#Components)
			for Number,v in pairs(Components[Selected]) do
				if Number ~= "1" then
					Boxes = Boxes + 1

					local Loot = math.random(#Loots)
					vRP.remSrvdata("stackChest:Helicrash-"..Number,false)

					for Slot,w in pairs(Loots[Loot]) do
						local Durability = itemDurability(w["item"])
						if Durability then
							w["item"] = w["item"].."-"..parseInt(os.time() - (86400 * (Durability / math.random(2,5))))

							Loots[Loot][Slot] = w
						end
					end

					vRP.setSrvdata("stackChest:Helicrash-"..Number,Loots[Loot],false)
				end
			end
			TriggerClientEvent("Notify",-1,"important","Helicoptero Caindo!","Mayday! Mayday! Tivemos problemas técnicos em nossos motores e estamos em queda livre.","amarelo",60000)
			GlobalState["Helicrash"] = Selected
			GlobalState["HelicrashCooldown"] = os.time() + 600
			Cooldown = os.time() + 3600
		end

		if Burn[os.date("%H:%M-%d/%m")] and os.time() >= Cooldown then
			TriggerClientEvent('smartphone:createSMS',-1,'Prefeitura',"A Prefeitura de Energy deseja a todos os seus cidadões um feliz e próspero Ano Novo! Feliz "..os.date("%Y").."!")
			GlobalState["Firework"] = true
			Cooldown = os.time() + 900

			SetTimeout(900000,function()
				GlobalState["Firework"] = false
			end)
		end

		if Backup[os.date("%M")] and os.time() >= Cooldown then
			TriggerEvent("SaveServer",false)
			Cooldown = os.time() + 60
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOX
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Box",function()
	if GlobalState["Helicrash"] then
		Boxes = Boxes - 1
		if Boxes <= 0 then
			GlobalState["Helicrash"] = false
			Boxes = 0
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("helicrash",function(source,Message)
	local getUserId = vRP.getUserId(source)
	if getUserId then
		if vRP.hasGroup(getUserId,"Admin") then
			Timers[os.date("%H:%M")] = true
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIREWORK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("firework",function(source)
	local getUserId = vRP.getUserId(source)
	if getUserId and vRP.hasGroup(getUserId,"Admin",2) then
    	GlobalState["Firework"] = true

		Wait(900000)
		GlobalState["Firework"] = false
	end
end)