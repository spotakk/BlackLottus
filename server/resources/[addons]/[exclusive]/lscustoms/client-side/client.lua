-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("lscustoms")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local activeBennys = false
local originalCategory = nil
local originalMod = nil
local originalPrimaryColour = nil
local originalSecondaryColour = nil
local originalPearlescentColour = nil
local originalWheelColour = nil
local originalDashColour = nil
local originalInterColour = nil
local originalWindowTint = nil
local originalWheelCategory = nil
local originalWheel = nil
local originalWheelType = nil
local originalCustomWheels = nil
local originalNeonLightState = nil
local originalNeonLightSide = nil
local originalNeonColourR = nil
local originalNeonColourG = nil
local originalNeonColourB = nil
local originalXenonColour = nil
local originalPoliceLivery = nil
local originalPlateIndex = nil
local attemptingPurchase = false
local isPurchaseSuccessful = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local bennysLocations = {
	["mechanic01"] = {
		pos = vec3(-212.24,-1325.22,30.89),
		permission = "Mechanic",
		heading = 311.82
	},
	["mechanic02"] = {
		pos = vec3(-223.23,-1329.87,30.89),
		permission = "Mechanic",
		heading = 311.82

	},
	["mechanic03"] = {
		pos = vec3(-335.98,-138.87,39.06),
		permission = "Mechanic",
		heading = 68.04
	},
	["mechanic04"] = {
		pos = vec3(-332.34,-130.02,39.06),
		permission = "Mechanic",
		heading = 70.87
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function getVehicleSpawn()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		local vehicleModel = GetEntityModel(vehicle)
		for model, infos in pairs(GlobalState['Vehicles']) do
			if model == vehicleModel then 
				return infos[1]
			end
		end
	end

end

local function saveVehicle()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		local vehicleMods = {
			neon = {},
			colors = {},
			extracolors = {},
			dashColour = -1,
			interColour = -1,
			lights = {},
			tint = GetVehicleWindowTint(vehicle),
			wheeltype = GetVehicleWheelType(vehicle),
			platestyle = GetVehicleNumberPlateTextIndex(vehicle),
			mods = {},
			var = {},
			smokecolor = {},
			xenonColor = -1,
			liverys = 24,
			extras = {},
			plateIndex = 0
		}

		vehicleMods["xenonColor"] = GetCurrentXenonColour(vehicle)
		vehicleMods["lights"][1],vehicleMods["lights"][2],vehicleMods["lights"][3] = GetVehicleNeonLightsColour(vehicle)
		vehicleMods["colors"][1],vehicleMods["colors"][2] = GetVehicleColours(vehicle)
		vehicleMods["extracolors"][1],vehicleMods["extracolors"][2] = GetVehicleExtraColours(vehicle)
		vehicleMods["smokecolor"][1],vehicleMods["smokecolor"][2],vehicleMods["smokecolor"][3] = GetVehicleTyreSmokeColor(vehicle)
		vehicleMods["dashColour"] = GetVehicleInteriorColour(vehicle)
		vehicleMods["interColour"] = GetVehicleDashboardColour(vehicle)
		vehicleMods["liverys"] = GetVehicleLivery(vehicle)
		vehicleMods["plateIndex"] = GetVehicleNumberPlateTextIndex(vehicle)

		for i = 0,3 do
			vehicleMods["neon"][i] = IsVehicleNeonLightEnabled(vehicle,i)
		end

		for i = 0,16 do
			vehicleMods["mods"][i] = GetVehicleMod(vehicle,i)
		end

		for i = 17,22 do
			vehicleMods["mods"][i] = IsToggleModOn(vehicle,i)
		end

		for i = 23,48 do
			vehicleMods["mods"][i] = GetVehicleMod(vehicle,i)

			if i == 24 or i == 23 then
				vehicleMods["var"][i] = GetVehicleModVariation(vehicle,i)
			end
		end

		for i = 1,12 do
			local ison = IsVehicleExtraTurnedOn(vehicle,i)
			if 1 == tonumber(ison) then
				vehicleMods["extras"][i] = 0
			else
				vehicleMods["extras"][i] = 1
			end
		end

		local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
		TriggerServerEvent("lscustoms:updateVehicle",vehicleMods,GetVehicleNumberPlateText(vehicle),vehname)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTEMPTPURCHASE
-----------------------------------------------------------------------------------------------------------------------------------------
function AttemptPurchase(type,upgradeLevel)
	if upgradeLevel ~= nil then
		upgradeLevel = upgradeLevel + 2
	end

	TriggerServerEvent("lscustoms:attemptPurchase",type,upgradeLevel)

	attemptingPurchase = true

	while attemptingPurchase do
		Wait(1)
	end

	if not isPurchaseSuccessful then
		PlaySoundFrontend(-1,"ERROR","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
	end

	return isPurchaseSuccessful
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTMOD
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentMod(id)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local mod = GetVehicleMod(vehicle,id)
	local modName = GetLabelText(GetModTextLabel(vehicle,id,mod))

	return mod,modName
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentWheel()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local wheel = GetVehicleMod(vehicle,23)
	local wheelName = GetLabelText(GetModTextLabel(vehicle,23,wheel))
	local wheelType = GetVehicleWheelType(vehicle)

	return wheel,wheelName,wheelType
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTCHUSTOMWHEELSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentCustomWheelState()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local state = GetVehicleModVariation(vehicle,23)

	if state then
		return 1
	else
		return 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETORIGINALWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function GetOriginalWheel()
	return originalWheel
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETORIGINALCUSTOMWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function GetOriginalCustomWheel()
	return originalCustomWheels
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTWINDOWTINT
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentWindowTint()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	return GetVehicleWindowTint(vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTVEHICLEWHEELSMOKECLOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentVehicleWheelSmokeColour()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local r,g,b = GetVehicleTyreSmokeColor(vehicle)

	return r,g,b
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTNEONSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentNeonState(id)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local isEnabled = IsVehicleNeonLightEnabled(vehicle,id)

	if isEnabled then
		return 1
	else
		return 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTNEONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentNeonColour()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local r,g,b = GetVehicleNeonLightsColour(vehicle)

	return r,g,b
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTXENONSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentXenonState()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local isEnabled = IsToggleModOn(vehicle,22)

	if isEnabled then
		return 1
	else
		return 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTXENONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentXenonColour()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	return GetVehicleHeadlightsColour(vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTTURBOSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentTurboState()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local isEnabled = IsToggleModOn(vehicle,18)

	if isEnabled then
		return 1
	else
		return 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTEXTRASTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentExtraState(extra)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	return IsVehicleExtraTurnedOn(vehicle,extra)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVALIDMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckValidMods(category,id,wheelType)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local tempMod = GetVehicleMod(vehicle,id)
	local tempWheel = GetVehicleMod(vehicle,23)
	local tempWheelType = GetVehicleWheelType(vehicle)
	local tempWheelCustom = GetVehicleModVariation(vehicle,23)
	local amountValidMods = 0
	local validMods = {}
	local hornNames = {}

	if wheelType ~= nil then
		SetVehicleWheelType(vehicle,wheelType)
	end

	if id == 14 then
		for k,v in pairs(vehicleCustomisation) do 
			if vehicleCustomisation[k]["category"] == category then
				hornNames = vehicleCustomisation[k]["hornNames"]
				break
			end
		end
	end

	local modAmount = GetNumVehicleMods(vehicle,id)
	for i = 1,modAmount do
		local label = GetModTextLabel(vehicle,id,(i - 1))
		local modName = GetLabelText(label)

		if modName == "NULL" then
			if id == 14 then
				if i <= #hornNames then
					modName = hornNames[i]["name"]
				else
					modName = "Horn "..i
				end
			else
				modName = category.." "..i
			end
		end

		validMods[i] = { id = (i - 1), name = modName }

		amountValidMods = amountValidMods + 1
	end

	if modAmount > 0 then
		table.insert(validMods,1,{ id = -1, name = "Original" })
	end

	if wheelType ~= nil then
		SetVehicleWheelType(vehicle,tempWheelType)
		SetVehicleMod(vehicle,23,tempWheel,tempWheelCustom)
	end

	return validMods,amountValidMods
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALMOD
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalMod()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleMod(vehicle,originalCategory,originalMod)
	SetVehicleDoorsShut(vehicle,true)

	originalCategory = nil
	originalMod = nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALWINDOWTINT
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalWindowTint()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleWindowTint(vehicle,originalWindowTint)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALCOLOURS
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalColours()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleColours(vehicle,originalPrimaryColour,originalSecondaryColour)
	SetVehicleExtraColours(vehicle,originalPearlescentColour,originalWheelColour)
	SetVehicleDashboardColour(vehicle,originalDashColour)
	SetVehicleInteriorColour(vehicle,originalInterColour)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALWHEELS
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalWheels()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local doesHaveCustomWheels = GetVehicleModVariation(vehicle,23)

	SetVehicleWheelType(vehicle,originalWheelType)

	if originalWheelCategory ~= nil then
		SetVehicleMod(vehicle,originalWheelCategory,originalWheel,originalCustomWheels)
		
		if GetVehicleClass(vehicle) == 8 then
			SetVehicleMod(vehicle,24,originalWheel,originalCustomWheels)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALNEONSTATES
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalNeonStates()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleNeonLightEnabled(vehicle,originalNeonLightSide,originalNeonLightState)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALNEONCOLOURS
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalNeonColours()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleNeonLightsColour(vehicle,originalNeonColourR,originalNeonColourG,originalNeonColourB)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALXENONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalXenonColour()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleHeadlightsColour(vehicle,originalXenonColour)
	SetVehicleLights(vehicle,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREPOLICELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function RestorePoliceLivery()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleLivery(vehicle,originalPoliceLivery)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREPLATEINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function RestorePlateIndex()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleNumberPlateTextIndex(vehicle,originalPlateIndex)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWMOD
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewMod(categoryID,modID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if originalMod == nil and originalCategory == nil then
		originalCategory = categoryID
		originalMod = GetVehicleMod(vehicle,categoryID)
	end

	if categoryID == 39 or categoryID == 40 or categoryID == 41 then
		SetVehicleDoorOpen(vehicle,4,false,true)
	elseif categoryID == 37 or categoryID == 38 then
		SetVehicleDoorOpen(vehicle,5,false,true)
	end

	SetVehicleMod(vehicle,categoryID,modID)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWWINDOWTINT
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewWindowTint(windowTintID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleWindowTint(vehicle,windowTintID)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewColour(paintType,paintCategory,paintID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	SetVehicleModKit(vehicle,0)

	if originalDashColour == nil and originalInterColour == nil and originalPrimaryColour == nil and originalSecondaryColour == nil and originalPearlescentColour == nil and originalWheelColour == nil then
		originalPrimaryColour,originalSecondaryColour = GetVehicleColours(vehicle)
		originalPearlescentColour,originalWheelColour = GetVehicleExtraColours(vehicle)
		originalDashColour = GetVehicleDashboardColour(vehicle)
		originalInterColour = GetVehicleInteriorColour(vehicle)
	end

	if paintType == 0 then
		if paintCategory == 1 then
			SetVehicleColours(vehicle,paintID,originalSecondaryColour)
			SetVehicleExtraColours(vehicle,originalPearlescentColour,originalWheelColour)
		else
			SetVehicleColours(vehicle,paintID,originalSecondaryColour)
		end
	elseif paintType == 1 then
		SetVehicleColours(vehicle,originalPrimaryColour,paintID)
	elseif paintType == 2 then
		SetVehicleExtraColours(vehicle,paintID,originalWheelColour)
	elseif paintType == 3 then
		SetVehicleExtraColours(vehicle,originalPearlescentColour,paintID)
	elseif paintType == 4 then
		SetVehicleDashboardColour(vehicle,paintID)
	elseif paintType == 5 then
		SetVehicleInteriorColour(vehicle,paintID)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewWheel(categoryID,wheelID,wheelType)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local doesHaveCustomWheels = GetVehicleModVariation(vehicle,23)

	if originalWheelCategory == nil and originalWheel == nil and originalWheelType == nil and originalCustomWheels == nil then
		originalWheelCategory = categoryID
		originalWheelType = GetVehicleWheelType(vehicle)
		originalWheel = GetVehicleMod(vehicle,23)
		originalCustomWheels = GetVehicleModVariation(vehicle,23)
	end

	SetVehicleWheelType(vehicle,wheelType)
	SetVehicleMod(vehicle,categoryID,wheelID,doesHaveCustomWheels)

	if GetVehicleClass(vehicle) == 8 then
		SetVehicleMod(vehicle,24,wheelID,doesHaveCustomWheels)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWNEON
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewNeon(side,enabled)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if originalNeonLightState == nil and originalNeonLightSide == nil then
		if IsVehicleNeonLightEnabled(vehicle,side) then
			originalNeonLightState = 1
		else
			originalNeonLightState = 0
		end

		originalNeonLightSide = side
	end

	SetVehicleNeonLightEnabled(vehicle,side,enabled)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWNEONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewNeonColour(r,g,b)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if originalNeonColourR == nil and originalNeonColourG == nil and originalNeonColourB == nil then
		originalNeonColourR,originalNeonColourG,originalNeonColourB = GetVehicleNeonLightsColour(vehicle)
	end

	SetVehicleNeonLightsColour(vehicle,r,g,b)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWXENONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewXenonColour(colour)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if originalXenonColour == nil then
		originalXenonColour = GetVehicleHeadlightsColour(vehicle)
	end

	SetVehicleLights(vehicle,2)
	SetVehicleHeadlightsColour(vehicle,colour)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWPOLICELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewPoliceLivery(liv)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleLivery(vehicle,tonumber(liv))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWPLATEINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewPlateIndex(index)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleNumberPlateTextIndex(vehicle,tonumber(index))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYMOD
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyMod(categoryID,modID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if categoryID == 18 then
		ToggleVehicleMod(vehicle,categoryID,modID)
	elseif categoryID == 11 or categoryID == 12 or categoryID== 13 or categoryID == 15 or categoryID == 16 then
		originalCategory = categoryID
		originalMod = modID

		SetVehicleMod(vehicle,categoryID,modID)
	else
		originalCategory = categoryID
		originalMod = modID

		SetVehicleMod(vehicle,categoryID,modID)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYEXTRA
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyExtra(extraID)
	local ped = PlayerPedId()
	local Vehicle = GetVehiclePedIsUsing(ped)

	local engine = GetVehicleEngineHealth(Vehicle)
	local body = GetVehicleBodyHealth(Vehicle)
	local vehWindows = {}
	local vehTyres = {}
	local vehDoors = {}

	for i = 0,7 do
		local Status = false

		if GetTyreHealth(Vehicle,i) ~= 1000.0 then
			Status = true
		end

		vehTyres[i] = Status
	end

	for i = 0,5 do
		vehDoors[i] = IsVehicleDoorDamaged(Vehicle,i)
	end

	for i = 0,5 do
		vehWindows[i] = IsVehicleWindowIntact(Vehicle,i)
	end

	local isEnabled = IsVehicleExtraTurnedOn(Vehicle,extraID)
	if isEnabled == 1 then
		SetVehicleExtra(Vehicle,tonumber(extraID),1)
		SetVehiclePetrolTankHealth(Vehicle,4000.0)
	else
		SetVehicleExtra(Vehicle,tonumber(extraID),0)
		SetVehiclePetrolTankHealth(Vehicle,4000.0)
	end

	SetVehicleEngineHealth(Vehicle,engine)
	SetVehicleBodyHealth(Vehicle,body)

	for Tyre,Burst in pairs(vehTyres) do
		if Burst then
			SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
		end
	end

	for k,v in pairs(vehWindows) do
		if not v then
			SmashVehicleWindow(Vehicle,k)
		end
	end

	for k,v in pairs(vehDoors) do
		if v then
			SetVehicleDoorBroken(Vehicle,k,v)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYWINDOWTINT
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyWindowTint(windowTintID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalWindowTint = windowTintID

	SetVehicleWindowTint(vehicle,windowTintID)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyColour(paintType,paintCategory,paintID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local vehPrimaryColour,vehSecondaryColour = GetVehicleColours(vehicle)
	local vehPearlescentColour,vehWheelColour = GetVehicleExtraColours(vehicle)

	if paintType == 0 then
		if paintCategory == 1 then
			SetVehicleColours(vehicle,paintID,vehSecondaryColour)
			SetVehicleExtraColours(vehicle,originalPearlescentColour,vehWheelColour)
			originalPrimaryColour = paintID
		else
			SetVehicleColours(vehicle,paintID,vehSecondaryColour)
			originalPrimaryColour = paintID
		end
	elseif paintType == 1 then
		SetVehicleColours(vehicle,vehPrimaryColour,paintID)
		originalSecondaryColour = paintID
	elseif paintType == 2 then
		SetVehicleExtraColours(vehicle,paintID,vehWheelColour)
		originalPearlescentColour = paintID
	elseif paintType == 3 then
		SetVehicleExtraColours(vehicle,vehPearlescentColour,paintID)
		originalWheelColour = paintID
	elseif paintType == 4 then
		SetVehicleDashboardColour(vehicle,paintID)
		originalDashColour = paintID
	elseif paintType == 5 then
		SetVehicleInteriorColour(vehicle,paintID)
		originalInterColour = paintID
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyWheel(categoryID,wheelID,wheelType)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local doesHaveCustomWheels = GetVehicleModVariation(vehicle,23)

	originalWheelCategory = categoryID
	originalWheel = wheelID
	originalWheelType = wheelType

	SetVehicleWheelType(vehicle,wheelType)
	SetVehicleMod(vehicle,categoryID,wheelID,doesHaveCustomWheels)
	
	if GetVehicleClass(vehicle) == 8 then
		SetVehicleMod(vehicle,24,wheelID,doesHaveCustomWheels)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYCUSTOMWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyCustomWheel(state)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleMod(vehicle,23,GetVehicleMod(vehicle,23),state)

	if GetVehicleClass(vehicle) == 8 then
		SetVehicleMod(vehicle,24,GetVehicleMod(vehicle,24),state)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYNEON
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyNeon(side,enabled)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalNeonLightState = enabled
	originalNeonLightSide = side

	SetVehicleNeonLightEnabled(vehicle,side,enabled)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYNEONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyNeonColour(r,g,b)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalNeonColourR = r
	originalNeonColourG = g
	originalNeonColourB = b

	SetVehicleNeonLightsColour(vehicle,r,g,b)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYXENONLIGHTS
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyXenonLights(category,state)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	ToggleVehicleMod(vehicle,category,state)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYXENONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyXenonColour(colour)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalXenonColour = colour

	SetVehicleHeadlightsColour(vehicle,colour)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYPOLICELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyPoliceLivery(liv)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalPoliceLivery = liv

	SetVehicleLivery(vehicle,liv)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYPLATEINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyPlateIndex(index)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalPlateIndex = index

	SetVehicleNumberPlateTextIndex(vehicle,index)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYTYRESMOKE
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyTyreSmoke(r,g,b)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	ToggleVehicleMod(vehicle,20,true)
	SetVehicleTyreSmokeColor(vehicle,r,g,b)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXITBENNYS
-----------------------------------------------------------------------------------------------------------------------------------------
function ExitBennys()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			FreezeEntityPosition(vehicle,false)
			saveVehicle()
		end
	end

	TriggerServerEvent("lscustoms:inVehicle",nil)
	TriggerEvent("player:inBennys",false)
	DisplayMenuContainer(false)
	activeBennys = false
	DestroyMenus()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLECONTROLS
-----------------------------------------------------------------------------------------------------------------------------------------
function disableControls()
	activeBennys = true

	CreateThread(function()
		while activeBennys do
			DisableControlAction(1,38,true)
			DisableControlAction(1,172,true)
			DisableControlAction(1,173,true)
			DisableControlAction(1,177,true)
			DisableControlAction(1,176,true)
			DisableControlAction(1,71,true)
			DisableControlAction(1,72,true)
			DisableControlAction(1,34,true)
			DisableControlAction(1,35,true)
			DisableControlAction(1,75,true)
			
			if IsDisabledControlJustReleased(1,172) then
				MenuScrollFunctionality("up")
				PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
			end
			
			if IsDisabledControlJustReleased(1,173) then
				MenuScrollFunctionality("down")
				PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
			end
			
			if IsDisabledControlJustReleased(1,176) then
				MenuManager(true)
				PlaySoundFrontend(-1,"OK","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
			end
			
			if IsDisabledControlJustReleased(1,177) then
				MenuManager(false)
				PlaySoundFrontend(-1,"NO","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
			end

			Wait(0)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PURCHASESUCCESFUL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("lscustoms:purchaseSuccessful")
AddEventHandler("lscustoms:purchaseSuccessful",function()
	isPurchaseSuccessful = true
	attemptingPurchase = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PURCHASEFAILED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("lscustoms:purchaseFailed")
AddEventHandler("lscustoms:purchaseFailed",function()
	isPurchaseSuccessful = false
	attemptingPurchase = false
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PURCHASEFAILED
-----------------------------------------------------------------------------------------------------------------------------------------
function setVehicleMods(veh,vehApply) 
	SetVehicleModKit(veh,0)
	if not vehApply or vehApply[1] then
		return
	end
	local primary = vehApply.colors[1]
	local secondary = vehApply.colors[2]
	-- local cprimary = vehApply.customPcolor
	-- if cprimary['1'] then
	-- 	bug = true
	-- end
	--local csecondary = vehApply.customScolor
	local extraFirst = vehApply.extracolors[1]
	local extraSecond = vehApply.extracolors[2]
	--local neoncolor = vehApply.neoncolor
	local smokecolor = vehApply.smokecolor
	ClearVehicleCustomPrimaryColour(veh)
	ClearVehicleCustomSecondaryColour(veh)
	SetVehicleWheelType(veh,vehApply.wheeltype)
	SetVehicleColours(veh,primary,secondary)
	-- if bug then
	-- 	SetVehicleCustomPrimaryColour(veh,cprimary['1'],cprimary['2'],cprimary['3'])
	-- 	SetVehicleCustomSecondaryColour(veh,csecondary['1'],csecondary['2'],csecondary['3'])
	-- else
	-- 	SetVehicleCustomPrimaryColour(veh,cprimary[1],cprimary[2],cprimary[3])
	-- 	SetVehicleCustomSecondaryColour(veh,csecondary[1],csecondary[2],csecondary[3])
	-- end
	SetVehicleExtraColours(veh,extraFirst,extraSecond)
	--SetVehicleNeonLightsColour(veh,neoncolor[1],neoncolor[2],neoncolor[3])
	SetVehicleXenonLightsColour(veh,vehApply.xenoncolor)
	SetVehicleWindowTint(veh,vehApply.windowtint)

	local r,g,b = parseInt(smokecolor[1]),parseInt(smokecolor[2]),parseInt(smokecolor[3])
	--ToggleVehicleMod(veh,mod["smoke"],true)
	SetVehicleTyreSmokeColor(veh,r,g,b)

	for i,t in pairs(vehApply.mods) do 
		if tonumber(i) == 22 or tonumber(i) == 18 then
			if t.mod > 0 then
				ToggleVehicleMod(veh,tonumber(i),true)
			else
				ToggleVehicleMod(veh,tonumber(i),false)
			end
		elseif tonumber(i) == 20 then
			
		elseif tonumber(i) == 23 or tonumber(i) == 24 then
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod),tonumber(t.variation))
		else
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod))
		end
	end
	if vehApply.neon then
		for i = 0, 3 do
			if vehApply.neon[tostring[i]] then 
				SetVehicleNeonLightEnabled(veh,i,true)
			else
				SetVehicleNeonLightEnabled(veh,i,false)
			end
		end
	end
end
--[[
	{
		"platestyle":5,
		"tint":1,
		"extracolors":[120,2],
		"interColour":91,
		"liverys":-1,
		"xenonColor":8,
		"smokecolor":[255,10,10],
		"extras":[1,0,0,0,0,0,0,0,0,0,0,0],
		"var":{"23":false,"24":false},
		"plateIndex":5,
		"dashColour":99,
		"colors":[28,64],
		"neon":{"1":1,"2":false,"3":1,"0":1},
		"lights":[2,21,255],
		"wheeltype":0,
		"mods":{"1":8,"2":5,"3":5,"4":0,"5":0,"6":-1,"7":5,"8":3,"9":-1,"10":-1,"11":3,"12":2,"13":2,"14":37,"15":3,"16":4,"17":false,"18":1,"19":false,"20":1,"21":false,"22":1,"23":13,"24":-1,"25":-1,"26":-1,"27":-1,"28":-1,"29":-1,"30":-1,"31":-1,"32":1,"33":0,"34":-1,"35":-1,"36":-1,"37":-1,"38":-1,"39":-1,"40":-1,"41":-1,"42":-1,"43":-1,"44":-1,"45":-1,"46":-1,"47":-1,"48":-1,"0":5}}	
]]
--[[
	{
		"platestyle":5,
		"tint":1,"extracolors":[120,2],"interColour":91,"liverys":-1,"xenonColor":8,"smokecolor":[255,10,10],"extras":[1,0,0,0,0,0,0,0,0,0,0,0],"var":{"23":false,"24":false},"plateIndex":5,"dashColour":99,"colors":[28,64],"neon":{"1":1,"2":false,"3":1,"0":1},"lights":[2,21,255],"wheeltype":0,"mods":{"1":8,"2":5,"3":5,"4":0,"5":0,"6":-1,"7":5,"8":3,"9":-1,"10":-1,"11":3,"12":2,"13":2,"14":37,"15":3,"16":4,"17":false,"18":1,"19":false,"20":1,"21":false,"22":1,"23":13,"24":-1,"25":-1,"26":-1,"27":-1,"28":-1,"29":-1,"30":-1,"31":-1,"32":1,"33":0,"34":-1,"35":-1,"36":-1,"37":-1,"38":-1,"39":-1,"40":-1,"41":-1,"42":-1,"43":-1,"44":-1,"45":-1,"46":-1,"47":-1,"48":-1,"0":5}}
]]


RegisterNetEvent("lscustoms:applyMods")
AddEventHandler("lscustoms:applyMods",function(vehNet,vehCustom)
		if not vehCustom or #vehCustom == 0 or not vehNet then return false end
		local veh = NetToVeh(vehNet)
		local custom = json.decode(vehCustom)
		if DoesEntityExist(veh) then
			SetVehicleModKit(veh,0)
			ClearVehicleCustomPrimaryColour(veh)
			ClearVehicleCustomSecondaryColour(veh)
			local customFunctions = {
				["platestyle"] = function(index)
					SetVehicleNumberPlateTextIndex(veh,index)
				end,
				["tint"] = function(tint)
					SetVehicleWindowTint(veh,tonumber(tint))
				end,
				["extracolors"] = function(colors)
					SetVehicleExtraColours(vehicle,tonumber(colors[1]),tonumber(colors[2]))
				end,
				["interColour"] = function(colors)
					SetVehicleInteriorColour(veh,tonumber(colors))
				end,
				["liverys"] = function(liv)
					SetVehicleLivery(veh,tonumber(liv))
				end,
				["xenonColor"] = function()
					SetVehicleXenonLightsColour(veh,tonumber(colour))
				end,
				["smokecolor"] = function(colors)
					SetVehicleTyreSmokeColor(veh,tonumber(colors[1]),tonumber(colors[2]),colors[3])
				end,
				["extras"] = function(extraID)
					for k,v in pairs(extraID) do
						print(k,v)
						SetVehicleExtra(veh,tonumber(k),v)
					end
					SetVehiclePetrolTankHealth(veh,4000.0)
				end,
				["plateIndex"] = function(index)
					SetVehicleNumberPlateTextIndex(veh,tonumber(index))
				end,
				["colors"] = function(colors)
					SetVehicleColours(veh,tonumber(colors[1]),tonumber(colors[2]))
				end,
				["wheeltype"] = function(wheeltype)
					SetVehicleWheelType(veh,tonumber(wheeltype))
				end,
				["neon"] = function(neon)
					for k,v in pairs(neon) do 
						SetVehicleNeonLightEnabled(veh,tonumber(k),tonumber(v))
					end
				end,
				["lights"] = function(colors)
					SetVehicleNeonLightsColour(veh,tonumber(colors[1]),tonumber(colors[2]),tonumber(colors[3]))
				end,
				["mods"] = function(mods)
					for i,t in pairs(mods) do 
						if tonumber(i) == 22 or tonumber(i) == 18 then
							if t then
								ToggleVehicleMod(veh,tonumber(i),true)
							else
								ToggleVehicleMod(veh,tonumber(i),false)
							end
						elseif tonumber(i) == 20 then
							ToggleVehicleMod(veh,20,tonumber(k))
						elseif tonumber(i) == 23 or tonumber(i) == 24 then
							SetVehicleMod(veh,tonumber(i),tonumber(t),tonumber(custom["var"][t]))
						else
							SetVehicleMod(veh,tonumber(i),tonumber(t))
						end
					end
				end
			}
			for k,v in pairs(custom) do 
				print(k,v)
				if customFunctions[k] then
					customFunctions[k](v)
				end
			end
			SetVehicleDirtLevel(veh,0.0)
		end	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
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

CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			if not activeBennys then
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped) then
					local coords = GetEntityCoords(ped)
					local vehicle = GetVehiclePedIsUsing(ped)
					if GetPedInVehicleSeat(vehicle,-1) == ped then
						for k,v in pairs(bennysLocations) do
							local distance = #(coords - v["pos"])

							if distance <= 8.0 then
								timeDistance = 1
								DrawText3D(v["pos"].x, v["pos"].y, v["pos"].z, 'PRESSIONE ~o~E~w~ PARA ACESSAR')

								if distance <= 2.5 then


									if IsControlJustPressed(1,38) and vSERVER.checkPermission(v["permission"]) then
										local isMotorcycle = false

										if v["bikes"] then
											if GetVehicleClass(vehicle) == 8 then
												isMotorcycle = true
											else
												goto skipBennys
											end
										else
											if GetVehicleClass(vehicle) == 8 then
												isMotorcycle = true
											else
												isMotorcycle = false
											end
										end

										SetVehicleModKit(vehicle,0)
										SetEntityCoords(vehicle,v["pos"])
										SetEntityHeading(vehicle,v["heading"])
										FreezeEntityPosition(vehicle,true)
										SetVehicleOnGroundProperly(vehicle)

										originalCategory = nil
										originalMod = nil
										originalPrimaryColour = nil
										originalSecondaryColour = nil
										originalPearlescentColour = nil
										originalWheelColour = nil
										originalDashColour = nil
										originalInterColour = nil
										originalWindowTint = nil
										originalWheelCategory = nil
										originalWheel = nil
										originalWheelType = nil
										originalCustomWheels = nil
										originalNeonLightState = nil
										originalNeonLightSide = nil
										originalNeonColourR = nil
										originalNeonColourG = nil
										originalNeonColourB = nil
										originalXenonColour = nil
										originalPoliceLivery = nil
										originalPlateIndex = nil

										InitiateMenus(isMotorcycle)

										DisplayMenuContainer(true)
										DisplayMenu(true,"mainMenu")
										TriggerEvent("player:inBennys",true)
										PlaySoundFrontend(-1,"OK","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
										TriggerServerEvent("lscustoms:inVehicle",VehToNet(vehicle),GetVehicleNumberPlateText(vehicle))

										disableControls()

										::skipBennys::
									end
								end
							end
						end
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)