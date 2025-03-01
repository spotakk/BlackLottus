-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
local oldSpeed = 0
local Aiming = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
local bikesModel = {
	[1131912276] = true,
	[448402357] = true,
	[-836512833] = true,
	[-546537451] = true,
	[1127861609] = true,
	[-1233807380] = true,
	[-400295096] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 1

			DisableControlAction(0,345,true)
			--Configuração para mirar e ir para primeira pessoa
			
			-- if GetPedConfigFlag(ped,78,true) then
			-- 	if not Aiming then
			-- 		Aiming = GetFollowVehicleCamViewMode()
			-- 	end

			-- 	SetFollowVehicleCamViewMode(4)
			-- else
			-- 	if Aiming then
			-- 		SetFollowVehicleCamViewMode(Aiming)
			-- 		Aiming = false
			-- 	end
			-- end

			local vehicle = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				local speed = GetEntitySpeed(vehicle) * 2.236936
				if speed ~= oldSpeed then
					if (oldSpeed - speed) >= 60 then
						TriggerServerEvent("upgradeStress",10)

						if GetVehicleClass(vehicle) ~= 8 then
							SetVehicleEngineOn(vehicle,false,true,true)

							local vehModel = GetEntityModel(vehicle)
							if bikesModel[vehModel] == nil then
								vehicleTyreBurst(vehicle)
							end
						end
					end

					oldSpeed = speed
				end
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end

			if Aiming then
				Aiming = false
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				local vehClass = GetVehicleClass(vehicle)
				if (vehClass >= 0 and vehClass <= 7) or vehClass == 9 then
					if IsControlPressed(1,21) then
						local speed = GetEntitySpeed(vehicle) * 2.236936
						if speed <= 75.0 then
							SetVehicleReduceGrip(vehicle,true)

							if not GetDriftTyresEnabled(vehicle) then
								SetDriftTyresEnabled(vehicle,true)
								SetReduceDriftVehicleSuspension(vehicle,true)
							end
						end
					else
						SetVehicleReduceGrip(vehicle,false)

						if GetDriftTyresEnabled(vehicle) then
							SetDriftTyresEnabled(vehicle,false)
							SetReduceDriftVehicleSuspension(vehicle,false)
						end
					end
				end
			end
		end

		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleTyreBurst(Vehicle)
	local Tyre = math.random(4)

	if Tyre == 1 then
		if GetTyreHealth(Vehicle,0) == 1000.0 then
			SetVehicleTyreBurst(Vehicle,0,true,1000.0)
		end
	elseif Tyre == 2 then
		if GetTyreHealth(Vehicle,1) == 1000.0 then
			SetVehicleTyreBurst(Vehicle,1,true,1000.0)
		end
	elseif Tyre == 3 then
		if GetTyreHealth(Vehicle,4) == 1000.0 then
			SetVehicleTyreBurst(Vehicle,4,true,1000.0)
		end
	elseif Tyre == 4 then
		if GetTyreHealth(Vehicle,5) == 1000.0 then
			SetVehicleTyreBurst(Vehicle,5,true,1000.0)
		end
	end

	if math.random(100) < 30 then
		Citizen.Wait(500)
		vehicleTyreBurst(Vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
	{ 137.48,-1085.09,29.18,348,62,"Bicicletário",0.7 },
	{ 44.59,-1748.16,29.52,78,11,"Mercado Central",0.5 },
	{ 2754.15,3469.52,55.76,78,11,"Mercado Central",0.5 },
	{1240.04,-3257.1,7.09,67,62,"Caminhoneiro",0.5 },
	{ 265.05,-1262.65,29.3,361,62,"Posto de Gasolina",0.4 },
	{ 819.02,-1027.96,26.41,361,62,"Posto de Gasolina",0.4 },
	{ 1208.61,-1402.43,35.23,361,62,"Posto de Gasolina",0.4 },
	{ 1181.48,-330.26,69.32,361,62,"Posto de Gasolina",0.4 },
	{ 621.01,268.68,103.09,361,62,"Posto de Gasolina",0.4 },
	{ 2581.09,361.79,108.47,361,62,"Posto de Gasolina",0.4 },
	{ 175.08,-1562.12,29.27,361,62,"Posto de Gasolina",0.4 },
	{ -319.76,-1471.63,30.55,361,62,"Posto de Gasolina",0.4 },
	{ 49.42,2778.8,58.05,361,62,"Posto de Gasolina",0.4 },
	{ 264.09,2606.56,44.99,361,62,"Posto de Gasolina",0.4 },
	{ 1039.38,2671.28,39.56,361,62,"Posto de Gasolina",0.4 },
	{ 1207.4,2659.93,37.9,361,62,"Posto de Gasolina",0.4 },
	{ 2539.19,2594.47,37.95,361,62,"Posto de Gasolina",0.4 },
	{ 2679.95,3264.18,55.25,361,62,"Posto de Gasolina",0.4 },
	{ 2005.03,3774.43,32.41,361,62,"Posto de Gasolina",0.4 },
	{ 1687.07,4929.53,42.08,361,62,"Posto de Gasolina",0.4 },
	{ 1701.53,6415.99,32.77,361,62,"Posto de Gasolina",0.4 },
	{ 180.1,6602.88,31.87,361,62,"Posto de Gasolina",0.4 },
	{ -94.46,6419.59,31.48,361,62,"Posto de Gasolina",0.4 },
	{ -2555.17,2334.23,33.08,361,62,"Posto de Gasolina",0.4 },
	{ -1800.09,803.54,138.72,361,62,"Posto de Gasolina",0.4 },
	{ -1437.0,-276.8,46.21,361,62,"Posto de Gasolina",0.4 },
	{ -2096.3,-320.17,13.17,361,62,"Posto de Gasolina",0.4 },
	{ -724.56,-935.97,19.22,361,62,"Posto de Gasolina",0.4 },
	{ -525.26,-1211.19,18.19,361,62,"Posto de Gasolina",0.4 },
	{ -70.96,-1762.21,29.54,361,62,"Posto de Gasolina",0.4 },
	{ 1776.7,3330.56,41.32,361,62,"Posto de Gasolina",0.4 },
	{ -1112.4,-2884.08,13.93,361,62,"Posto de Gasolina",0.4 },
	{ -653.38,-852.87,24.51,459,11,"Eletrônicos",0.6 },
	{ -462.26,-345.12,34.29,489,1,"Hospital",0.7 },
	{ 55.43,-876.19,30.66,357,38,"Garagem",0.6 },
	{ 598.04,2741.27,42.07,357,65,"Garagem",0.6 },
	{ -136.36,6357.03,31.49,357,38,"Garagem",0.6 },
	{ 275.23,-345.54,45.17,357,65,"Garagem",0.6 },
	{ 596.40,90.65,93.12,357,65,"Garagem",0.6 },
	{ -340.76,265.97,85.67,357,65,"Garagem",0.6 },
	{ -2030.01,-465.97,11.60,357,65,"Garagem",0.6 },
	{ -1184.92,-1510.00,4.64,357,65,"Garagem",0.6 },
	{ 214.02,-808.44,31.01,357,65,"Garagem",0.6 },
	{ -348.88,-874.02,31.31,357,65,"Garagem",0.6 },
	{ 67.74,12.27,69.21,357,65,"Garagem",0.6 },
	{ 361.90,297.81,103.88,357,65,"Garagem",0.6 },
	{ 1035.89,-763.89,57.99,357,65,"Garagem",0.6 },
	{ -796.63,-2022.77,9.16,357,65,"Garagem",0.6 },
	{ 453.27,-1146.76,29.52,357,65,"Garagem",0.6 },
	{ 528.66,-146.3,58.38,357,65,"Garagem",0.6 },
	{ -1159.48,-739.32,19.89,357,65,"Garagem",0.6 },
	{ 101.22,-1073.68,29.38,357,65,"Garagem",0.6 },
	{ 1725.21,4711.77,42.11,357,65,"Garagem",0.6 },
	{ 1624.05,3566.14,35.15,357,38,"Garagem",0.6 },
	{ -73.35,-2004.6,18.27,357,65,"Garagem",0.6 },
	
	{ -422.49,1131.71,325.86,60,54,"Departamento Policial",0.7 },
	{ -905.92,-2045.05,9.3,60,54,"Departamento Policial",0.7 },
	{ 112.3,-752.88,45.75,60,54,"Departamento Policial",0.7 },
	{ 2537.25,-375.87,93.06,60,54,"Departamento Policial",0.7 },


	{ 25.68,-1346.6,29.5,52,36,"Loja de Departamento",0.5 },
	{ 2556.47,382.05,108.63,52,36,"Loja de Departamento",0.5 },
	{ 1163.55,-323.02,69.21,52,36,"Loja de Departamento",0.5 },
	{ -707.31,-913.75,19.22,52,36,"Loja de Departamento",0.5 },
	{ -47.72,-1757.23,29.43,52,36,"Loja de Departamento",0.5 },
	{ 373.89,326.86,103.57,52,36,"Loja de Departamento",0.5 },
	{ -3242.95,1001.28,12.84,52,36,"Loja de Departamento",0.5 },
	{ 1729.3,6415.48,35.04,52,36,"Loja de Departamento",0.5 },
	{ 548.0,2670.35,42.16,52,36,"Loja de Departamento",0.5 },
	{ 1960.69,3741.34,32.35,52,36,"Loja de Departamento",0.5 },
	{ 2677.92,3280.85,55.25,52,36,"Loja de Departamento",0.5 },
	{ 1698.5,4924.09,42.07,52,36,"Loja de Departamento",0.5 },
	{ 1393.21,3605.26,34.99,52,36,"Loja de Departamento",0.5 },
	{ -2967.78,390.92,15.05,52,36,"Loja de Departamento",0.5 },
	{ -3040.14,585.44,7.91,52,36,"Loja de Departamento",0.5 },
	{ 1135.56,-982.24,46.42,52,36,"Loja de Departamento",0.5 },
	{ 1166.0,2709.45,38.16,52,36,"Loja de Departamento",0.5 },
	{ -1487.21,-378.99,40.17,52,36,"Loja de Departamento",0.5 },
	{ -1222.76,-907.21,12.33,52,36,"Loja de Departamento",0.5 },
	{ 1692.62,3759.50,34.70,76,6,"Loja de Armas",0.4 },
	{ 252.89,-49.25,69.94,76,6,"Loja de Armas",0.4 },
	{ 843.28,-1034.02,28.19,76,6,"Loja de Armas",0.4 },
	{ -331.35,6083.45,31.45,76,6,"Loja de Armas",0.4 },
	{ -663.15,-934.92,21.82,76,6,"Loja de Armas",0.4 },
	{ -1305.54,-393.48,36.69,76,6,"Loja de Armas",0.4 },
	{ -1154.80,2698.22,54.55,76,6,"Loja de Armas",0.4 },
	{ 2568.83,293.89,108.73,76,6,"Loja de Armas",0.4 },
	{ -3172.68,1087.10,20.83,76,6,"Loja de Armas",0.4 },
	{ 21.32,-1106.44,29.79,76,6,"Loja de Armas",0.4 },
	{ 811.19,-2157.67,29.61,76,6,"Loja de Armas",0.4 },
	{ 75.35,-1392.92,29.38,366,62,"Loja de Roupas",0.5 },
	{ -710.15,-152.36,37.42,366,62,"Loja de Roupas",0.5 },
	{ -163.73,-303.62,39.74,366,62,"Loja de Roupas",0.5 },
	{ -822.38,-1073.52,11.33,366,62,"Loja de Roupas",0.5 },
	{ -1193.13,-767.93,17.32,366,62,"Loja de Roupas",0.5 },
	{ -1449.83,-237.01,49.82,366,62,"Loja de Roupas",0.5 },
	{ 4.83,6512.44,31.88,366,62,"Loja de Roupas",0.5 },
	{ 1693.95,4822.78,42.07,366,62,"Loja de Roupas",0.5 },
	{ 125.82,-223.82,54.56,366,62,"Loja de Roupas",0.5 },
	{ 614.2,2762.83,42.09,366,62,"Loja de Roupas",0.5 },
	{ 1196.72,2710.26,38.23,366,62,"Loja de Roupas",0.5 },
	{ -3170.53,1043.68,20.87,366,62,"Loja de Roupas",0.5 },
	{ -1101.42,2710.63,19.11,366,62,"Loja de Roupas",0.5 },
	{ 425.6,-806.25,29.5,366,62,"Loja de Roupas",0.5 },
	{ -1082.22,-247.54,37.77,439,73,"Life Invader",0.6 },
	{-1183.72,-885.81,14.83,106,1,"BurguerShot",0.6 },
	{562.34,2740.42,42.71,463,11,"Pets",0.6},
	{ -680.9,5832.41,17.32,141,62,"Cabana do Caçador",0.7 },
	{ -1728.06,-1050.69,1.71,266,62,"Embarcações",0.5 },
	{ 1966.36,3975.86,31.51,266,62,"Embarcações",0.5 },
	{ -776.72,-1495.02,2.29,266,62,"Embarcações",0.5 },
	{ -893.97,5687.78,3.29,266,62,"Embarcações",0.5 },
	{ 4952.76,-5163.6,-0.3,266,62,"Embarcações",0.5 },
	{ 452.99,-607.74,28.59,513,62,"Motorista",0.5 },
	{ 356.42,274.61,103.14,67,62,"Transportador",0.5 },
	{ -840.21,5399.25,34.61,285,62,"Lenhador",0.5 },
	{ 132.6,-1305.06,29.2,93,62,"Vanilla Unicorn",0.5 },
	{ -565.14,271.56,83.02,93,62,"Tequi-La-La",0.5 },
	{ -172.21,6385.85,31.49,403,5,"Farmácia",0.7 },
	{ 1690.07,3581.68,35.62,403,5,"Farmácia",0.7 },
	{ 315.12,-1068.58,29.39,403,5,"Farmácia",0.7 },
	{ 114.45,-4.89,67.82,403,5,"Farmácia",0.7 },
	{ 82.54,-1553.28,29.59,318,62,"Lixeiro",0.6 },
	{ 287.36,2843.6,44.7,318,62,"Lixeiro",0.6 },
	{ -413.97,6171.58,31.48,318,62,"Lixeiro",0.6 },
	{ -428.56,-1728.33,19.79,467,11,"Reciclagem",0.6 },
	{ 540.07,2793.29,45.65,467,11,"Reciclagem",0.6 },
	{ -195.42,6264.62,31.49,467,11,"Reciclagem",0.6 },
	{ -741.56,5594.94,41.66,36,62,"Teleférico",0.6 },
	{ 454.46,5571.95,781.19,36,62,"Teleférico",0.6 },
	{ 371.31,-1612.76,29.28,357,9,"Impound",0.6 },
	{ -210.13,-1330.29,30.89,402,1,"Bennys Motosport",0.7 },
	{ 1524.51,3782.06,34.51,68,62,"Pescador",0.6 },
	{ -594.55,2090.22,131.66,617,62,"Minerador",0.6 },
	{-633.98,-238.86,37.98,617,62,"Joalheria",0.7},
	{ 405.92,6526.12,27.73,89,62,"Colheita",0.4 },
	{ -70.49,-1104.59,26.12,225,62,"Concessionária",0.4 },
	{ 895.46,-179.4,74.7,198,62,"Taxista",0.5 },
	{ 1696.19,4785.25,42.02,198,62,"Taxista",0.5 },
	{ -1447.51,-537.3,34.74,475,4,"Hotel",0.7 },
	{ -535.04,-221.34,37.64,267,28,"Prefeitura",0.6 },
	{-1202.37,-1566.44,4.8,311,1,"Academia",0.6},

	-- { -1213.44,-331.02,37.78,207,2,"Banco",0.5 },
	-- { -351.59,-49.68,49.04,207,2,"Banco",0.5 },
	-- { 313.47,-278.81,54.17,207,2,"Banco",0.5 },
	-- { 149.35,-1040.53,29.37,207,2,"Banco",0.5 },
	-- { -2962.60,482.17,15.70,207,2,"Banco",0.5 },
	-- { -112.81,6469.91,31.62,207,2,"Banco",0.5 },
	 { -1422.44,-439.63,35.89,402,1,"Hayes Auto Sport",0.7 },
	 { 864.9,-2110.49,30.36,402,1,"Mecânica East",0.7 },
	 { 937.4,-966.48,39.75,402,1,"Mecânica Sport Race",0.7 },
	 
	-- {1240.04,-3257.1,7.09,67,62,"Caminhoneiro",0.5 },
	
	-- { -293.57,619.85,31.48,75,13,"Loja de Tatuagem",0.5 },
	
	-- { 1175.74,2706.80,38.09,207,2,"Banco",0.5 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip,v[4])
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v[5])
		SetBlipScale(blip,v[7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v[6])
		EndTextCommandSetBlipName(blip)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,25 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		InvalidateIdleCam()
		InvalidateVehicleIdleCam()

		SetCreateRandomCops(false)
		CancelCurrentPoliceReport()
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		SetVehicleModelIsSuppressed(GetHashKey("jet"),true)
		SetVehicleModelIsSuppressed(GetHashKey("besra"),true)
		SetVehicleModelIsSuppressed(GetHashKey("luxor"),true)
		SetVehicleModelIsSuppressed(GetHashKey("blimp"),true)
		SetVehicleModelIsSuppressed(GetHashKey("polmav"),true)
		SetVehicleModelIsSuppressed(GetHashKey("buzzard2"),true)
		SetVehicleModelIsSuppressed(GetHashKey("mammatus"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_prismuscl_01"),true)
		SetPedModelIsSuppressed(GetHashKey("u_m_y_prisoner_01"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_prisoner_01"),true)

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetWeaponDamageModifierThisFrame("WEAPON_BAT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_HAMMER",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_WRENCH",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_UNARMED",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_HATCHET",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_CROWBAR",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_MACHETE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_POOLCUE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KNUCKLE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_GOLFCLUB",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_BATTLEAXE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_FLASHLIGHT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_NIGHTSTICK",0.35)
		SetWeaponDamageModifierThisFrame("WEAPON_STONE_HATCHET",0.25)

		RemoveAllPickupsOfType("PICKUP_WEAPON_KNIFE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PISTOL")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MINISMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MICROSMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PUMPSHOTGUN")
		RemoveAllPickupsOfType("PICKUP_WEAPON_CARBINERIFLE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_SAWNOFFSHOTGUN")

		DisablePlayerVehicleRewards(PlayerId())

		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)
		HideHudComponentThisFrame(23)
		HideHudComponentThisFrame(24)
		HideHudComponentThisFrame(25)
		HideHudComponentThisFrame(26)
		HideHudComponentThisFrame(27)
		HideHudComponentThisFrame(28)
		HideHudComponentThisFrame(29)
		HideHudComponentThisFrame(30)
		HideHudComponentThisFrame(31)
		HideHudComponentThisFrame(32)
		HideHudComponentThisFrame(33)
		HideHudComponentThisFrame(34)
		HideHudComponentThisFrame(35)
		HideHudComponentThisFrame(36)
		HideHudComponentThisFrame(37)
		HideHudComponentThisFrame(38)
		HideHudComponentThisFrame(39)
		HideHudComponentThisFrame(40)
		HideHudComponentThisFrame(41)
		HideHudComponentThisFrame(42)
		HideHudComponentThisFrame(43)
		HideHudComponentThisFrame(44)
		HideHudComponentThisFrame(45)
		HideHudComponentThisFrame(46)
		HideHudComponentThisFrame(47)
		HideHudComponentThisFrame(48)
		HideHudComponentThisFrame(49)
		HideHudComponentThisFrame(50)
    	HideHudComponentThisFrame(51)

		DisableControlAction(1,37,true)
		DisableControlAction(1,204,true)
		DisableControlAction(1,211,true)
		DisableControlAction(1,349,true)
		DisableControlAction(1,192,true)
		DisableControlAction(1,157,true)
		DisableControlAction(1,158,true)
		DisableControlAction(1,159,true)
		DisableControlAction(1,160,true)
		DisableControlAction(1,161,true)
		DisableControlAction(1,162,true)
		DisableControlAction(1,163,true)
		DisableControlAction(1,164,true)
		DisableControlAction(1,165,true)

		SetRandomVehicleDensityMultiplierThisFrame(0.5)
		SetVehicleDensityMultiplierThisFrame(0.5)
		SetGarbageTrucks(false)
		SetRandomBoats(false)

		if IsPedArmed(PlayerPedId(),6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end

		Citizen.Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
local ipList = {
	{
		props = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = { -1150.70,-1520.70,10.60 }
	},{
		props = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = { -47.10,-1115.30,26.50 }
	},{
		props = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = { -802.30,175.00,72.80 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADIPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _k,_v in pairs(ipList) do
		local interiorCoords = GetInteriorAtCoords(_v["coords"][1],_v["coords"][2],_v["coords"][3])
		LoadInterior(interiorCoords)

		if _v["props"] ~= nil then
			for k,v in pairs(_v["props"]) do
				EnableInteriorProp(interiorCoords,v)
				Citizen.Wait(1)
			end
		end

		RefreshInterior(interiorCoords)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local teleport = {
	{ 330.19,-601.21,43.29,344.33,-586.16,28.8 },
	{ 344.33,-586.16,28.8,330.19,-601.21,43.29 },

	{ 327.16,-603.53,43.29,338.97,-583.85,74.16 },
	{ 338.97,-583.85,74.16,327.16,-603.53,43.29 },

	{ -741.07,5593.13,41.66,446.19,5568.79,781.19 },
	{ 446.19,5568.79,781.19,-741.07,5593.13,41.66 },

	{ 936.01,47.19,81.1,1089.73,205.78,-48.99 }, --CASINO 1
	{ 1089.73,205.78,-48.99,936.01,47.19,81.1 },

	{ -740.78,5597.04,41.66,446.37,5575.02,781.19 },
	{ 446.37,5575.02,781.19,-740.78,5597.04,41.66 },

	{ 241.1,-1378.85,33.73,275.89,-1361.45,24.53 },
	{ 275.89,-1361.45,24.53,241.1,-1378.85,33.73 },

	{ 2497.55,-349.13,94.09,2496.98,-349.38,101.89 },
	{ 2496.98,-349.38,101.89,2497.55,-349.13,94.09 },

	{ 2504.48,-342.19,94.09,2497.43,-349.16,105.68 },
	{ 2497.43,-349.16,105.68,2504.48,-342.19,94.09 },

	{ -435.82,-359.53,34.95,-418.7,-344.92,24.23 },
	{ -418.7,-344.92,24.23,-435.82,-359.53,34.95 },

	{ -452.59,-288.97,34.95,-440.16,-336.01,78.3 },
	{ -440.16,-336.01,78.3,-452.59,-288.97,34.95 },



	




	{ 254.01,225.22,101.87,253.35,223.3,101.67 }




}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}

	for k,v in pairs(teleport) do
		table.insert(innerTable,{ v[1],v[2],v[3],1,"E","Porta de Acesso","Pressione para acessar" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for _,v in pairs(teleport) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1 then
					timeDistance = 1

					if IsControlJustPressed(1,38) then
						SetEntityCoords(ped,v[4],v[5],v[6],1,0,0,0)
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			local distance = #(coords - vector3(236.54,229.23,97.11))
			if distance <= 3.0 then
				timeDistance = 1

				if IsControlJustPressed(1,38) then
					local handle,object = FindFirstObject()
					local finished = false

					repeat
						local heading = GetEntityHeading(object)
						local coordsObj = GetEntityCoords(object)
						local distanceObjs = #(coordsObj - coords)

						if distanceObjs < 3.0 and GetEntityModel(object) == 961976194 then
							if heading > 150.0 then
								SetEntityHeading(object,60.0)
							else
								SetEntityHeading(object,0.0)
							end

							FreezeEntityPosition(object,true)
							finished = true
						end

						finished,object = FindNextObject(handle)
					until not finished

					EndFindObject(handle)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	TriggerEvent("hoverfy:insertTable",{{ 236.54,229.23,97.11,1.5,"E","Porta do Cofre","Pressione para abrir/fechar" }})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUNNYHOP
-----------------------------------------------------------------------------------------------------------------------------------------
local bunnyHope = GetGameTimer()
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if GetGameTimer() <= bunnyHope then
				timeDistance = 1
				DisableControlAction(1,22,true)
			else
				if IsPedJumping(ped) then
					bunnyHope = GetGameTimer() + 5000
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVISIBLABLES
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Invisible"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHACKER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()

			if not IsEntityVisible(ped) and not LocalPlayer["state"]["Invisible"] then
				TriggerServerEvent("admin:Hacker","está invisível")
			end

			if ForceSocialClubUpdate == nil then
				TriggerServerEvent("admin:Hacker","forçou a social club.")
			end

			if ShutdownAndLaunchSinglePlayerGame == nil then
				TriggerServerEvent("admin:Hacker","entrou no modo single player.")
			end

			if ActivateRockstarEditor == nil then
				TriggerServerEvent("admin:Hacker","ativou o rockstar editor.")
			end
		end

		Citizen.Wait(10000)
	end
end)

--[ MINIMAP ILHA ]------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
        SetRadarAsExteriorThisFrame()
        SetRadarAsInteriorThisFrame("h4_fake_islandx",vec(4700.0,-5145.0),0,0)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(500)
    end
end

local agachar = false
local movimento = false
local ctrl = 0
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if DoesEntityExist(ped) and not IsEntityDead(ped) then 
            if not IsPauseMenuActive() then 
                if IsPedJumping(ped) then
                    movimento = false
                end
            end
        end
        if DoesEntityExist(ped) and not IsEntityDead(ped) then 
            DisableControlAction(0,36,true)
            if not IsPauseMenuActive() then 
                if IsDisabledControlJustPressed(0,36) and not IsPedInAnyVehicle(ped) and ctrl == 0 then
                    ctrl = 1
                    RequestAnimSet('move_ped_crouched')
                    RequestAnimSet('move_ped_crouched_strafing')
                    if agachar == true then 
                        ResetPedMovementClipset(ped,0.30)
                        ResetPedStrafeClipset(ped)
                        movimento = false
                        agachar = false 
                    elseif agachar == false then
                        SetPedMovementClipset(ped,'move_ped_crouched',0.30)
                        SetPedStrafeClipset(ped,'move_ped_crouched_strafing')
                        agachar = true 
                    end 
                end
            end 
        end 
    end
end)

Citizen.CreateThread(function() 
    while true do
        Wait(0)
        if agachar then DisablePlayerFiring(PlayerId(), true) end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if ctrl > 0 then
            ctrl = ctrl - 1
        end
    end
end)

-- ------------------------------------------------------------------------------
-- -- DANO POR OSSO + RECOIL CONFIG
-- ------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		-- Pistols
-- 		local W
-- 		local headshotRevolverMK2 = HasPedBeenDamagedByWeapon(PlayerPedId(), -879347409, 0) --Revolver Mk2

--         local headshotFive = HasPedBeenDamagedByWeapon(PlayerPedId(), -1075685676, 0) -- Five
--         local headshotGlock = HasPedBeenDamagedByWeapon(PlayerPedId(), 1593441988, 0) -- Glock
-- 		local headshotFajuta = HasPedBeenDamagedByWeapon(PlayerPedId(), -1076751822, 0) -- Fajuta
-- 		local headshotDesert = HasPedBeenDamagedByWeapon(PlayerPedId(), 2578377531, 0)	-- Desert
-- 		local headshotPesada = HasPedBeenDamagedByWeapon(PlayerPedId(), 3523564046, 0) -- Heavy
-- 		local headshot1911 = HasPedBeenDamagedByWeapon(PlayerPedId(), 453432689, 0) -- Pistol
-- 		local headshotAP = HasPedBeenDamagedByWeapon(PlayerPedId(), 584646201, 0) -- Ap Pistol
-- 		local headshotFajutaMK2 = HasPedBeenDamagedByWeapon(PlayerPedId(), 3218215474, 0) -- Fajuta MK2
-- 		local headshotVintage = HasPedBeenDamagedByWeapon(PlayerPedId(), 137902532, 0) --Vintage
-- 		local headshotRevolver = HasPedBeenDamagedByWeapon(PlayerPedId(), 3249783761, 0) -- Revolver 
-- 		local headshotRevolverMK2 = HasPedBeenDamagedByWeapon(PlayerPedId(), -879347409, 0) --Revolver Mk2
-- 		-- End Pistols

-- 		-- Smg
-- 		local headshotMicroSMG = HasPedBeenDamagedByWeapon(PlayerPedId(), 324215364, 0) -- Uzi
-- 		local headshotSMG = HasPedBeenDamagedByWeapon(PlayerPedId(), 736523883, 0) -- MP5
-- 		local headshotSMGMK2 = HasPedBeenDamagedByWeapon(PlayerPedId(), 2024373456, 0) -- SMG MK2
-- 		local headshotAssaultSMG = HasPedBeenDamagedByWeapon(PlayerPedId(), 4024951519, 0) -- MTAR-21
-- 		local headshotMachinePistol = HasPedBeenDamagedByWeapon(PlayerPedId(), 3675956304, 0) -- Tec9
-- 		local headshotMiniSMG = HasPedBeenDamagedByWeapon(PlayerPedId(), 3173288789, 0) -- Mini SMG
-- 		-- End Smg

-- 		-- Shotguns
-- 		local headshotPump = HasPedBeenDamagedByWeapon(PlayerPedId(), 487013001, 0) -- PumpShotgun
-- 		local headshotSawnoff = HasPedBeenDamagedByWeapon(PlayerPedId(), 2017895192, 0) -- Mini Shotgun
-- 		-- End Shotguns

-- 		-- Rifles
-- 		local headshotAK = HasPedBeenDamagedByWeapon(PlayerPedId(), 3220176749, 0) -- AK-103
-- 		local headshotAKMK2 = HasPedBeenDamagedByWeapon(PlayerPedId(), 961495388, 0) -- AK-47
-- 		local headshotM4 = HasPedBeenDamagedByWeapon(PlayerPedId(), -2084633992, 0) -- M4A1
-- 		local headshotG36C = HasPedBeenDamagedByWeapon(PlayerPedId(), 3231910285, 0) -- G36C
-- 		local headshotMINIAK = HasPedBeenDamagedByWeapon(PlayerPedId(), 1649403952, 0) -- Mini AK
-- 		local headshotM4A4 = HasPedBeenDamagedByWeapon(PlayerPedId(), -1768145561, 0) -- SIG
-- 		local headshotSIG = HasPedBeenDamagedByWeapon(PlayerPedId(), -86904375, 0) -- M4A4
-- 		local headshotFNSCAR = HasPedBeenDamagedByWeapon(PlayerPedId(), -1873874036, 0) -- WEAPON_FNSCAR
-- 		local headshotCOLTXM177 = HasPedBeenDamagedByWeapon(PlayerPedId(), 1342794003, 0) -- WEAPON_COLTXM177

-- 		-- End Rifles
-- 		local a, b = GetPedLastDamageBone(PlayerPedId())
-- 		if a and b == 31086 then
-- 			if headshotFNSCAR or headshotCOLTXM177 or headshotFive or headshotGlock or headshotSIG or headshotM4A4 or headshotFajuta or headshotFajutaMK2 or headshotDesert or headshotPesada or headshot1911 or headshotAP or headshotVintage or headshotRevolver or headshotRevolverMK2 or headshotMicroSMG or headshotSMG or headshotSMGMK2 or headshotAssaultSMG or headshotMachinePistol or headshotMiniSMG then
-- 				SetEntityHealth(PlayerPedId(), 101)
-- 			elseif headshotPump or headshotSawnoff or headshotAK or headshotAKMK2 or headshotM4 or headshotG36C or headshotMINIAK then
-- 				SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 101)
-- 			end
-- 			a, b, headshotFNSCAR,headshotCOLTXM177, headshotFive, headshotGlock, headshotSIG, headshotM4A4, headshotFajuta, headshotDesert, headshotPesada, headshot1911, headshotAP, headshotFajutaMK2, headshotVintage, headshotRevolver, headshotRevolverMK2, headshotMicroSMG, headshotSMG, headshotSMGMK2, headshotAssaultSMG, headshotMachinePistol, headshotMiniSMG, headshotPump, headshotSawnoff, headshotAK, headshotAKMK2, headshotM4, headshotG36C, headshotMINIAK = nil, nil, nil, nil, nil, nil
-- 		end
-- 	end
-- end)


-----------------Rodaaa
Citizen.CreateThread(function()
    local angle = 0.0
    local speed = 0.0
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        if DoesEntityExist(veh) then
            local tangle = GetVehicleSteeringAngle(veh)
            if tangle > 10.0 or tangle < -10.0 then
                angle = tangle
            end
            speed = GetEntitySpeed(veh)
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
            if speed < 0.1 and DoesEntityExist(vehicle) and not GetIsTaskActive(PlayerPedId(), 151) and not GetIsVehicleEngineRunning(vehicle) then
                SetVehicleSteeringAngle(GetVehiclePedIsIn(PlayerPedId(), true), angle)
            end
        end
    end
end)