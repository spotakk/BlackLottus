local api = {}
local isNearPump = false
local currentFuel = 0.0
local currentFuel2 = 0.0
local currentCost = 0.0
local bomba
local particle
local abastecendo = false
local bombaNaMao = false
local galaoNaMao = false
local bombaNoVeh = false
local block = false
local boneMark = nil
local vehicleMark = nil
local currentMoney = 0
local fuelCost = 0.00
local spawnedRope = {}
local inUse = false
local lastPump = 0

function ManageFuelUsage(vehicle)
	if IsVehicleEngineOn(vehicle) and not Config.electricVehicles[string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))] then
		local value = GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle),1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10
		DecorSetFloat(vehicle,Config.FuelDecor,GetVehicleFuelLevel(vehicle))
		local Plate = GetVehicleNumberPlateText(vehicle)
		TriggerServerEvent("engine:tryFuel",Plate,value)
	end
end

Citizen.CreateThread(function()
	while true do
		local coords = GetEntityCoords(PlayerPedId())
		local pumpObject = 0
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				ManageFuelUsage(vehicle)
			end
		end
		for _,v in pairs(Config.PumpModels) do
			local prop = GetClosestObjectOfType(coords, 10.0,tonumber(v), false, 0, 0)
			if prop ~= 0 then
				if DoesEntityExist(prop) then
					if GetEntityHealth(prop) > 0 then
						pumpObject = prop
					end
				end
			end
		end
		if pumpObject ~= 0 then
			isNearPump = pumpObject
		else
			isNearPump = false
		end
		Wait(1000)
	end
end)


function floor(num)
	local mult = 10 ^ 1
	return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent("q_fuel:insuficiente")
AddEventHandler("q_fuel:insuficiente",function(index,fuel)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			SetVehicleFuelLevel(v,fuel)
			DecorSetFloat(v,Config.FuelDecor,GetVehicleFuelLevel(v))
		end
	end
end)

RegisterNetEvent('q_fuel:galao')
AddEventHandler('q_fuel:galao',function()
	GiveWeaponToPed(PlayerPedId(),883325847,4500,false,true)
end)

function Round(num,numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num*mult+0.5) / mult
end

function TheRopeIsTooTight()
	if RopeGetDistanceBetweenEnds(spawnedRope[bomba]) > Config.DistanciaParaExplodir then
		return true
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		wait = 1000
		local ped = PlayerPedId()
		if not abastecendo and (isNearPump or (GetSelectedPedWeapon(ped) == 883325847 and not isNearPump)) then
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped),-1) == ped and not bombaNoVeh and Vdist(GetEntityCoords(isNearPump), GetEntityCoords(GetPlayerPed())) < 10 then
				wait = 5
				local pumpCoords = GetEntityCoords(isNearPump)
				DrawText3Ds(pumpCoords.x,pumpCoords.y,pumpCoords.z + 1.2,"SAIA DO ~o~VEÍCULO ~w~PARA ABASTECER")
			end
			local pedCoords = GetEntityCoords(ped)
			if bombaNaMao or bombaNoVeh then
				if api then
					if DoesEntityExist(api.vehicle) then
						SendNUIMessage({ show = true })
						if bombaNoVeh then
							wait = 5
							if Config.ExplodirQuandoFicarLonge then
								if isNearPump and bomba and inUse and TheRopeIsTooTight() then
									SendNUIMessage({ show = false })
									ExplodeFuelPump()
								end
							else
								SetVehicleEngineOn(api.vehicle,false,true,true)
								SetVehicleUndriveable(api.vehicle,false)
							end
						end
						-- if not DoesEntityExist(GetPedInVehicleSeat(api.vehicle,-1)) then
						-- 	wait = 1000
						-- 	if bombaNoVeh then
						-- 		SendNUIMessage({ show = true })
						-- 	end
						-- end
					end
				end
			end
		end
		Wait(wait)
	end
end)

function ExplodeFuelPump()
	AddExplosion(GetEntityCoords(lastPump),2,1.0,true,false,0.5)
	ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.10)
	RemoveRope()
	bombaNaMao = false
	inUse = false
end

