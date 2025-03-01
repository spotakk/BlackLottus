-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("RazeBank",cRP)
vSERVER = Tunnel.getInterface("RazeBank")
local trans = {}
local isBankOpened = false
local closestATM, atmPos
local playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney

local banks = {
	{ 149.39,-1040.54,29.37,161.58 },
	{ 314.01,-279.01,54.17,155.91 },
	{ -351.6,-49.7,49.03,158.75 },
	{ -2962.58,482.73,15.7,266.46 },
	{ -1212.68,-330.77,37.78,204.1 },
	{ 1175.13,2706.81,38.1,0.0 },
	{ -113.01,6470.21,31.63 },
	{ -111.99,6469.15,31.63 },
	{ -110.92,6468.1,31.63 },
}

local atmList = {
	{ 147.82,-1035.85,29.34,164.41 },
	{ 146.06,-1035.12,29.34,155.91 },
	{ 111.3,-775.31,31.44,351.5 },
	{ 114.37,-776.41,31.41,345.83 },
	{ 114.4,-776.42,31.41,343.0 },
	{ 112.75,-819.4,31.34,161.58 },
	{ 118.3,1951.87,14.67,279.75 },
	{ 295.72,-896.09,29.22,274.97 },
	{ 296.4,-894.03,29.23,257.96 },
	{ 50.85,364.48,15.41,185.7 }, 
	{ 33.31,-1348.18,29.49,184.26 },
	{-97.34,6455.44,31.46,42.52},
	{-95.49,6457.26,31.46,42.52},
	{-133.01,6366.48,31.48,317.49},
	{-283.13,6226.11,31.49,320.32},
	{174.19,6637.85,31.58,42.52},
	{155.86,6642.78,31.59,306.15},
	{-386.98,6046.2,31.49,320.32},
	{1701.2,6426.45,32.76,62.37},
	{1735.22,6410.64,35.03,153.08},
	{2682.98,3286.52,55.23,238.12},
	{1686.85,4815.78,42.01,283.47},
	{1822.7,3683.06,34.27,201.26},
	{1968.06,3743.58,32.33,209.77},
	{540.27,2671.07,42.16,0.0},
	{1172.58,2702.5,38.16,5.67},
	{1171.53,2702.48,38.16,357.17},
	{2564.66,2584.63,38.08,113.39},
	{2558.44,389.46,108.61,272.13},
	{2558.76,350.96,108.61,85.04},
	{1077.92,-776.45,58.23,184.26},
	{1153.75,-326.8,69.2,104.89},
	{1167.04,-456.11,66.79,348.67},
	{285.47,143.4,104.17,155.91},
	{380.73,323.44,103.56,161.58},
	{228.14,338.39,105.56,161.58},
	{-165.07,232.71,94.91,79.38},
	{-165.08,234.76,94.91,85.04},
	{-1430.07,-211.1,46.51,119.06},
	{-1415.96,-212.0,46.51,232.45},
	{-2072.42,-317.18,13.31,269.3},
	{-1386.43,-596.29,30.31,291.97},
	{-1386.3,-597.23,30.31,266.46},
	{-1386.65,-598.18,30.31,229.61},
	{-1200.75,-885.4,13.26,218.27},
	{-1314.75,-836.01,16.95,308.98},
	{-1315.8,-834.71,16.95,308.98},
	{-821.69,-1081.99,11.12,31.19},
	{-717.69,-915.67,19.21,93.55},
	{-809.34,-1238.21,7.33,51.03},
	{-537.81,-854.47,29.28,187.09},
	{-526.64,-1222.95,18.45,158.75},
	{-219.04,-1311.79,31.29,178.59},
	{130.0,-1292.66,29.27,300.48},
	{5.2,-919.79,29.55,246.62},
	{129.67,-1291.88,29.27,297.64},
	{24.47,-946.04,29.35,340.16},
	{129.18,-1291.17,29.27,303.31},
	{289.01,-1256.79,29.44,272.13},
	{119.12,-883.72,31.12,76.54},
	{288.77,-1282.37,29.64,266.46},
	{112.7,-819.29,31.34,167.25},
	{111.33,-775.33,31.44,343.0},
	{114.52,-776.42,31.41,348.67},
	{314.11,-279.11,54.17,161.58},
	{-254.25,-692.51,33.62,150.24},
	{-256.18,-716.14,33.51,68.04},
	{-258.92,-723.5,33.48,70.87},
	{-350.99,-49.89,49.03,158.75},
	{-721.06,-415.46,34.98,260.79},
	{-1205.01,-326.28,37.83,116.23},
	{-1205.64,-324.84,37.86,113.39}

}

