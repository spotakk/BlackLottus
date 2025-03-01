-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("tencode",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local codes = {
	['QRU'] = {
		text = "Confronto em andamento",
		blip = 6,
		value = 'QRU'
	},
	['QRT'] = {
		text = "Oficial ferido",
		blip = 1,
		value = 'QRT'
	},
	['QTH'] = {
		text = "Localização",
		blip = 38,
		value = 'QTH'
	},
	-- [32] = {
	-- 	text = "Homem armado",
	-- 	blip = 83
	-- },
	-- [38] = {
	-- 	text = "Parando veículo suspeito",
	-- 	blip = 61
	-- },
	-- [50] = {
	-- 	text = "Acidente de trânsito",
	-- 	blip = 77
	-- },
	['QRR'] = {
		text = "Reforço solicitado",
		blip = 4,
		value = 'QRR'
	}
	,
	['QTI'] = {
		text = "A caminho",
		blip = 4,
		value = 'QTI'
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.sendCode(code)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local identity = vRP.userIdentity(user_id)
		local policeResult = vRP.numPermission("Police")

		for k,v in pairs(policeResult) do
			async(function()
				
				if code ~= 'QRT' then
					vRPC.playSound(v,"Event_Start_Text","GTAO_FM_Events_Soundset")
				end

				TriggerClientEvent("NotifyPush",v,{ code = code, title = codes[code]["text"], x = coords["x"], y = coords["y"], z = coords["z"], name = identity["name"].." "..identity["name2"], time = "Recebido às "..os.date("%H:%M"), blipColor = codes[code]["blip"] })
			end)
		end
	end
end