RegisterNetEvent("felp:retirarbombaexplodida")
AddEventHandler("felp:retirarbombaexplodida", function()
	local ped = PlayerPedId()
	AttachEntityToEntity(NetToObj(bomba),ped,GetPedBoneIndex(ped,28422),0.055,0.05,0.0,-50.0,-90.0,-50.0,1,1,0,1,0,1)
	bombaNoVeh = false
	RequestAnimDict("random@domestic")
	RequestModel("hei_p_m_bag_var22_arm_s")
	while not HasAnimDictLoaded("random@domestic") and not RequestModel("hei_p_m_bag_var22_arm_s") do
		Wait(1000)
	end
	TaskPlayAnim(GetPlayerPed(-1),'random@domestic', 'pickup_low',5.0, 1.0, 5.0, 48, 0.0, 0, 0, 0)
	Wait(1200)
	RemovePistola()
end)

RegisterNetEvent("felp:pegarmangueira") 
AddEventHandler("felp:pegarmangueira", function()
	if bombaNoVeh then
		TriggerEvent("Notify", "cancel", "Negado","Não a mais mangueiras disponiveis, ela está em seu veiculo.","vermelho", 7000)
		return
	end
	if not bombaNaMao then
		currentMoney = vRPSend.getMoney()
		if currentMoney >= Config.valorMinimo then
			SpawnRope()
			bombaNaMao = true
			startPistol()
			inUse = true
			lastPump  = isNearPump
		else
			TriggerEvent("Notify", "cancel", "Negado","Dinheiro insuficiente.","vermelho", 7000)
		end
	else
		if fuelCost > 0 then
			vRPSend.paymentFuelCost(fuelCost)
			fuelCost = 0.0
		end
		RemoveRope()
		RemovePistola()
		bombaNaMao = false
		inUse = false
		lastPump  = false
		SendNUIMessage({ show = false })
	end
end)

function abastecerVeiculo()
	local ped = PlayerPedId()
	TriggerEvent('fuel:startFuelUpTick',isNearPump,ped,api.vehicle)
	if not isNearPump then
		TaskTurnPedToFaceCoord(ped,api.locBone,1000)
		LoadAnimDict("timetable@gardener@filling_can")
		TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0,8.0,-1,50,0,0,0,0)
	end

	Citizen.CreateThread(function()
		while abastecendo do
			local time = 1000
			local vehicleCoords = api.locVeh
			
			if not isNearPump then
				time = 5
				local num = 0
				if api.bone == 'petroltank' then
					num = 0.5
				end
				local x,y,z = api.locBone[1],api.locBone[2],api.locBone[3] - num
				DrawText3Ds(x,y,z + 1.0,"~o~[ G ]~w~ CANCELAR")
				DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.34,"GALÃO: ~b~"..parseInt(GetAmmoInPedWeapon(ped,883325847) / 4500 * 100,1).."%~w~    TANQUE: ~y~"..parseInt(currentFuel,1).."%")
				if IsControlJustReleased(0,47) then
					abastecendo = false
					break
				end
			end
			if isNearPump and GetEntityHealth(isNearPump) <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				abastecendo = false
				SendNUIMessage({ show = false })
				break
			end
			Wait(time)
		end
	end)
end

RegisterNetEvent("felp:iniciarabastecimento") 
AddEventHandler("felp:iniciarabastecimento", function()
	if not bombaNoVeh then
		currentMoney = vRPSend.getMoney()
		if currentMoney >= Config.valorMinimo then
			boneMark = api.bone
			vehicleMark = api.vehicle
			pistolVeh(api.vehicle,api.bone)
			bombaNaMao = false
			abastecendo = true
			abastecerVeiculo()
		else 
			TriggerEvent("Notify", "cancel", "Negado","Dinheiro insuficiente.","vermelho", 7000)
		end
	else
		if api.bone == boneMark and vehicleMark == api.vehicle then
			boneMark = nil
			vehicleMark = nil
			bombaNaMao = true
			abastecendo = false
			pistolMao()
			startPistol()
		end
	end
end)


Citizen.CreateThread(function()
	DecorRegister(Config.FuelDecor,1)
	SetNuiFocus(false,false)
	while true do
		if isNearPump or galaoNaMao then
			local veh = vRP.vehList(10)
			if veh then
				local locTank = {}
				if GetVehicleClass(veh) == 8 then -- se for uma moto
					locTank["petroltank"] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"petroltank"))
				else
					locTank["wheel_lr"] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_lr"))
					locTank["wheel_rr"] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_rr"))
				end
				for i,j in pairs(locTank) do
					if Vdist(j, GetEntityCoords(PlayerPedId())) <= 1.5 then
						if not Config.electricVehicles[string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))] then
							api = { vehicle = veh, bone = i, locBone = j, locVeh = GetEntityCoords(veh)}
						end
					end
				end
			end
		end
		Wait(1000)
	end
