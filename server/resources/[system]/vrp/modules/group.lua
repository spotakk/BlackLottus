-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local permList = {}
local selfReturn = {}
permList["Taxi"] = {}
permList["Police"] = {}
permList["Runners"] = {}
permList["Mechanic"] = {}
permList["Paramedic"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local permissions = {
	["Admin"] = {
		["Admin"] = true
	},
	["Moderator"] = {
		["Admin"] = true,
		["Moderator"] = true
	},
	----------------------------------------------------------------------
	-- FAVELAS
	----------------------------------------------------------------------
	["Barragem"] = {
		["Barragem"] = true
	},
	["Barragem-Líder"] = {
		["Barragem-Líder"] = true
	},
	["Barragem-Sub-Líder"] = {
		["Barragem-Sub-Líder"] = true
	},
	["Barragem-Gerente"] = {
		["Barragem-Gerente"] = true
	},
	["Barragem-Membro"] = {
		["Barragem-Membro"] = true
	},
	["Franca"] = {
		["Franca"] = true
	},
	["Porto"] = {
		["Porto"] = true
	},
	["Helipa"] = {
		["Helipa"] = true
	},
	["Farol"] = {
		["Farol"] = true
	},
	["Pedreira"] = {
		["Pedreira"] = true
	},
	["Igreja"] = {
		["Igreja"] = true
	},
	["FMansoes"] = {
		["FMansoes"] = true
	},
	["Vinewood"] = {
		["Vinewood"] = true
	},
	["Esgoto"] = {
		["Esgoto"] = true
	},
	----------------------------------------------------------------------
	-- FACÇÕES
	----------------------------------------------------------------------
	["Mafia"] = {
		["Mafia"] = true
	},
	["Vinhedo"] = {
		["Vinhedo"] = true
	},
	["TheLost"] = {
		["TheLost"] = true
	},
	["Tequila"] = {
		["Tequila"] = true
	},
	["Bennys"] = {
		["Bennys"] = true
	},
	["Vanilla"] = {
		["Vanilla"] = true
	},
	["Bahamas"] = {
		["Bahamas"] = true
	},
	["Ballas"] = {
		["Ballas"] = true
	},
	["Groove"] = {
		["Groove"] = true
	},
	----------------------------------------------------------------------
	-- ORGANIZAÇÕES LEGAIS
	----------------------------------------------------------------------
	["Paramedic"] = {
		["Paramedic"] = true
	},
	["Police"] = {
		["Police"] = true,
		["DIP"] = true,
	},
	["Burguer"] = {
		["Burguer"] = true
	},
	["Mechanic"] = {
		["Mechanic"] = true
	},
	["BurgerShot"] = {
		["BurgerShot"] = true
	},
	["DIP"] = {
		["DIP"] = true
	},
	["Ranger"] = {
		["Ranger"] = true
	},
	["State"] = {
		["State"] = true
	},
	["Corrections"] = {
		["Corrections"] = true
	},
	["Lspd"] = {
		["Lspd"] = true
	},
	["Policia"] = {
		["Policia"] = true
	},
	["Emergency"] = {
		["Lspd"] = true,
		["State"] = true,
		["Ranger"] = true,
		["Policia"] = true,
		["Paramedic"] = true,
		["Corrections"] = true
	},
	----------------------------------------------------------------------
	-- CORES
	----------------------------------------------------------------------
	["Azul"] = {
		["Azul"] = true
	},
	["Laranjas"] = {
		["Laranjas"] = true
	},
	["Roxos"] = {
		["Roxos"] = true
	},
	["Amarelos"] = {
		["Amarelos"] = true
	},
	["Verdes"] = {
		["Verdes"] = true
	},
	["Vermelhos"] = {
		["Vermelhos"] = true
	},
}

exports('permissions', function()
	return permissions
end)

local ClientState = {
	['Police'] = true,
	['Mechanic'] = true,
	['Paramedic'] = true
}

exports("permissions", function()
	return permissions
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasPermission(user_id, perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] then
			if dataTable["perm"][perm] then
				return true
			end
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setPermission(user_id, perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] == nil then
			dataTable["perm"] = {}
		end

		if dataTable["perm"][perm] == nil then
			dataTable["perm"][perm] = true
		end

		if perm and ClientState[perm] then
			local source = vRP.userSource(user_id)
			Player(parseInt(source)).state:set(perm, true, true)
		end
	else
		local userTables = vRP.userData(user_id, "Datatable")

		if userTables["inventory"] then
			if userTables["perm"] == nil then
				userTables["perm"] = {}
			end

			if userTables["perm"][perm] == nil then
				userTables["perm"][perm] = true
			end

			vRP.execute("playerdata/setUserdata", { user_id = user_id, key = "Datatable", value = json.encode(userTables) })
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.cleanPermission(user_id)
	local dataTable = vRP.getDatatable(user_id)
	local source = vRP.userSource(user_id)

	if dataTable then
		if dataTable["perm"] then
			for permission, _ in pairs(dataTable.perm) do
				if permission and ClientState[permission] then
					Player(parseInt(source)).state:set(permission, false, true)
				end
			end

			dataTable["perm"] = {}
		end
	else
		local userTables = vRP.userData(user_id, "Datatable")

		if userTables["inventory"] then
			if userTables["perm"] then
				userTables["perm"] = {}
				vRP.execute("playerdata/setUserdata", { user_id = user_id, key = "Datatable", value = json.encode(userTables) })
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remPermission(user_id, perm)
	local perm = tostring(perm)

	if vRP.userTables[parseInt(user_id)]["inventory"] then
		if vRP.userTables[parseInt(user_id)]["perm"] then
			if vRP.userTables[parseInt(user_id)]["perm"][perm] then
				if perm and ClientState[perm] then
					Player(parseInt(source)).state:set(perm, false, true)
				end

				vRP.userTables[parseInt(user_id)]["perm"][perm] = nil
				vRP.execute("playerdata/setUserdata",
					{ user_id = user_id, key = "Datatable", value = json.encode(vRP.userTables[parseInt(user_id)]) })
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updatePermission(user_id, perm, new)
	local new = tostring(new)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] == nil then
			dataTable["perm"] = {}
		end

		if dataTable["perm"][perm] then
			dataTable["perm"][perm] = nil
		end

		if perm and ClientState[perm] and perm ~= "" then
			Player(parseInt(source)).state:set(perm, false, true)
		end

		if new and ClientState[new] and new ~= "" then
			Player(parseInt(source)).state:set(new, true, true)
		end

		dataTable["perm"][new] = true
	else
		if vRP.userTables[parseInt(user_id)]["inventory"] then
			if vRP.userTables[parseInt(user_id)]["perm"] == nil then
				vRP.userTables[parseInt(user_id)]["perm"] = {}
			end

			if vRP.userTables[parseInt(user_id)]["perm"][perm] then
				vRP.userTables[parseInt(user_id)]["perm"][perm] = nil
			end

			vRP.userTables[parseInt(user_id)]["perm"][new] = true

			vRP.execute("playerdata/setUserdata",
				{ user_id = user_id, key = "Datatable", value = json.encode(vRP.userTables[parseInt(user_id)]) })
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasGroup(user_id, perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	for k, v in pairs(permissions) do
		if (k == perm) then
			if dataTable then
				if dataTable["perm"] then
					for k, _ in pairs(dataTable["perm"]) do
						if permissions[perm][k] then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.numPermission(perm)
	local tableList = {}

	for k, v in pairs(permList[perm]) do
		table.insert(tableList, v)
	end

	return tableList
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.insertPermission(source, user_id, perm)
	if permList[perm] then
		permList[perm][user_id] = source
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removePermission(user_id, perm)
	if permList[perm][user_id] then
		permList[perm][user_id] = nil
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect", function(user_id, source)
	if permList["Police"][user_id] then
		permList["Police"][user_id] = nil
	end

	if permList["Paramedic"][user_id] then
		permList["Paramedic"][user_id] = nil
	end

	if permList["Taxi"][user_id] then
		permList["Taxi"][user_id] = nil
	end

	if permList["Mechanic"][user_id] then
		permList["Mechanic"][user_id] = nil
	end

	if permList["Runners"][user_id] then
		permList["Runners"][user_id] = nil
	end

	if selfReturn[user_id] then
		selfReturn[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect", function(user_id, source)
	if vRP.hasPermission(user_id, "Corrections") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "POLICE: Corrections", 24)
		TriggerClientEvent("service:Label", source, "Corrections", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "Ranger") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "POLICE: Ranger", 69)
		TriggerClientEvent("service:Label", source, "Ranger", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "State") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("", source, "POLICE: State", 11)
		TriggerClientEvent("service:Label", source, "State", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "Lspd") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "POLICE: Lspd", 18)
		TriggerClientEvent("service:Label", source, "Police", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "Policia") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "Policia", 3)
		TriggerClientEvent("service:Label", source, "Policia", "Sair de Serviço", 5000)
		TriggerClientEvent("service:Label", source, "Policia-2", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "Paramedic") then
		permList["Paramedic"][user_id] = source
		TriggerClientEvent("vRP:ParamedicService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "Paramedic", 6)
		TriggerClientEvent("service:Label", source, "Paramedic-1", "Sair de Serviço", 5000)
		TriggerClientEvent("service:Label", source, "Paramedic-2", "Sair de Serviço", 5000)
		TriggerClientEvent("service:Label", source, "Paramedic-3", "Sair de Serviço", 5000)
	end

	if vRP.hasGroup(user_id, "Mechanic") then
		permList["Mechanic"][user_id] = source
		TriggerClientEvent("service:Label", source, "Mechanic", "Sair de Serviço", 5000)
	end

	if vRP.hasGroup(user_id, "Runners") then
		permList["Runners"][user_id] = source
	end

	if vRP.hasGroup(user_id, "Roxos") then
		TriggerClientEvent("player:Relationship", source, "Roxos")
	end

	if vRP.hasGroup(user_id, "Verdes") then
		TriggerClientEvent("player:Relationship", source, "Verdes")
	end

	if vRP.hasGroup(user_id, "Azul") then
		TriggerClientEvent("player:Relationship", source, "Azul")
	end

	if vRP.hasGroup(user_id, "Amarelos") then
		TriggerClientEvent("player:Relationship", source, "Amarelos")
	end

	if vRP.hasGroup(user_id, "TheLost") then
		TriggerClientEvent("player:Relationship", source, "TheLost")
	end

	local dataTable = vRP.getDatatable(user_id)

	if dataTable.perm then
		for permission, _ in pairs(dataTable.perm) do
			if permission and ClientState[permission] then
				Player(parseInt(source)).state:set(permission, true, true)
			end
		end
	end
end)

function vRP.getUsersByPermission(perm)
	local tableList = {}

	for user_id, source in pairs(vRP.userList()) do
		if vRP.hasPermission(user_id, perm) then
			table.insert(tableList, user_id)
		end
	end

	return tableList
end
