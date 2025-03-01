-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local serviceList = {
	{ -918.38,-2027.98,9.4,"Police-1",5.0,18 },



	{ -432.51,-318.46,34.91,"Paramedic-1",1.0,6 },
	{ 1831.79,3672.95,34.27,"Paramedic-2",1.0,6 },
	{ -254.77,6331.03,32.79,"Paramedic-3",1.5,6 },
	{ -1430.55,-453.82,35.91,"Mechanic-1",1.0,0 },
	{ 2742.68,3488.1,55.25,"Mechanic-2",1.0,0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(serviceList) do
		exports["target"]:AddCircleZone("service:"..v[4],vector3(v[1],v[2],v[3]),0.75,{
			name = "service:"..v[4],
			heading = 3374176
		},{
			shop = k,
			distance = v[5],
			options = {
				{
					label = "Entrar em Serviço",
					event = "service:Toggle",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service)
	TriggerServerEvent("service:Toggle",serviceList[Service][4],serviceList[Service][6])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:LABEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Label")
AddEventHandler("service:Label",function(Service,Text)
	if Service == "Police" then
		exports["target"]:LabelText("service:Policia",Text)
		exports["target"]:LabelText("service:Policia-2",Text)
	elseif Service == "Paramedic" then
		exports["target"]:LabelText("service:Paramedic-1",Text)
		exports["target"]:LabelText("service:Paramedic-2",Text)
		exports["target"]:LabelText("service:Paramedic-3",Text)
	else
		exports["target"]:LabelText("service:"..Service,Text)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Open")
AddEventHandler("service:Open",function(Title)
	SetNuiFocus(true,true)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "openSystem", title = Title })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "closeSystem" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Request",function(Data,cb)
	cb({ Result = vSERVER.Request() })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Remove",function(Data)
	TriggerServerEvent("service:Remove",Data["passport"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Add",function(Data)
	TriggerServerEvent("service:Add",Data["passport"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Update")
AddEventHandler("service:Update",function()
	SendNUIMessage({ action = "updateSystem" })
end)