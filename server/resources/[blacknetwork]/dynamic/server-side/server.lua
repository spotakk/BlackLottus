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
Tunnel.bindInterface("dynamic",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local animal = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalRegister(netId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		animal[user_id] = netId
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMACLEANER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalCleaner()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("tryDeletePed",animal[user_id])
		animal[user_id] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if animal[user_id] then
		TriggerEvent("tryDeletePed",animal[user_id])
		animal[user_id] = nil
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["1"] = { -- RECRUTA
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 84, texture = 0 },
			["vest"] = { item = 8, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 122, texture = 0 },
			["torso"] = { item = 255, texture = 8 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 },
			["parachute"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 12, texture = 0 },
			["vest"] = { item = -1, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = -1, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 152, texture = 0 },
			["torso"] = { item = 286, texture = 0 },
			["accessory"] = { item = -1, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["2"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 84, texture = 0 },
			["vest"] = { item = 1, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 122, texture = 0 },
			["torso"] = { item = 255, texture = 8 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 },
			["parachute"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 12, texture = 0 },
			["vest"] = { item = -1, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = -1, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 152, texture = 0 },
			["torso"] = { item = 286, texture = 0 },
			["accessory"] = { item = -1, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["3"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 84, texture = 0 },
			["vest"] = { item = 1, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 122, texture = 0 },
			["torso"] = { item = 220, texture = 0 },
			["accessory"] = { item = 4, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 1, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 },
			["parachute"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 12, texture = 0 },
			["vest"] = { item = -1, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = -1, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 6, texture = 0 },
			["torso"] = { item = 391, texture = 0 },
			["accessory"] = { item = 22, texture = 2 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["4"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 84, texture = 0 },
			["vest"] = { item = 3, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 122, texture = 0 },
			["torso"] = { item = 94, texture = 2 },
			["accessory"] = { item = 4, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 1, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 },
			["parachute"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 12, texture = 0 },
			["vest"] = { item = -1, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = -1, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 152, texture = 0 },
			["torso"] = { item = 75, texture = 3 },
			["accessory"] = { item = -1, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["5"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 84, texture = 0 },
			["vest"] = { item = 1, texture = 2 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 122, texture = 0 },
			["torso"] = { item = 94, texture = 0 },
			["accessory"] = { item = 4, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 1, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 },
			["parachute"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 12, texture = 0 },
			["vest"] = { item = -1, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = -1, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 152, texture = 0 },
			["torso"] = { item = 75, texture = 0 },
			["accessory"] = { item = -1, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["Bennys"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 98, texture = 4 },
			["vest"] = { item = 18, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["shoes"] = { item = 35, texture = 0 },
			["tshirt"] = { item = 53, texture = 0 },
			["torso"] = { item = 241, texture = 1 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 1, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 },
			["parachute"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = { -- 
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 90, texture = 1 },
			["vest"] = { item = 6, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 36, texture = 0 },
			["tshirt"] = { item = 10, texture = 0 },
			["torso"] = { item = 356, texture = 1 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 13, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
			["9"] = {
				["mp_m_freemode_01"] = {
					["hat"] = { item = 0, texture = 0 },
					["pants"] = { item = 20, texture = 0 },
					["vest"] = { item = -1, texture = 0 },
					["bracelet"] = { item = -1, texture = 0 },
					["decals"] = { item = 0, texture = 0 },
					["mask"] = { item = 0, texture = 0 },
					["shoes"] = { item = 8, texture = 0 },
					["tshirt"] = { item = 15, texture = 0 },
					["torso"] = { item = 136, texture = 1 },
					["accessory"] = { item = 126, texture = 0 },
					["watch"] = { item = -1, texture = 0 },
					["arms"] = { item = 15, texture = 0 },
					["glass"] = { item = 0, texture = 0 },
					["ear"] = { item = -1, texture = 0 },
					["parachute"] = { item = -1, texture = 0 }
				},
				["mp_f_freemode_01"] = {
					["hat"] = { item = -1, texture = 0 },
					["pants"] = { item = 37, texture = 5 },
					["vest"] = { item = -1, texture = 0 },
					["bracelet"] = { item = -1, texture = 0 },
					["backpack"] = { item = 0, texture = 0 },
					["decals"] = { item = 0, texture = 0 },
					["mask"] = { item = -1, texture = 0 },
					["shoes"] = { item = 1, texture = 0 },
					["tshirt"] = { item = 6, texture = 0 },
					["torso"] = { item = 392, texture = 0 },
					["accessory"] = { item = 96, texture = 0 },
					["watch"] = { item = -1, texture = 0 },
					["arms"] = { item = 15, texture = 0 },
					["glass"] = { item = 0, texture = 0 },
					["ear"] = { item = -1, texture = 0 }
				}
			},
			["10"] = {
				["mp_m_freemode_01"] = {
					["hat"] = { item = 0, texture = 0 },
					["pants"] = { item = 20, texture = 0 },
					["vest"] = { item = -1, texture = 0 },
					["bracelet"] = { item = -1, texture = 0 },
					["decals"] = { item = 0, texture = 0 },
					["mask"] = { item = 0, texture = 0 },
					["shoes"] = { item = 8, texture = 0 },
					["tshirt"] = { item = 10, texture = 0 },
					["torso"] = { item = 156, texture = 1 },
					["accessory"] = { item = 126, texture = 0 },
					["watch"] = { item = -1, texture = 0 },
					["arms"] = { item = 1, texture = 0 },
					["glass"] = { item = 0, texture = 0 },
					["ear"] = { item = -1, texture = 0 },
					["parachute"] = { item = -1, texture = 0 }
				},
				["mp_f_freemode_01"] = {
					["hat"] = { item = -1, texture = 0 },
					["pants"] = { item = 37, texture = 5 },
					["vest"] = { item = -1, texture = 0 },
					["bracelet"] = { item = -1, texture = 0 },
					["backpack"] = { item = 0, texture = 0 },
					["decals"] = { item = 0, texture = 0 },
					["mask"] = { item = -1, texture = 0 },
					["shoes"] = { item = 1, texture = 0 },
					["tshirt"] = { item = 71, texture = 0 },
					["torso"] = { item = 91, texture = 0 },
					["accessory"] = { item = 96, texture = 0 },
					["watch"] = { item = -1, texture = 0 },
					["arms"] = { item = 7, texture = 0 },
					["glass"] = { item = 0, texture = 0 },
					["ear"] = { item = -1, texture = 0 }
				}
			},
			["11"] = {
				["mp_m_freemode_01"] = {
					["hat"] = { item = 0, texture = 0 },
					["pants"] = { item = 20, texture = 0 },
					["vest"] = { item = -1, texture = 0 },
					["bracelet"] = { item = -1, texture = 0 },
					["decals"] = { item = 0, texture = 0 },
					["mask"] = { item = 0, texture = 0 },
					["shoes"] = { item = 8, texture = 0 },
					["tshirt"] = { item = 13, texture = 0 },
					["torso"] = { item = 13, texture = 0 },
					["accessory"] = { item = 14, texture = 0 },
					["watch"] = { item = -1, texture = 0 },
					["arms"] = { item = 1, texture = 0 },
					["glass"] = { item = 0, texture = 0 },
					["ear"] = { item = -1, texture = 0 },
					["parachute"] = { item = -1, texture = 0 }
				},
				["mp_f_freemode_01"] = {
					["hat"] = { item = -1, texture = 0 },
					["pants"] = { item = 37, texture = 5 },
					["vest"] = { item = -1, texture = 0 },
					["bracelet"] = { item = -1, texture = 0 },
					["backpack"] = { item = 0, texture = 0 },
					["decals"] = { item = 0, texture = 0 },
					["mask"] = { item = -1, texture = 0 },
					["shoes"] = { item = 1, texture = 0 },
					["tshirt"] = { item = 71, texture = 0 },
					["torso"] = { item = 91, texture = 0 },
					["accessory"] = { item = 96, texture = 0 },
					["watch"] = { item = -1, texture = 0 },
					["arms"] = { item = 7, texture = 0 },
					["glass"] = { item = 0, texture = 0 },
					["ear"] = { item = -1, texture = 0 }
		}
	}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:presetFunctions")
AddEventHandler("player:presetFunctions",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Police") or vRP.hasGroup(user_id,"Paramedic") then
			local model = vRP.modelPlayer(source)
			if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",source,preset[number][model])
			end
		end
	end
end)