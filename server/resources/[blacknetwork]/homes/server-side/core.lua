-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("propertys", Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
vSKINSHOP = Tunnel.getInterface("skinshop")
vCLIENT = Tunnel.getInterface("propertys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lock = {}
local Inside = {}
local Markers = {}
local theftTimers = {}

local mobileTheft = {
	["MOBILE"] = {
		{ item = "notepad", min = 1, max = 5 },
		{ item = "keyboard", min = 1, max = 1 },
		{ item = "mouse", min = 1, max = 1 },
		{ item = "silverring", min = 1, max = 1 },
		{ item = "goldring", min = 1, max = 1 },
		{ item = "watch", min = 2, max = 4 },
		{ item = "playstation", min = 1, max = 1 },
		{ item = "xbox", min = 1, max = 1 },
		{ item = "legos", min = 1, max = 1 },
		{ item = "ominitrix", min = 1, max = 1 },
		{ item = "bracelet", min = 1, max = 1 },
		{ item = "pendrive", min = 1, max = 3 },
		{ item = "dildo", min = 1, max = 1 },
		{ item = "alicate", min = 1, max = 1 },
		{ item = "lockpick", min = 1, max = 1 },
		{ item = "lockpick2", min = 1, max = 1 },
		{ item = "joint", min = 8, max = 13 },
		{ item = "plasticbottle", min = 4, max = 9 },
		{ item = "glassbottle", min = 4, max = 9 },
		{ item = "elastic", min = 4, max = 9 },
		{ item = "battery", min = 4, max = 9 },
		{ item = "metalcan", min = 4, max = 9 },
		{ item = "vape", min = 1, max = 1 },
		{ item = "card01", min = 1, max = 1 },
		{ item = "card02", min = 1, max = 1 },
		{ item = "card03", min = 1, max = 1 },
		{ item = "pendrive", min = 1, max = 3 },
		{ item = "card04", min = 1, max = 1 },
		{ item = "pager", min = 1, max = 1 },
	},
	["LOCKER"] = {
		{ item = "card04", min = 1, max = 1 },
		{ item = "card05", min = 1, max = 1 },
		{ item = "WEAPON_PISTOL_MK2", min = 1, max = 1 },
		{ item = "WEAPON_PISTOL_AMMO", min = 10, max = 30 },

	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- prepare
-----------------------------------------------------------------------------------------------------------------------------------------

vRP.prepare("propertys/All", "SELECT * FROM propertys")
vRP.prepare("propertys/Sell", "DELETE FROM propertys WHERE name = @name")
vRP.prepare("propertys/SellHotel", "DELETE FROM propertys WHERE user_id=@user_id AND name=@name")
vRP.prepare("propertys/Exist", "SELECT * FROM propertys WHERE user_id = @user_id")
vRP.prepare("propertys/ExistPropertys", "SELECT * FROM propertys WHERE user_id = @user_id AND name = @name")
vRP.prepare("propertys/ExistPropertys2", "SELECT * FROM propertys WHERE  name = @name")
vRP.prepare("propertys/Serial", "SELECT * FROM propertys WHERE Serial = @serial")
vRP.prepare("propertys/Garages", "SELECT * FROM propertys WHERE garage IS NOT NULL")
vRP.prepare("propertys/AllUser", "SELECT * FROM propertys WHERE id = @id")
vRP.prepare("propertys/Garage", "UPDATE propertys SET garage = @garage WHERE name = @name")
vRP.prepare("propertys/Keys", "UPDATE propertys SET Keys = Keys + @keys WHERE name = @name")
vRP.prepare("propertys/Credentials", "UPDATE propertys SET Serial = @serial WHERE name = @name")
vRP.prepare("propertys/vault", "UPDATE propertys SET vault = vault + @weight WHERE name = @name")
vRP.prepare("propertys/fridge", "UPDATE propertys SET fridge = fridge + @weight WHERE name = @name")
vRP.prepare("propertys/CheckGarages", "SELECT coordsGarages FROM propertys WHERE  id = @id")
vRP.prepare("propertys/Check", "SELECT * FROM propertys WHERE name = @name AND id = @id")
vRP.prepare("propertys/tax", "UPDATE propertys SET tax = UNIX_TIMESTAMP() + 2592000 WHERE name = @name")
vRP.prepare("propertys/Buy",
	"INSERT INTO propertys(name,interior,price,user_id,vault,fridge,tax,owner) VALUES(@name,@interior,@price,@user_id,@vault,@fridge,@tax,@owner)")


RegisterCommand("voltar",function(source)

	SetPlayerRoutingBucket(source,0)

end)


function Creative.getUser()
	local source = source 
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then 
		return identity["name"].." "..identity["name2"],user_id
	end 
end

RegisterServerEvent("fx:updateHomes")
AddEventHandler("fx:updateHomes",function()
	local Consult = vRP.query("propertys/All")
	if (not Consult) then
		return
	end
	for Index, v in pairs(Consult) do
		Markers[v["name"]] = true
	end
	TriggerClientEvent("propertys:Table", -1, Propertys, Interiors, Markers)
end)

TriggerEvent("fx:updateHomes",-1)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Propertys()
	
	local source = source
	local getUserId = vRP.getUserId(source)
	local homes = nearestHomes(source)
	if getUserId then 
		local Consult = vRP.query("propertys/ExistPropertys2", { name = homes})

				
		if homes == "Hotel" then
			return "Hotel",Informations
		end

		if not Markers[homes] then
			return  "Corretor", Informations
		end

		for k,v in pairs(Consult) do 
			if (v["user_id"] == getUserId) then
				if os.time() > v["tax"] then 
					if vRP.request(source, "Hipoteca atrasada, deseja efetuar o pagamento?") then 
						if vRP.paymentFull(getUserId, Informations[v["interior"]]["Price"] * 0.1) then
							vRP.execute("propertys/tax", { name = Name })
							TriggerClientEvent("Notify", source, "amarelo", "Pagamento concluído.", 5000)
							return "Player", v
							
						end
					end
						
				else 
					v["tax"] = v["tax"] - os.time()
					return "Player", Consult
				end
			else
				return "Vizinho",Consult
			end
		end
	end
	return false
end
local enterCoords = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Toggle")
AddEventHandler("propertys:Toggle", function(coords,bucket)
	local source = source
	local getUserId = vRP.getUserId(source)
	
	if getUserId then
		if not Inside[getUserId] then
			if bucket then
				Inside[getUserId] = bucket
				TriggerEvent("vRP:BucketServer", source, bucket)
				if (coords) then
					enterCoords[source] = coords
				end
			else
				Inside[getUserId] = getUserId
				TriggerEvent("vRP:BucketServer", source, getUserId)
				if (coords) then
					enterCoords[source] = coords
				end
			end
		else
			Inside[getUserId] = nil
			enterCoords[source] = nil
			TriggerEvent("vRP:BucketServer", source, 0)
		end
	end
end)

RegisterServerEvent("vRP:BucketServer")
AddEventHandler("vRP:BucketServer", function(source, Router)
	local source = source
	if (Router) then
		SetPlayerRoutingBucket(source, Router)
	else
		SetPlayerRoutingBucket(source, 0)
	end
end)


RegisterServerEvent("fx:RouberysProperty")
AddEventHandler("fx:RouberysProperty",function (source,Name)

	TriggerClientEvent("propertys:RouberysEnter",source,Name)
	
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Buy")
AddEventHandler("propertys:Buy", function(Name)
	local source = source
	local Split = splitString(Name, "-")
	local getUserId = vRP.getUserId(source)
	if getUserId then
		local Name = Split[1]
		local Interior = Split[2] 

		local Consult = vRP.Query("propertys/Exist", { id = getUserId })
		if Consult == nil then
			TriggerClientEvent("dynamic:closeSystem", source)

			if vRP.request(source, "Deseja comprar a propriedade?") then
				if vRP.paymentFull(getUserId, Informations[Interior]["Price"]) then
					Markers[Name] = true
					TriggerClientEvent("propertys:Markers", -1, Markers)
					TriggerEvent("fx:updateHomes")
					vRP.execute("propertys/Buy",
						{
							name = Name,
							interior = Interior,
							user_id = getUserId, 
							price = Informations[Interior]["Price"],
							vault = Informations[Interior]["Vault"],
							fridge = Informations[Interior]["Fridge"],
							tax = os.time() + 2592000,
							owner = 1,
						})
						
						local Query = vRP.query("propertys/ExistPropertys",{user_id = getUserId, name = "Hotel"})
				
						if #Query > 0 then 
							vRP.execute("propertys/SellHotel",{
								user_id = getUserId,
								name = "Hotel"
							})
							TriggerClientEvent("Notify",source,"important","Atenção","Voce acabou de perder seu apartamento.","amarelo",3000)
						end
				else
					TriggerClientEvent("Notify", source, "cancel","Negado", "<b>Dólares</b> insuficientes.","vermelho", 5000)
				end
			end
		end
	end
end)






RegisterServerEvent("propertys:enterHomeUser")
AddEventHandler("propertys:enterHomeUser",function(interior)
	TriggerEvent("dynamic:closeSystem")
	local source = source
	local user_id = vRP.getUserId(source)
	local Consult = vRP.query("propertys/ExistPropertys2", { name = interior })

	if (Lock[interior] == nil) then
		TriggerClientEvent("Notify", source, "important","Atenção", "Propriedade trancada.","amarelo", 5000)
	else
		TriggerClientEvent("propertys:Enter", source, interior, Consult[1]['user_id'])
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Lock")
AddEventHandler("propertys:Lock", function(Name)
	local source = source
	local getUserId = vRP.getUserId(source)
	if getUserId then
		local Consult = vRP.query("propertys/Exist", { user_id = getUserId })
		if Consult[1] then 
			if (parseInt(Consult[1]["user_id"]) == getUserId) then
				if Lock[Name] then
					Lock[Name] = nil
					TriggerClientEvent("Notify", source, "important","Atenção", "Propriedade trancada.","amarelo", 5000)
				else
					TriggerClientEvent("Notify", source, "important","Atenção", "Propriedade destrancada.","amarelo", 5000)
					Lock[Name] = true
				end
			end
		end
	end
end)


local roubedRunTime = {}

RegisterServerEvent("fx:roubedRunTime")
AddEventHandler("fx:roubedRunTime",function(name)
	local source = source 
	local user_id = vRP.getUserId(source)
	roubedRunTime[user_id] = name
	TriggerClientEvent("fx:alimentHouseRoubed",source,roubedRunTime[user_id])
end)


RegisterServerEvent("fx:finishRoubed")
AddEventHandler("fx:finishRoubed", function(name)
	local source = source 
	local user_id = vRP.getUserId(source)
	if(roubedRunTime[user_id] == name) then
		roubedRunTime[user_id] = nil
	end

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:SELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Sell")
AddEventHandler("propertys:Sell", function(Name)
	local source = source
	local getUserId = vRP.getUserId(source)
	local home = nearestHomes(source)
	if home then
		
		if getUserId then
			local Consult = vRP.query("propertys/ExistPropertys", { user_id = getUserId,name = home })
			if Consult[1] then
				if parseInt(Consult[1]["user_id"]) == getUserId then
					TriggerClientEvent("dynamic:closeSystem", source)
	
					if vRP.request(source, "Deseja vender a propriedade? por R$"..Informations[Consult[1]["interior"]]["Price"] * 0.75) then
						if Markers[Name] then
							Markers[Name] = nil
							TriggerClientEvent("propertys:Markers", -1, Markers)
						end
	
						vRP.remSrvdata("vault:" .. getUserId)
						vRP.remSrvdata("fridge:" .. getUserId)
						vRP.execute("propertys/Sell",{name = home})
						TriggerEvent("garages:removeGarages", Consult[1]["name"])
	
						TriggerEvent("fx:updateHomes")
						TriggerClientEvent("Notify", source, "important","Atenção", "Venda concluída.","amarelo", 5000)
						vRP.addBank(getUserId, Informations[Consult[1]["interior"]]["Price"] * 0.75)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CREDENTIALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Credentials")
AddEventHandler("propertys:Credentials", function(Name)
	local source = source
	local getUserId = vRP.getUserId(source)
	if getUserId then
		local Consult = vRP.query("propertys/Exist", { user_id = getUserId })
		if Consult[1] then
			if parseInt(Consult[1]["getUserId"]) == getUserId then
				TriggerClientEvent("dynamic:closeSystem", source)

				if vRP.Request(source, "Você escolheu reconfigurar todos os cartões de segurança, lembrando que ao prosseguir todos os cartões vão deixar de funcionar, deseja prosseguir?", "Sim, prosseguir", "Não, outra hora") then
					local Serial = PropertysSerials()
					vRP.Query("propertys/Credentials", { name = Name, serial = Serial })
					vRP.generateItem(getUserId, "propertys-" .. Serial, Consult[1]["Keys"], true)
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES FX
-----------------------------------------------------------------------------------------------------------------------------------------

vRP.prepare("fx:clothesdata/fx:createData", [[
	CREATE TABLE IF NOT EXISTS `fx_clothesdata` (
		`id` INT NOT NULL AUTO_INCREMENT,
		`user_id` INT NOT NULL DEFAULT '0',
		`nameClothes` VARCHAR(50) NOT NULL DEFAULT '0',
		`clothes` TEXT NOT NULL,
		PRIMARY KEY (`id`)
	)

]])
vRP.prepare("fx:clothesdata/fx:removeData",
	"DELETE  FROM fx_clothesdata WHERE user_id = @user_id AND nameClothes = @nameClothes")
vRP.prepare("fx:clothesdata/fx:getData", "SELECT * FROM fx_clothesdata   WHERE user_id = @user_id")
vRP.prepare("fx:clothesdata/fx:getDataClothes", "SELECT clothes FROM fx_clothesdata   WHERE nameClothes = @nameClothes")
vRP.prepare("fx:clothesdata/fx:getDataNameClothes", "SELECT nameClothes FROM fx_clothesdata   WHERE user_id = @user_id")
vRP.prepare("fx:clothesdata/fx:setData",
	"INSERT INTO fx_clothesdata(user_id,nameClothes,clothes) VALUES(@user_id,@nameClothes,@clothes)")

CreateThread(function() vRP.execute("fx:clothesdata/fx:createData") end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Clothes()
	local source = source
	local getUserId = vRP.getUserId(source)
	if getUserId then
		local Clothes = {}
		local Consult = vRP.query("fx:clothesdata/fx:getData", { user_id = getUserId })

		for i = 1, #Consult, 1 do
			Clothes[i] = { ["name"] = Consult[i]["nameClothes"] }
		end

		return Clothes
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------

local insertsNames = {}

RegisterServerEvent("propertys:Clothes")
AddEventHandler("propertys:Clothes", function(Mode)
	local source = source
	local getUserId = vRP.getUserId(source)
	if getUserId then
		local Split = splitString(Mode, "-")
		local Consult = vRP.query("fx:clothesdata/fx:getData", { user_id = getUserId })
		local ConsultName = vRP.query("fx:clothesdata/fx:getDataNameClothes", { user_id = getUserId })
		if not insertsNames[getUserId] then
			insertsNames[getUserId] = {}
		end

		for i = 1, #Consult, 1 do
			insertsNames[getUserId] = { ["name"] = Consult[i]["nameClothes"] }
		end



		if Mode == "save" then
			if Consult[1] == nil then
				local Keyboard = vRP.prompt(source, "Nome:","","")
				if Keyboard then
					local Name = Keyboard
					local clothe = vSKINSHOP.getCustomization(source)

					vRP.execute("fx:clothesdata/fx:setData",
						{ user_id = getUserId, nameClothes = Name, clothes = json.encode(clothe) })
					TriggerClientEvent("propertys:ClothesReset", source)
					TriggerClientEvent("Notify", source, "verde", "<b>" .. Name .. "</b> adicionado.", 5000)
					return
				end
			else
				local Keyboard = vRP.prompt(source, "Nome:","","")
				if Keyboard then
					local Name = Keyboard
					for k, v in pairs(insertsNames) do
						if v["name"] ~= Name then
							local clothe = vSKINSHOP.getCustomization(source)
							vRP.execute("fx:clothesdata/fx:setData",
								{ user_id = getUserId, nameClothes = Name, clothes = json.encode(clothe) })
							TriggerClientEvent("propertys:ClothesReset", source)
							TriggerClientEvent("Notify", source, "verde",
								"<b>" .. Name .. "</b> adicionado.", 5000)
						else
							TriggerClientEvent("Notify", source, "amarelo",
								"Nome escolhido já existe em seu armário.", 5000)
							return
						end
					end
				end
			end
		end
		if Split[1] == "delete" then
			for k, v in pairs(ConsultName) do
				if v["nameClothes"] == Split[2] then
					vRP.execute("fx:clothesdata/fx:removeData", { user_id = getUserId, nameClothes = Split[2] })
					TriggerClientEvent("propertys:ClothesReset", source)
					--TriggerClientEvent("Notify", source, "verde", "<b>" .. Name .. "</b> removido.", 5000)
				else
					--TriggerClientEvent("Notify", source, "amarelo","A vestimenta salva não se encontra mais em seu armário.", 5000)
				end
			end
		end
		if Split[1] == "apply" then
			for k, v in pairs(ConsultName) do
				if v["nameClothes"] == Split[2] then
					local clothesdB = vRP.query("fx:clothesdata/fx:getDataClothes", { nameClothes = Split[2] })

					local decodeClothes = json.decode(clothesdB[1]["clothes"])

					TriggerClientEvent("skinshop:apply", source, decodeClothes)
					--TriggerClientEvent("Notify", source, "verde", "<b>" .. Consult["name"] .. "</b> aplicado.", 5000)
				else
					--TriggerClientEvent("Notify", source, "amarelo","A vestimenta salva não se encontra mais em seu armário.", 5000)
				end
			end
		end
	end
end)


RegisterCommand("homes", function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		insertsNames[user_id] = nil
	end
end)







-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYSSERIALS
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertysSerials()
	local Serial = vRP.GenerateString("LDLDLDLDLD")
	local Consult = vRP.Query("propertys/Serial", { serial = Serial })
	if Consult[1] then
		PropertysSerials()
	end

	return Serial
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.OpenChest(Name, Mode)
	local source = source
	local getUserId = vRP.getUserId(source)
	if getUserId then
		local Chest = {}
		local Inventory = {}
		local Inv = vRP.userInventory(getUserId)

		local Owner = vRP.query("propertys/ExistPropertys", { user_id = getUserId , name = Name })
		
		local Consult = vRP.getSrvdata(Mode .. ":" ..Name.."-"..Owner[1]['user_id'])
		for k, v in pairs(Inv) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["type"] = itemType(v["item"])
			v["slot"] = k

			local Split = splitString(v["item"], "-")
			if Split[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			Inventory[k] = v
		end


		for k, v in pairs(Consult) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["type"] = itemType(v["item"])
			v["slot"] = k

			local Split = splitString(v["item"], "-")
			if Split[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end
			Chest[k] = v
		end

		local Exist = vRP.query("propertys/Exist", { user_id = getUserId })
		if Exist[1] then
			return Inventory, Chest, vRP.inventoryWeight(getUserId), vRP.getWeight(getUserId),
			    vRP.chestWeight(Consult), Exist[1][Mode]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
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
	["cupcake"] = true,
	["milkshake"] = true,
	["cappuccino"] = true
}

function Creative.Store(Item, Slot, Amount, Target, Name, Mode)
	local source = source
	local Amount = parseInt(Amount)
	local getUserId = vRP.getUserId(source)
	local Owner = vRP.query("propertys/ExistPropertys", { user_id = getUserId , name = Name })
	if getUserId then
		if Amount <= 0 then Amount = 1 end

		--[[ if itemBlock(Item) then
			TriggerClientEvent("propertys:Update", source)
			return
		end ]]

		local Consult = vRP.query("propertys/Exist", { user_id = getUserId })

		if Consult[1] then
			if Item == "diagram" then
				if vRP.TakeItem(getUserId, Item, Amount, false, Slot) then
					vRP.query("propertys/" .. Mode, { name = Name, weight = 10 * Amount })
					TriggerClientEvent("propertys:Update", source)
				end
			else 
				
				if vRP.storeChest(getUserId,Mode .. ":" ..Name.."-"..Owner[1]['user_id'], Amount, Consult[1][Mode], Slot, Target) then
					TriggerClientEvent("propertys:Update", source)
				else
					local Result = vRP.getSrvdata(Mode .. ":" ..Name.."-"..Owner[1]['user_id'])
					TriggerClientEvent("propertys:Weight", source, vRP.inventoryWeight(getUserId),
						vRP.getWeight(getUserId), vRP.chestWeight(Result), Consult[1][Mode])
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Slot, Amount, Target, Name, Mode)
	local source = source
	local Amount = parseInt(Amount)
	local getUserId = vRP.getUserId(source)
	local Owner = vRP.query("propertys/ExistPropertys", { user_id = getUserId , name = Name })
	if getUserId then
		if Amount <= 0 then Amount = 1 end
		if vRP.tryChest(getUserId, Mode .. ":" ..Name.."-"..Owner[1]['user_id'], Amount, Slot, Target) then
			TriggerClientEvent("propertys:Update", source)
		else
			local Consult = vRP.query("propertys/Exist", { user_id = getUserId })
			if Consult[1] then
				local Result = vRP.getSrvdata(Mode .. ":" ..Name.."-"..Owner[1]['user_id'])

				TriggerClientEvent("propertys:Weight", source, vRP.inventoryWeight(getUserId),
					vRP.getWeight(getUserId), vRP.chestWeight(Result), Consult[1][Mode])
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Slot, Target, Amount, Name, Mode)
	local source = source
	local Amount = parseInt(Amount)
	local getUserId = vRP.getUserId(source)
	local Owner = vRP.query("propertys/ExistPropertys2", { name = Name })
	if getUserId then
		if Amount <= 0 then Amount = 1 end

		if vRP.UpdateChest(getUserId, Mode .. ":" ..Name.."-"..Owner[1]['user_id'], Slot, Target, Amount) then
			TriggerClientEvent("propertys:Update", source)
		end
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTf
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	TriggerClientEvent("propertys:Table",-1, Propertys, Interiors, Markers)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped", function(getUserId)
	if Inside[getUserId] then
		vRP.InsidePropertys(getUserId, Propertys[Inside[getUserId]])
		Inside[getUserId] = nil
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------

local actived = {}
AddEventHandler("CharacterChosen", function(getUserId, source)
	local Consult = vRP.Query("propertys/AllUser", { getUserId = getUserId })
	if Consult[1] then
		local Tables = {}

		for _, v in pairs(Consult) do
			local Name = v["Name"]
			if Propertys[Name] then
				Tables[#Tables + 1] = { ["Coords"] = Propertys[Name] }
			end
		end

		TriggerClientEvent("spawn:Increment", source, Tables)
	end
end)
function nearestHomes(source)
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)

	for k, v in pairs(Propertys) do
		local distance = #(coords - vec3(v[1], v[2], v[3]))
		if distance <= 1.5 then
			return k
		end
	end

	return false
end

exports("nearestHomes",nearestHomes)

RegisterServerEvent("homes:invokeSystem")
AddEventHandler("homes:invokeSystem", function(mode)
	local source = source
	local homeName = nearestHomes(source)
	if homeName then
		local user_id = vRP.getUserId(source)
		if user_id and actived[user_id] == nil then
			actived[user_id] = true

			local consult = vRP.query("propertys/userPermissions", { name = homeName, user_id = user_id })

			if consult[1] ~= nil then
				if mode == "garagem" and consult[1]["owner"] >= 1 and homeName ~= "Container" then
					if vRP.request(source, "Adicionar uma garagem por <b>$50.000</b> dólares?") then
						local userPermissions = vRP.query("propertys/userPermissions",
							{ name = homeName, user_id = user_id })
						if userPermissions[1] then
							if vRP.paymentFull(user_id, 50000) then
								TriggerClientEvent("Notify", source, "important","Atenção","Fique no local onde vai abrir a garagem e pressione a tecla <b>E</b>.", "amarelo",10000)
								vCLIENT.homeGarage(source, homeName)
							else
								TriggerClientEvent("Notify", source, "vermelho",
									"<b>Dólares</b> insuficientes.", 5000)
							end
						end
					end
				elseif mode == "checar" then
					local checkExist = vRP.query("propertys/permissions", { name = homeName })
					if checkExist[1] then
						local permList = ""
						for k, v in pairs(checkExist) do
							local identity = vRP.userIdentity(v["user_id"])
							if identity then
								permList = permList ..
								    "<b>Nome:</b> " ..
								    identity["name"] ..
								    " " .. identity["name2"] .. "   -   <b>Passaporte:</b> " ..
								    v["user_id"]

								if k ~= #checkExist then
									permList = permList .. "<br>"
								end
							end
						end

						TriggerClientEvent("Notify", source, "azul",
							"Lista de permissões da(o): <br>" .. permList, 20000)
					end
				elseif mode == "armario" then
					if vRP.request(source, "Aumentar o armário por <b>$10.000</b> dólares?") then
						local userPermissions = vRP.query("propertys/userPermissions",
							{ name = homeName, user_id = user_id })
						if userPermissions[1] then
							if vRP.paymentFull(user_id, 10000) then
								vRP.execute("propertys/updateVault", { name = homeName })
								TriggerClientEvent("Notify", source, "verde", "Compra efetuada.", 5000)
							else
								TriggerClientEvent("Notify", source, "vermelho",
									"<b>Dólares</b> insuficientes.", 5000)
							end
						end
					end
				elseif mode == "geladeira" then
					if vRP.request(source, "Aumentar a geladeira por <b>$10.000</b> dólares?") then
						local userPermissions = vRP.query("propertys/userPermissions",
							{ name = homeName, user_id = user_id })
						if userPermissions[1] then
							if vRP.paymentFull(user_id, 10000) then
								vRP.execute("propertys/updateFridge", { name = homeName })
								TriggerClientEvent("Notify", source, "verde", "Compra efetuada.", 5000)
							else
								TriggerClientEvent("Notify", source, "vermelho",
									"<b>Dólares</b> insuficientes.", 5000)
							end
						end
					end
				end
			end

			actived[user_id] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.paymentTheft(mobile)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policeResult = vRP.numPermission("Police")
		local randItem = math.random(#mobileTheft[mobile])
		local value = math.random(mobileTheft[mobile][randItem]["min"],mobileTheft[mobile][randItem]["max"])
		
		if (vRP.inventoryWeight(user_id) + (itemWeight(mobileTheft[mobile][randItem]["item"]) * parseInt(value))) <= vRP.getWeight(user_id) then
			if parseInt(#policeResult) >= 0 then
				if math.random(0,100) <= 40 then
					vRP.generateItem(user_id,mobileTheft[mobile][randItem]["item"],parseInt(value),true)
					TriggerClientEvent("player:applyGsr",source)
				else
					TriggerClientEvent("Notify",source,"important","Atenção","Compartimento vazio.","amarelo",5000)
				end
			else
				if math.random(0,100) <= 80 then
					vRP.generateItem(user_id,mobileTheft[mobile][randItem]["item"],parseInt(value),true)
					TriggerClientEvent("player:applyGsr",source)
				else
					TriggerClientEvent("Notify",source,"important","Atenção","Compartimento vazio.","amarelo",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
		end

		vRP.upgradeStress(user_id,1)

		if math.random(1000) >= 950 then
			TriggerEvent("Wanted",source,user_id,120)
			TriggerClientEvent("homes:UpdateCalled",source)
			TriggerClientEvent("sounds:source",source,"alarm",0.5)

			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			for k,v in pairs(policeResult) do
				async(function()
					TriggerClientEvent("NotifyPush",v,{ code = 90, title = "Roubo de Propriedade", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 43 })
				end)
			end
		end
		
	end
end

function Creative.AlertPoliceInRobberyHouse()
	if math.random(1000) >= 950 then
		TriggerEvent("Wanted",source,user_id,120)
		TriggerClientEvent("homes:UpdateCalled",source)
		TriggerClientEvent("sounds:source",source,"alarm",0.5)

		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)

		for k,v in pairs(policeResult) do
			async(function()
				TriggerClientEvent("NotifyPush",v,{ code = 90, title = "Roubo de Propriedade", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 43 })
			end)
		end
	end
end


exports("homesTheft",function(source)
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)

	for homeName,v in pairs(Propertys) do
		local distance = #(coords - vec3(v[1],v[2],v[3]))
		if distance <= 1.5 then
			return homeName
		end
	end

	return false
end)

exports("resetTheft",function(homeName)
	theftTimers[homeName] = nil
end)

function Creative.callPolice(coords)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		
		local policeResult = vRP.numPermission("Police")
		if(#policeResult > 0 ) then
			TriggerClientEvent("sounds:source",source,"alarm",1.0)
		end
		for k,v in pairs(policeResult) do
			async(function()
				TriggerClientEvent("NotifyPush",v,{ code = 90, title = "Roubo de Propriedade", x = coords[1], y = coords[2], z = coords[3], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 43 })
			end)
		end
	end
end

function Creative.checkHotel()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local Consult = vRP.query("propertys/Exist", { user_id = user_id })
		if #Consult > 1 then 
			TriggerClientEvent("Notify",source,"important","Atenção","Sua corretora passou aqui para pegar seus imoveis para sua nova casa","amarelo",15000)
			return false
		end
		local Query = vRP.query("propertys/ExistPropertys",{user_id = user_id, name = "Hotel"})
		if Query[1] == nil then 
			vRP.execute("propertys/Buy",
			{
				name = "Hotel",
				interior = "Hotel",
				user_id = user_id, 
				price = "",
				vault = Informations["Hotel"]["Vault"],
				fridge = Informations["Hotel"]["Fridge"],
				tax =0,
				owner = 1,
			})
			TriggerClientEvent("Notify",source,"check","Parabens","Voce acabou de alugar um apartamento.","verde",3000)

			return true
		end
	
		return true
	end
end

RegisterServerEvent("homes:invadeSystem")
AddEventHandler("homes:invadeSystem",function()
	local source = source
	local homeName = nearestHomes(source)
	if homeName then
		local user_id = vRP.getUserId(source)
		if user_id then
			if vRP.hasGroup(user_id,"Police") then
				TriggerClientEvent("propertys:PoliceEnter",source,homeName)
			end
		end
	end
end)

AddEventHandler("playerDisconnect",function(user_id, source)
	if (enterCoords[source]) then
		Wait(5000)
		vRP.execute("playerdata/setUserdata", { user_id = user_id, key = "Position", value = json.encode({ x = mathLegth(enterCoords[source]["x"]), y = mathLegth(enterCoords[source]["y"]), z = mathLegth(enterCoords[source]["z"]) })})
	end

	if user_id then
		Inside[user_id] = nil
		enterCoords[source] = nil
	end
	TriggerEvent("vRP:BucketServer", source, 0)
end)
