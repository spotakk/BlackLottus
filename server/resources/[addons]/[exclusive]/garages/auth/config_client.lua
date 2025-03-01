
Config = {}

Config["ApplyMods"] = function(vehicle,vehModel, vehNet, vehEngine, vehCustom, vehWindows, vehTyres, vehName, vehPlate)
	if vehName then
		TriggerEvent('lscustoms:applyMods',vehNet,vehCustom)
	end
end

Config["Blips"] = function(searchBlip,vehCoords)
	if DoesBlipExist(searchBlip) then
		RemoveBlip(searchBlip)
		searchBlip = nil
	end

	searchBlip = AddBlipForCoord(vehCoords["x"], vehCoords["y"], vehCoords["z"])
	SetBlipSprite(searchBlip, 225)
	SetBlipColour(searchBlip, 2)
	SetBlipScale(searchBlip, 0.6)
	SetBlipAsShortRange(searchBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(searchBlip)

	SetTimeout(30000, function()
		RemoveBlip(searchBlip)
		searchBlip = nil
	end)

end

Config["Makers"] = function(coords)
	-- SetTextFont(4)
	-- SetTextCentre(1)
	-- SetTextEntry("STRING")
	-- SetTextScale(0.3,0.3)
	-- SetTextColour(255,255,255,150)
	-- AddTextComponentString("[~r~GARAGEM~w~]")
	-- SetDrawOrigin(coords["x"],coords["y"],coords["z"],0)
	-- DrawText(0.0,0.0)
	-- local factor = (string.len("[Garagem]") / 375) + 0.01
	-- DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	-- ClearDrawOrigin()
	DrawMarker(36, coords["x"], coords["y"], coords["z"] - 0.45, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.25, 1.75, 1.50, 30,144,255, 100,0, 0, 0, 10)
end

Config["BreakCarWindows"] = true
Config["ExplodeTires"] = true

RegisterKeyMapping("unlock","Destrancar veiculos.","keyboard","L")

