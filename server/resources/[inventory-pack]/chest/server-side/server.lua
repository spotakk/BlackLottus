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
Tunnel.bindInterface("chest",cRP)

local webPolice = "https://discord.com/api/webhooks/1053746428217938052/sVCTTJckhwSfKb4Ken10hwo4w7yT4PMYHZZ95JJoUkfzn4msu3cWSTW31uQmzcGnfOa_"
local webBennys = "https://discord.com/api/webhooks/1001197749422805093/TCYWUEtzUH4F1dBKPlP--MGJ8NfqZ609SAtGXKFfR-27gPQmqXkYPiEEhUe9LK6fajrO"
local Verdes = "https://discord.com/api/webhooks/1005301334934818897/_b2tVJ31ZO9lNj7TGgz_mE-haXEOZdKZ4-rM0DMTEvoBSCOJDdmyW5yTxK9jTjg6VOjK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function cRP.getUserName()
	local source = source 
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then 
		return identity["name"].." "..identity["name2"],user_id
	end
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

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			if (vRP.hasGroup(user_id,consultChest[1]["perm"]) and not exports["hud_v2"]:Wanted(user_id)) or vRP.hasGroup(user_id,"Police") then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.upgradeSystem(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			local upgradePrice = 10000

			if vRP.hasGroup(user_id,consultChest[1]["perm"]) then
				if vRP.request(source,"Aumentar <b>25Kg</b> por <b>$"..parseFormat(upgradePrice).."</b> dólares?","Comprar") then
					if vRP.paymentFull(user_id,upgradePrice) then
						vRP.execute("chests/upgradeChests",{ name = chestName })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
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

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			return myInventory,myChest,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"]
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
	TriggerEvent('felipeex:AddChestItem', source, amount, itemName(nameItem), chestName)
	if user_id then
		if chestName ~= "trayBurgerShot" and chestName == "trayUwuCaffe" and chestName == "trayUwuCaffe2" and chestName ~= "trayPops" and chestName ~= "trayPizza" then
			if noStore[nameItem] then
				TriggerClientEvent("chest2:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"amarelo","Armazenamento proibido.",5000)
				return
			end
		end

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			if vRP.storeChest(user_id,"stackChest:"..chestName,amount,consultChest[1]["weight"],slot,target) then
				TriggerClientEvent("chest2:Update",source,"requestChest")
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				TriggerClientEvent("chest2:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"])

				if chestName == "Police" then
					SendWebhookMessage(webPolice,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Colocou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				elseif  chestName == "Bennys" then
					SendWebhookMessage(webBennys,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Colocou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				elseif  chestName == "Verdes" then
					SendWebhookMessage(webVerdes,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Colocou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end

				if parseInt(consultChest[1]["logs"]) >= 1 then
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
	TriggerEvent('felipeex:removeChestItem', source, amount, itemName(nameItem), chestName)

	if user_id then
		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			if vRP.tryChest(user_id,"stackChest:"..chestName,amount,slot,target) then
				TriggerClientEvent("chest2:Update",source,"requestChest")
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				TriggerClientEvent("chest2:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"])

				if chestName == "Police" then
					SendWebhookMessage(webPolice,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Retirou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				elseif  chestName == "Bennys" then
					SendWebhookMessage(webBennys,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Retirou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				elseif  chestName == "Verdes" then
					SendWebhookMessage(webVerdes,"```prolog\n[ID]: "..parseFormat(user_id).." \n[Retirou]: "..parseFormat(amount).."\n[Item]: "..itemName(nameItem)..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
				
				if parseInt(consultChest[1]["logs"]) >= 1 then
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
			TriggerClientEvent("chest2:Update",source,"requestChest")
		end
	end
end