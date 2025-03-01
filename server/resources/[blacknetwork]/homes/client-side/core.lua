-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
vRP = Proxy.getInterface("vRP")
Tunnel.bindInterface("propertys", Creative)
vSERVER = Tunnel.getInterface("propertys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Init = ""
local Blips = {}
local Chest = ""
local Markers = {}
local Interior = ""
local Propertys = {}
local Informations = {}
local itensRoubed = {}
local roubando = {
	emRoubo = false,
	enterCoords = {}
}

local policeEnter = false

local theftCoords = {
	["Middle"] = {
		["MOBILE01"] = { 0.45,-2.87,-0.8 },
		["MOBILE02"] = { -4.26,-5.36,-0.3 },
		["MOBILE03"] = { -5.61,-5.21,-0.8 },
		["MOBILE04"] = { -7.57,2.04,-1.0 },
		["MOBILE05"] = { -3.91,2.08,-1.0 },
		["MOBILE06"] = { 0.77,2.96,0.1 },
		["MOBILE07"] = { 5.68,-1.13,-0.8 },
		["MOBILE08"] = { 7.15,-1.00,-1.0 },
		["MOBILE09"] = { 6.38,5.78,-0.3 },
		["MOBILE10"] = { 3.59,3.83,-0.9 },
		["MOBILE11"] = { 1.60,4.58,-0.7 },
		["MOBILE12"] = { -0.54,-2.46,-0.3 },
		["LOCKER"] = { 4.47,-1.00,-0.9 }
	},
	["Mansion"] = {
		["MOBILE01"] = { 0.93,-14.28,-0.2 },
		["MOBILE02"] = { -0.41,-18.88,-0.2 },
		["MOBILE03"] = { -5.93,-18.00,-0.1 },
		["MOBILE04"] = { -3.97,-13.54,0.5 },
		["MOBILE05"] = { 5.80,-11.88,0.5 },
		["MOBILE06"] = { 8.98,0.43,-0.5 },
		["MOBILE07"] = { 4.97,5.94,-0.1 },
		["MOBILE08"] = { -2.41,9.43,-0.6 },
		["MOBILE09"] = { 1.48,8.29,-0.5 },
		["MOBILE10"] = { 3.19,14.13,-0.9 },
		["MOBILE11"] = { -0.08,14.00,-0.9 },
		["MOBILE12"] = { -2.80,17.30,-0.7 },
		["LOCKER"] = { -2.37,11.14,-0.7 }
	},
	["Trailer"] = {
		["MOBILE01"] = { 5.57,-1.36,-0.7 },
		["MOBILE02"] = { 1.82,-1.79,-0.7 },
		["MOBILE03"] = { 0.22,1.70,-0.5 },
		["MOBILE04"] = { -6.10,-1.47,-0.3 },
		["MOBILE05"] = { -4.39,-1.97,-0.8 },
		["MOBILE06"] = { -3.25,-1.85,-0.2 },
		["LOCKER"] = { 3.49,-2.00,-1.0 }
	},
	["Beach"] = {
		["MOBILE01"] = { -0.62,-0.95,-0.6 },
		["MOBILE02"] = { 3.14,-3.75,-0.6 },
		["MOBILE03"] = { 8.36,-3.60,-0.1 },
		["MOBILE04"] = { 7.86,-0.49,-0.8 },
		["MOBILE05"] = { 6.47,0.34,-0.8 },
		["MOBILE06"] = { 7.80,3.72,-0.8 },
		["MOBILE07"] = { 3.63,3.00,-0.1 },
		["MOBILE08"] = { 0.78,2.10,-0.3 },
		["MOBILE09"] = { -1.07,2.79,-0.6 },
		["MOBILE10"] = { -8.31,3.55,-0.9 },
		["MOBILE11"] = { -5.39,-3.83,-0.2 },
		["MOBILE12"] = { -1.45,-2.98,-0.7 },
		["LOCKER"] = { 8.76,0.49,-0.8 }
	},
	["Simple"] = {
		["MOBILE01"] = { -5.74,-1.80,0.6 },
		["MOBILE02"] = { -5.49,2.60,0.8 },
		["MOBILE03"] = { -4.06,2.62,0.8 },
		["MOBILE04"] = { -3.30,2.63,1.2 },
		["MOBILE05"] = { 1.41,-2.15,1.2 },
		["MOBILE06"] = { 5.61,-3.89,0.5 },
		["MOBILE07"] = { 5.53,-0.58,0.5 },
		["MOBILE08"] = { 5.57,0.66,0.8 },
		["LOCKER"] = { 2.60,2.68,0.7 }
	},
	["Motel"] = {
		["MOBILE01"] = { 5.08,2.05,0.3 },
		["MOBILE02"] = { 4.89,3.40,0.6 },
		["MOBILE03"] = { 2.31,6.13,0.2 },
		["MOBILE04"] = { 1.05,6.16,0.0 },
		["MOBILE05"] = { -3.55,0.30,0.6 },
		["LOCKER"] = { -5.10,2.78,0.0 }
	},
	["Modern"] = {
		["MOBILE01"] = { -1.01,0.42,-0.6 },
		["MOBILE02"] = { 3.07,-2.66,-0.8 },
		["MOBILE03"] = { 2.14,7.27,-0.1 },
		["MOBILE04"] = { 1.02,7.27,-0.1 },
		["MOBILE05"] = { 0.05,7.27,-0.1 },
		["MOBILE06"] = { -1.98,7.26,-0.6 },
		["MOBILE07"] = { -3.46,4.33,-0.6 },
		["MOBILE08"] = { -0.56,4.34,-0.6 },
		["MOBILE09"] = { -0.59,2.92,-0.1 },
		["MOBILE10"] = { -0.59,1.53,-0.1 },
		["LOCKER"] = { 4.64,6.27,-0.8 }
	},
	["Hotel"] = {
		["MOBILE01"] = { 2.40,-1.78,-0.8 },
		["MOBILE02"] = { -1.78,2.59,-0.1 },
		["MOBILE03"] = { -2.24,0.95,-0.6 },
		["MOBILE04"] = { -2.26,-0.49,-0.7 },
		["LOCKER"] = { -1.04,3.87,-0.8 }
	},
	["Franklin"] = {
		["MOBILE01"] = { -1.81,-5.41,-0.7 },
		["MOBILE02"] = { -2.59,-5.59,-0.8 },
		["MOBILE03"] = { -5.45,-5.75,-1.0 },
		["MOBILE04"] = { -2.68,-0.50,-1.0 },
		["MOBILE05"] = { -3.74,3.31,-0.6 },
		["MOBILE06"] = { 2.01,7.33,-0.7 },
		["MOBILE07"] = { 4.40,5.50,-0.7 },
		["MOBILE08"] = { 4.31,4.59,-0.2 },
		["MOBILE09"] = { 5.15,-0.81,-0.8 },
		["MOBILE10"] = { 0.93,-0.25,-0.9 },
		["MOBILE11"] = { 4.81,-6.93,-0.8 },
		["LOCKER"] = { 1.19,3.43,-0.9 }
	},
	["Container"] = {
		["MOBILE01"] = { 1.45,-1.29,0.7 },
		["MOBILE02"] = { 4.46,-1.30,0.6 },
		["MOBILE03"] = { 4.62,0.72,0.1 },
		["MOBILE04"] = { 1.75,1.55,0.1 },
		["MOBILE05"] = { 0.59,1.44,0.7 },
		["MOBILE06"] = { -0.51,1.44,0.7 },
		["MOBILE07"] = { -1.63,1.55,0.1 },
		["MOBILE08"] = { -4.62,0.76,0.1 },
		["MOBILE09"] = { -4.44,-1.31,0.6 },
		["LOCKER"] = { 2.80,1.33,0.0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			if Init == "" then
				for Name, v in pairs(Propertys) do
					if #(Coords - v) <= 1.0 then
						TimeDistance = 1

						if IsControlJustPressed(1, 38) then
							local Option, Table = vSERVER.Propertys()
							if Option == "Corretor" then
								for Line, v in pairs(Table) do 
									
									if Line ~= "Hotel" then

										-- exports["dynamic"]:AddButton("Comprar", "Adquirir a propriedade.",
										-- 	"propertys:Buy", Name .. "-" .. Line, Line, true)
										-- exports["dynamic"]:AddButton("Valor",
										-- 	"Custo de <yellow>$" ..
										-- 	parseFormat(v["Price"]) .. "</yellow> dólares.", "", "",
										-- 	Line, false)
										-- exports["dynamic"]:AddButton("Compartimento",
										-- 	"Total de <yellow>" ..
										-- 	v["Vault"] ..
										-- 	"Kg</yellow> no baú e <yellow>" ..
										-- 	v["Fridge"] .. "Kg</yellow> na geladeira.", "", "", Line,
										-- 	false)
										-- exports["dynamic"]:SubMenu(Line, "Informações sobre o interior.",
										-- 	Line)
										TriggerEvent("fx:initHomes",v,Name)
									end
									
								end

								--exports["dynamic"]:openMenu()
							elseif Option == "Player" then
								Interior = Table[1]["interior"]
								if string.sub(Name, 1, 9) == "Propertys" then
									exports["dynamic"]:AddButton("Entrar", "Adentrar a propriedade.",
										"propertys:Enter", Name, false, false)
							
									exports["dynamic"]:AddButton("Fechadura",
										"Trancar/Destrancar a propriedade.", "propertys:Lock", Name,
										false, true)
									exports["dynamic"]:AddButton("Garagem",
										"Adicionar/Reajustar a garagem.", "homes:invokeSystem", "garagem",
										false, true)
									exports["dynamic"]:AddButton("Vender",
										"Se desfazer da propriedade.", "propertys:Sell", Name, false,
										true)
									exports["dynamic"]:openMenu()
								else
									TriggerEvent("propertys:Enter", Name)
								end
							elseif Option == "Vizinho" then
								Interior = Table[1]["interior"]
								exports["dynamic"]:AddButton("Entrar", "Adentrar a propriedade.","propertys:enterHomeUser",Table[1]["name"], false, true)
								exports["dynamic"]:openMenu()
							else
								if vSERVER.checkHotel() then
									Interior = "Hotel"
									TriggerEvent("propertys:Enter", Name)
								end
							end
						end
					end
				end
			else
				if Informations[Interior] then
					SetPlayerBlipPositionThisFrame(Propertys[Init][1], Propertys[Init][2])

					if Coords["z"] < (Informations[Interior]["Exit"][3] - 25.0) then
						SetEntityCoords(Ped, Informations[Interior]["Exit"], false, false, false, false)
					end

					for Line, v in pairs(Informations[Interior]) do
						if #(Coords - v) <= 1.0 then
							TimeDistance = 1

							if Line == "Exit" and IsControlJustPressed(1, 38) then
								SetEntityCoords(Ped, Propertys[Init], false, false, false, false)
								TriggerServerEvent("propertys:Toggle", Init)
								Interior = ""
								Chest = ""
								Init = ""
							elseif (Line == "Vault" or Line == "Fridge") and IsControlJustPressed(1, 38) then
								local userName,userId = vSERVER.getUser()
								SendNUIMessage({ action = "showMenu",userName = userName,userId = userId })
								SetNuiFocus(true, true)
								if (Line == "Vault") then
									Chest = "vault"
								else
									Chest = "fridge"
								end
							elseif Line == "Clothes" and IsControlJustPressed(1, 38) then
								ClothesMenu()
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHESMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function ClothesMenu()
	exports["dynamic"]:AddButton("Guardar", "Salvar suas vestimentas do corpo.", "propertys:Clothes", "save", false,
		true)
	exports["dynamic"]:AddButton("Shopping", "Abrir a loja de vestimentas.", "nation_skinshop:toggleMenu", "admin", false,
		false)
	exports["dynamic"]:SubMenu("Vestir", "Abrir lista com todas as vestimentas.", "apply")
	exports["dynamic"]:SubMenu("Remover", "Abrir lista com todas as vestimentas.", "delete")

	local Clothes = vSERVER.Clothes()

	if parseInt(#Clothes) > 0 then
		for k, v in pairs(Clothes) do
			exports["dynamic"]:AddButton(v["name"], "Vestir-se com as vestimentas.", "propertys:Clothes",
				"apply-" .. v["name"], "apply", true)
			exports["dynamic"]:AddButton(v["name"], "Remover a vestimenta salva.", "propertys:Clothes",
				"delete-" .. v["name"], "delete", true)
		end
	end

	exports["dynamic"]:openMenu()
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CLOTHESRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:ClothesReset")
AddEventHandler("propertys:ClothesReset", function()
	TriggerEvent("dynamic:closeSystem")
	ClothesMenu()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Enter")
AddEventHandler("propertys:Enter", function(Name,bucket)
	Init = Name
	local Ped = PlayerPedId()
	TriggerEvent("dynamic:closeSystem")
	
	if bucket then
		TriggerServerEvent("propertys:Toggle", GetEntityCoords(Ped), bucket)
	else
		TriggerServerEvent("propertys:Toggle", GetEntityCoords(Ped))
	end
	SetEntityCoords(Ped, Interiors[Interior]["Exit"][1], Interiors[Interior]["Exit"][2], Interiors[Interior]["Exit"][3], false, false, false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBERYSPROPERTYS:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
local house = ""
local interiorsRoubed = {"Emerald","Diamond","Ruby","Sapphire","Amethyst","Amber"}
local houseRoubed = ""
RegisterNetEvent("propertys:PoliceEnter")
AddEventHandler("propertys:PoliceEnter", function(Name)
	house = Name
	local Ped = PlayerPedId()
	TriggerEvent("dynamic:closeSystem")
	TriggerServerEvent("propertys:Toggle", house)

	policeEnter = true
	SetEntityCoords(Ped, Interiors[houseRoubed]["Exit"][1], Interiors[houseRoubed]["Exit"][2], Interiors[houseRoubed]["Exit"][3], false, false, false, false)
end)



RegisterNetEvent("propertys:RouberysEnter")
AddEventHandler("propertys:RouberysEnter", function(Name)
	house = Name

	local Ped = PlayerPedId()
	TriggerEvent("dynamic:closeSystem")
	TriggerServerEvent("propertys:Toggle", house)
	local randomHomes = math.random(#interiorsRoubed)
	houseRoubed = interiorsRoubed[randomHomes]
	SetEntityCoords(Ped, Interiors[houseRoubed]["Exit"][1], Interiors[houseRoubed]["Exit"][2], Interiors[houseRoubed]["Exit"][3], false, false, false, false)
	roubando.emRoubo = true
	roubando.enterCoords = Propertys[Name]
end)
 


Citizen.CreateThread(function()
	while true do
		if policeEnter then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			
			local distance = #(coords - Interiors[houseRoubed]["Exit"])
			if distance <= 3.2 then
				if IsControlJustPressed(1, 38)  then
					SetEntityCoords(ped, Propertys[house][1], Propertys[house][2], Propertys[house][3], false, false,
						false, false)
					TriggerServerEvent("propertys:Toggle", house)
					policeEnter = false;
					itensRoubed = {}
				end
			end
		end
		Wait(1)
	end
end)

Citizen.CreateThread(function()
	while true do
		if roubando.emRoubo then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			
			local distance = #(coords - Interiors[houseRoubed]["Exit"])
			if distance <= 3.2 then
				if IsControlJustPressed(1, 38)  then
					SetEntityCoords(ped, Propertys[house][1], Propertys[house][2], Propertys[house][3], false, false,false, false)
					TriggerServerEvent("propertys:Toggle", house)
					roubando.emRoubo = false;
					itensRoubed = {}
				end
			end
		end
		Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Request", function(Data, Callback)
	print(Init,Chest)
	local Inventory, Chest, InvPeso, InvMax, ChestPeso, ChestMax = vSERVER.OpenChest(Init, Chest)
	if Inventory then
		Callback({
			myInventory = Inventory,
			myChest = Chest,
			invPeso = InvPeso,
			invMaxpeso = InvMax,
			chestPeso = ChestPeso,
			chestMaxpeso = ChestMax
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
	SendNUIMessage({ action = "hideMenu" })
	SetNuiFocus(false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take", function(Data, Callback)
	vSERVER.Take(Data["slot"], Data["amount"], Data["target"], Init, Chest)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store", function(Data, Callback)
	vSERVER.Store(Data["item"], Data["slot"], Data["amount"], Data["target"], Init, Chest)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update", function(Data, Callback)
	vSERVER.Update(Data["slot"], Data["target"], Data["amount"], Init, Chest)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Update")
AddEventHandler("propertys:Update", function()
	SendNUIMessage({ Action = "requestChest" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:WEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Weight")
AddEventHandler("propertys:Weight", function(InvPeso, InvMax, ChestPeso, ChestMax)
	SendNUIMessage({ Action = "updateWeight", InvPeso = InvPeso, InvMax = InvMax, ChestPeso = ChestPeso, ChestMax = ChestMax })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
local typesMessages = {
	["Exit"] = "Saída",
	["Vault"] = "Baú",
	["Fridge"] = "Geladeira",
	["Clothes"] = "Armário",
}

RegisterNetEvent("propertys:Table")
AddEventHandler("propertys:Table", function(PropTable, PropInfos, PropMarkers)
	Markers = PropMarkers
	Propertys = PropTable
	Informations = PropInfos

	local Tables = {}
	for _, v in pairs(Propertys) do
		table.insert(Tables, { v["x"], v["y"], v["z"], 1.0, "E", "Propriedade", "Pressione para acessar" })
	end

	for _, v in pairs(Interiors) do
		for type, _ in pairs(v) do
			table.insert(Tables, { v[type]["x"], v[type]["y"], v[type]["z"], 1.0, "E", typesMessages[type], "Pressione para acessar" })
		end
	end

	TriggerEvent("hoverfy:insertTable", Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Blips")
AddEventHandler("propertys:Blips", function()
	if json.encode(Blips) ~= "[]" then
		for _, v in pairs(Blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end

		Blips = {}

		TriggerEvent("Notify","important","Propriedades","Marcações desativadas.","amarelo", 10000)
	else
		for Name, v in pairs(Propertys) do 
			Blips[Name] = AddBlipForCoord(v["x"], v["y"], v["z"])
			SetBlipSprite(Blips[Name], 374)
			SetBlipAsShortRange(Blips[Name], true)
			SetBlipColour(Blips[Name], Markers[Name] and 35 or 43)
			SetBlipScale(Blips[Name], 0.4)
		end

		TriggerEvent("Notify","important","Propriedades","Marcações Ativadas", "amarelo", 10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:MARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Markers")
AddEventHandler("propertys:Markers", function(PropMarkers)
	Markers = PropMarkers
end)

function Creative.homeGarage(homeName)
	local homes = {}
	homes["garage"] = 0
	local homeCoords = {}
	homeCoords[homeName] = {}
	homeCoords[homeName]["1"] = {}

	CreateThread(function()
		while true do
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)
		
			if homes["garage"] >= 2 then
				TriggerServerEvent("garages:updateGarages",homeName,homeCoords[homeName])
				break
			end

			if IsControlJustPressed(1,38) then
				homes["garage"] = homes["garage"] + 1

				if homes["garage"] <= 1 then 
					TriggerEvent("Notify","important","Atenção","Fique no <b>local olhando</b> pra onde deseja que o veículo<br>apareça e pressione a tecla <b>E</b> novamente.","amarelo",10000)
					homeCoords[homeName] = { x =coords[1], y = coords[2], z = coords[3] }
				else 
					TriggerEvent("Notify","check","Sucesso","Garagem adicionada.","verde",10000)
					homeCoords[homeName]["1"] = { coords[1],coords[2],coords[3],mathLegth(heading) }
				end
			end

			Wait(1)
		end
	end)
end



function DrawText3D(x, y, z, text)
	local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255, 255, 255, 150)
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x, _y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x, _y + 0.0125, width, 0.03, 15, 15, 15, 175)
	end
end


local policeTime = GetGameTimer()
CreateThread(function()
    SetNuiFocus(false, false)

    while true do
        if roubando.emRoubo then
            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped) then
                local speed = GetEntitySpeed(ped)

                if speed > 2 and GetGameTimer() >= policeTime then
					policeTime = GetGameTimer() + 15000
					vSERVER.callPolice(roubando.enterCoords)
				end

                for k, v in pairs({
					vec3(92.54,-105.4,-24.2),
					vec3(94.61,-99.3,-24.2),
					vec3(92.63,-104.65,-24.2),
					vec3(96.74,-108.58,-24.2),
					vec3(97.14,-94.21,-24.2),
					vec3(103.76,-97.19,-24.2),
					vec3(123.54,-110.09,-23.59),
					vec3(120.78,-123.73,-23.99),
					vec3(128.87,-124.21,-24.01),
					vec3(120.98,-124.35,-27.4),
					vec3(83.98,82.01,-24.01),
					vec3(71.49,84.57,-24.2),
					vec3(62.58,74.31,-24.6),
					vec3(74.92,75.96,-24.01),
					vec3(160.0,-156.56,-19.19),
					vec3(148.71,-165.44,-19.19),
					vec3(139.51,-152.38,-19.19),
					vec3(149.52,-146.86,-19.19),
					vec3(148.48,-153.94,-24.01),
					vec3(30.94,-25.92,-24.01),
					vec3(18.74,-30.05,-24.01),
					vec3(23.73,-21.99,-24.01),
					vec3(24.43,-33.89,-24.01),
					vec3(23.81,-27.46,-24.01),
					vec3(52.28,-45.24,-24.01),
					vec3(51.61,-53.34,-24.01),
					vec3(46.0,-46.41,-24.01),
					vec3(46.04,-49.29,-24.01),
				}) do
					local coords = GetEntityCoords(ped)
                    local distance = #(coords - v)
                    if distance <= 1.9 then
                        if (not itensRoubed[k]) then
                            DrawText3D(v[1],v[2],v[3], "~g~E~w~   VASCULHAR")
                        end
						
						if IsControlPressed(1, 38) and not itensRoubed[k] then   
							if (#(vec3(92.54,-105.4,-24.2) - v) == 0 or  #(vec3(128.92,-124.62,-27.38) - v) == 0 or  #(vec3(51.46,-44.04,-24.01) - v) == 0 or  #(vec3(59.13,79.07,-24.6) - v) == 0 or  #(vec3(144.47,-151.16,-24.01) - v) == 0 or  #(vec3(25.97,-32.98,-24.01) - v) == 0) then
								itensRoubed[k] = true
								local safeCracking = exports["safecrack"]:safeCraking(3)
								if safeCracking then
									vSERVER.paymentTheft("LOCKER")
								end
							else
								itensRoubed[k] = true
								LocalPlayer["state"]["Cancel"] = true
                                vRP.playAnim(false, { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" },
                                    true)

                                local taskBar = exports["taskbar"]:taskHomes()
                                if taskBar then
									vSERVER.AlertPoliceInRobberyHouse()
                                    vSERVER.paymentTheft("MOBILE")
                                end
                                LocalPlayer["state"]["Cancel"] = false
                                vRP.removeObjects()
							end
						end

                        --[[ if IsControlPressed(1, 38) and not itensRoubed[k] then
                            itensRoubed[k] = true
                            local randon = math.random(1, 100)
                            if randon >= 50 then
                                local safeCracking = exports["safecrack"]:safeCraking(3)
                                if safeCracking then
                                    vSERVER.paymentTheft("LOCKER")
                                end
                            else
                                LocalPlayer["state"]["Cancel"] = true
                                vRP.playAnim(false, { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" },
                                    true)

                                local taskBar = exports["taskbar"]:taskHomes()
                                if taskBar then
                                    vSERVER.paymentTheft("MOBILE")
                                end
                                LocalPlayer["state"]["Cancel"] = false
                                vRP.removeObjects()
                            end
                        end ]]
                    end

                end
            end
        end

        Wait(1)
    end
end)