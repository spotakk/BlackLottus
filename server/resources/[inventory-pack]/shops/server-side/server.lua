-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------

cRP = {}

Tunnel.bindInterface("shops", cRP)

vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------

local shops = {
	["weedShop"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["silk"] = 3
		}
	},
	["Lesterilegal"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["notepad"] = 3,
			["keyboard"] = 30,
			["mouse"] = 55,
			["watch"] = 30,
			["playstation"] = 55,
			["xbox"] = 95,
			["legos"] = 3,
			["ominitrix"] = 30,
			["bracelet"] = 55,
			["dildo"] = 95,
			["alicate"] = 3
		}
	},
	["Ilegal"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["silk"] = 3,
			["weedseed"] = 30,
			["cokeseed"] = 55,
			["mushseed"] = 95
		}
	},
	["lixodp"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["notepad"] = 5,
			["keyboard"] = 5,
			["mouse"] = 5,
			["watch"] = 5,
			["playstation"] = 5,
			["xbox"] = 5,
			["legos"] = 5,
			["ominitrix"] = 5,
			["bracelet"] = 5,
			["dildo"] = 5,
			["alicate"] = 5
		}
	},
	["Fuel"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_PETROLCAN_AMMO"] = 1,
			["WEAPON_PETROLCAN"] = 500
		}
	},
	["maconhapub"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["bucket"] = 30,
			["compost"] = 55,
			["cannabisseed"] = 95
		}
	},
	["Mechanic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["tyres"] = 250,
			["toolbox"] = 500,
			["WEAPON_CROWBAR"] = 750,
			["WEAPON_WRENCH"] = 750
		}
	},
	["credential"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["credential"] = 500
		}
	},
	["Imoveis"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["contract1"] = 125000,
			["contract2"] = 300000,
			["contract3"] = 75000,
			["contract4"] = 175000,
			["contract5"] = 125000,
			["contract6"] = 250000,
			["contract7"] = 75000,
			["contract8"] = 250000,
			["contract9"] = 175000,
			["contract10"] = 100000
		}
	},
	["Colheita"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["tomato"] = 40,
			["banana"] = 80,
			["passion"] = 60,
			["grape"] = 75,
			["tange"] = 80,
			["orange"] = 40,
			["apple"] = 55,
			["strawberry"] = 100
		}
	},
	["Identity"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 500
		}
	},
	["Identity2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["fidentity"] = 10000
		}
	},
	["Petz"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["rottweiler"] = 25000,
			["husky"] = 25000,
			["shepherd"] = 25000,
			["retriever"] = 25000,
			["poodle"] = 25000,
			["pug"] = 25000,
			["westy"] = 25000,
			["cat"] = 25000
		}
	},
	["Departament"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["notepad"] = 10,
			["energetic"] = 200,
			["emptybottle"] = 30,
			["cigarette"] = 10,
			["lighter"] = 200,
			["chocolate"] = 15,
			["coffee"] = 100,
			["sandwich"] = 100,
			["water"] = 100,
			["backpack"] = 5000
		}
	},
	["MegaMall"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["teddy"] = 75,
			["WEAPON_BRICK"] = 25,
			["postit"] = 20,
			["rope"] = 1000,
			["emptybottle"] = 50,
			["cigarette"] = 20,
			["lighter"] = 200,
			["teddy"] = 500,
			["rose"] = 50,
			["silk"] = 3,
			["saquinho"] = 3,
			["firecracker"] = 300,
			["campfire"] = 3000,
			["chair01"] = 500,
			["tyres"] = 500,
			["toolbox"] = 1000
		}
	},
	["MegaMall2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["teddy"] = 75,
			["WEAPON_BRICK"] = 25,
			["postit"] = 20,
			["rope"] = 2500,
			["emptybottle"] = 50,
			["cigarette"] = 20,
			["lighter"] = 200,
			["teddy"] = 500,
			["rose"] = 50,
			["silk"] = 3,
			["firecracker"] = 300,
			["campfire"] = 3000,
			["chair01"] = 500
		}
	},
	["Eletronicos"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["radio"] = 2000,
			["cellphone"] = 2000,
			["vape"] = 3500
		}
	},
	["hk"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_SNSPISTOL"] = 30000
		}
	},
	["Mechanic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["tyres"] = 225,
			["toolbox"] = 625,
			["advtoolbox"] = 1525,
			["WEAPON_CROWBAR"] = 725,
			["WEAPON_WRENCH"] = 725
		}
	},
	["Weapons"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["pistolbody"] = 425,
			["smgbody"] = 525,
			["riflebody"] = 625
		}
	},
	["Oxy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["oxy"] = 35
		}
	},
	["Pharmacy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["analgesic"] = 125,
			["gauze"] = 450,
			["bandage"] = 500
		}
	},
	["Paramedic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["badge02"] = 10,
			["gauze"] = 70,
			["bandage"] = 100,
			["medkit"] = 150,
			["adrenaline"] = 300,
			["gdtkit"] = 20,
			["analgesic"] = 20,
			["sinkalmy"] = 325,
			["ritmoneury"] = 425,
			["wheelchair"] = 250,
			["medicbag"] = 100,
			["barrier"] = 50,
			["syringe"] = 10,
			["syringe01"] = 10,
			["syringe02"] = 10,
			["syringe03"] = 10,
			["syringe04"] = 10
		}
	},
	["Ammunation"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["GADGET_PARACHUTE"] = 2000,
			["WEAPON_HATCHET"] = 4000,
			["WEAPON_BAT"] = 4000,
			["WEAPON_BATTLEAXE"] = 4000,
			["WEAPON_GOLFCLUB"] = 4000,
			["WEAPON_HAMMER"] = 4000,
			["WEAPON_MACHETE"] = 4000,
			["WEAPON_POOLCUE"] = 4000,
			["WEAPON_STONE_HATCHET"] = 4000,
			["WEAPON_KNUCKLE"] = 1000,
			["WEAPON_FLASHLIGHT"] = 1000,
			["WEAPON_WRENCH"] = 2000,
			["WEAPON_CROWBAR"] = 2000
		}
	},
	["Premium"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["list"] = {
			["chip"] = 25,
			["premiumplate"] = 50,
			["spotify"] = 50,
			["newgarage"] = 30,
			["newchars"] = 50,
			["namechange"] = 50,

			["bronzepremium"] = 50,
			["pratapremium"] = 100,
			["goldpremium"] = 150,
		}
	},
	["Fishing"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["octopus"] = 20,
			["shrimp"] = 20,
			["carp"] = 18,
			["horsefish"] = 18,
			["tilapia"] = 20,
			["codfish"] = 22,
			["catfish"] = 22,
			["goldenfish"] = 24,
			["pirarucu"] = 24,
			["pacu"] = 24,
			["tambaqui"] = 24
		}
	},
	["Fishing2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["bait"] = 5,
			["fishingrod"] = 725
		}
	},
	["Burguershot"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger2"] = 500,
			["hamburger3"] = 500,
			["hamburger4"] = 500,
			["hamburger5"] = 500,
			["orangejuice"] = 500,
			["bananajuice"] = 500,
			["strawberryjuice"] = 500,
			["grapejuice"] = 500
		}
	},
	["Hunting2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["switchblade"] = 525,
			["WEAPON_MUSKET"] = 30000,
			["WEAPON_MUSKET_AMMO"] = 7
		}
	},
	["Hunting"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["meat"] = 175,
			["animalpelt"] = 250,
			["coffee2"] = 6,
			["animalfat"] = 150,
			["leather"] = 25,
			["wheat"] = 15,
			["tomato"] = 40,
			["banana"] = 80,
			["passion"] = 60,
			["grape"] = 75,
			["tange"] = 80,
			["orange"] = 40,
			["apple"] = 55,
			["strawberry"] = 100
		}
	},
	["Recycle"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["notepad"] = 5,
			["plastic"] = 10,
			["glass"] = 10,
			["rubber"] = 10,
			["aluminum"] = 15,
			["copper"] = 15,
			["radio"] = 485,
			["rope"] = 435,
			["cellphone"] = 325,
			["binoculars"] = 135,
			["emptybottle"] = 15,
			["switchblade"] = 215,
			["camera"] = 135,
			["vape"] = 2375,
			["rose"] = 15,
			["lighter"] = 75,
			["teddy"] = 35,
			["tyres"] = 100,
			["bait"] = 2,
			["firecracker"] = 50,
			["fishingrod"] = 365,
			["silvercoin"] = 10,
			["goldcoin"] = 20,
			["techtrash"] = 60,
			["tarp"] = 20,
			["sheetmetal"] = 20,
			["roadsigns"] = 20,
			["explosives"] = 30,
			["codeine"] = 15,
			["amphetamine"] = 20,
			["acetone"] = 15,
			["cotton"] = 20,
			["plaster"] = 15,
			["sulfuric"] = 12,
			["saline"] = 20,
			["alcohol"] = 15,
			["pistolbody"] = 425,
			["smgbody"] = 525,
			["riflebody"] = 625
		}
	},
	["Miners"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["emerald"] = 85,
			["diamond"] = 75,
			["ruby"] = 55,
			["sapphire"] = 45,
			["amethyst"] = 35,
			["amber"] = 25,
			["turquoise"] = 15
		}
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 200
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cola"] = 150,
			["soda"] = 150
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["donut"] = 150,
			["chocolate"] = 150
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 150
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 150
		}
	},
	["Chihuahua"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 150,
			["hamburger"] = 150,
			["coffee"] = 150,
			["cola"] = 150,
			["soda"] = 150
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 150
		}
	},
	["Police"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["list"] = {
			["vest"] = 100,
			["gsrkit"] = 50,
			["gdtkit"] = 30,
			["barrier"] = 50,
			["attachsFlashlight"] = 300,
			["attachsCrosshair"] = 300,
			["attachsSilencer"] = 300,
			["attachsMagazine"] = 300,
			["attachsGrip"] = 300,
			["WEAPON_SMG"] = 300,
			["WEAPON_BARRET"] = 300,
			["WEAPON_PARAFAL"] = 300,
			["WEAPON_COLTXM177"] = 300,
			["handcuff"] = 50,
			["WEAPON_FNSCAR"] = 350,
			["WEAPON_PUMPSHOTGUN"] = 300,
			["WEAPON_CARBINERIFLE"] = 300,
			["WEAPON_SMOKEGRENADE"] = 75,
			["WEAPON_CARBINERIFLE_MK2"] = 300,
			["WEAPON_STUNGUN"] = 150,
			["WEAPON_COMBATPISTOL"] = 300,
			["WEAPON_HEAVYPISTOL"] = 300,
			["WEAPON_NIGHTSTICK"] = 50,
			["WEAPON_PISTOL_AMMO"] = 2,
			["WEAPON_SMG_AMMO"] = 2,
			["WEAPON_RIFLE_AMMO"] = 2,
			["WEAPON_SHOTGUN_AMMO"] = 2,
			["badge07"] = 5
		}
	},
	["Criminal"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["keyboard"] = 45,
			["mouse"] = 45,
			["playstation"] = 50,
			["xbox"] = 50,
			["dish"] = 45,
			["pan"] = 70,
			["fan"] = 45,
			["blender"] = 45,
			["switch"] = 20,
			["cup"] = 70,
			["lampshade"] = 60
		}
	},
	["Criminal2"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["silverring"] = 45,
			["goldring"] = 70,
			["watch"] = 50,
			["bracelet"] = 50,
			["dildo"] = 45,
			["spray01"] = 45,
			["spray02"] = 45,
			["spray03"] = 45,
			["spray04"] = 45,
			["slipper"] = 40,
			["rimel"] = 45,
			["brush"] = 45,
			["soap"] = 40
		}
	},
	["Criminal3"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["eraser"] = 40,
			["legos"] = 45,
			["ominitrix"] = 45,
			["dices"] = 20,
			["domino"] = 35,
			["floppy"] = 30,
			["horseshoe"] = 45,
			["deck"] = 40
		}
	},
	["Criminal4"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["goldbar"] = 450,
			["pliers"] = 40,
			["pager"] = 110,
			["card01"] = 275,
			["card02"] = 275,
			["card03"] = 300,
			["card04"] = 225,
			["card05"] = 315,
			["pendrive"] = 275
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMES
-----------------------------------------------------------------------------------------------------------------------------------------

local nameMale = {
	"James",
	"John",
	"Robert",
	"Michael",
	"William",
	"David",
	"Richard",
	"Charles",
	"Joseph",
	"Thomas",
	"Christopher",
	"Daniel",
	"Paul",
	"Mark",
	"Donald",
	"George",
	"Kenneth",
	"Steven",
	"Edward",
	"Brian",
	"Ronald",
	"Anthony",
	"Kevin",
	"Jason",
	"Matthew",
	"Gary",
	"Timothy",
	"Jose",
	"Larry",
	"Jeffrey",
	"Frank",
	"Scott",
	"Eric",
	"Stephen",
	"Andrew",
	"Raymond",
	"Gregory",
	"Joshua",
	"Jerry",
	"Dennis",
	"Walter",
	"Patrick",
	"Peter",
	"Harold",
	"Douglas",
	"Henry",
	"Carl",
	"Arthur",
	"Ryan",
	"Roger",
	"Joe",
	"Juan",
	"Jack",
	"Albert",
	"Jonathan",
	"Justin",
	"Terry",
	"Gerald",
	"Keith",
	"Samuel",
	"Willie",
	"Ralph",
	"Lawrence",
	"Nicholas",
	"Roy",
	"Benjamin",
	"Bruce",
	"Brandon",
	"Adam",
	"Harry",
	"Fred",
	"Wayne",
	"Billy",
	"Steve",
	"Louis",
	"Jeremy",
	"Aaron",
	"Randy",
	"Howard",
	"Eugene",
	"Carlos",
	"Russell",
	"Bobby",
	"Victor",
	"Martin",
	"Ernest",
	"Phillip",
	"Todd",
	"Jesse",
	"Craig",
	"Alan",
	"Shawn",
	"Clarence",
	"Sean",
	"Philip",
	"Chris",
	"Johnny",
	"Earl",
	"Jimmy",
	"Antonio"
}

local nameFemale = {
	"Mary",
	"Patricia",
	"Linda",
	"Barbara",
	"Elizabeth",
	"Jennifer",
	"Maria",
	"Susan",
	"Margaret",
	"Dorothy",
	"Lisa",
	"Nancy",
	"Karen",
	"Betty",
	"Helen",
	"Sandra",
	"Donna",
	"Carol",
	"Ruth",
	"Sharon",
	"Michelle",
	"Laura",
	"Sarah",
	"Kimberly",
	"Deborah",
	"Jessica",
	"Shirley",
	"Cynthia",
	"Angela",
	"Melissa",
	"Brenda",
	"Amy",
	"Anna",
	"Rebecca",
	"Virginia",
	"Kathleen",
	"Pamela",
	"Martha",
	"Debra",
	"Amanda",
	"Stephanie",
	"Carolyn",
	"Christine",
	"Marie",
	"Janet",
	"Catherine",
	"Frances",
	"Ann",
	"Joyce",
	"Diane",
	"Alice",
	"Julie",
	"Heather",
	"Teresa",
	"Doris",
	"Gloria",
	"Evelyn",
	"Jean",
	"Cheryl",
	"Mildred",
	"Katherine",
	"Joan",
	"Ashley",
	"Judith",
	"Rose",
	"Janice",
	"Kelly",
	"Nicole",
	"Judy",
	"Christina",
	"Kathy",
	"Theresa",
	"Beverly",
	"Denise",
	"Tammy",
	"Irene",
	"Jane",
	"Lori",
	"Rachel",
	"Marilyn",
	"Andrea",
	"Kathryn",
	"Louise",
	"Sara",
	"Anne",
	"Jacqueline",
	"Wanda",
	"Bonnie",
	"Julia",
	"Ruby",
	"Lois",
	"Tina",
	"Phyllis",
	"Norma",
	"Paula",
	"Diana",
	"Annie",
	"Lillian",
	"Emily",
	"Robin"
}

local userName2 = {
	"Smith",
	"Johnson",
	"Williams",
	"Jones",
	"Brown",
	"Davis",
	"Miller",
	"Wilson",
	"Moore",
	"Taylor",
	"Anderson",
	"Thomas",
	"Jackson",
	"White",
	"Harris",
	"Martin",
	"Thompson",
	"Garcia",
	"Martinez",
	"Robinson",
	"Clark",
	"Rodriguez",
	"Lewis",
	"Lee",
	"Walker",
	"Hall",
	"Allen",
	"Young",
	"Hernandez",
	"King",
	"Wright",
	"Lopez",
	"Hill",
	"Scott",
	"Green",
	"Adams",
	"Baker",
	"Gonzalez",
	"Nelson",
	"Carter",
	"Mitchell",
	"Perez",
	"Roberts",
	"Turner",
	"Phillips",
	"Campbell",
	"Parker",
	"Evans",
	"Edwards",
	"Collins",
	"Stewart",
	"Sanchez",
	"Morris",
	"Rogers",
	"Reed",
	"Cook",
	"Morgan",
	"Bell",
	"Murphy",
	"Bailey",
	"Rivera",
	"Cooper",
	"Richardson",
	"Cox",
	"Howard",
	"Ward",
	"Torres",
	"Peterson",
	"Gray",
	"Ramirez",
	"James",
	"Watson",
	"Brooks",
	"Kelly",
	"Sanders",
	"Price",
	"Bennett",
	"Wood",
	"Barnes",
	"Ross",
	"Henderson",
	"Coleman",
	"Jenkins",
	"Perry",
	"Powell",
	"Long",
	"Patterson",
	"Hughes",
	"Flores",
	"Washington",
	"Butler",
	"Simmons",
	"Foster",
	"Gonzales",
	"Bryant",
	"Alexander",
	"Russell",
	"Griffin",
	"Diaz",
	"Hayes"
}

local userLocate = {
	"Sul",
	"Norte"
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify", source, "important", "Atenção", "Multas pendentes encontradas.", "amerelo", 5000)

			return false
		end

		if exports["hud_v2"]:Wanted(user_id, source) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasGroup(user_id, shops[shopType]["perm"]) then
				return false
			end
		end

		return true
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local shopSlots = 20
		local inventoryShop = {}

		for k, v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop, {
				key = k,
				price = parseInt(v),
				name = itemName(k),
				index = itemIndex(k),
				peso = itemWeight(k),
				type = itemType(k),
				max = itemMaxAmount(k),
				desc = itemDescription(k)
			})
		end

		local inventoryUser = {}
		local inventory = vRP.userInventory(user_id)

		for k, v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"], "-")

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

			inventoryUser[k] = v
		end

		if parseInt(#inventoryShop) > 20 then
			shopSlots = parseInt(#inventoryShop)
		end
		local identity = vRP.userIdentity(user_id)
		return inventoryShop, inventoryUser, vRP.inventoryWeight(user_id), vRP.getWeight(user_id), shopSlots,identity["name"].." "..identity["name2"],user_id
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getShopType(name)
	return shops[name]["mode"]
end

---------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionShops(shopType, shopItem, shopAmount, slot)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if shops[shopType] then
			if shopAmount == nil then
				shopAmount = 1
			end

			if shopAmount <= 0 then
				shopAmount = 1
			end

			local inventory = vRP.userInventory(user_id)

			if inventory[tostring(slot)] and inventory[tostring(slot)]["item"] == shopItem or inventory[tostring(slot)] == nil then
				if shops[shopType]["mode"] == "Buy" then
					if vRP.checkMaxItens(user_id, shopItem, shopAmount) then
						TriggerClientEvent("Notify", source, "important", "Atenção", "Limite atingido.", "amarelo", 3000)
						vCLIENT.updateShops(source, "requestShop")

						return
					end

					if vRP.inventoryWeight(user_id) + itemWeight(shopItem) * parseInt(shopAmount) <= vRP.getWeight(user_id) then
						if shops[shopType]["type"] == "Cash" then
							if shops[shopType]["list"][shopItem] then
								if vRP.paymentFull(user_id, shops[shopType]["list"][shopItem] * shopAmount) then
									if shopItem == "identity" or string.sub(shopItem, 1, 5) == "badge" then
										vRP.generateItem(user_id, shopItem .. "-" .. user_id, parseInt(shopAmount), false, slot)
									elseif shopItem == "fidentity" then
										local identity = vRP.userIdentity(user_id)

										if identity then
											if identity["sex"] == "M" then
												vRP.execute("fidentity/newIdentity", {
													name = nameMale[math.random(#nameMale)],
													name2 = userName2[math.random(#userName2)],
													locate = userLocate[math.random(#userLocate)],
													blood = math.random(4)
												})
											else
												vRP.execute("fidentity/newIdentity", {
													name = nameFemale[math.random(#nameFemale)],
													name2 = userName2[math.random(#userName2)],
													locate = userLocate[math.random(#userLocate)],
													blood = math.random(4)
												})
											end

											local identity = vRP.userIdentity(user_id)
											local consult = vRP.query("fidentity/lastIdentity")

											if consult[1] then
												vRP.generateItem(user_id, shopItem .. "-" .. consult[1]["id"], parseInt(shopAmount), false, slot)
											end
										end
									else
										vRP.generateItem(user_id, shopItem, parseInt(shopAmount), false, slot)
									end

									TriggerClientEvent("sounds:source", source, "cash", 0.1)
								else
									TriggerClientEvent("Notify", source, "cancel", "Negado", "Dólares insuficientes.", "vermelho", 3000)
								end
							end
						elseif shops[shopType]["type"] == "Consume" then
							if vRP.tryGetInventoryItem(user_id, shops[shopType]["item"], parseInt(shops[shopType]["list"][shopItem] * shopAmount)) then
								vRP.generateItem(user_id, shopItem, parseInt(shopAmount), false, slot)
								TriggerClientEvent("sounds:source", source, "cash", 0.1)
							else
								TriggerClientEvent("Notify", source, "cancel", "Negado", "" .. itemName(shops[shopType]["item"]) .. " insuficiente.", "vermelho", 3000)
							end
						elseif shops[shopType]["type"] == "Premium" then
							if vRP.paymentGems(user_id, shops[shopType]["list"][shopItem] * shopAmount) then
								TriggerClientEvent("sounds:source", source, "cash", 0.1)
								vRP.generateItem(user_id, shopItem, parseInt(shopAmount), false, slot)
								TriggerClientEvent("Notify", source, "check", "Sucesso", "Comprou " .. parseFormat(shopAmount) .. "x " .. itemName(shopItem) .. "por " .. parseFormat(shops[shopType]["list"][shopItem] * shopAmount) .. " Gemas.", "verde", 3000)
							else
								TriggerClientEvent("Notify", source, "cancel", "Negado", "<b>Gemas</b> insuficientes.", "verde", 3000)
							end
						end
					else
						TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
					end
				elseif shops[shopType]["mode"] == "Sell" then
					local splitName = splitString(shopItem, "-")

					if shops[shopType]["list"][splitName[1]] then
						local itemPrice = shops[shopType]["list"][splitName[1]]

						if itemPrice > 0 then
							if vRP.checkBroken(shopItem) then
								TriggerClientEvent("Notify", source, "cancel", "Negado", "Itens quebrados não podem ser vendidos.", "vermelho", 5000)
								vCLIENT.updateShops(source, "requestShop")

								return
							end
						end

						if shops[shopType]["type"] == "Cash" then
							if vRP.tryGetInventoryItem(user_id, shopItem, parseInt(shopAmount), true, slot) then
								if itemPrice > 0 then
									vRP.generateItem(user_id, "dollars", parseInt(itemPrice * shopAmount), false)
									TriggerClientEvent("sounds:source", source, "cash", 0.1)
								end
							end
						elseif shops[shopType]["type"] == "Consume" then
							if vRP.tryGetInventoryItem(user_id, shopItem, parseInt(shopAmount), true, slot) then
								if itemPrice > 0 then
									vRP.generateItem(user_id, shops[shopType]["item"], parseInt(itemPrice * shopAmount), false)
									TriggerClientEvent("sounds:source", source, "cash", 0.1)
								end
							end
						end
					end
				end
			end
		end

		vCLIENT.updateShops(source, "requestShop")
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot", function(nameItem, slot, target, amount)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if amount == nil then
			amount = 1
		end

		if amount <= 0 then
			amount = 1
		end

		if vRP.tryGetInventoryItem(user_id, nameItem, amount, false, slot) then
			vRP.giveInventoryItem(user_id, nameItem, amount, false, target)
			vCLIENT.updateShops(source, "requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot", function(nameItem, slot, target, amount)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if amount == nil then
			amount = 1
		end

		if amount <= 0 then
			amount = 1
		end

		local inventory = vRP.userInventory(user_id)

		if inventory[tostring(slot)] and inventory[tostring(target)] and inventory[tostring(slot)]["item"] == inventory[tostring(target)]["item"] then
			if vRP.tryGetInventoryItem(user_id, nameItem, amount, false, slot) then
				vRP.giveInventoryItem(user_id, nameItem, amount, false, target)
			end
		else
			vRP.swapSlot(user_id, slot, target)
		end

		vCLIENT.updateShops(source, "requestShop")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DIVINGSUIT
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("shops:divingSuit")
AddEventHandler("shops:divingSuit", function()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.request(source, "Comprar <b>Roupa de Mergulho</b> por <b>$975</b>?") then
			if vRP.paymentFull(user_id, 975) then
				vRP.generateItem(user_id, "divingsuit", 1, true)
			else
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Dólares insuficientes.", "vermelho", 3000)
			end
		end
	end
end)
