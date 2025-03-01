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
Tunnel.bindInterface("groupmanager-chest",cRP)

local webPolice = "https://discord.com/api/webhooks/1053746428217938052/sVCTTJckhwSfKb4Ken10hwo4w7yT4PMYHZZ95JJoUkfzn4msu3cWSTW31uQmzcGnfOa_"
local webBennys = "https://discord.com/api/webhooks/1001197749422805093/TCYWUEtzUH4F1dBKPlP--MGJ8NfqZ609SAtGXKFfR-27gPQmqXkYPiEEhUe9LK6fajrO"
local Verdes = "https://discord.com/api/webhooks/1005301334934818897/_b2tVJ31ZO9lNj7TGgz_mE-haXEOZdKZ4-rM0DMTEvoBSCOJDdmyW5yTxK9jTjg6VOjK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

vRP.prepare("chest/getChest","SELECT * FROM groupmanager_chest WHERE name = @name")
vRP.prepare("chest/getChests","SELECT * FROM groupmanager_chest")

function cRP.getChests()
	local source = source
	local consultChest = vRP.query("chest/getChests")
	local chestCoords = {}
	for index, value in ipairs(consultChest) do
		local cds = json.decode(value.cds)['position']
		table.insert(chestCoords, { value.perm, cds['x'], cds['y'], cds['z'], "1" })
		if value.cds2 then 
			local cds2 = json.decode(value.cds2)['position']
			table.insert(chestCoords, { value.perm.."-Private", cds2['x'], cds2['y'], cds2['z'], "1" })
		end

	end

	return chestCoords
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if chestName == "trayBurgerShot" or chestName == "trayUwuCaffe" or chestName == "trayUwuCaffe2" or chestName == "trayPops" or chestName == "trayPizza" then
			return true
		end
		local groupPerm = splitString(chestName)

		local consultChest = vRP.query("chest/getChest",{ name = groupPerm[1] })
		if groupPerm[2] and groupPerm[2] == "Private" and not vRP.hasGroup(user_id,"Police") then
			for i = 1, #config.openChest do
				if vRP.hasGroup(user_id, consultChest[1]["perm"] .. "-" .. config.openChest[i]) then
					return true
				end
			end
			return false
		elseif groupPerm[1] and vRP.hasGroup(user_id,consultChest[1]["perm"]) or vRP.hasGroup(user_id,"Police") then
			return true
		end
	end

	return false
end 
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("upgradeChest", "UPDATE groupmanager_chest SET weight = weight + 25 WHERE name = @name")
vRP.prepare("upgradeChestLider", "UPDATE groupmanager_chest SET liderW = liderW + 25 WHERE name = @name")

