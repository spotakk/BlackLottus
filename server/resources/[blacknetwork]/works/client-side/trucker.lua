-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inSeconds = 0
local serviceBlip = nil
local initStage = false
local getPackage = false
local deliveryLocates = 1
local packageVehicle = nil
local isTake = false
local initCoords = { 1239.87,-3257.16,7.09 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local deliveryCoords = {
	{ 120.22,6612.56,31.88,"tr4" },
	{ 185.94,6620.62,31.74,"tanker" },
	{ -51.89,6529.22,31.49,"trailers3" },
	{ 156.74,6404.81,31.16,"tvtrailer" },
	{ -80.76,6429.06,31.49,"armytanker" },
	{ -572.43,5339.07,70.21,"trailerlogs" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local TruckerTraje = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = 0, texture = 0 },
		["pants"] = { item = 122, texture = 0 },
		["vest"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 73, texture = 0 },
		["shoes"] = { item = 73, texture = 0 },
		["tshirt"] = { item = 23, texture = 0 },
		["torso"] = { item = 339, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 4, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["parachute"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 90, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 10, texture = 0 },
		["torso"] = { item = 389, texture = 9 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 14, texture = 0 },
		["glass"] = { item = 13, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}

RegisterNetEvent("work:setTraje:trucker",function()
	local model = vSERVER.modelPlayer()
	if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
		TriggerEvent("updateRoupas", TruckerTraje[model])
	end
end)

RegisterNetEvent("init:target:trucker", function()
	if not initStage then
		deliveryLocates = math.random(#deliveryCoords)
		TriggerEvent("Notify","amarelo","Atenção","Dirija-se até seu caminhão <b>Packer</b> e buzine o mesmo<br>e receba a carga responsável pelo transporte.",5000)
		makeBlipMarked(deliveryCoords[deliveryLocates][1],deliveryCoords[deliveryLocates][2],deliveryCoords[deliveryLocates][3])
		getPackage = true
		inSeconds = 3
	end
end)

RegisterNetEvent("payment:target:trucker", function()
	if (initStage) then
		vSERVER.paymentMethod()
		isTake = false
		packageVehicle = nil
		initStage = false
		inSeconds = 3

		if DoesBlipExist(serviceBlip) then
			RemoveBlip(serviceBlip)
			serviceBlip = nil
		end
	else
		TriggerEvent("Notify","amarelo","Atenção","Você ainda não completou o serviço, e não está apto a receber o pagamento.",5000)
	end
end)

Citizen.CreateThread(function()
	while true do
		if getPackage ~= nil then
			distance = 1
			if IsControlJustPressed(1, 168) then
				if getPackage then
					getPackage = false
					initStage = false
					TriggerEvent("Notify", "amarelo", "Atenção", "Serviço finalizado.", 5000)
					isTake = false
					packageVehicle = nil
					initStage = false
					inSeconds = 3

					if DoesBlipExist(serviceBlip) then
						RemoveBlip(serviceBlip)
						serviceBlip = nil
					end
				end
			end
		end
		Wait(distance)
	end
end)
local FreezeEntity = false
Citizen.CreateThread(function()
	exports["target"]:AddCircleZone("trucker", vec3(initCoords[1], initCoords[2], initCoords[3]), 0.5, {
		name = "trucker",
		heading = 3374176
	}, {
		shop = "trucker",
		distance = 1.5,
		options = {
			{
				event = "init:target:trucker",
				label = "Iniciar",
				tunnel = "client"
			},
			{
				event = "work:setTraje:trucker",
				label = "Traje",
				tunnel = "client"
			},
			{
				event = "payment:target:trucker",
				label = "Receber Pagamento",
				tunnel = "client"
			},
		}
	})

	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			if getPackage then
				local distance = #(coords - vector3(deliveryCoords[deliveryLocates][1],deliveryCoords[deliveryLocates][2],deliveryCoords[deliveryLocates][3]))
				if distance <= 50 then
					timeDistance = 1
					DrawMarker(23,deliveryCoords[deliveryLocates][1],deliveryCoords[deliveryLocates][2],deliveryCoords[deliveryLocates][3] - 0.95,0.0,0.0,0.0,0.0,0.0,0.0,10.0,10.0,0.0,42,137,255,100,0,0,0,0)

					if IsControlJustPressed(1,38) and inSeconds <= 0 and distance <= 5 then
						inSeconds = 3

						local _,vehNet,vehPlate,modelVehicle = vRP.vehList(10)
						if modelVehicle == deliveryCoords[deliveryLocates][4] then
							TriggerEvent("Notify","amarelo","Atenção","Volte ao ponto de partida e receba o pagamento.",5000)
							TriggerEvent("garages:Delete",_,source)
							makeBlipMarked(initCoords[1],initCoords[2],initCoords[3])
							getPackage = false
							initStage = true
						end
					end
				end
			end
		else
			if getPackage and packageVehicle == nil then
				local coords = GetEntityCoords(ped)
				local distance = #(coords - vector3(initCoords[1],initCoords[2],initCoords[3]))
				if distance <= 50 then
					local veh = GetVehiclePedIsUsing(ped)
					if GetEntityModel(veh) == 569305213 then
						timeDistance = 1
						if not isTake and not FreezeEntity then
							TriggerEvent("Notify","amarelo","Atenção","Aperte [E] para sair com a carga",7000)
							FreezeEntity = true
						end

						if IsControlJustPressed(1,38) and inSeconds <= 0 and not isTake then
							inSeconds = 3
							FreezeEntity = false

							local vehCoords = GetOffsetFromEntityInWorldCoords(veh,0.0,-12.0,0.0)
							local _,groundZ = GetGroundZAndNormalFor_3dCoord(vehCoords["x"],vehCoords["y"],vehCoords["z"])
							TriggerServerEvent("garages:createVehicle",deliveryCoords[deliveryLocates][4],vehCoords["x"],vehCoords["y"],groundZ,source)
							isTake = true
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if inSeconds > 0 then
			inSeconds = inSeconds - 1
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipMarked(x,y,z)
	if DoesBlipExist(serviceBlip) then
		RemoveBlip(serviceBlip)
		serviceBlip = nil
	end

	serviceBlip = AddBlipForCoord(x,y,z)
	SetBlipSprite(serviceBlip,12)
	SetBlipColour(serviceBlip,84)
	SetBlipScale(serviceBlip,0.9)
	SetBlipRoute(serviceBlip,true)
	SetBlipAsShortRange(serviceBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Caminhoneiro")
	EndTextCommandSetBlipName(serviceBlip)
end