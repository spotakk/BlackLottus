--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------

--------------------------------------------------
---------------------- EVENTS --------------------
--------------------------------------------------

local Proxy = module('vrp', 'lib/Proxy')
local vRP = Proxy.getInterface('vRP')

RegisterServerEvent('CinematicCam:requestPermissions')
AddEventHandler('CinematicCam:requestPermissions', function()
	local source = source
	local playerId = vRP.getUserId(source)
	local isWhitelisted = false

	if playerId then
		isWhitelisted = vRP.hasGroup(playerId, 'Admin')
	end

	-- \/ -- permission check here (set "isWhitelisted") -- \/ --


	
	-- /\ -- permission check here (set "isWhitelisted") -- /\ --

	TriggerClientEvent('CinematicCam:receivePermissions', source, isWhitelisted)
end)