function cRP.upgradeSystem(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local groupPerm = splitString(chestName)

		local consultChest = vRP.query("chest/getChest",{ name = groupPerm[1] })
		if consultChest[1] then
			local upgradePrice = 10000
			local function updateChestSystem()
				if vRP.request(source, "Aumentar <b>25Kg</b> por <b>$" .. parseFormat(upgradePrice) .. "</b> dólares?", "Comprar") then
					if vRP.paymentFull(user_id, upgradePrice) then
						if groupPerm[2] and groupPerm[2] == "Private" then
							vRP.execute("upgradeChestLider", { name = groupPerm[1] })
						else
							vRP.execute("upgradeChest", { name = chestName })
						end
						TriggerClientEvent("Notify", source, "check", "Sucesso", "Compra concluída.", "verde", 3000)
					else
						TriggerClientEvent("Notify", source, "cancel", "Negado", "Saldo insuficiente: "..upgradePrice, "vermelho", 5000)
					end
				end
			end

			if groupPerm[2] and groupPerm[2] == "Private" then
				for i = 1, #config.openChest do
					if vRP.hasGroup(user_id, consultChest[1]["perm"] .. "-" .. config.openChest[i]) then
						return updateChestSystem()
					end
				end
				return
			elseif vRP.hasGroup(user_id,consultChest[1]["perm"]) then
				if vRP.request(source,"Aumentar <b>25Kg</b> por <b>$"..parseFormat(upgradePrice).."</b> dólares?","Comprar") then
					updateChestSystem()
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
--[[
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["key"] = v["item"]
			v["slot"] = Index

]]

function cRP.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myInventory = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			myInventory[k] = v
		end

		local myChest = {}
		local result = vRP.getSrvdata("stackChest:"..chestName)

		for k,v in pairs(result) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			myChest[k] = v
		end

		local groupPerm = splitString(chestName)

		local consultChest = vRP.query("chest/getChest",{ name = groupPerm[1] })
		if string.find(chestName, "%Helicrash") then
			return myInventory,myChest,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),5000
		end
		if groupPerm[2] and groupPerm[2] == "Private" then
			consultChest[1]["weight"] = consultChest[1]["liderW"]
		end
		if consultChest[1] then
			local identity = vRP.userIdentity(user_id)
			return myInventory,myChest,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"],identity["name"].." "..identity["name2"],user_id
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
local noStore = {
	["cheese"] = true,
	["foodburger"] = true,
	["foodjuice"] = true,
	["foodbox"] = true,
	["octopus"] = true,
	["shrimp"] = true,
	["carp"] = true,
	["codfish"] = true,
	["catfish"] = true,
	["goldenfish"] = true,
	["horsefish"] = true,
	["tilapia"] = true,
	["pacu"] = true,
	["pirarucu"] = true,
	["tambaqui"] = true,
	["energetic"] = true,
	["milkbottle"] = true,
	["water"] = true,
	["coffee"] = true,
	["cola"] = true,
	["tacos"] = true,
	["fries"] = true,
	["soda"] = true,
	["orange"] = true,
	["apple"] = true,
	["strawberry"] = true,
	["coffee2"] = true,
	["grape"] = true,
	["tange"] = true,
	["banana"] = true,
	["passion"] = true,
	["tomato"] = true,
	["mushroom"] = true,
	["orangejuice"] = true,
	["tangejuice"] = true,
	["grapejuice"] = true,
	["strawberryjuice"] = true,
	["bananajuice"] = true,
	["passionjuice"] = true,
	["bread"] = true,
	["ketchup"] = true,
	["cannedsoup"] = true,
	["canofbeans"] = true,
	["meat"] = true,
	["fishfillet"] = true,
	["marshmallow"] = true,
	["cookedfishfillet"] = true,
	["cookedmeat"] = true,
	["hamburger"] = true,
	["hamburger2"] = true,
	["pizza"] = true,
	["pizza2"] = true,
	["hotdog"] = true,
	["donut"] = true,
	["chocolate"] = true,
	["sandwich"] = true,
	["absolut"] = true,
	["chandon"] = true,
	["dewars"] = true,
	["hennessy"] = true,
	["nigirizushi"] = true,
	["sushi"] = true,
	["cupcake"] = false,
	["milkshake"] = false,
	["cappuccino"] = false
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	TriggerEvent('groupmanager:AddChestItem', source, chestName, amount, itemName(nameItem), chestName)
	if user_id then
		if chestName ~= "trayBurgerShot" and chestName == "trayUwuCaffe" and chestName == "trayUwuCaffe2" and chestName ~= "trayPops" and chestName ~= "trayPizza" then
			if noStore[nameItem] then
				TriggerClientEvent("chest:Update",source,"requestChest")
				TriggerClientEvent("Notify", source, "important","Atenção","Armazenamento proibido.", "amarelo", 5000)

				return
			end
		end
		local groupPerm = splitString(chestName)
		local consultChest = vRP.query("chest/getChest",{ name = groupPerm[1] })
		if groupPerm[2] and groupPerm[2] == "Private" then
			consultChest[1]["weight"] = consultChest[1]["liderW"]
		end
		if consultChest[1] or string.find(chestName, "%Helicrash") then
			if vRP.storeChest(user_id,"stackChest:"..chestName,amount,consultChest[1]["weight"],slot,target) then
				TriggerClientEvent("chest:Update",source,"requestChest")
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				if not consultChest[1] then
					consultChest = {}
					consultChest[1] = {["weight"] = 5000}
				end
				TriggerClientEvent("chest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"])

				if chestName == "Police" then
					SendWebhookMessage(webPolice,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Colocou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				elseif  chestName == "Bennys" then
					SendWebhookMessage(webBennys,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Colocou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				elseif  chestName == "Verdes" then
					SendWebhookMessage(webVerdes,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Colocou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end

				vRP.SendWebhookMessage("ChestSend",user_id,0,{
					["1"] = chestName,
					["2"] = nameItem,
					["3"] = amount
				})
				if not string.find(chestName, "%Helicrash") and parseInt(consultChest[1]["logs"]) >= 1 then
					TriggerEvent("discordLogs",chestName,"**Passaporte:** "..parseFormat(user_id).."\n**Guardou:** "..parseFormat(amount).."x "..itemName(nameItem).."\n**Horário:** "..os.date("%H:%M:%S"),3042892)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	TriggerEvent('groupmanager:removeChestItem', source, chestName, amount, itemName(nameItem), chestName)

	if user_id then
		local groupPerm = splitString(chestName)

		local consultChest = vRP.query("chest/getChest",{ name = groupPerm[1] })
		if consultChest[1] or string.find(chestName, "%Helicrash") then
			if groupPerm[2] and groupPerm[2] == "Private" then
				consultChest[1]["weight"] = consultChest[1]["liderW"]
			end
			if vRP.tryChest(user_id,"stackChest:"..chestName,amount,slot,target) then
				TriggerClientEvent("chest:Update",source,"requestChest")
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				if not consultChest[1] then
					consultChest = {}
					consultChest[1] = {["weight"] = 5000}
				end
				TriggerClientEvent("chest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"])
				if string.sub(chestName,1,9) == "Helicrash" and json.encode(result) == '[]' then
					TriggerClientEvent("chest:Close",source)
					exports["helicrash"]:Box()
				end

				if chestName == "Police" then
					SendWebhookMessage(webPolice,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Retirou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				elseif  chestName == "Bennys" then
					SendWebhookMessage(webBennys,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Retirou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				elseif  chestName == "Verdes" then
					SendWebhookMessage(webVerdes,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Retirou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
				vRP.SendWebhookMessage("ChestTake",user_id,0,{
					["1"] = chestName,
					["2"] = nameItem,
					["3"] = amount
				})
				if not string.find(chestName, "%Helicrash") and parseInt(consultChest[1]["logs"]) >= 1 then
					TriggerEvent("discordLogs",chestName,"**Passaporte:** "..parseFormat(user_id).."\n**Retirou:** "..parseFormat(amount).."x "..itemName(nameItem).."\n**Horário:** "..os.date("%H:%M:%S"),9317187)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateChest(slot,target,amount,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.updateChest(user_id,"stackChest:"..chestName,slot,target,amount) then
			TriggerClientEvent("chest:Update",source,"requestChest")
		end
	end
end