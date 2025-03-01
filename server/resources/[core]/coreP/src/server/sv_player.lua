-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getDiscord()
	return GetNumPlayerIndices()
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
--function src.getPlayerName()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		local identity = vRP.userIdentity(user_id)
--		if identity then 
--			return identity["name"],identity["name2"],user_id
--		else
--			return "Individuo","Indigente", user_id
--		end
--	end
--end
-----------------------------------------------------------------------------------------------------------------------------------------
-- / COR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cor', function(source, args, rawCommand)
	local playerId = vRP.getUserId(source)
	if args[1] and vRP.hasPermission(playerId, 'Admin') then
		TriggerClientEvent('changeWeaponColor', source, args[1])
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("me", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)

	if user_id and args[1] then
		local message = string.sub(rawCommand:sub(4), 1, 100)
		local activePlayers = vRPC.activePlayers(source)

		for _, v in ipairs(activePlayers) do
			async(function()
				TriggerClientEvent("showme:pressMe", v, source, message, 10)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("upgradeStress")
AddEventHandler("upgradeStress", function(number)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		vRP.upgradeStress(user_id, number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("downgradeStress")
AddEventHandler("downgradeStress", function(number)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		vRP.downgradeStress(user_id, number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("status", function(source, args, rawCommand)
	local onlinePlayers = GetNumPlayerIndices()
	local policia = vRP.getUsersByPermission("Police")
	local paramedico = vRP.getUsersByPermission("Paramedic")
	local mec = vRP.getUsersByPermission("Mechanic")
	local staff = vRP.getUsersByPermission("Admin")
	local user_id = vRP.getUserId(source)

	TriggerClientEvent("Notify", source, "check", "Lista de jogadores", "Jogadores: " .. onlinePlayers .. "Administração: " .. #staff .. "Policiais: " .. #policia .. "Paramédicos</b>: " .. #paramedico .. "Mecânicos</b>: " .. #mec .. ".", "verde", 9000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:KICKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("player:kickSystem")
AddEventHandler("player:kickSystem", function(message)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if not vRP.hasGroup(user_id, "Admin") then
			vRP.kick(user_id, message)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("e", function(source, args, rawCommand)
	--[[ if exports["chat"]:statusChat(source) then --]]

	local user_id = vRP.getUserId(source)

	if user_id and vRP.getHealth(source) > 100 then
		if args[2] == "friend" then
			local otherPlayer = vRPC.nearestPlayer(source)

			if otherPlayer then
				if vRP.getHealth(otherPlayer) > 100 and not clientAPI.getHandcuff(otherPlayer) then
					local identity = vRP.userIdentity(user_id)

					if vRP.request(otherPlayer, "Pedido de <b>" .. identity["name"] .. "</b> da animação <b>" .. args[1] .. "</b>?") then
						TriggerClientEvent("emotes", otherPlayer, args[1])
						TriggerClientEvent("emotes", source, args[1])
					end
				end
			end
		else
			TriggerClientEvent("emotes", source, args[1])
		end
	end

	--[[ end --]]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("e2", function(source, args, rawCommand)
	--[[ if exports["chat"]:statusChat(source) then --]]

	local user_id = vRP.getUserId(source)

	if user_id and vRP.getHealth(source) > 100 then
		local otherPlayer = vRPC.nearestPlayer(source)

		if otherPlayer then
			if vRP.hasGroup(user_id, "Paramedic") then
				TriggerClientEvent("emotes", otherPlayer, args[1])
			end
		end
	end

	--[[ end --]]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("player:Doors")
AddEventHandler("player:Doors", function(number)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local vehicle, vehNet = vRPC.vehList(source, 5)

		if vehicle then
			local activePlayers = vRPC.activePlayers(source)

			for _, v in ipairs(activePlayers) do
				async(function()
					TriggerClientEvent("player:syncDoors", v, vehNet, number)
				end)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getSalary()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.userPremium(user_id) then
			TriggerEvent("vRP:updateSalary", user_id, 1000)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$1000</b> recebido.", "amarelo", 5000)
		end

		--- SALÁRIOS VIPS ---

		if vRP.hasPermission(user_id, "Bronze") then
			TriggerEvent("vRP:updateSalary", user_id, 500)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$500</b> recebido.", "amarelo", 5000)
		end

		if vRP.hasPermission(user_id, "Prata") then
			TriggerEvent("vRP:updateSalary", user_id, 1000)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$1000</b> recebido.", "amarelo", 5000)
		end

		if vRP.hasPermission(user_id, "Ouro") then
			TriggerEvent("vRP:updateSalary", user_id, 1500)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$1500</b> recebido.", "amarelo", 5000)
		end

		--- GRUPOS ---

		if vRP.hasPermission(user_id, "Police") then
			TriggerEvent("vRP:updateSalary", user_id, 2500)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$2500</b> recebido.", "amarelo", 5000)
		end

		if vRP.hasPermission(user_id, "Paramedic") then
			TriggerEvent("vRP:updateSalary", user_id, 1500)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$1500</b> recebido.", "amarelo", 5000)
		end
	end
end

function numPermission(perm)
	local arr = {}
	for k,v in pairs(vRP.userList()) do 
		local nuser_id = vRP.getUserId(v)
		if vRP.hasPermission(nuser_id,perm) then 
			arr[#arr + 1] = v
		end
	end 
	return arr 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("911", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local pedHealth = GetEntityHealth(GetPlayerPed(source))
	if user_id and args[1] and pedHealth > 100 then
		if vRP.hasGroup(user_id,"Admin") then
			local identity = vRP.userIdentity(user_id)
			local policeResult = numPermission("Police")
			for k, v in pairs(policeResult) do
				async(function()
					TriggerClientEvent("chat:ClientMessage", v,"PREFEITURA", string.sub(rawCommand, 4), "911")
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("112", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local pedHealth = GetEntityHealth(GetPlayerPed(source))
	if user_id and args[1] and pedHealth > 100 then
		if vRP.hasGroup(user_id, "Paramedic") then
			local identity = vRP.userIdentity(user_id)
			local paramedicResult = numPermission("Paramedic")

			for k, v in pairs(paramedicResult) do
				async(function()
					TriggerClientEvent("chat:ClientMessage", v,identity["name"] .. " " .. identity["name2"], string.sub(rawCommand, 4), "112")
				end)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function src.shotsFired()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local policeResult = vRP.numPermission("Police")

		for k, v in pairs(policeResult) do
			async(function()
				TriggerClientEvent("NotifyPush", v, {
					code = 10,
					title = "Confronto em andamento",
					x = coords["x"],
					y = coords["y"],
					z = coords["z"],
					criminal = "Disparos de arma de fogo",
					blipColor = 6
				})
			end)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------

local playerCarry = {}

RegisterServerEvent("player:carryPlayer")
AddEventHandler("player:carryPlayer", function()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if not vRPC.inVehicle(source) then
			if playerCarry[user_id] then
				TriggerClientEvent("player:playerCarry", playerCarry[user_id], source)
				TriggerClientEvent("player:Commands", playerCarry[user_id], false)
				playerCarry[user_id] = nil
			else
				local otherPlayer = vRPC.nearestPlayer(source)

				if otherPlayer then
					playerCarry[user_id] = otherPlayer

					TriggerClientEvent("player:playerCarry", playerCarry[user_id], source)
					TriggerClientEvent("player:Commands", playerCarry[user_id], true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("playerDisconnect", function(user_id)
	if playerCarry[user_id] then
		TriggerClientEvent("player:Commands", playerCarry[user_id], false)
		playerCarry[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions", function(mode)
	local source = source
	local vehicle, vehNet = vRPC.vehSitting(source)

	if vehicle then
		local activePlayers = vRPC.activePlayers(source)

		for _, v in ipairs(activePlayers) do
			async(function()
				TriggerClientEvent("player:syncWins", v, vehNet, mode)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions", function(mode)
	local source = source
	local distance = 1.1

	if mode == "rv" then
		distance = 10
	end

	local otherPlayer = vRPC.nearestPlayer(source, distance)

	if otherPlayer then
		local user_id = vRP.getUserId(source)
		local consultItem = vRP.getInventoryItemAmount(user_id, "rope")

		if vRP.hasGroup(user_id, "Emergency") or consultItem[1] >= 1 then
			local vehicle, vehNet = vRPC.vehList(source, 5)

			if vehicle then
				local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
				local doorStatus = GetVehicleDoorLockStatus(idNetwork)

				if parseInt(doorStatus) <= 1 then
					if mode == "rv" then
						clientAPI.removeVehicle(otherPlayer)
					elseif mode == "cv" then
						clientAPI.putVehicle(otherPlayer, vehNet)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk", function()
	local source = source
	local otherPlayer = vRPC.nearestPlayer(source)

	if otherPlayer then
		TriggerClientEvent("player:checkTrunk", otherPlayer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------

local removeFit = {
	["homem"] = {
		["hat"] = {
			item = -1,
			texture = 0
		},
		["pants"] = {
			item = 61,
			texture = 0
		},
		["vest"] = {
			item = 0,
			texture = 0
		},
		["backpack"] = {
			item = 0,
			texture = 0
		},
		["bracelet"] = {
			item = -1,
			texture = 0
		},
		["decals"] = {
			item = 0,
			texture = 0
		},
		["mask"] = {
			item = 0,
			texture = 0
		},
		["shoes"] = {
			item = 5,
			texture = 0
		},
		["tshirt"] = {
			item = 15,
			texture = 0
		},
		["torso"] = {
			item = 15,
			texture = 0
		},
		["accessory"] = {
			item = 0,
			texture = 0
		},
		["watch"] = {
			item = -1,
			texture = 0
		},
		["arms"] = {
			item = 15,
			texture = 0
		},
		["glass"] = {
			item = 0,
			texture = 0
		},
		["ear"] = {
			item = -1,
			texture = 0
		}
	},
	["mulher"] = {
		["hat"] = {
			item = -1,
			texture = 0
		},
		["pants"] = {
			item = 15,
			texture = 0
		},
		["vest"] = {
			item = 0,
			texture = 0
		},
		["backpack"] = {
			item = 0,
			texture = 0
		},
		["bracelet"] = {
			item = -1,
			texture = 0
		},
		["decals"] = {
			item = 0,
			texture = 0
		},
		["mask"] = {
			item = 0,
			texture = 0
		},
		["shoes"] = {
			item = 35,
			texture = 0
		},
		["tshirt"] = {
			item = 14,
			texture = 0
		},
		["torso"] = {
			item = 15,
			texture = 0
		},
		["accessory"] = {
			item = 0,
			texture = 0
		},
		["watch"] = {
			item = -1,
			texture = 0
		},
		["arms"] = {
			item = 15,
			texture = 0
		},
		["glass"] = {
			item = 0,
			texture = 0
		},
		["ear"] = {
			item = -1,
			texture = 0
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local vSKINSHOP = Tunnel.getInterface('skinshop')
RegisterServerEvent("player:outfitFunctions")
AddEventHandler("player:outfitFunctions", function(mode)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if mode == "aplicar" then
			local result = vRP.getSrvdata("saveClothes:" .. user_id)

			if result["pants"] ~= nil then
				vRPC.playAnim(source, true, {"clothingshirt","try_shirt_positive_d"}, false)
				SetTimeout(3000, function()
					TriggerClientEvent("updateRoupas", source, result)
					TriggerClientEvent("Notify", source, "check", "Sucesso", "Roupas aplicadas.", "verde", 3000)
					vRPC.stopAnim(source)
				end)
			else
				TriggerClientEvent("Notify", source, "important", "Atenção", "Roupas não encontradas.", "amarelo", 3000)
			end
		elseif mode == "preaplicar" then
			if vRP.userPremium(user_id) then
				local result = vRP.getSrvdata("premClothes:" .. user_id)

				if result["pants"] ~= nil then
					TriggerClientEvent("updateRoupas", source, result)
					TriggerClientEvent("Notify", source, "check", "Sucesso", "Roupas aplicadas.", "verde", 3000)
				else
					TriggerClientEvent("Notify", source, "important", "Atenção", "Roupas não encontradas.", "amarelo", 3000)
				end
			end
		elseif mode == "salvar" then
			local checkBackpack = vSKINSHOP.checkBackpack(source)

			if not checkBackpack then
				local custom = vSKINSHOP.getCustomization(source)
				if custom then
					vRP.setSrvdata("saveClothes:" .. user_id, custom)
					TriggerClientEvent("Notify", source, "check", "Sucesso", "Roupas salvas.", "verde", 3000)
				end
			else
				TriggerClientEvent("Notify", source, "important", "Atenção", "Remova do corpo o acessório item.", "amarelo", 5000)
			end
		elseif mode == "presalvar" then
			if vRP.userPremium(user_id) then
				local checkBackpack = vSKINSHOP.checkBackpack(source)

				if not checkBackpack then
					local custom = vSKINSHOP.getCustomization(source)

					if custom then
						vRP.setSrvdata("premClothes:" .. user_id, custom)
						TriggerClientEvent("Notify", source, "check", "Sucesso", "Roupas salvas.", "verde", 3000)
					end
				else
					TriggerClientEvent("Notify", source, "important", "Atenção", "Remova do corpo o acessório item.", "amarelo", 5000)
				end
			end
		elseif mode == "remover" then
			local model = vRP.modelPlayer(source)

			if model == "mp_m_freemode_01" then
				TriggerClientEvent("updateRoupas", source, removeFit["homem"])
			elseif model == "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas", source, removeFit["mulher"])
			end
		else
			TriggerClientEvent("skinshop:set" .. mode, source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("add", function(source, args, rawCommand)
	--[[ if exports["chat"]:statusChat(source) then --]]

	local user_id = vRP.getUserId(source)

	if user_id and args[1] and parseInt(args[2]) > 0 then
		local Group = args[1]
		local nuser_id = parseInt(args[2])
		local identity = vRP.userIdentity(nuser_id)

		if identity then
			if vRP.hasPermission(user_id, "set" .. Group) then
				vRP.cleanPermission(nuser_id)
				vRP.setPermission(nuser_id, Group)
				TriggerClientEvent("Notify", source, "check", "Sucesso", "Passaporte " .. nuser_id .. " adicionado.", "verde", 5000)
			end
		end
	end

	--[[ end --]]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("rem", function(source, args, rawCommand)
	--[[ if exports["chat"]:statusChat(source) then --]]

	local user_id = vRP.getUserId(source)

	if user_id and args[1] and parseInt(args[2]) > 0 then
		local Group = args[1]
		local nuser_id = parseInt(args[2])
		local identity = vRP.userIdentity(nuser_id)

		if identity then
			if vRP.hasPermission(user_id, "set" .. Group) then
				vRP.cleanPermission(nuser_id)
				TriggerClientEvent("Notify", source, "important", "Atenção", "Passaporte " .. nuser_id .. "removido.", "amarelo", 5000)
			end
		end
	end

	--[[ end --]]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHLOGS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("player:deathLogs")
AddEventHandler("player:deathLogs", function(nSource)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id and source ~= nSource then
		local nuser_id = vRP.getUserId(nSource)

		if nuser_id then
			TriggerEvent("discordLogs", "Deaths", "**Matou:** " .. user_id .. "\n**Morreu:** " .. nuser_id .. "\n**Horário:** " .. os.date("%H:%M:%S") )
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDLINKS
-----------------------------------------------------------------------------------------------------------------------------------------

local discordLinks = {
	["Disconnect"] = "https://discord.com/api/webhooks/1046532885328445620/4KdL6MklXtlBuIBnf8DUlQBicKw8Voe1ttnvAr1o1ARdc1hwj4G0LnptR2SZ4GH12oCX",
	["Airport"] = "https://discord.com/api/webhooks/1046534408934535179/7tNZ5GThTHeV7BralFyNFAl7VqUUSlJbfQ5QcebAwlx-7qX1mHXJcXjYNeT5xzPQy0TC",
	["Deaths"] = "https://discord.com/api/webhooks/1046523104165384252/Mek3rJEKy941-cdLqTb4ojVBXkgTFRYpA3b-nxDr_8IcZZlsa542nizW8HDFKw_xGx1l",
	["Police"] = "",
	["State"] = "",
	["Police"] = "",
	["Sheriff"] = "",
	["Ranger"] = "",
	["Corrections"] = "",
	["Paramedic"] = "",
	["Hackers"] = "https://discord.com/api/webhooks/1046534528220549170/8BJIposuEw1kLiakui4Mng1w8n7OJcijgcJ9xgwaxB8RUU9G3H4iKLNc8umL8OeYe1SG",
	["Gemstones"] = "https://discord.com/api/webhooks/1046533176358621225/FPC-No6egWNsmt0mcQ3Jo0p9-8BRNB3WhNXbVGoQF5DQiSwwCGhh2BQS7JvJPHsUMbQA",
	["Badges"] = "",
	["Suggestions"] = ""
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDLOGS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("discordLogs")
AddEventHandler("discordLogs", function(webhook, message, color)
	PerformHttpRequest(discordLinks[webhook], function(err, text, headers) end, "POST", json.encode{
		username = "Vice City",
		embeds = {
			{
				color = color,
				description = message
			}
		}
	}, {
		["Content-Type"] = "application/json"
	})
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function src.bikesBackpack()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local amountWeight = 10
		local myWeight = vRP.getWeight(user_id)

		if parseInt(myWeight) < 45 then
			amountWeight = 15
		elseif parseInt(myWeight) >= 45 and parseInt(myWeight) <= 79 then
			amountWeight = 10
		elseif parseInt(myWeight) >= 80 and parseInt(myWeight) <= 95 then
			amountWeight = 5
		elseif parseInt(myWeight) >= 100 and parseInt(myWeight) <= 148 then
			amountWeight = 2
		elseif parseInt(myWeight) >= 150 then
			amountWeight = 1
		end

		vRP.setWeight(user_id, amountWeight)
	end
end

function src.ClearGunsAnDead()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		TriggerEvent("inventory:clearWeapons", user_id)
	end
end
