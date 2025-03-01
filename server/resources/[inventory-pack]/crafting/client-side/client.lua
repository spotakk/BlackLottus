-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCrafting",function(data,cb)
	local inventoryCraft,inventoryUser,invPeso,invMaxpeso,playerName,playerId = vSERVER.requestCrafting(data["craft"])
	if inventoryCraft then
		cb({ inventoryCraft = inventoryCraft, inventario = inventoryUser, invPeso = invPeso, invMaxpeso = invMaxpeso,name = playerName,id = playerId })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionCraft",function(data)
	if MumbleIsConnected() then
		vSERVER.functionCrafting(data["index"],data["craft"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionDestroy",function(data)
	if MumbleIsConnected() then
		vSERVER.functionDestroy(data["index"],data["craft"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("crafting:populateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("crafting:updateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Update")
AddEventHandler("crafting:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	-----------------------------------------------------------------------------------------------------------------------------------------
	-- CRAFT'S PÚBLICOS
	-----------------------------------------------------------------------------------------------------------------------------------------
		["1"] = { 82.45,-1553.26,29.59,"Lixeiro" }, -- Troca de material
		["2"] = { 287.36,2843.6,44.7,"Lixeiro" }, -- Troca de material
		["3"] = { -413.68,6171.99,31.48,"Lixeiro" }, -- Troca de material
		["4"] = {845.46,2123.06,52.64,"Utilspub"}, -- Utilitários
		["5"] = {-1051.81,-232.21,44.01,"LavagemPUB"}, -- Lavagem Pública
		["6"] = {-1194.89,-898.37,13.88,"Burguer"}, -- BurguerShot
		["7"] = {-1191.09,-898.29,13.88,"BurguerJuice"}, -- BurguerShot
	
	-----------------------------------------------------------------------------------------------------------------------------------------
	-- FAVELAS - PRODUÇÃO - FEITO
	-----------------------------------------------------------------------------------------------------------------------------------------
		["8"] = {1274.01,-125.06,87.64,"Barragem"}, -- Cocaína 
		["9"] = {1346.5,-683.92,88.55,"Helipa"}, -- --  Maconha
		["10"] = {-1724.63,-227.45,57.56,"Igreja"}, -- Metafetamina
		["11"] = {1258.04,-1091.24,54.16,"Esgoto"}, -- Lean
		["12"] = {1364.93,-2443.23,62.18,"Porto"}, -- Oxy

	-----------------------------------------------------------------------------------------------------------------------------------------
	-- FACÇÕES
	-----------------------------------------------------------------------------------------------------------------------------------------
		["13"] = {977.85,-95.19,74.86,"TheLost"}, -- Munição, colete
		["14"] = {-571.41,290.04,79.18,"Tequila"}, -- Munição, colete

		["15"] = { 1405.86,1137.88,109.74,"Mafia" }, -- Armas
		["16"] = {-1865.65,2061.24,135.44,"Vinhedo"}, -- Armas

		["17"] = {95.0,-1292.9,29.27,"Vanilla"}, -- Lavagem, attachs
	    ["18"] = {-1365.5,-623.73,30.33,"Bahamas"}, --  Attachs

		["19"] = {-75.4,-1813.8,20.81,"Roxos"}, -- Capuz, algema
		["20"] = {-134.78,-1609.47,35.03,"Groove"}, -- Capuz, algema

		["21"] = {-198.18,-1340.72,34.9,"Bennys"}, -- Nitro, Placa, Notebook


	}
	local LixeiroTraje = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 36, texture = 0 },
			["vest"] = { item = -1, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 27, texture = 0 },
			["tshirt"] = { item = 59, texture = 0 },
			["torso"] = { item = 56, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 },
			["parachute"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 35, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 24, texture = 0 },
			["tshirt"] = { item = 36, texture = 0 },
			["torso"] = { item = 73, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 223, texture = 0 },
			["glass"] = { item = 13, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	}
	
	RegisterNetEvent("setTrajeLixeiro",function()
		local model = vSERVER.modelPlayer()
		if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
			TriggerEvent("updateRoupas", LixeiroTraje[model])
		end
	end)
	
	Citizen.CreateThread(function()
		SetNuiFocus(false,false)
	
		for k,v in pairs(List) do
			if v[4] == "Lixeiro" then 
				exports["target"]:AddCircleZone("Crafting:"..k,vector3(v[1],v[2],v[3]),1.0,{
					name = "Crafting:"..k,
					heading = 3374176
				},{
					shop = k,
					distance = 1.0,
					options = {
						{
							event = "crafting:openSystem",
							label = "Abrir",
							tunnel = "shop"
						},
						{
							event = "setTrajeLixeiro",
							label = "Traje",
							tunnel = "client"
						}
					}
				})
			else
				exports["target"]:AddCircleZone("Crafting:"..k,vector3(v[1],v[2],v[3]),1.0,{
					name = "Crafting:"..k,
					heading = 3374176
				},{
					shop = k,
					distance = 1.0,
					options = {
						{
							event = "crafting:openSystem",
							label = "Abrir",
							tunnel = "shop"
						},
					}
				})
			end
		end
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:openSystem",function(shopId)
	if vSERVER.requestPerm(List[shopId][4]) then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = List[shopId][4] })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:FUELSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:fuelShop",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "fuelShop" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPENSOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:openSource")
AddEventHandler("crafting:openSource",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "craftShop" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:AMMUNATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Ammunation")
AddEventHandler("crafting:Ammunation",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "ammuShop" })
end)


-- function cRP.modelPlayer()
--     local source = source
--     local ped = GetPlayerPed(source)
--     if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
--         return "mp_m_freemode_01"
--     elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
--         return "mp_f_freemode_01"
--     end

--     return false
-- end