end)

function DrawText3Ds(x, y, z, text)
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
		DrawRect(_x, _y + 0.0125, width, 0.03, 38, 42, 56, 200)
	end
end

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Wait(10)
		end
	end
end

function startPistol()
	Citizen.CreateThread(function()
		while true do
			if bombaNaMao then
				if TheRopeIsTooTight() then
					SendNUIMessage({ show = false })
					ExplodeFuelPump()
					break
				end
				DisableControlAction(0, 24, true)
				if currentMoney >= fuelCost then
					if IsDisabledControlPressed(0, 24) and not isNearPump then
						startParticulas(true)
						fuelCost = fuelCost + 0.075
					else
						startParticulas(false)
					end
				else
					startParticulas(false)
				end
			else
				break
			end
			Wait(5)
		end
	end)
end

function SpawnRope()
	local ped = PlayerPedId(-1)
	local pedPos = GetEntityCoords(ped, false)
	local propPos = GetEntityCoords(isNearPump)
	criarPistola()
	RopeLoadTextures()
	local rope = AddRope(pedPos.x,pedPos.y,pedPos.z,0.0,0.0,0.0,3.0,1,6.0,6.0,10,false,false,false,1.0,true,0)
	local coords = GetOffsetFromEntityInWorldCoords(NetToObj(bomba), 0.0, -0.02, -0.175)
	AttachEntitiesToRope(rope,NetToObj(bomba),isNearPump, coords.x, coords.y, coords.z, propPos.x, propPos.y, propPos.z+1.2, 4.0, false, false,"","")
	spawnedRope[bomba] = rope
	Wait(1000)
	TriggerServerEvent("q_fuel:createRope",bomba,GetEntityModel(isNearPump),pedPos,propPos)
end

RegisterNetEvent("q_fuel:syncRope")
AddEventHandler("q_fuel:syncRope",function(bombaComb,NearPump,pedPos,propPos)
	if spawnedRope[bombaComb] == nil then
		local prop = GetClosestObjectOfType(propPos, 5.0,NearPump, false, 0, 0)
		if prop ~= 0 then
			if NetworkDoesEntityExistWithNetworkId(bombaComb) then
				RopeLoadTextures()
				local rope = AddRope(pedPos.x,pedPos.y,pedPos.z,0.0,0.0,0.0,3.0,1,6.0,6.0,10,false,false,false,1.0,true,0)
				local propPos = GetEntityCoords(prop)
				local coords = GetOffsetFromEntityInWorldCoords(NetworkGetEntityFromNetworkId(bombaComb), 0.0, -0.02, -0.175)
				AttachEntitiesToRope(rope,NetworkGetEntityFromNetworkId(bombaComb),prop, coords.x, coords.y, coords.z, propPos.x, propPos.y, propPos.z+1.2, 4.0, false, false,"","")
				spawnedRope[bombaComb] = rope
			end
		end
	end
end)

RegisterNetEvent("q_fuel:syncDeleteRope")
AddEventHandler("q_fuel:syncDeleteRope",function(bombaComb)
	RopeUnloadTextures()
	DeleteRope(spawnedRope[bombaComb])
	spawnedRope[bombaComb] = nil
end)

function RemoveRope()
	SendNUIMessage({ show = false })
	TriggerServerEvent("q_fuel:DeleteRope",bomba)
end

function criarPistola()
	if not bomba then
		local model = GetHashKey("prop_cs_fuel_nozle")
		while not HasModelLoaded(model) do
		RequestModel(model)
			Wait(10)
		end
		local coords = GetEntityCoords(PlayerPedId())
		bomba = ObjToNet(CreateObject(model,coords[1],coords[2],coords[3],true,false))
		SetNetworkIdExistsOnAllMachines(bomba,true)
		NetworkUseHighPrecisionBlending(bomba,true)
		SetNetworkIdCanMigrate(bomba,false)
		DetachEntity(NetToObj(bomba),true,true)
		pistolMao()
	end
end

function RemovePistola()
	if DoesEntityExist(NetToObj(bomba)) then
		TriggerServerEvent("tryDeleteObject",bomba)
		bomba = nil
	end
end

function pistolMao()
	if bomba then
		local ped = PlayerPedId(-1)
		AttachEntityToEntity(NetToObj(bomba),ped,GetPedBoneIndex(ped,60309),0.055,0.05,0.0,-50.0,-90.0,-50.0,1,1,0,1,0,1)
		bombaNoVeh = false
	end
