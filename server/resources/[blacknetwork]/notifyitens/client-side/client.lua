-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSNOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify", function(status)
	SendNUIMessage({
		action = "itensNotify",
		data = { mode = status[1], item = status[2], amount = status[3], name = status[4] }
	})
end)