Citizen.CreateThread(function()
    SetNuiFocus(false,false)

    for k,v in pairs(atmList) do
        exports["target"]:AddCircleZone("ATM:"..k,vector3(v[1],v[2],v[3]),2.0,{
            name = "ATM:"..k,
            heading = 0.0
        },{
						shop = k,
            distance = 2.0,
            options = {
                {
                    event = "atm:open",
                    label = "Abrir",
                    tunnel = "client"
                },
				{
					event = "eletronics:openSystem",
					label = "Roubar",
					tunnel = "shop"
				}
            }
        })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ELETRONICS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("eletronics:openSystem",function(shopId)
	if vSERVER.checkSystems(shopId) then
		currentTimer = GetGameTimer()
		inTimers = 18
		inService = true
		TriggerEvent("Progress",18000) --[[ 36000 ]]
		LocalPlayer["state"]["Cancel"] = true
		LocalPlayer["state"]["Commands"] = true
		SetEntityHeading(PlayerPedId(),atmList[shopId][4])
		vRP.playAnim(false,{"oddjobs@shop_robbery@rob_till","loop"},true)
		SetEntityCoords(PlayerPedId(),atmList[shopId][1],atmList[shopId][2],atmList[shopId][3] - 1,1,0,0,0)

		while inService do
			if inTimers > 0 and GetGameTimer() >= currentTimer then
				inTimers = inTimers - 1
				currentTimer = GetGameTimer() + 1000
				if inTimers <= 0 then
					vSERVER.paymentSystems(math.random(730,1237))
					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Cancel"] = false
					vRP.removeObjects()
					inService = false
					break
				end
			end

			Citizen.Wait(1)
		end
	end
end)

Citizen.CreateThread(function()
    SetNuiFocus(false,false)

		LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Cancel"] = false

    for k,v in pairs(banks) do
        exports["target"]:AddCircleZone("BANK:"..k,vector3(v[1],v[2],v[3]),2.0,{
            name = "BANK:"..k,
            heading = 0.0
        },{
            distance = 2.0,
            options = {
                {
                    event = "bank:open",
                    label = "Abrir",
                    tunnel = "client"
                }
            }
        })
    end
end)

RegisterNetEvent("bank:open",function()
	--[[ if vSERVER.requestWanted() then ]]
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'loading_data',
		})
		Citizen.Wait(500)
		openBank()
	--[[ end ]]
end)

RegisterNetEvent("atm:open",function()

	local ped = PlayerPedId()
	if not isBankOpened then
		local pin = vSERVER.GetPIN()
		if pin then
		
			if not isBankOpened then
				isBankOpened = true
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'atm',
					pin = pin,
				})
			end
		else
			TriggerEvent("Notify","vermelho","Atenção","Para acessar o ATM, registre um pincode!",5000)
		end
	end
end)

function openBank()
	local hasJob = false
	local playerJobName = ''
	local playerJobGrade = ''
	local jobLabel = ''
	multas = vSERVER.requestFines()
	isBankOpened = true

	local data = vSERVER.GetPlayerInfo()
	local cb, identifier, allDays = vSERVER.GetOverviewTransactions()

	isBankOpened = true
	trans = cb
	
	Citizen.Wait(1000)
	local model = GetEntityModel(PlayerPedId())
	if tonumber(model) == 1885233650 then 
		model = "m"
	else 
		model = "f"
	end
	playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney = data.playerName, data.playerBankMoney, data.playerIBAN, identifier, allDays, data.walletMoney
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'bankmenu',
		playerName = data.playerName,
		playerSex = model,
		playerBankMoney = data.playerBankMoney,
		walletMoney = walletMoney,
		db = trans,
		multas = multas,
		identifier = trsIdentifier,
		graphDays = allDaysValues,
	})
end

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		isBankOpened = false
		SetNuiFocus(false, false)
	elseif data.action == "deposit" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				TriggerServerEvent('RazeBank:DepositMoney', tonumber(data.value))
			end
		end
	elseif data.action == "withdraw" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				TriggerServerEvent('RazeBank:WithdrawMoney', tonumber(data.value))
			end
		end
	elseif data.action == "transfer" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				TriggerServerEvent('RazeBank:TransferMoney', tonumber(data.value),data.iban)
			end
		end
	elseif data.action == "fines" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				vSERVER.finesPayment(data.id,tonumber(data.value))
			end
		end
	elseif data.action == "overview_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'overview_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			db = trans,
			identifier = trsIdentifier,
			graphDays = allDaysValues,
		})
	elseif data.action == "transactions_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'transactions_page',
			db = trans,
			identifier = trsIdentifier,
			graph_values = allDaysValues,
		})
	elseif data.action == "settings_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'settings_page',
			pinCost = 1000,
			pinCharNum = 4,
		})
	elseif data.action == "atm" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'loading_data',
		})
		Citizen.Wait(500)
		openBank()
	elseif data.action == "change_pin" then
		if tonumber(data.pin) ~= nil then
			if string.len(data.pin) == 4 then
				TriggerServerEvent('RazeBank:UpdatePINDB', data.pin, 1000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("finesPayment",function(data)

	if data.id ~= nil then
		vSERVER.finesPayment(data.id,data.price)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("RazeBank:updateTransactions")
AddEventHandler("RazeBank:updateTransactions", function(money, wallet)
	Citizen.Wait(100)
	if isBankOpened then
		local cb, id, allDays = vSERVER.GetOverviewTransactions()
		trans = cb
		allDaysValues = allDays
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'overview_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			db = trans,
			identifier = trsIdentifier,
			graphDays = allDaysValues,
		})
		TriggerEvent('RazeBank:updateMoney', money, wallet)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("RazeBank:updateMoney")
AddEventHandler("RazeBank:updateMoney", function(money, wallet)
	if isBankOpened then
		playerBankMoney = money
		walletMoney = wallet
		SendNUIMessage({
			action = 'updatevalue',
			playerBankMoney = money,
			walletMoney = wallet,
		})
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEFINES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("RazeBank:updateFines")
AddEventHandler("RazeBank:updateFines", function(money, wallet)
    Citizen.Wait(100)
    if isBankOpened then
        multas = vSERVER.requestFines()
        allDaysValues = allDays
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'multas_page',
            playerBankMoney = playerBankMoney,
            walletMoney = walletMoney,
            db = multas,
            identifier = trsIdentifier,
            graphDays = allDaysValues,
        })
        TriggerEvent('RazeBank:updateMoney', money, wallet)
    end
end)