end

function pistolVeh(veh,bone)
	if bomba then
		if bone == 'wheel_lr' then
			AttachEntityToEntity(NetToObj(bomba),veh,GetEntityBoneIndexByName(veh,'brakelight_l'),-0.2,0.4,0,-50.0,0.0,-90.0,1,1,0,1,0,1)
		elseif bone == 'petroltank' then
			AttachEntityToEntity(NetToObj(bomba),veh,GetEntityBoneIndexByName(veh,bone),0.0,0.15,0.25,-100.0,0.0,180.0,1,1,0,1,0,1)
		else
			AttachEntityToEntity(NetToObj(bomba),veh,GetEntityBoneIndexByName(veh,'brakelight_r'),0.3,0.6,0,-50.0,0.0,90.0,1,1,0,1,0,1)
			-- VEICULOS GTA AttachEntityToEntity(NetToObj(bomba),veh,GetEntityBoneIndexByName(veh,'wheel_rr'),-0.2,0,-0.4,0.0,180.0,-90.0,1,1,0,1,0,1)
		end
		bombaNoVeh = true
	end
end

function startParticulas(status)
	if status and not block then
		block = true
		local dic = "core"
		local part = "veh_petrol_leak"
		while not HasNamedPtfxAssetLoaded(dic) do
			RequestNamedPtfxAsset(dic)
			Wait(10)
		end
		UseParticleFxAsset(dic)
		particle = StartNetworkedParticleFxLoopedOnEntity(part,NetToObj(bomba), 0.0, 0.23, 0.25, 0.0, 0.0, -70.0, 1.0, true, true, true)
	elseif not status and particle then
		StopParticleFxLooped(particle, true)
		particle = nil
		block = false
	end
end

AddEventHandler('fuel:startFuelUpTick',function(pumpObject,ped,vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)
	currentFuel2 = currentFuel
	while abastecendo do
		Wait(100)
		local oldFuel = DecorGetFloat(vehicle,Config.FuelDecor)
		local fuelToAdd = Config.valorPorLitro / 100.0
		local extraCost = fuelToAdd / 0.2

		if not pumpObject then
			if parseInt(GetAmmoInPedWeapon(ped,883325847) / 4500 * 100,1) > 0 then
				currentFuel = oldFuel + fuelToAdd
				SetPedAmmo(ped,883325847,math.floor(GetAmmoInPedWeapon(ped,883325847) - fuelToAdd * 100))
			else
				abastecendo = false
			end
			if not IsEntityPlayingAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
				TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0,8.0,-1,50,0,0,0,0)
			end
		else
			currentFuel = oldFuel + fuelToAdd
		end

		if currentFuel > 100.0 then
			currentFuel = 100.0
			abastecendo = false
		end

		currentCost = currentCost + extraCost
		
		SetVehicleFuelLevel(vehicle,currentFuel)
		DecorSetFloat(vehicle,Config.FuelDecor,GetVehicleFuelLevel(vehicle))
		if pumpObject then
			SendNUIMessage({ tank = parseInt(floor(currentFuel)), price = parseInt(currentCost), lts = extraCost })
			if currentCost >= currentMoney then
				TriggerEvent("Notify", "cancel", "Negado","Dinheiro insuficiente.","vermelho", 7000)
				abastecendo = false
			end			
		end
	end
	local veh = vRP.vehList(10)
	local Plate = GetVehicleNumberPlateText(veh)
	if pumpObject then
		TriggerServerEvent('q_fuel:pagamento',parseInt(currentCost),false,VehToNet(veh),currentFuel,currentFuel2,Plate)
	else
		TriggerServerEvent("engine:tryFuel",Plate,GetVehicleFuelLevel(veh))
	end

	ClearPedTasks(ped)

	currentCost = 0.0
end)

exports("GetStatus",function()
	if bombaNoVeh and not bombaNaMao and not spawnedRope[bomba] and api then
		return {event = 'felp:retirarbombaexplodida', name = 'Remover pistola da bomba'}
	end
	if bombaNoVeh and not bombaNaMao then
		return { event = 'felp:iniciarabastecimento', name = 'Retirar bomba do veiculo' }
	end
	if bombaNaMao and not bombaNoVeh then
		return { event = 'felp:iniciarabastecimento', name = 'Iniciar abastecimento' }
	end
	return {}
end)
