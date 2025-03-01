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
Tunnel.bindInterface("inventory",cRP)
vPLAYER = Tunnel.getInterface("coreP")
vGARAGE = Tunnel.getInterface("garages")
vTASKBAR = Tunnel.getInterface("taskbar")
vDELIVER = Tunnel.getInterface("deliver")
vPARAMEDIC = Tunnel.getInterface("paramedic")
vKEYBOARD = Tunnel.getInterface("keyboard")
vCLIENT = Tunnel.getInterface("inventory")
vWEPLANTS = Tunnel.getInterface("vrp_weplants")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Carry = {}
local Ammos = {}
local Loots = {}
local Boxes = {}
local Active = {}
local Trashs = {}
local Armors = {}
local Plates = {}
local Trunks = {}
local Objects = {}
local Healths = {}
local Animals = {}
local Attachs = {}
local Scanners = {}
local Stockade = {}
local userAmount = {}

local openIdentity = {}
local verifyObjects = {}
local verifyAnimals = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
local dismantleList = {}
local dismantleProgress = {}
local dismantleTimer = os.time()
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLEVEHS
-----------------------------------------------------------------------------------------------------------------------------------------
local dismantleVehs = {
	"baller","jackal","mule","youga","mesa","nemesis","primo","biff","bison","seminole","zion2","landstalker","panto",
	"boxville2","premier","scrap","rhapsody","pcj","jester","superd","sentinel","bus","sentinel2","blazer2","asea",
	"regina","pounder","huntley","tornado","rubble","tribike","bjxl","patriot","ingot","serrano","fq2","bobcatxl",
	"journey","bfinjection","sanchez2","surfer2","caddy2","rebel2","bagger","dilettante","blista","hexer",
	"buffalo","emperor2","fugitive","rocoto","dukes","thrust","faggio2","double","camper","massacro","feltzer2",
	"sabregt","ninef2","banshee","infernus","bullet","coquette","phoenix","cavalcade","stratum","minivan","picador",
	"taco","glendale","intruder","ruffian","schafter2","asterope","mixer2","rumpo","exemplar","surfer","cavalcade2",

	"panto","prairie","rhapsody","blista","dilettante","emperor2","emperor","bfinjection","ingot","regina",

	"asbo","brioso","club","weevil","felon","felon2","jackal","oracle","zion","zion2","buccaneer","virgo",
	"voodoo","bifta","rancherxl","bjxl","cavalcade","gresley","habanero","rocoto","primo","stratum","pigalle",
	"peyote","manana","streiter",

	"exemplar","windsor","windsor2","blade","clique","dominator","faction2","gauntlet","moonbeam","nightshade",
	"sabregt2","tampa","rebel","baller","cavalcade2","fq2","huntley","landstalker","patriot","radi","xls","blista2",
	"retinue","stingergt","surano","specter","sultan","schwarzer","schafter2","ruston","rapidgt","raiden","ninef",
	"ninef2","omnis","massacro","jester","feltzer2","futo","carbonizzare",

	"voltic","sc1","sultanrs","tempesta","nero","nero2","reaper","gp1","infernus","bullet","banshee2","turismo2","retinue",
	"mamba","infernus2","feltzer3","coquette2","futo2","zr350","tampa2","sugoi","sultan2","schlagen","penumbra","pariah",
	"paragon","jester3","gb200","elegy","furoregt",

	"zentorno","xa21","visione","vagner","vacca","turismor","t20","osiris","italigtb","entityxf","cheetah","autarch","sultan3",
	"cypher","vectre","growler","comet6","jester4","euros","calico","neon","kuruma","issi7","italigto","komoda","elegy2","coquette4",

	"mazdarx72","rangerover","civictyper","subaruimpreza","corvettec7","ferrariitalia","mustang1969","vwtouareg",
	"mercedesg65","bugattiatlantic","m8competition","audirs6","audir8","silvias15","camaro","mercedesamg63",
	"dodgechargerrt69","skyliner342","astonmartindbs","panameramansory","lamborghinihuracanlw","lancerevolutionx",
	"porsche911","jeepcherokee","dodgecharger1970","golfgti","subarubrz","nissangtr","mustangfast","golfmk7",
	"lancerevolution9","shelbygt500","ferrari812","bmwm4gts","ferrarif12","bmwm5e34","toyotasupra2","escalade2021",
	"fordmustang","mclarensenna","lamborghinihuracan","acuransx","toyotasupra","escaladegt900","bentleybacalar"
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:TABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local tableSelect = {}
local tableList = {
	["tablecoke"] = { 
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "sulfuric", ["amount"] = 1 },
			{ ["item"] = "cokeseed", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "cocaine", ["itemAmount"] = 3 }
	},
	["tablemeth"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "saline", ["amount"] = 1 },
			{ ["item"] = "acetone", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "meth", ["itemAmount"] = 3 }
	},
	["tableweed"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "bucket", ["amount"] = 1 },
			{ ["item"] = "cannabisseed", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "weed", ["itemAmount"] = 3 }
	},
	["tablelean"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "codeine", ["amount"] = 1 },
			{ ["item"] = "amphetamine", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "lean", ["itemAmount"] = 3 }
	},
	["tableoxy"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "analgesic", ["amount"] = 1 },
			{ ["item"] = "ritmoneury", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "oxy", ["itemAmount"] = 3 }
	},
	["foodJuice"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["item"] = "foodjuice", ["itemAmount"] = 1 }
	}, 
	["foodBurger"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "tomato", ["amount"] = 2 },
			{ ["item"] = "bread", ["amount"] = 2 },
			{ ["item"] = "carne", ["amount"] = 1 },
			{ ["item"] = "ketchup", ["amount"] = 3 },
		}, ["needAmount"] = 1, ["item"] = "foodbox", ["itemAmount"] = 1 }
	},
	["foodBox"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "foodburger", ["amount"] = 1 },
			{ ["item"] = "foodjuice", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "foodbox", ["itemAmount"] = 1 }
	},
	["milkBottle"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = "emptybottle", ["needAmount"] = 1,  ["item"] = "milkbottle", ["itemAmount"] = 1 }
	},
	["scanner"] = {
		[1] = { ["timer"] = 5, ["item"] = "sheetmetal", ["itemAmount"] = 1 },
		[2] = { ["timer"] = 5, ["item"] = "roadsigns", ["itemAmount"] = 1 },
		[3] = { ["timer"] = 5, ["item"] = "syringe", ["itemAmount"] = 1 },
		[4] = { ["timer"] = 5, ["item"] = "fishingrod", ["itemAmount"] = 1 },
		[5] = { ["timer"] = 5, ["item"] = "plate", ["itemAmount"] = 1 },
		[6] = { ["timer"] = 5, ["item"] = "aluminum", ["itemAmount"] = 1 },
		[7] = { ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 1 },
		[8] = { ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		[9] = { ["timer"] = 5, ["item"] = "battery", ["itemAmount"] = 1 },
		[10] = { ["timer"] = 5, ["item"] = "metalcan", ["itemAmount"] = 1 }
	},
	["cemitery"] = {
		[1] = { ["timer"] = 5, ["item"] = "silk", ["itemAmount"] = 1 },
		[2] = { ["timer"] = 5, ["item"] = "cotton", ["itemAmount"] = 1 },
		[3] = { ["timer"] = 5, ["item"] = "plaster", ["itemAmount"] = 1 },
		[4] = { ["timer"] = 5, ["item"] = "pouch", ["itemAmount"] = 1 },
		[5] = { ["timer"] = 5, ["item"] = "switchblade", ["itemAmount"] = 1 },
		[6] = { ["timer"] = 5, ["item"] = "joint", ["itemAmount"] = 1 },
		[7] = { ["timer"] = 5, ["item"] = "weedseed", ["itemAmount"] = 1 },
		[8] = { ["timer"] = 5, ["item"] = "cokeseed", ["itemAmount"] = 1 },
		[9] = { ["timer"] = 5, ["item"] = "mushseed", ["itemAmount"] = 1 },
		[10] = { ["timer"] = 5, ["item"] = "acetone", ["itemAmount"] = 1 },
		[11] = { ["timer"] = 5, ["item"] = "water", ["itemAmount"] = 1 },
		[12] = { ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 1 },
		[13] = { ["timer"] = 5, ["item"] = "cigarette", ["itemAmount"] = 1 },
		[14] = { ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		[15] = { ["timer"] = 5, ["item"] = "dollars", ["itemAmount"] = 1 },
		[16] = { ["timer"] = 5, ["item"] = "elastic", ["itemAmount"] = 1 },
		[17] = { ["timer"] = 5, ["item"] = "rose", ["itemAmount"] = 1 },
		[18] = { ["timer"] = 5, ["item"] = "teddy", ["itemAmount"] = 1 },
		[19] = { ["timer"] = 5, ["item"] = "binoculars", ["itemAmount"] = 1 },
		[20] = { ["timer"] = 5, ["item"] = "camera", ["itemAmount"] = 1 },
		[21] = { ["timer"] = 5, ["item"] = "silverring", ["itemAmount"] = 1 },
		[22] = { ["timer"] = 5, ["item"] = "goldring", ["itemAmount"] = 1 },
		[23] = { ["timer"] = 5, ["item"] = "silvercoin", ["itemAmount"] = 1 },
		[24] = { ["timer"] = 5, ["item"] = "goldcoin", ["itemAmount"] = 1 },
		[25] = { ["timer"] = 5, ["item"] = "watch", ["itemAmount"] = 1 },
		[26] = { ["timer"] = 5, ["item"] = "bracelet", ["itemAmount"] = 1 },
		[27] = { ["timer"] = 5, ["item"] = "dices", ["itemAmount"] = 1 },
		[28] = { ["timer"] = 5, ["item"] = "cup", ["itemAmount"] = 1 },
		[30] = { ["timer"] = 5, ["item"] = "card01", ["itemAmount"] = 1 },
		[31] = { ["timer"] = 5, ["item"] = "card04", ["itemAmount"] = 1 },
		[32] = { ["timer"] = 5, ["item"] = "card05", ["itemAmount"] = 1 },
		[29] = { ["timer"] = 5, ["item"] = "slipper", ["itemAmount"] = 1 }
	},
	["fishfillet"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 20, ["need"] = "fishfillet", ["needAmount"] = 1, ["item"] = "cookedfishfillet", ["itemAmount"] = 1 }
	},
	["marshmallow"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 20, ["need"] = "sugar", ["needAmount"] = 4, ["item"] = "marshmallow", ["itemAmount"] = 1 }
	},
	["animalmeat"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 20, ["need"] = "meat", ["needAmount"] = 1,  ["item"] = "cookedmeat", ["itemAmount"] = 1 }
	},
	["emptybottle"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 3, ["need"] = "emptybottle", ["needAmount"] = 1,  ["item"] = "water", ["itemAmount"] = 1 }
	},
	["dollars100"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = "dollarsroll", ["needAmount"] = 100, ["item"] = "dollars100", ["itemAmount"] = 1 }
	},
	["dollars500"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = "dollarsroll", ["needAmount"] = 500, ["item"] = "dollars500", ["itemAmount"] = 1 }
	},
	["dollars1000"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = "dollarsroll", ["needAmount"] = 1000, ["item"] = "dollars1000", ["itemAmount"] = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local stealItens = {
	[1] = { ["item"] = "pendrive", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	[2] = { ["item"] = "slipper", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[3] = { ["item"] = "soap", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[4] = { ["item"] = "pliers", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[5] = { ["item"] = "deck", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[6] = { ["item"] = "floppy", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[7] = { ["item"] = "domino", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[8] = { ["item"] = "brush", ["min"] = 1, ["max"] = 4, ["rand"] = 225 },
	[9] = { ["item"] = "rimel", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	[10] = { ["item"] = "sneakers", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[11] = { ["item"] = "dices", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	[12] = { ["item"] = "spray04", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[13] = { ["item"] = "spray03", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[14] = { ["item"] = "spray02", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[15] = { ["item"] = "spray01", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[16] = { ["item"] = "bracelet", ["min"] = 2, ["max"] = 4, ["rand"] = 200 },
	[17] = { ["item"] = "xbox", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[18] = { ["item"] = "playstation", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[19] = { ["item"] = "watch", ["min"] = 2, ["max"] = 3, ["rand"] = 200 },
	[20] = { ["item"] = "goldcoin", ["min"] = 4, ["max"] = 6, ["rand"] = 175 },
	[21] = { ["item"] = "silvercoin", ["min"] = 4, ["max"] = 8, ["rand"] = 175 },
	[22] = { ["item"] = "goldring", ["min"] = 1, ["max"] = 2, ["rand"] = 175 },
	[23] = { ["item"] = "silverring", ["min"] = 1, ["max"] = 2, ["rand"] = 175 },
	[24] = { ["item"] = "oxy", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[25] = { ["item"] = "analgesic", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	[26] = { ["item"] = "firecracker", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[27] = { ["item"] = "pager", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	[28] = { ["item"] = "GADGET_PARACHUTE", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[29] = { ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 1, ["rand"] = 50 },
	[30] = { ["item"] = "WEAPON_WRENCH", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	[31] = { ["item"] = "WEAPON_POOLCUE", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	[32] = { ["item"] = "WEAPON_BAT", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	[33] = { ["item"] = "notebook", ["min"] = 1, ["max"] = 1, ["rand"] = 75 },
	[34] = { ["item"] = "camera", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[35] = { ["item"] = "binoculars", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[36] = { ["item"] = "hennessy", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	[37] = { ["item"] = "dewars", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	[38] = { ["item"] = "teddy", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	[39] = { ["item"] = "chocolate", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	[40] = { ["item"] = "lighter", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	[41] = { ["item"] = "divingsuit", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[42] = { ["item"] = "cellphone", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	[43] = { ["item"] = "tyres", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[44] = { ["item"] = "notepad", ["min"] = 1, ["max"] = 5, ["rand"] = 225 },
	[45] = { ["item"] = "brokenpick", ["min"] = 1, ["max"] = 3, ["rand"] = 175 },
	[46] = { ["item"] = "plate", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[47] = { ["item"] = "emptybottle", ["min"] = 2, ["max"] = 5, ["rand"] = 225 },
	[48] = { ["item"] = "bait", ["min"] = 1, ["max"] = 6, ["rand"] = 225 },
	[49] = { ["item"] = "switchblade", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[50] = { ["item"] = "card01", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	[51] = { ["item"] = "card02", ["min"] = 1, ["max"] = 1, ["rand"] = 200 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local lootItens = {
	["Medic"] = {
		["null"] = 75,
		["cooldown"] = 3600,
		["list"] = {
			[1] = { ["item"] = "alcohol", ["min"] = 1, ["max"] = 4 },
			[2] = { ["item"] = "syringe", ["min"] = 1, ["max"] = 4 },
			[3] = { ["item"] = "codeine", ["min"] = 1, ["max"] = 4 },
			[4] = { ["item"] = "amphetamine", ["min"] = 1, ["max"] = 4 },
			[5] = { ["item"] = "acetone", ["min"] = 1, ["max"] = 4 },
			[6] = { ["item"] = "adrenaline", ["min"] = 1, ["max"] = 4 },
			[7] = { ["item"] = "cotton", ["min"] = 1, ["max"] = 4 },
			[8] = { ["item"] = "plaster", ["min"] = 1, ["max"] = 4 },
			[9] = { ["item"] = "saline", ["min"] = 1, ["max"] = 4 },
			[10] = { ["item"] = "sulfuric", ["min"] = 1, ["max"] = 4 },
			[11] = { ["item"] = "analgesic", ["min"] = 1, ["max"] = 4 }
		}
	},
	["Weapons"] = {
		["null"] = 50,
		["cooldown"] = 7200,
		["list"] = {
			[1] = { ["item"] = "roadsigns", ["min"] = 1, ["max"] = 4 },
			[2] = { ["item"] = "techtrash", ["min"] = 1, ["max"] = 4 },
			[3] = { ["item"] = "pistolbody", ["min"] = 2, ["max"] = 4 },
			[4] = { ["item"] = "smgbody", ["min"] = 1, ["max"] = 3 },
			[5] = { ["item"] = "riflebody", ["min"] = 1, ["max"] = 2 },
			[6] = { ["item"] = "sheetmetal", ["min"] = 1, ["max"] = 4 },
			[7] = { ["item"] = "explosives", ["min"] = 1, ["max"] = 4 },
			[8] = { ["item"] = "aluminum", ["min"] = 2, ["max"] = 6 },
			[9] = { ["item"] = "copper", ["min"] = 2, ["max"] = 6 },
			[10] = { ["item"] = "nitro", ["min"] = 1, ["max"] = 4 }
		}
	},
	["Supplies"] = {
		["null"] = 75,
		["cooldown"] = 3600,
		["list"] = {
			[1] = { ["item"] = "tarp", ["min"] = 4, ["max"] = 4 },
			[2] = { ["item"] = "sheetmetal", ["min"] = 4, ["max"] = 4 },
			[3] = { ["item"] = "roadsigns", ["min"] = 4, ["max"] = 4 },
			[4] = { ["item"] = "leather", ["min"] = 4, ["max"] = 4 },
			[5] = { ["item"] = "animalfat", ["min"] = 4, ["max"] = 4 },
			[6] = { ["item"] = "cotton", ["min"] = 4, ["max"] = 4 },
			[7] = { ["item"] = "plaster", ["min"] = 4, ["max"] = 4 },
			[8] = { ["item"] = "sulfuric", ["min"] = 4, ["max"] = 4 },
			[9] = { ["item"] = "saline", ["min"] = 4, ["max"] = 4 },
			[10] = { ["item"] = "alcohol", ["min"] = 4, ["max"] = 4 },
			[11] = { ["item"] = "syringe", ["min"] = 4, ["max"] = 4 },
			[12] = { ["item"] = "card01", ["min"] = 1, ["max"] = 1 },
			[13] = { ["item"] = "weedseed", ["min"] = 4, ["max"] = 4 },
			[14] = { ["item"] = "cokeseed", ["min"] = 4, ["max"] = 4 },
			[15] = { ["item"] = "mushseed", ["min"] = 4, ["max"] = 4 },
			[16] = { ["item"] = "heroine", ["min"] = 4, ["max"] = 4 },
			[17] = { ["item"] = "silk", ["min"] = 4, ["max"] = 4 },
			[18] = { ["item"] = "fertilizer", ["min"] = 4, ["max"] = 4 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestInventory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myInventory = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			if (parseInt(v["amount"]) <= 0 or itemBody(v["item"]) == nil) then
				vRP.removeInventoryItem(user_id,v["item"],parseInt(v["amount"]),false)
			else
				
				local Split = splitString(v["item"],"-")
				if Split[2] ~= nil then
					if Split[1] == "identity" then
						local Number = parseInt(Split[2])
						local Identity = vRP.userIdentity(Number)
						v["Passport"] = Number
						v["idRolepass"] = "Inativo"
						v["idBlood"] = bloodTypes(Identity["blood"])
						v["idPhone"] = Identity["phone"]
						v["idName"] = Identity["name"].." "..Identity["name2"]
					end
				end

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
		end
		local identity = vRP.userIdentity(user_id)
		return myInventory,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),identity["name"].." "..identity["name2"],user_id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.invUpdate(Slot,Target,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.invUpdate(user_id,Slot,Target,Amount) then
			TriggerClientEvent("inventory:Update",source,"updateMochila")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BADGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Badges")
AddEventHandler("inventory:Badges",function(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local Inventory = vRP.userInventory(user_id)
		if Inventory then
			for k,v in pairs(Inventory) do
				if string.sub(v["item"],1,5) == "badge" then
					local Amount = 1
					local Item = v["item"]

					if vRP.tryGetInventoryItem(user_id,Item,Amount,false,k) then
						local Days = 1
						local Number = 0
						local Durability = 0
						local splitName = splitString(Item,"-")

						repeat
							Number = Number + 1
						until Drops[tostring(Number)] == nil

						if splitName[2] ~= nil then
							if itemDurability(Item) then
								Durability = parseInt(os.time() - splitName[2])
								Days = itemDurability(Item)
							else
								Durability = 0
								Days = 1
							end
						else
							Durability = 0
							Days = 1
						end

						Drops[tostring(Number)] = {
							["key"] = Item,
							["amount"] = Amount,
							["coords"] = { x,y,z },
							["name"] = itemName(Item),
							["peso"] = itemWeight(Item),
							["index"] = itemIndex(Item),
							["days"] = Days,
							["durability"] = Durability
						}

						TriggerEvent("discordLogs","Badges","O passaporte **"..user_id.."** deixou sua badge cair.",3092790)
						TriggerClientEvent("drops:Adicionar",-1,tostring(Number),Drops[tostring(Number)])
						TriggerClientEvent("inventory:Update",source,"updateMochila")

						break
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drops")
AddEventHandler("inventory:Drops",function(Item,Slot,Amount,x,y,z)
	local source = source
	local Slot = tostring(Slot)
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] == nil and not vPLAYER.getHandcuff(source) and not exports["hud_v2"]:Wanted(user_id) and not vRPC.inVehicle(source) then
			if vRP.tryGetInventoryItem(user_id,Item,Amount,false,Slot) then
				vRPC._playAnim(source,true,{"pickup_object","pickup_low"},false)
				local Days = 1
				local Number = 0
				local Durability = 0
				local splitName = splitString(Item,"-")

				repeat
					Number = Number + 1
				until Drops[tostring(Number)] == nil

				if splitName[2] ~= nil then
					if itemDurability(Item) then
						Durability = parseInt(os.time() - splitName[2])
						Days = itemDurability(Item)
					else
						Durability = 0
						Days = 1
					end
				else
					Durability = 0
					Days = 1
				end

				Drops[tostring(Number)] = {
					["key"] = Item,
					["amount"] = Amount,
					["coords"] = { x,y,z },
					["name"] = itemName(Item),
					["peso"] = itemWeight(Item),
					["index"] = itemIndex(Item),
					["days"] = Days,
					["durability"] = Durability
				}

				TriggerClientEvent("drops:Adicionar",-1,tostring(Number),Drops[tostring(Number)])
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			end
		else
			TriggerClientEvent("inventory:Update",source,"updateMochila")
		end
	end
end)

local municaoperdida = {}
function cRP.returnAmmout(Ammo)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if not municaoperdida[user_id] then
			municaoperdida[user_id] = {}
			municaoperdida[user_id].ammo = Ammo
		end

		municaoperdida[user_id].ammo = Ammo
	end
end

RegisterServerEvent("inventory:returnAmount")
AddEventHandler("inventory:returnAmount", function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		if Ammos[user_id]  then 
			for k, v in pairs(Ammos[user_id]) do
				TriggerClientEvent("clearAmmoInWeapon", source, k, 0)
				--[[ TriggerClientEvent("hud:Ammount", source, 0, 0) ]]
				TriggerClientEvent("hud:ActiveArmed", source, true)
		
				if municaoperdida[user_id].ammo == v then
					
					if vRP.tryGetInventoryItem(user_id, k, v, false) then
						v = v - municaoperdida[user_id].ammo
					end
					vRP.generateItem(user_id, k, v)
				end

			end
		end
	end
end)


local shoting = {}

RegisterServerEvent("get:client_evidence")
AddEventHandler("get:client_evidence",function(source)
	shoting[source] = true
end)

function cRP.gsrCheck(sourcePlayer)
	if (shoting[sourcePlayer]) then
		shoting[sourcePlayer] = nil
		return true
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Pickup")
AddEventHandler("inventory:Pickup",function(Number,Amount,Slot)
	local source = source
	local Slot = tostring(Slot)
	local Number = tostring(Number)
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] == nil then
		
			if Drops[Number] == nil then
				TriggerClientEvent("inventory:Update",source,"updateMochila")
				return
			else
				if (vRP.inventoryWeight(user_id) + (itemWeight(Drops[Number]["key"]) * Amount)) <= vRP.getWeight(user_id) then
					if Drops[Number] == nil or Drops[Number]["amount"] < Amount then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						return
					end

					if vRP.checkMaxItens(user_id,Drops[Number]["key"],Amount) then
						TriggerClientEvent("Notify",source,"important","Atenção","Limite atingido.",3000)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						return
					end

		
					if Drops[Number] then
						local inventory = vRP.userInventory(user_id)
						if inventory[Slot] and Drops[Number]["key"] then
							if inventory[Slot]["item"] == Drops[Number]["key"] then
								vRP.giveInventoryItem(user_id,Drops[Number]["key"],Amount,false,Slot)
							else
								vRP.giveInventoryItem(user_id,Drops[Number]["key"],Amount,false)
							end
						else 
							if Drops[Number] then 
								vRP.giveInventoryItem(user_id,Drops[Number]["key"],Amount,false,Slot)
							end
						end

						Drops[Number]["amount"] = Drops[Number]["amount"] - Amount
						if Drops[Number]["amount"] <= 0 then
							TriggerClientEvent("drops:Remover",-1,Number)
							Drops[Number] = nil
						else
							TriggerClientEvent("drops:Atualizar",-1,Number,Drops[Number]["amount"])
						end

						TriggerClientEvent("inventory:Update",source,"updateMochila")
					else
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				else
					TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
					return 
				end
			end
		else
			TriggerClientEvent("inventory:Update",source,"updateMochila")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:sendItem")
AddEventHandler("inventory:sendItem",function(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local Player = vRPC.nearestPlayer(source,3)
		if Player then
			Active[user_id] = os.time() + 100

			local inventory = vRP.userInventory(user_id)
			if not inventory[Slot] or inventory[Slot]["item"] == nil then
				Active[user_id] = nil
				return
			end

			if Amount == 0 then Amount = 1 end
			local Item = inventory[Slot]["item"]

			local nuser_id = vRP.getUserId(Player)
			if not vRP.checkMaxItens(nuser_id,Item,Amount) then
				if (vRP.inventoryWeight(nuser_id) + itemWeight(Item) * Amount) <= vRP.getWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,Item,Amount,true,Slot) then
						vRPC.createObjects(source,"mp_safehouselost@","package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)

						Citizen.Wait(3000)

						vRP.giveInventoryItem(nuser_id,Item,Amount,true)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						TriggerClientEvent("inventory:Update",Player,"updateMochila")
						vRPC.removeObjects(source)
					end
				else
					TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
				end
			else
				TriggerClientEvent("Notify",source,"important","Atenção","Limite atingido.","amarelo",3000)
			end

			Active[user_id] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Deliver")
AddEventHandler("inventory:Deliver",function(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local user_id = vRP.getUserId(source)
	if user_id then
		local inventory = vRP.userInventory(user_id)
		if not inventory[Slot] or inventory[Slot]["item"] == nil then
			return
		end

		if Amount == 0 then Amount = 1 end
		local splitName = splitString(inventory[Slot]["item"],"-")
		local totalName = inventory[Slot]["item"]
		local nameItem = splitName[1]

		if nameItem == "newspaper" then
			if not vRPC.lastVehicle(source,"bmx") then
				TriggerClientEvent("Notify",source,"important","Atenção","Precisa utilizar o veículo BMX<.","amarelo",3000)
				return
			end

			if exports["homes"]:initNewspapers(source) then
				vRP.generateItem(user_id,"dollars",60,true)

				if vRP.userPremium(user_id) then
					vRP.generateItem(user_id,"dollars",6,true)
				end

				vRP.removeInventoryItem(user_id,totalName,1,true)
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			end
		return end

		if nameItem == "burgershot3" or nameItem == "burgershot4" then
			if vDELIVER.Deliver(source,"BurgerShot") then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					vDELIVER.Update(source)

					if nameItem == "burgershot3" then
						vRP.generateItem(user_id,"dollars",120,true)
						
						if vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",10,true)
						end
					elseif nameItem == "burgershot4" then
						vRP.generateItem(user_id,"dollars",270,true)
						
						if vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",10,true)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end
		
		if nameItem == "backpack" then
			if vRP.getWeight(user_id) >= 100 then
				return
			end

			Active[user_id] = os.time() + 7
			TriggerClientEvent("Progress",source,7000)
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("inventory:blockButtons",source,true)
			vRPC.playAnim(source,true,{"clothingtie","try_tie_negative_a"},true)

			repeat
				if os.time() >= parseInt(Active[user_id]) then
					Active[user_id] = nil
					vRPC.stopAnim(source,"one")
					TriggerClientEvent("inventory:Buttons",source,false)

					if vRP.tryGetInventoryItem(user_id,totalName,1,true,slot) then
						vRP.setWeight(user_id, 15)
					end
				end

				Citizen.Wait(100)
			until Active[user_id] == nil
		return end	

		if nameItem == "pizzathis3" or nameItem == "pizzathis4" then
			if vDELIVER.Deliver(source,"PizzaThis") then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					vDELIVER.Update(source)

					if nameItem == "pizzathis3" then
						vRP.generateItem(user_id,"dollars",120,true)
						
						if vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",10,true)
						end
					elseif nameItem == "pizzathis4" then
						vRP.generateItem(user_id,"dollars",270,true)
						
						if vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",10,true)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end
		
		if nameItem == "uwucoffee3" or nameItem == "uwucoffee4" then
			if vDELIVER.Deliver(source,"UwuCoffee") then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					vDELIVER.Update(source)

					if nameItem == "uwucoffee3" then
						vRP.generateItem(user_id,"dollars",120,true)
						
						if vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",10,true)
						end
					elseif nameItem == "uwucoffee4" then
						vRP.generateItem(user_id,"dollars",270,true)
						
						if vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",10,true)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end
		
		if nameItem == "beanmachine3" or nameItem == "beanmachine4" then
			if vDELIVER.Deliver(source,"BeanMachine") then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					vDELIVER.Update(source)

					if nameItem == "beanmachine3" then
						vRP.generateItem(user_id,"dollars",120,true)
						
						if vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",10,true)
						end
					elseif nameItem == "beanmachine4" then
						vRP.generateItem(user_id,"dollars",270,true)
						
						if vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",10,true)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end
	end
end)


-- if nameItem == "saquinho" then
-- 	local consultItem = vRP.getInventoryItemAmount(user_id,"saquinho")
-- 	local consultItem2 = vRP.getInventoryItemAmount(user_id,"cocaine")
-- 	if consultItem[1] and consultItem2[1] >= Amount then
-- 		vCLIENT.blockButtons(source,true)
		

-- 		Active[user_id] = os.time() + parseInt(Amount * 1)
-- 		TriggerClientEvent("Progress",source,parseInt(Amount*1000))
-- 		TriggerClientEvent("inventory:Close",source)
-- 		TriggerClientEvent("inventory:blockButtons",source,true)
-- 		-- vRPC.playAnim(source,false,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)
-- 		TriggerClientEvent('emotes', source, 'mexer')


-- 		repeat
-- 			if os.time() >= parseInt(Active[user_id]) then
-- 					TriggerClientEvent("inventory:blockButtons",source,false)
-- 					Active[user_id] = nil
-- 					vRPC.stopAnim(source,false)

-- 					if vRP.tryGetInventoryItem(user_id,"saquinho",Amount,true,slot) and vRP.tryGetInventoryItem(user_id,"cocaine",Amount,true) then
-- 							vRP.giveInventoryItem(user_id,"cokesack",Amount,true)
-- 					end
-- 			end
-- 			Citizen.Wait(100)
-- 		until Active[user_id] == nil
-- 	end
-- return end

-- if nameItem == "saquinho" then
-- 	local consultItem = vRP.getInventoryItemAmount(user_id,"saquinho")
-- 	local consultItem2 = vRP.getInventoryItemAmount(user_id,"meth")
-- 	if consultItem[1] and consultItem2[1] >= Amount then
-- 		vCLIENT.blockButtons(source,true)
		

-- 		Active[user_id] = os.time() + parseInt(Amount * 1)
-- 		TriggerClientEvent("Progress",source,parseInt(Amount*1000))
-- 		TriggerClientEvent("inventory:Close",source)
-- 		TriggerClientEvent("inventory:blockButtons",source,true)
-- 		-- vRPC.playAnim(source,false,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)
-- 		TriggerClientEvent('emotes', source, 'mexer')


-- 		repeat
-- 			if os.time() >= parseInt(Active[user_id]) then
-- 					TriggerClientEvent("inventory:blockButtons",source,false)
-- 					Active[user_id] = nil
-- 					vRPC.stopAnim(source,false)

-- 					if vRP.tryGetInventoryItem(user_id,"saquinho",Amount,true,slot) and vRP.tryGetInventoryItem(user_id,"meth",Amount,true) then
-- 							vRP.giveInventoryItem(user_id,"methsack",Amount,true)
-- 					end
-- 			end
-- 			Citizen.Wait(100)
-- 		until Active[user_id] == nil
-- 	end
-- return end


RegisterServerEvent("inventory:inComa")
AddEventHandler("inventory:inComa",function(status)
    inComa = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:useItem")
AddEventHandler("inventory:useItem",function(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		if Amount == 0 then Amount = 1 end
		local inventory = vRP.userInventory(user_id)
		if not inventory[Slot] or inventory[Slot]["item"] == nil then
			return
		end

		local splitName = splitString(inventory[Slot]["item"],"-")
		local totalName = inventory[Slot]["item"]
		local nameItem = splitName[1]

		if itemDurability(totalName) then
			if vRP.checkBroken(totalName) then
				TriggerClientEvent("Notify",source,"cancel","Negado",""..itemName(nameItem).." quebrado.","vermelho",5000)
				return
			end
		end

		if vCLIENT.checkWater(source) and nameItem ~= "soap" then
			return
		end

		if vPLAYER.getHandcuff(source) and nameItem ~= "lockpick2" then
			return
		end

		if itemType(totalName) == "Throwing" then
			if vRPC.inVehicle(source) then
				if not itemVehicle(totalName) then
					return
				end
			end

			local checkWeapon = vCLIENT.returnWeapon(source)
			if checkWeapon then
				local weaponStatus,weaponAmmo,hashItem = vCLIENT.storeWeaponHands(source)
				if weaponStatus then
					
					TriggerClientEvent("itensNotify",source,{ "guardou",itemIndex(hashItem),1,itemName(hashItem) })
				end
			else
				local consultItem = vRP.getInventoryItemAmount(user_id,nameItem)
				if consultItem[1] <= 0 then
					return
				end
				
				if vCLIENT.putWeaponHands(source,nameItem,1) then
					--[[ DeleteObject(attached_object.handle) ]]
					TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),1,itemName(totalName) })
					TriggerClientEvent("inventory:throwableWeapons",source,nameItem)
				end
			end
		return end

		if itemType(totalName) == "Armamento" then
			if vRPC.inVehicle(source) then
				if not itemVehicle(totalName) then
					return
				end
			end

			local returnWeapon = vCLIENT.returnWeapon(source)
			if returnWeapon then
				local weaponStatus,weaponAmmo,hashItem = vCLIENT.storeWeaponHands(source)

				if weaponStatus then
					local wHash = itemAmmo(hashItem)
					if wHash ~= nil then
						Ammos[user_id][wHash] = parseInt(weaponAmmo)
					end
					--[[ TriggerClientEvent("hud:Ammount", source, 0, 0) ]]
					TriggerClientEvent("itensNotify",source,{ "guardou",itemIndex(hashItem),1,itemName(hashItem) })
				end
			else
				local wHash = itemAmmo(nameItem)
				if wHash ~= nil then
					if (Ammos[user_id] == nil) then
						Ammos[user_id] = vRP.userData(user_id,"weaponAmmos")
						Attachs[user_id] = vRP.userData(user_id,"weaponAttachs")
					end

					if Ammos[user_id][wHash] == nil then
						Ammos[user_id][wHash] = 0
					end
				end

				if vCLIENT.putWeaponHands(source,nameItem,Ammos[user_id][wHash] or 0,Attachs[user_id][nameItem] or nil) then
					TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),1,itemName(totalName) })
				end
			end
		return end

		if itemType(totalName) == "Munição" then
			local returnWeapon,weaponHash,weaponAmmo = vCLIENT.rechargeCheck(source,nameItem)

			if returnWeapon then
				if nameItem ~= itemAmmo(weaponHash) then
					return
				end

				if (totalName == "WEAPON_PETROLCAN_AMMO") then
					if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
						Ammos[user_id][nameItem] = parseInt(Ammos[user_id][nameItem]) + Amount
	
						TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),Amount,itemName(totalName) })
						vCLIENT.rechargeWeapon(source,weaponHash,Amount)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
					return
				end

				if (weaponAmmo >= 250) then
					TriggerClientEvent("Notify", source, "vermelho", "Essa arma alcançou seu limite de 250 muniçoes.", 5000)
					return vCLIENT.rechargeWeapon(source,weaponHash,250)
				end

					if (Amount + weaponAmmo > 250) then
						Amount = Amount - Amount + weaponAmmo - 250
						Amount = -Amount
						if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
							Ammos[user_id][nameItem] = parseInt(Ammos[user_id][nameItem]) + Amount
		
							TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),Amount,itemName(totalName) })
							vCLIENT.rechargeWeapon(source,weaponHash,Amount)
							TriggerClientEvent("inventory:Update",source,"updateMochila")
						end
					else
						if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
							Ammos[user_id][nameItem] = parseInt(Ammos[user_id][nameItem]) + Amount
		
							TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),Amount,itemName(totalName) })
							vCLIENT.rechargeWeapon(source,weaponHash,Amount)
							TriggerClientEvent("inventory:Update",source,"updateMochila")
						end
					end
			end
		return end

		if nameItem == "attachsFlashlight" or nameItem == "attachsCrosshair" or nameItem == "attachsSilencer" or nameItem == "attachsGrip" then
			local returnWeapon = vCLIENT.returnWeapon(source)
			if returnWeapon then
				if Attachs[user_id][returnWeapon] == nil then
					Attachs[user_id][returnWeapon] = {}
				end

				if Attachs[user_id][returnWeapon][nameItem] == nil then
					local checkAttachs = vCLIENT.checkAttachs(source,nameItem,returnWeapon)
					if checkAttachs then
						if vRP.tryGetInventoryItem(user_id,totalName,1,false,Slot) then
							TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),1,itemName(totalName) })
							TriggerClientEvent("inventory:Update",source,"updateMochila")
							vCLIENT.putAttachs(source,nameItem,returnWeapon)
							Attachs[user_id][returnWeapon][nameItem] = true
						end
					else
						TriggerClientEvent("Notify",source,"important","Atenção","O armamento não possui suporte ao componente.","amarelo",5000)
					end
				else
					TriggerClientEvent("Notify",source,"important","Atenção","O armamento já possui o componente equipado.","amarelo",5000)
				end
			end
		return end

		if itemType(totalName) == "Usável" or itemType(totalName) == "Animal" then
			if nameItem == "vehkey" then
				local vehicle,vehNet,vehPlate = vRPC.vehList(source,5)
				if vehicle then
					if vehPlate == splitName[2] then
						TriggerEvent("garages:keyVehicle",source,vehNet)
					end
				end
			return end

			if nameItem == "newgarage" then
				if vRP.tryGetInventoryItem(user_id,totalName,1,false,Slot) then
					vRP.upgradeGarage(user_id)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					TriggerClientEvent("Notify",source,"check","Sucesso","Garagem liberada.","verde",5000)
				end
			return end

			if nameItem == "newlocate" then
				if vRP.tryGetInventoryItem(user_id,totalName,1,false,Slot) then
					vRP.updateLocate(user_id)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					TriggerClientEvent("Notify",source,"check","Sucesso","Nacionalidade atualizada.","verde",5000)
				end
			return end

			if nameItem == "newchars" then
				if vRP.tryGetInventoryItem(user_id,totalName,1,false,Slot) then
					vRP.upgradeChars(user_id)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					TriggerClientEvent("Notify",source,"check","Sucesso","Personagem liberado.","verde",5000)
				end
			return end

			if nameItem == "wheelchair" then
				local plateVehicle = "WCH"..math.random(10000,99999)
				
				if vRP.tryGetInventoryItem(user_id,nameItem,1,false,Slot) then
					TriggerEvent("plateEveryone",plateVehicle)
					vCLIENT.wheelChair(source,plateVehicle)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			return end

			if nameItem == "backpolice" then
				TriggerClientEvent("skinshop:toggleBackpack",source,49)
			return end

			if nameItem == "cellphone" then
				TriggerClientEvent("drugs:initService",source)
			return end

			if nameItem == "gemstone" then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.upgradeGemstone(user_id,Amount)
				end
			return end

			if nameItem == "backpack" then
				if vRP.getWeight(user_id) >= 100 then
					return
				end
	
				Active[user_id] = os.time() + 7
				TriggerClientEvent("Progress",source,7000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:blockButtons",source,true)
				vRPC.playAnim(source,true,{"clothingtie","try_tie_negative_a"},true)
	
				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)
	
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,slot) then
							vRP.setWeight(user_id, 15)
						end
					end
	
					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "rottweiler" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_rottweiler")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "husky" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_husky")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "shepherd" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_shepherd")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "retriever" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_retriever")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "poodle" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_poodle")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "pug" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_pug")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "westy" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_westy")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "cat" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_cat_01")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			-- if nameItem == "contract"..string.sub(totalName,9,10) then
			-- 	TriggerClientEvent("inventory:Close",source)
			-- 	TriggerEvent("homes:propItem",source,totalName,string.sub(totalName,9,10))
			-- return end

			if nameItem == "dismantle" then
				TriggerClientEvent("inventory:Close",source)
				if not vCLIENT.DismantleStatus(source) then
					vCLIENT.Dismantle(source,math.random(100,1001))
					vRP.removeInventoryItem(user_id,"dismantle",1,true)
				end
			return end

			if string.sub(nameItem,1,5) == "badge" then
				if openIdentity[user_id] then
					TriggerClientEvent("vRP:Identity",source)
					openIdentity[user_id] = nil
					vRPC.removeObjects(source)
				else
					local userIdentity = parseInt(splitName[2])
					local identity = vRP.userIdentity(userIdentity)
					if identity then
						openIdentity[user_id] = true
						TriggerClientEvent("inventory:Close",source)

						if nameItem == "badge04" then
							vRPC.createObjects(source,"paper_1_rcm_alt1-8","player_one_dual-8","prop_medic_badge",49,28422,0.065,0.029,-0.035,80.0,-1.90,75.0)
						else
							vRPC.createObjects(source,"paper_1_rcm_alt1-8","player_one_dual-8","prop_police_badge",49,28422,0.065,0.029,-0.035,80.0,-1.90,75.0)
						end

						TriggerClientEvent("vRP:Identity",source,{ mode = "fidentity", nome = identity["name"].." "..identity["name2"], nacionalidade = identity["locate"], passaporte = user_id, porte = identity["port"], sangue = bloodTypes(identity["blood"]) })
					end
				end
			return end

			if nameItem == "namechange" then
				TriggerClientEvent("inventory:Close",source)

				local name =  vRP.prompt(source,"Primeiro Nome:","")
				local name2 =  vRP.prompt(source,"Segundo Nome:","")
				if name == "" or name2 == "" then
					return
				end

				if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
					TriggerClientEvent("Notify",source,"check","Sucesso","Passaporte atualizado.","verde",5000)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.upgradeNames(user_id,name,name2)
				end
			return end

			if nameItem == "chip" then
				TriggerClientEvent("inventory:Close",source)

				local newPhone = vRP.prompt(source,"Digite o novo número no formato: XXX-XXX","")
				
				if newPhone == "" then
					return
				end
				--if string.len(initCheck) == 3 and string.len(finiCheck) == 3 then
					--local newPhone = firstNumber.."-"..lastNumber..""
					if not vRP.userPhone(newPhone) then
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("Notify",source,"check","Sucesso","Telefone atualizado.","verde",5000)
							TriggerEvent("smartphone:updatePhoneNumber",user_id,newPhone)
							vRP.upgradePhone(user_id,newPhone)
						end
					else
						TriggerClientEvent("Notify",source,"important","Atenção","Número escolhido já possui um proprietário.","amerelo",5000)
					end
				--else
					--TriggerClientEvent("Notify",source,"important","Atenção","O número telefônico deve conter 6 dígitos e somente números.",5000)
				--end
			return end

			if nameItem == "dices" then
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,1750)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"anim@mp_player_intcelebrationmale@wank","wank"},true)

				Citizen.Wait(1750)

				Active[user_id] = nil
				vRPC.stopAnim(source,false)
				TriggerClientEvent("inventory:Buttons",source,false)

				local Dice = math.random(6)
				local activePlayers = vRPC.activePlayers(source)
				for _,v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("showme:pressMe",v,source,"<img src='images/"..Dice..".png'>",10,true)
					end)
				end
			return end

			if nameItem == "deck" then
				TriggerClientEvent("inventory:Close",source)

				local card = math.random(13)
				local cards = { "A","2","3","4","5","6","7","8","9","10","J","Q","K" }

				local naipe = math.random(4)
				local naipes = { "de paus","de espada","de ouros","de copas" }

				local identity = vRP.userIdentity(user_id)
				TriggerClientEvent("chatME",source,"^5CARTAS^9"..identity["name"].." "..identity["name2"].."^0 tirou "..cards[card].." "..naipes[naipe].." do baralho.")

				local players = vRPC.nearestPlayers(source,5)
				for _,v in pairs(players) do
					TriggerClientEvent("chatME",v[2],"^5CARTAS^9"..identity["name"].." "..identity["name2"].."^0 tirou "..cards[card]..naipes[naipe].." do baralho.")
				end
			return end
			if nameItem == "spray05" then
				TriggerClientEvent("domination:territory",source)
			return end
			if nameItem == "tiner" then
				TriggerClientEvent("domination:dominatingTerritory",source,user_id)
			return end
			if nameItem == "bandage" then
				if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
					if vRP.getHealth(source) > 101 and vRP.getHealth(source) < 200 then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									TriggerClientEvent("sounds:source",source,"bandage",0.5)
									Healths[user_id] = os.time() + 60
									vRP.upgradeStress(user_id,3)
									vRPC.updateHealth(source,15)
								end
							end

							Citizen.Wait(100)
						until Active[user_id] == nil
					else
						TriggerClientEvent("Notify",source,"important","Atenção","Não pode utilizar de vida cheia ou nocauteado.","amarelo",5000)
					end
				else
					local healTimers = parseInt(Healths[user_id] - os.time())
					TriggerClientEvent("Notify",source,"important","Atenção","Aguarde "..healTimers.." segundos.","atenção",5000)
				end
			return end

			if nameItem == "sulfuric" then
				Active[user_id] = os.time() + 3
				TriggerClientEvent("Progress",source,3000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_suicide","pill"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRPC.downHealth(source,100)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "analgesic" or nameItem == "oxy" then
				if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
					if vRP.getHealth(source) > 101 and vRP.getHealth(source) < 200 then
						Active[user_id] = os.time() + 3
						TriggerClientEvent("Progress",source,3000)
						TriggerClientEvent("inventory:Close",source)
						vRPC.playAnim(source,true,{"mp_suicide","pill"},true)
						TriggerClientEvent("inventory:Buttons",source,true)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									Healths[user_id] = os.time() + 30
									vRP.upgradeStress(user_id,15)
									vRPC.updateHealth(source,8)
								end
							end

							Citizen.Wait(100)
						until Active[user_id] == nil
					else
						TriggerClientEvent("Notify",source,"azul","Não pode utilizar de vida cheia ou nocauteado.",5000)
					end
				else
					local healTimers = parseInt(Healths[user_id] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..healTimers.." segundos</b>.",5000)
				end
			return end

			if nameItem == "soap" then
				if shoting[source] then
					Active[user_id] = os.time() + 15
					TriggerClientEvent("Progress",source,15000)
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)
					vRPC.playAnim(source,false,{"amb@world_human_bum_wash@male@high@base","base"},true)

					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.removeObjects(source)
							TriggerClientEvent("inventory:Buttons",source,false)

							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								shoting[source] = nil;
								TriggerClientEvent("Notify",source,"important","Atenção","Residuo removido","amarelo",5000)

							end
						end
						Citizen.Wait(100)
					until Active[user_id] == nil
				else
					TriggerClientEvent("Notify",source,"important","Atenção","Você não está com resíduos no corpo.","amarelo",5000)
				end
			return end

			if nameItem == "joint" then
				local consultItem = vRP.getInventoryItemAmount(user_id,"lighter")
				if consultItem[1] <= 0 then
					return
				end

				Active[user_id] = os.time() + 30
				TriggerClientEvent("Progress",source,30000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.weedTimer(user_id,1)
							vRP.downgradeHunger(user_id,5)
							vRP.downgradeThirst(user_id,5)
							vRP.downgradeStress(user_id,20)
							vPLAYER.movementClip(source,"move_m@shadyped@a")
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "lean" then
				Active[user_id] = os.time() + 3
				TriggerClientEvent("Progress",source,3000)
				TriggerClientEvent("inventory:Close",source)
				vRPC.playAnim(source,true,{"mp_suicide","pill"},true)
				TriggerClientEvent("inventory:Buttons",source,true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.chemicalTimer(user_id,10)
							vRP.downgradeStress(user_id,25)
							TriggerClientEvent("cleanEffectDrugs",source)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "ecstasy" then
				Active[user_id] = os.time() + 3
				TriggerClientEvent("Progress",source,3000)
				TriggerClientEvent("inventory:Close",source)
				vRPC.playAnim(source,true,{"mp_suicide","pill"},true)
				TriggerClientEvent("inventory:Buttons",source,true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.chemicalTimer(user_id,10)
							TriggerClientEvent("setEcstasy",source)
							TriggerClientEvent("setEnergetic",source,10,1.30)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cocaine" then
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							--vRP.chemicalTimer(user_id,10)
							--TriggerClientEvent("setCocaine",source)
							vRP.downgradeHunger(user_id,80)
							vRP.downgradeThirst(user_id,80)
							
							TriggerClientEvent("setEnergetic",source,15,1.20)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "meth" then
				if Armors[user_id] then
					if os.time() < Armors[user_id] then
						local armorTimers = parseInt(Armors[user_id] - os.time())
						TriggerClientEvent("Notify",source,"important","Atenção","Aguarde <b>"..armorTimers.." segundos</b>.","amarelo",5000)
						return
					end
				end

				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setMeth",source)
							Armors[user_id] = os.time() + 60
							vRP.chemicalTimer(user_id,10)
							vRP.setArmour(source,10)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cigarette" then
				local consultItem = vRP.getInventoryItemAmount(user_id,"lighter")
				if consultItem[1] <= 0 then
					return
				end

				Active[user_id] = os.time() + 60
				TriggerClientEvent("Progress",source,60000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,35)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "vape" then
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","ba_prop_battle_vape_01",49,18905,0.08,-0.00,0.03,-150.0,90.0,-10.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRP.downgradeStress(user_id,35)
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "tablet" then
				vRPC.stopActived(source)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("tablet:openSystem",source)
			return end

			if nameItem == "identity" then
				local owner = splitName[2]
				if owner then
					TriggerEvent("RenderIdentity", source, owner)
					TriggerClientEvent("inventory:Close", source)
				else
					TriggerEvent("RenderIdentity", source, owner)
					TriggerClientEvent("inventory:Close", source)
				end
				return
			end

			if nameItem == "medkit" then
				if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
					if vRP.getHealth(source) > 101 and vRP.getHealth(source) < 200 then
						Active[user_id] = os.time() + 20
						TriggerClientEvent("Progress",source,20000)
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									TriggerClientEvent("resetBleeding",source)
									Healths[user_id] = os.time() + 120
									vRPC.updateHealth(source,40)
								end
							end

							Citizen.Wait(100)
						until Active[user_id] == nil
					else
						TriggerClientEvent("Notify",source,"important","Atenção","Não pode utilizar de vida cheia ou nocauteado.",5000)
					end
				else
					local healTimers = parseInt(Healths[user_id] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..healTimers.." segundos</b>.",5000)
				end
			return end

			if nameItem == "gauze" then
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("sounds:source",source,"bandage",0.5)
							TriggerClientEvent("resetBleeding",source)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "binoculars" then
				local ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") then
					return
				end

				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						TriggerClientEvent("useBinoculos",source)
						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.createObjects(source,"amb@world_human_binoculars@male@enter","enter","prop_binoc_01",50,28422)
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "evidence01" or nameItem == "evidence02" or nameItem == "evidence03" or nameItem == "evidence04" then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local distance = #(coords - vector3(312.45,-562.14,43.29))

				if distance <= 1.0 then
					local userSerial = vRP.userSerial(splitName[2])
					if userSerial then
						local identity = vRP.userIdentity(userSerial["id"])
						if identity then
							TriggerClientEvent("Notify",source,"important","Atenção","Evidência de "..identity["name2"]..".","amarelo",5000)
						end
					end
				end
			end

			if nameItem == "camera" then
				local ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") then
					return
				end

				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						TriggerClientEvent("useCamera",source)
						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.createObjects(source,"amb@world_human_paparazzi@male@base","base","prop_pap_camera_01",49,28422)
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "teddy" then
				TriggerClientEvent("inventory:Close",source)
				vRPC.createObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","v_ilev_mr_rasberryclean",49,24817,-0.20,0.46,-0.016,-180.0,-90.0,0.0)
			return end

			if nameItem == "rose" then
				TriggerClientEvent("inventory:Close",source)
				vRPC.createObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","prop_single_rose",49,18905,0.13,0.15,0.0,-100.0,0.0,-20.0)
			return end

			if nameItem == "firecracker" then
				if not vRPC.inVehicle(source) and not vCLIENT.checkCracker(source) then
					Active[user_id] = os.time() + 3
					TriggerClientEvent("Progress",source,3000)
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)
					vRPC.playAnim(source,false,{"anim@mp_fireworks","place_firework_3_box"},true)

					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.stopAnim(source,false)
							TriggerClientEvent("inventory:Buttons",source,false)

							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								TriggerClientEvent("inventory:Firecracker",source)
							end
						end

						Citizen.Wait(100)
					until Active[user_id] == nil
				end
			return end

			if nameItem == "gsrkit" then
				local otherPlayer = vRPC.nearestPlayer
				if otherPlayer then
					Active[user_id] = os.time() + 10
					TriggerClientEvent("Progress",source,10000)
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)

					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							TriggerClientEvent("inventory:Buttons",source,false)
							
							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								if cRP.gsrCheck(otherPlayer) then
									TriggerClientEvent("Notify",source,"check","Sucesso","Resultado positivo.","verde",5000)
								else
									TriggerClientEvent("Notify",source,"important","Atenção","Resultado negativo.","amarelo",3000)
								end
							end
						end

						Citizen.Wait(100)
					until Active[user_id] == nil
				end
			return end

			if nameItem == "gdtkit" then
				local otherPlayer = vRPC.nearestPlayer
				if otherPlayer then
					local nuser_id = vRP.getUserId(otherPlayer)
					local identity = vRP.userIdentity(nuser_id)
					if nuser_id and identity then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									local weed = vRP.weedReturn(nuser_id)
									local chemical = vRP.chemicalReturn(nuser_id)
									local alcohol = vRP.alcoholReturn(nuser_id)

									local chemStr = ""
									local alcoholStr = ""
									local weedStr = ""

									if chemical == 0 then
										chemStr = "Nenhum"
									elseif chemical == 1 then
										chemStr = "Baixo"
									elseif chemical == 2 then
										chemStr = "Médio"
									elseif chemical >= 3 then
										chemStr = "Alto"
									end

									if alcohol == 0 then
										alcoholStr = "Nenhum"
									elseif alcohol == 1 then
										alcoholStr = "Baixo"
									elseif alcohol == 2 then
										alcoholStr = "Médio"
									elseif alcohol >= 3 then
										alcoholStr = "Alto"
									end

									if weed == 0 then
										weedStr = "Nenhum"
									elseif weed == 1 then
										weedStr = "Baixo"
									elseif weed == 2 then
										weedStr = "Médio"
									elseif weed >= 3 then
										weedStr = "Alto"
									end

									openIdentity[user_id] = true
									TriggerClientEvent("vRP:Identity",source,{ mode = "fidentity", nome = identity["name"].." "..identity["name2"], nacionalidade = identity["locate"], porte = identity["port"], sangue = bloodTypes(identity["blood"]) })
									TriggerClientEvent("Notify",source,"azul","<b>Químicos:</b> "..chemStr.."<br><b>Álcool:</b> "..alcoholStr.."<br><b>Drogas:</b> "..weedStr,8000)
								end
							end

							Citizen.Wait(100)
						until Active[user_id] == nil
					end
				end
			return end

			if nameItem == "nitro" then
				if not vRPC.inVehicle(source) then
					local vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if vehicle then
						vRPC.stopActived(source)
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

						local activePlayers = vRPC.activePlayers(source)
						for _,v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"open")
							end)
						end

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									local Nitro = GlobalState["Nitro"]
									Nitro[vehPlate] = 200
									GlobalState["Nitro"] = Nitro
								end
							end

							Citizen.Wait(100)
						until Active[user_id] == nil

						local activePlayers = vRPC.activePlayers(source)
						for _,v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"close")
							end)
						end
					end
				end
			return end

			if nameItem == "vest" then
				if Armors[user_id] then
					if os.time() < Armors[user_id] then
						local armorTimers = parseInt(Armors[user_id] - os.time())
						TriggerClientEvent("Notify",source,"important","Atenção","Aguarde <b>"..armorTimers.." segundos</b>.","amarelo",5000)
						return
					end
				end

				Active[user_id] = os.time() + 30
				TriggerClientEvent("Progress",source,30000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"clothingtie","try_tie_negative_a"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							Armors[user_id] = os.time() + 1800
							vRP.setArmour(source,100)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "GADGET_PARACHUTE" then
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vCLIENT.parachuteColors(source)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "advtoolbox" then
				if not vRPC.inVehicle(source) then
					local vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if vehicle then
						vRPC.stopActived(source)
						Active[user_id] = os.time() + 100
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

						local activePlayers = vRPC.activePlayers(source)
						for _,v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"open")
							end)
						end

						if vTASKBAR.taskMechanic(source) then
							local numberItem = splitName[2]
							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								numberItem = numberItem - 1

								if numberItem > 0 then
									vRP.giveInventoryItem(user_id,"advtoolbox-"..numberItem,1,false)
								end

								local activePlayers = vRPC.activePlayers(source)
								for _,v in ipairs(activePlayers) do
									async(function()
										TriggerClientEvent("inventory:repairVehicle",v,vehNet,vehPlate)
									end)
								end

								vRP.upgradeStress(user_id,2)
							end
						end

						local activePlayers = vRPC.activePlayers(source)
						for _,v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"close")
							end)
						end

						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.stopAnim(source,false)
						Active[user_id] = nil
					end
				end
			return end

			if nameItem == "toolbox" then
				if not vRPC.inVehicle(source) then
					local vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if vehicle then
						vRPC.stopActived(source)
						Active[user_id] = os.time() + 100
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

						local activePlayers = vRPC.activePlayers(source)
						for _,v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"open")
							end)
						end

						if vTASKBAR.taskMechanic(source) then
							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								local activePlayers = vRPC.activePlayers(source)
								for _,v in ipairs(activePlayers) do
									async(function()
										TriggerClientEvent("inventory:repairVehicle",v,vehNet,vehPlate)
									end)
								end

								vRP.upgradeStress(user_id,2)
							end
						end

						local activePlayers = vRPC.activePlayers(source)
						for _,v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"close")
							end)
						end

						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.stopAnim(source,false)
						Active[user_id] = nil
					end
				end
			return end

			if nameItem == "lockpick" then
				if not vPLAYER.getHandcuff(source) then
					local vehicle,vehNet,vehPlate,vehName,vehBlock,vehHealth,vehClass = vRPC.vehList(source,4)
					if vehicle then
						if vehClass == 15 or vehClass == 16 or vehClass == 19 then
							return
						end

						if vRPC.inVehicle(source) and not vCLIENT.DismantleStatus(source) then
							vRPC.stopActived(source)
							vGARAGE.startAnimHotwired(source)
							Active[user_id] = os.time() + 100
							TriggerClientEvent("inventory:Close",source)
							TriggerClientEvent("inventory:Buttons",source,true)

							if vTASKBAR.taskLockpick(source) then
								vRP.upgradeStress(user_id,2)
								TriggerEvent("plateEveryone",vehPlate)
								TriggerEvent("platePlayers",vehPlate,user_id)

								local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
								if GetVehicleDoorLockStatus(idNetwork) == 2 then
									SetVehicleDoorsLocked(idNetwork,1)
								end
								
								if vCLIENT.DismantleStatus(source) then
									TriggerClientEvent("target:Dismantles",source)
								end

								if math.random(100) >= 75 then
									local activePlayers = vRPC.activePlayers(source)
									for _,v in ipairs(activePlayers) do
										async(function()
											TriggerClientEvent("inventory:vehicleAlarm",v,vehNet,vehPlate)
										end)
									end

									local coords = vRPC.getEntityCoords(source)
									local policeResult = vRP.numPermission("Police")
									for k,v in pairs(policeResult) do
										async(function()
											TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
										end)
									end
									
									if vCLIENT.DismantleStatus(source) then
										TriggerClientEvent("inventory:DisPed",source)
									end
								end
							end

							if parseInt(math.random(1000)) >= 900 then
								vRP.removeInventoryItem(user_id,totalName,1,false)
								TriggerClientEvent("itensNotify",source,{ "quebrou","lockpick",1,"Lockpick de Alumínio" })
							end

							TriggerClientEvent("inventory:Buttons",source,false)
							vGARAGE.stopAnimHotwired(source,vehicle)
							Active[user_id] = nil
						else
							vRPC.stopActived(source)
							Active[user_id] = os.time() + 100
							TriggerClientEvent("inventory:Close",source)
							TriggerClientEvent("inventory:Buttons",source,true)
							vRPC.playAnim(source,false,{"missfbi_s4mop","clean_mop_back_player"},true)

							if vCLIENT.DismantleStatus(source) and vehPlate == "DISM"..(1000 + user_id) then
								if vTASKBAR.taskLockpick(source) then
									vRP.upgradeStress(user_id,2)
									TriggerEvent("plateEveryone",vehPlate)
									local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
									if GetVehicleDoorLockStatus(idNetwork) == 2 then
										SetVehicleDoorsLocked(idNetwork,1)
									end

									local activePlayers = vRPC.activePlayers(source)
									for _,v in ipairs(activePlayers) do
										async(function()
											TriggerClientEvent("inventory:vehicleAlarm",v,vehNet,vehPlate)
										end)
									end

									if vCLIENT.DismantleStatus(source) then
										TriggerClientEvent("target:Dismantles",source)
									end

									if math.random(100) >= 75 then
										local coords = vRPC.getEntityCoords(source)
										local policeResult = vRP.numPermission("Police")
										for k,v in pairs(policeResult) do
											async(function()
												TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
											end)
										end
										
										if vCLIENT.DismantleStatus(source) then
											TriggerClientEvent("inventory:DisPed",source)
										end
									end
								end
							else
								if vTASKBAR.taskLockpick(source) then
									if math.random(100) >= 75 then
										vRP.upgradeStress(user_id,2)
										TriggerEvent("plateEveryone",vehPlate)
										local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
										if GetVehicleDoorLockStatus(idNetwork) == 2 then
											SetVehicleDoorsLocked(idNetwork,1)
										end
									end
									
									if math.random(100) >= 75 then
										local activePlayers = vRPC.activePlayers(source)
										for _,v in ipairs(activePlayers) do
											async(function()
												TriggerClientEvent("inventory:vehicleAlarm",v,vehNet,vehPlate)
											end)
										end
										
										local coords = vRPC.getEntityCoords(source)
										local policeResult = vRP.numPermission("Police")
										for k,v in pairs(policeResult) do
											async(function()
												TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
											end)
										end
									end
								end
							end

							if parseInt(math.random(1000)) >= 900 then
								vRP.removeInventoryItem(user_id,totalName,1,false)
								TriggerClientEvent("itensNotify",source,{ "quebrou","lockpick",1,"Lockpick de Alumínio" })
							end

							TriggerClientEvent("inventory:Buttons",source,false)
							vRPC.stopAnim(source,false)
							Active[user_id] = nil
						end
					else 
						local homeName = exports["homes"]:homesTheft(source)
						if homeName then
							vRPC.stopActived(source)
							vRP.upgradeStress(user_id,2)
							Active[user_id] = os.time() + 100
							TriggerClientEvent("inventory:Close",source)
							TriggerClientEvent("inventory:Buttons",source,true)
							vRPC.playAnim(source,false,{"missheistfbi3b_ig7","lift_fibagent_loop"},false)
	
							if vTASKBAR.taskLockpick(source) then 
								TriggerEvent("fx:RouberysProperty",source,homeName)
							else
								return false
							end
	
							if parseInt(math.random(1000)) >= 900 then
								vRP.generateItem(user_id,"brokenpick",1,false)
								vRP.removeInventoryItem(user_id,totalName,1,false)
								TriggerClientEvent("itensNotify",source,{ "quebrou","lockpick2",1,"Lockpick de Cobre" })
							end
	
							TriggerClientEvent("inventory:Buttons",source,false)
							vRPC.stopAnim(source,false)
							Active[user_id] = nil
						end
					end
				end
			return end

			if nameItem == "lockpick2" then
				if not vPLAYER.getHandcuff(source) then
					--[[ if exports["hud_v2"]:Wanted(user_id) then
						return
					end ]]

					local homeName = exports["homes"]:homesTheft(source)
					if homeName then
						vRPC.stopActived(source)
						vRP.upgradeStress(user_id,2)
						Active[user_id] = os.time() + 100
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,false,{"missheistfbi3b_ig7","lift_fibagent_loop"},false)

						if vTASKBAR.taskLockpick(source) then 
							TriggerEvent("fx:RouberysProperty",source,homeName)
						else
							return false
						end

						if parseInt(math.random(1000)) >= 900 then
							vRP.generateItem(user_id,"brokenpick",1,false)
							vRP.removeInventoryItem(user_id,totalName,1,false)
							TriggerClientEvent("itensNotify",source,{ "quebrou","lockpick2",1,"Lockpick de Cobre" })
						end

						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.stopAnim(source,false)
						Active[user_id] = nil
					end
				end
			return end

			if nameItem == "blocksignal" then
				if not vPLAYER.getHandcuff(source) then
					local vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if vehicle and vRPC.inVehicle(source) then
						if exports["garages"]:vehSignal(vehPlate) == nil then
							vRPC.stopActived(source)
							vGARAGE.startAnimHotwired(source)
							Active[user_id] = os.time() + 100
							TriggerClientEvent("inventory:Close",source)
							TriggerClientEvent("inventory:Buttons",source,true)

							if vTASKBAR.taskLockpick(source) then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									TriggerClientEvent("Notify",source,"check","Sucesso","Bloqueador de Sinal instalado.","verde",5000)
									TriggerEvent("signalRemove",vehPlate)
								end
							end

							TriggerClientEvent("inventory:Buttons",source,false)
							vGARAGE.stopAnimHotwired(source)
							Active[user_id] = nil
						else
							TriggerClientEvent("Notify",source,"important","Atenção",">Bloqueador de Sinal já instalado.","amarelo",5000)
						end
					end
				end
			return end

			if nameItem == "postit" then
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("postit:initPostit",source)
			return end

			if nameItem == "energetic" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","prop_energy_drink",49,60309,0.0,0.0,0.0,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.upgradeStress(user_id,5)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "absolut" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,90)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "hennessy" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "chandon" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "dewars" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "scanner" then
				vRPC.stopActived(source)
				Scanners[user_id] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				TriggerClientEvent("inventory:updateScanner",source,true)
				vRPC.createObjects(source,"mini@golfai","wood_idle_a","w_am_digiscanner",49,18905,0.15,0.1,0.0,-270.0,-180.0,-170.0)
			return end

			if nameItem == "orangejuice" or nameItem == "passionjuice" or nameItem == "tangejuice" or nameItem == "grapejuice" or nameItem == "strawberryjuice" or nameItem == "bananajuice" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,50)
							vRP.generateItem(user_id,"emptybottle",1)

							if nameItem == "passionjuice" then
								vRP.downgradeStress(user_id,10)
							end
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "orange" or nameItem == "apple" or nameItem == "strawberry" or nameItem == "coffee2" or nameItem == "grape" or nameItem == "tange" or nameItem == "banana" or nameItem == "passion" or nameItem == "tomato" or nameItem == "mushroom" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,3)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "mushroomtea" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.removeObjects(source,"one")
						Active[user_id] = nil

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("player:MushroomTea",source)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "water" or nameItem == "milkbottle" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,20)
							vRP.generateItem(user_id,"emptybottle",1)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end
		
			if nameItem == "sinkalmy" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,5)
							vRP.chemicalTimer(user_id,3)
							vRP.downgradeStress(user_id,25)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "ritmoneury" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,5)
							vRP.chemicalTimer(user_id,3)
							vRP.downgradeStress(user_id,40)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cola" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","prop_ecola_can",49,60309,0.01,0.01,0.05,0.0,0.0,90.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,15)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "soda" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","ng_proc_sodacan_01b",49,60309,0.0,0.0,-0.04,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,15)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "fishingrod" then
				if vCLIENT.fishingCoords(source) then
					Active[user_id] = os.time() + 100
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)

					if not vCLIENT.fishingAnim(source) then
						vRPC.stopActived(source)
						vRPC.createObjects(source,"amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",49,60309)
					end

					if vTASKBAR.taskFishing(source) then
						local fishList = { "octopus","shrimp","carp","horsefish","tilapia","codfish","catfish","goldenfish","pirarucu","pacu","tambaqui" }
						local fishRandom = math.random(#fishList)
						local fishSelects = fishList[fishRandom]

						if (vRP.inventoryWeight(user_id) + itemWeight(fishSelects)) <= vRP.getWeight(user_id) then
							if vRP.tryGetInventoryItem(user_id,"bait",1,false) then
								vRP.generateItem(user_id,fishSelects,1,true)
								vRP.downgradeStress(user_id,2)
							else
								TriggerClientEvent("Notify",source,"important","Atenção","Precisa de 1x "..itemName("bait")..".","amarelo",5000)
							end
						else
							TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
						end
					end

					TriggerClientEvent("inventory:Buttons",source,false)
					Active[user_id] = nil
				end
			return end

			if nameItem == "coffee" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,10,1.05)
							vRP.upgradeThirst(user_id,15)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VIPS
-----------------------------------------------------------------------------------------------------------------------------------------
if nameItem == 'bronzepremium' then
	if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
		vRP.giveInventoryItem(user_id,'gemstone',30,true)
		vRP.giveInventoryItem(user_id,'newgarage',1,true)
		vRP.giveInventoryItem(user_id,'backpack',1,true)
		vRP.giveInventoryItem(user_id,'dollars',15000,true)
		vRP.setPermission(user_id,'Bronze')
		local days = 30
        
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Vip", value = json.encode(os.time() +  (days * 24 * 60 * 60)) })
	end
end

if nameItem == 'pratapremium' then
	if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
		vRP.giveInventoryItem(user_id,'gemstone',60,true)
		vRP.giveInventoryItem(user_id,'newgarage',2,true)
		vRP.giveInventoryItem(user_id,'backpack',3,true)
		vRP.giveInventoryItem(user_id,'newchars',1,true)
		vRP.giveInventoryItem(user_id,'dollars',35000,true)
		vRP.setPermission(user_id,'Prata')
		local days = 30
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Vip", value = json.encode(os.time() +  (days * 24 * 60 * 60)) })
	end
end

if nameItem == 'goldpremium' then
	if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
		vRP.giveInventoryItem(user_id,'gemstone',100,true)
		vRP.giveInventoryItem(user_id,'newgarage',3,true)
		vRP.giveInventoryItem(user_id,'newchars',1,true)
		vRP.giveInventoryItem(user_id,'backpack',5,true)
		vRP.giveInventoryItem(user_id,'dollars',80000,true)
		vRP.setPermission(user_id,'Ouro')
		local days = 30
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Vip", value = json.encode(os.time() +  (days * 24 * 60 * 60)) })
	end
end

if nameItem == 'spotify' then
	if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
		vRP.setPermission(user_id,'Spotify')
		local days = 30
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Vip", value = json.encode(os.time() +  (days * 24 * 60 * 60)) })
	end
end

if nameItem == 'Verificado' then
	if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
		vRP.setPermission(user_id,'Verificado')
		local days = 30
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Vip", value = json.encode(os.time() +  (days * 24 * 60 * 60)) })
	end
end

			if nameItem == "pizza" or nameItem == "pizza2" or nameItem == "sushi" or nameItem == "nigirizushi" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							if nameItem == "pizza" then
								vRP.upgradeHunger(user_id,40)
							elseif nameItem == "pizza2" then
								vRP.upgradeHunger(user_id,40)
							elseif nameItem == "sushi" then
								vRP.upgradeHunger(user_id,30)
							elseif nameItem == "nigirizushi" then
								vRP.upgradeHunger(user_id,25)
							end
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "hamburger" or nameItem == "hamburger2" or nameItem == "hamburger3" or nameItem == "hamburger4" or nameItem == "hamburger5" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							if nameItem == "hamburger" then
								vRP.upgradeHunger(user_id,15)
							elseif nameItem == "hamburger2" then
								vRP.upgradeHunger(user_id,50)
							elseif nameItem == "hamburger3" then
								vRP.upgradeHunger(user_id,50)
							elseif nameItem == "hamburger4" then
								vRP.upgradeHunger(user_id,50)
							elseif nameItem == "hamburger5" then
								vRP.upgradeHunger(user_id,50)
							end
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cannedsoup" or nameItem == "canofbeans" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,20)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "miner" then
				if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
					vRP.generateItem(user_id,"notebook",1)
					vRP.generateItem(user_id,"techtrash",50)
					vRP.generateItem(user_id,"aluminum",125)
					vRP.generateItem(user_id,"sheetmetal",15)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			return end

			if nameItem == "weed" then
				local consultItem = vRP.getInventoryItemAmount(user_id,"weed")
				local consultItem2 = vRP.getInventoryItemAmount(user_id,"silk")
				if consultItem[1] and consultItem2[1] >= Amount then
					vCLIENT.blockButtons(source,true)
					
			
					Active[user_id] = os.time() + parseInt(Amount * 1)
					TriggerClientEvent("Progress",source,parseInt(Amount*1000))
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:blockButtons",source,true)
					-- vRPC.playAnim(source,false,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)
					TriggerClientEvent('emotes', source, 'mexer')
			
			
					repeat
						if os.time() >= parseInt(Active[user_id]) then
								TriggerClientEvent("inventory:blockButtons",source,false)
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
			
								if vRP.tryGetInventoryItem(user_id,"weed",Amount,true,slot) and vRP.tryGetInventoryItem(user_id,"silk",Amount,true) then
										vRP.giveInventoryItem(user_id,"joint",Amount,true)
								end
						end
						Citizen.Wait(100)
					until Active[user_id] == nil
				end
			return end

			if nameItem == "weedseed" then
				if not exports["homes"]:checkHotel(user_id) then
					TriggerClientEvent("inventory:Close",source)
					local consultItem = vRP.getInventoryItemAmount(user_id,"bucket")
					if consultItem[1] <= 0 then
						TriggerClientEvent("Notify",source,"important","Atenção","Necessário possuir 1x Balde.","amarelo",5000)
						return
					end

					local application,coords = vRPC.objectCoords(source,"bkr_prop_weed_med_01a")
					if application then
						local Route = GetPlayerRoutingBucket(source)
						vRP.removeInventoryItem(user_id,"bucket",1,false)
						vRP.removeInventoryItem(user_id,totalName,1,false)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						exports["plants"]:initPlants("weedseed",coords,Route,"bkr_prop_weed_med_01a",user_id)
					end
				end
			return end

			if nameItem == "cokeseed" then
				if not exports["homes"]:checkHotel(user_id) then
					TriggerClientEvent("inventory:Close",source)
					local consultItem = vRP.getInventoryItemAmount(user_id,"bucket")
					if consultItem[1] <= 0 then
						TriggerClientEvent("Notify",source,"important","Atenção","Necessário possuir 1x Balde.","amarelo",5000)
						return
					end

					local application,coords = vRPC.objectCoords(source,"bkr_prop_weed_med_01a")
					if application then
						local Route = GetPlayerRoutingBucket(source)
						vRP.removeInventoryItem(user_id,"bucket",1,false)
						vRP.removeInventoryItem(user_id,totalName,1,false)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						exports["plants"]:initPlants("cokeseed",coords,Route,"bkr_prop_weed_med_01a",user_id)
					end
				end
			return end

			if nameItem == "mushseed" then
				
					local rand = math.random(2)
					TriggerClientEvent("inventory:Close",source)
					local application,coords = vRPC.objectCoords(source,"prop_stoneshroom1"..rand)
					if application then
						local Route = GetPlayerRoutingBucket(source)
						vRP.removeInventoryItem(user_id,totalName,1,false)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						exports["plants"]:initPlants("mushseed",coords,Route,"prop_stoneshroom1"..rand,user_id)
					end
				
			return end

			if nameItem == "tablecoke" then
				
					local favela = cRP.favelaDistance(source)
					if favela == true then
						
						TriggerClientEvent("inventory:Close",source)
					local application,coords,heading = vRPC.objectCoords(source,"bkr_prop_coke_table01a")
					if application then
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "bkr_prop_coke_table01a", item = "tablecoke", distance = 50, mode = "1" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
							TriggerClientEvent("inventory:Close",source)
						end
					end
			
					
					end
					
			return end

			if nameItem == "tablemeth" then
				local favela = cRP.favelaDistance(source)
				
				if favela == true then
					TriggerClientEvent("inventory:Close",source)
					local application,coords,heading = vRPC.objectCoords(source,"bkr_prop_meth_table01a")

					if application then
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							local Number = 0
	
							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil
	
							Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "bkr_prop_meth_table01a", item = totalName, distance = 50, mode = "1" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
							TriggerClientEvent("inventory:Close",source)
						end
					end
				else
					TriggerClientEvent("Notify",source,"cancel","Negado","Você precisa estar em uma favela para poder montar a mesa","vermelho",5000)
				end	
			return end

			if nameItem == "tableweed" then
				
					local favela = cRP.favelaDistance(source)
					if favela == true then
						TriggerClientEvent("inventory:Close",source)
						local application,coords,heading = vRPC.objectCoords(source,"bkr_prop_weed_table_01a")
						if application then
							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								local Number = 0
	
								repeat
									Number = Number + 1
								until Objects[tostring(Number)] == nil
	
								Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "bkr_prop_weed_table_01a", item = totalName, distance = 50, mode = "1" }
								TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
								TriggerClientEvent("inventory:Close",source)
							end
						end
					else
						TriggerClientEvent("Notify",source,"cancel","Negado","Você precisa estar em uma favela para poder montar a mesa","vermelho",5000)
					end	
				
			return end

			if nameItem == "tablelean" then
				
					local favela = cRP.favelaDistance(source)
					if favela == true then
						TriggerClientEvent("inventory:Close",source)
					local application,coords,heading = vRPC.objectCoords(source,"bkr_prop_weed_table_01a")
					if application then
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "bkr_prop_weed_table_01a", item = totalName, distance = 50, mode = "1" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
							TriggerClientEvent("inventory:Close",source)
						end
					end
				
					end
			return end

			if nameItem == "tableoxy" then
				
				
				TriggerClientEvent("inventory:Close",source)
				local application,coords,heading = vRPC.objectCoords(source,"bkr_prop_weed_table_01a")
				if application then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until Objects[tostring(Number)] == nil

						Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "bkr_prop_weed_table_01a", item = totalName, distance = 50, mode = "1" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						TriggerClientEvent("inventory:Close",source)
					end
				end
			
				
			return end

			if nameItem == "adrenaline" then
				local distance = vCLIENT.adrenalineDistance(source)
                local parAmount = vRP.numPermission("Paramedic")
                if distance then
                    local otherPlayer = vRPC.nearestPlayer(source,2)
                    if otherPlayer then
                        local nuser_id = vRP.getUserId(otherPlayer)
                        if nuser_id then
                            if vRP.getHealth(otherPlayer) <= 101 then
                                Active[user_id] = os.time() + 15
                                vRPC.stopActived(source)
                                TriggerClientEvent("Progress",source,15000)
                                TriggerClientEvent("inventory:Close",source)
                                TriggerClientEvent("inventory:blockButtons",source,true)
                                vRPC.playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
                              
                                repeat
                                    if os.time() >= parseInt(Active[user_id]) then

                                        Active[user_id] = nil
                                        vRPC.removeObjects(source)
                                        TriggerClientEvent("inventory:blockButtons",source,false)

                                        if vRP.tryGetInventoryItem(user_id,totalName,1,true,slot) then
                                            vRP.upgradeThirst(user_id,10)
                                            vRP.upgradeHunger(user_id,10)
                                            vRPC.revivePlayer(otherPlayer,110)
                                            TriggerClientEvent("resetBleeding",otherPlayer)
                                        end
                                    end

                                    Citizen.Wait(10)
                                until Active[user_id] == nil
                            end
                        end
                    end
                else 
                    TriggerClientEvent("Notify",source,"cancel","Negado","Você precisa estar no hospital ilegal para usar a adrenalina!!","vermelho",5000)
                end

            return end

			if nameItem == "campfire" then
					TriggerClientEvent("inventory:Close",source)
					local application,coords,heading = vRPC.objectCoords(source,"prop_beach_fire")
					if application then
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]) - 0.6, h = heading, object = "prop_beach_fire", item = totalName, distance = 50, mode = "2" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
							TriggerClientEvent("inventory:Close",source)
						end
					end
			return end

			if nameItem == "barrier" then
					TriggerClientEvent("inventory:Close",source)
					local application,coords,heading = vRPC.objectCoords(source,"prop_mp_barrier_02b")
					if application then
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "prop_mp_barrier_02b", item = totalName, distance = 100, mode = "3" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
							TriggerClientEvent("inventory:Close",source)
						end
					end
			return end

			if nameItem == "medicbag" then
					TriggerClientEvent("inventory:Close",source)
					local application,coords,heading = vRPC.objectCoords(source,"xm_prop_x17_bag_med_01a")
					if application then
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "xm_prop_x17_bag_med_01a", item = totalName, distance = 50, mode = "5" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
							TriggerClientEvent("inventory:Close",source)
						end
					end
			return end

			if nameItem == "chair01" then
					TriggerClientEvent("inventory:Close",source)
					local application,coords,heading = vRPC.objectCoords(source,"prop_off_chair_01")
					if application then
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "prop_off_chair_01", item = totalName, distance = 50, mode = "4" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
							TriggerClientEvent("inventory:Close",source)
						end
					end
			return end

			if nameItem == "c4" then
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("cashmachine:machineRobbery",source,user_id,totalName,1,true,slot)
			return end


			if nameItem == "carp" or nameItem == "codfish" or nameItem == "catfish" or nameItem == "goldenfish" or nameItem == "horsefish" or nameItem == "tilapia" or nameItem == "pacu" or nameItem == "pirarucu" or nameItem == "tambaqui" then
				if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						vRP.generateItem(user_id,"fishfillet",2)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				else
					TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
				end
			return end

			if nameItem == "cookedfishfillet" or nameItem == "cookedmeat" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							if nameItem == "cookedfishfillet" then
								vRP.upgradeHunger(user_id,20)
							else
								vRP.upgradeHunger(user_id,30)
							end
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "hotdog" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_hotdog_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,10)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "sandwich" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_sandwich_01",49,18905,0.13,0.05,0.02,-50.0,16.0,60.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,15)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "tacos" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_taco_01",49,18905,0.16,0.06,0.02,-50.0,220.0,60.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,15)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "fries" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_food_bs_chips",49,18905,0.10,0.0,0.08,150.0,320.0,160.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,10)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "milkshake" or nameItem == "cappuccino" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,30)
							vRP.upgradeThirst(user_id,10)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "applelove" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,10)
							vRP.upgradeHunger(user_id,8)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cupcake" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,25)
							vRP.upgradeHunger(user_id,10)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "marshmallow" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 3
				TriggerClientEvent("Progress",source,3000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_suicide","pill"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,8)
							vRP.upgradeHunger(user_id,4)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "chocolate" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,10)
							vRP.upgradeHunger(user_id,5)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "donut" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_amb_donut",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,10)
							vRP.upgradeHunger(user_id,15)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "notepad" then
				if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("notepad:createNotepad",source)
				end
			return end

			if nameItem == "notebook" then
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("notebook:openSystem",source)
			return end

			if nameItem == "tyres" then
				if not vRPC.inVehicle(source) then
					if not vCLIENT.checkWeapon(source,"WEAPON_WRENCH") then
						TriggerClientEvent("Notify",source,"important","Atenção","Chave Inglesa não encontrada.","amarelo",5000)
						return
					end

					local tyreStatus,Tyre,vehNet,vehPlate = vCLIENT.tyreStatus(source)
					if tyreStatus then
						local Vehicle = NetworkGetEntityFromNetworkId(vehNet)
						if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
							if vCLIENT.tyreHealth(source,vehNet,Tyre) ~= 1000.0 then
								vRPC.stopActived(source)
								Active[user_id] = os.time() + 100
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("inventory:Buttons",source,true)
								vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

								if vTASKBAR.taskTyre(source) then
									if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
										local activePlayers = vRPC.activePlayers(source)
										for _,v in ipairs(activePlayers) do
											async(function()
												TriggerClientEvent("inventory:repairTyre",v,vehNet,Tyre,vehPlate)
											end)
										end
									end
								end

								TriggerClientEvent("inventory:Buttons",source,false)
								vRPC.stopAnim(source,false)
								Active[user_id] = nil
							end
						end
					end
				end
			return end

			if nameItem == "premiumplate" then
                if vRPC.inVehicle(source) then
                    TriggerClientEvent("inventory:Close",source)

                    local vehModel = vRPC.vehicleName(source)
                    local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehModel })

                    if vehicle[1] then

                        local vehPlate =  vRP.prompt(source,"Placa:","")
                        vehPlate = vehPlate[1]

                        if vehPlate == "" or string.upper(vehPlate) == "CREATIVE" then

                            return
                        end


                        local namePlate = vehPlate

                        local plateCheck = sanitizeString(namePlate,"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",true)


                        if string.len(namePlate) ~= 8 then

                            TriggerClientEvent("Notify",source,"important","Atenção","O nome de definição para a placa deve conter 8 caracteres.","amarelo",5000)
                            return
                        else

                            if vRP.userPlate(namePlate) then

                                TriggerClientEvent("Notify",source,"cancel","Negado","A placa escolhida já está sendo registrada em outro veículo.","vermelho",5000)
                                return
                            else

                                if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then

                                    vRP.execute("vehicles/plateVehiclesUpdate",{ user_id = user_id, vehicle = vehModel, plate = string.upper(namePlate) })
                                    TriggerClientEvent("Notify",source,"check","Sucesso","Placa atualizada.","verde",5000)
                                end
                            end
                        end
                    else
                        TriggerClientEvent("Notify",source,"cancel","Negado","Modelo de veículo não encontrado.","vermelho",5000)
                    end
                end
            return end

			if nameItem == "radio" then
				vRPC.stopActived(source)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("radio:openSystem",source)
			return end

			if nameItem == "divingsuit" then
				TriggerClientEvent("hud:Diving",source)
			return end

			if nameItem == "handcuff" then
				if not vRPC.inVehicle(source) then
					local otherPlayer = vRPC.nearestPlayer(source,0.8)
					if otherPlayer then
						if vPLAYER.getHandcuff(otherPlayer) then
							vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},false)
							Wait(3000)
							vRPC.stopAnim(source,false)
							vPLAYER.toggleHandcuff(otherPlayer)
							TriggerClientEvent("sounds:source",source,"uncuff",0.5)
							TriggerClientEvent("sounds:source",otherPlayer,"uncuff",0.5)
							TriggerClientEvent("player:Commands",otherPlayer,false)
						else
							if not vTASKBAR.taskDoors(otherPlayer) then
								TriggerClientEvent("player:playerCarry",otherPlayer,source,"handcuff")
								vRPC.playAnim(otherPlayer,false,{"mp_arrest_paired","crook_p2_back_left"},false)
							
								vRPC.playAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)

								Wait(3000)
								vRPC.stopAnim(source,false)
								vPLAYER.toggleHandcuff(otherPlayer)
								TriggerClientEvent("inventory:Close",otherPlayer)
								TriggerClientEvent("sounds:source",source,"cuff",0.5)
								TriggerClientEvent("player:Commands",otherPlayer,true)
								TriggerClientEvent("sounds:source",otherPlayer,"cuff",0.5)
								TriggerClientEvent("player:playerCarry",otherPlayer,source)
							end
						end
					end
				end
			return end

			if nameItem == "hood" then
				local otherPlayer = vRPC.nearestPlayer(source,3)
				if otherPlayer and vPLAYER.getHandcuff(otherPlayer) then
					TriggerClientEvent("hud:toggleHood",otherPlayer)
					TriggerClientEvent("inventory:Close",otherPlayer)
				end
			return end

			if nameItem == "rope" then
				if not vRPC.inVehicle(source) then
					if Carry[user_id] then
						TriggerClientEvent("player:ropeCarry",Carry[user_id],source)
						TriggerClientEvent("player:Commands",Carry[user_id],false)
						vRPC.removeObjects(Carry[user_id])
						vRPC.removeObjects(source)
						Carry[user_id] = nil
					else
						local otherPlayer = vRPC.nearestPlayer(source,3)
						if otherPlayer and (vRP.getHealth(otherPlayer) <= 101 or vPLAYER.getHandcuff(otherPlayer)) then
							Carry[user_id] = otherPlayer

							TriggerClientEvent("player:ropeCarry",Carry[user_id],source)
							TriggerClientEvent("player:Commands",Carry[user_id],true)
							TriggerClientEvent("inventory:Close",Carry[user_id])

							vRPC.playAnim(source,true,{"missfinale_c2mcs_1","fin_c2_mcs_1_camman"},true)
							vRPC.playAnim(otherPlayer,false,{"nm","firemans_carry"},true)
						end
					end
				end
			return end

			if nameItem == "premium" then
				if not vRP.userPremium(user_id) then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						vRP.setPremium(user_id)
					end
				else
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						vRP.upgradePremium(user_id)
					end
				end
			return end

			if nameItem == "pager" then
				local otherPlayer = vRPC.nearestPlayer(source,3)
				if otherPlayer then
					if vPLAYER.getHandcuff(otherPlayer) then
						local nuser_id = vRP.getUserId(otherPlayer)
						if nuser_id then
							if vRP.hasGroup(nuser_id,"Ranger") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(nuser_id,"Police")
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("radio:outServers",otherPlayer)
									vRP.updatePermission(nuser_id,"Ranger","waitRanger")
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									TriggerClientEvent("service:Label",otherPlayer,"Ranger","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"important","Atenção","Todas as comunicações foram retiradas.","amarelo",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"State") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(nuser_id,"Police")
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("radio:outServers",otherPlayer)
									vRP.updatePermission(nuser_id,"State","waitState")
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									TriggerClientEvent("service:Label",otherPlayer,"State","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"important","Atenção","Todas as comunicações foram retiradas.","amarelo",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"Lspd") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(nuser_id,"Police")
									vRP.updatePermission(nuser_id,"Lspd","waitLspd")
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("radio:outServers",otherPlayer)
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									TriggerClientEvent("service:Label",otherPlayer,"Lspd","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"important","Atenção","Todas as comunicações foram retiradas.","amarelo",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"Police") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("radio:outServers",otherPlayer)
									vRP.updatePermission(nuser_id,"Police","waitPolice")
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									TriggerClientEvent("service:Label",otherPlayer,"Police","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"important","Atenção","Todas as comunicações foram retiradas.","amarelo",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"Corrections") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(nuser_id,"Police")
									TriggerClientEvent("radio:outServers",otherPlayer)
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									vRP.updatePermission(nuser_id,"Corrections","waitCorrections")
									TriggerClientEvent("service:Label",otherPlayer,"Corrections","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"important","Atenção","Todas as comunicações foram retiradas.","amarelo",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"Paramedic") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									TriggerClientEvent("radio:outServers",otherPlayer)
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									vRP.updatePermission(nuser_id,"Paramedic","waitParamedic")
									TriggerClientEvent("service:Label",otherPlayer,"Paramedic","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"important","Atenção","Todas as comunicações foram retiradas.","amarelo",5000)
								end
							end
						end
					end
				end
			return end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if Ammos[user_id] then
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "weaponAttachs", value = json.encode(Attachs[user_id]) })
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "weaponAmmos", value = json.encode(Ammos[user_id]) })
		Attachs[user_id] = nil
		Ammos[user_id] = nil
	end

	if Active[user_id] then
		Active[user_id] = nil
	end

	if verifyObjects[user_id] then
		verifyObjects[user_id] = nil
	end

	if verifyAnimals[user_id] then
		verifyAnimals[user_id] = nil
	end

	if Loots[user_id] then
		Loots[user_id] = nil
	end

	if Healths[user_id] then
		Healths[user_id] = nil
	end

	if Armors[user_id] then
		Armors[user_id] = nil
	end

	if Scanners[user_id] then
		Scanners[user_id] = nil
	end

	if openIdentity[user_id] then
		openIdentity[user_id] = nil
	end

	if dismantleProgress[user_id] then
		local vehName = dismantleProgress[user_id]
		dismantleList[vehName] = true
		dismantleProgress[user_id] = nil
	end

	if Carry[user_id] then
		TriggerClientEvent("player:Commands",Carry[user_id],false)
		vRPC.removeObjects(Carry[user_id])
		Carry[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	Ammos[user_id] = vRP.userData(user_id,"weaponAmmos")
	Attachs[user_id] = vRP.userData(user_id,"weaponAttachs")

	TriggerClientEvent("objects:Table",source,Objects)
	TriggerClientEvent("drops:Table",source,Drops)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] ~= nil then
			Active[user_id] = nil
			vGARAGE.updateHotwired(source,false)
			TriggerClientEvent("Progress",source,1000)
			TriggerClientEvent("inventory:Buttons",source,false)

			if verifyObjects[user_id] then
				local model = verifyObjects[user_id][1]
				local hash = verifyObjects[user_id][2]

				Trashs[model][hash] = nil
				verifyObjects[user_id] = nil
			end

			if verifyAnimals[user_id] then
				local model = verifyAnimals[user_id][1]
				local netObjects = verifyAnimals[user_id][2]

				Animals[model][netObjects] = Animals[model][netObjects] - 1
				verifyAnimals[user_id] = nil
			end

			if Loots[user_id] then
				Boxes[Loots[user_id]][user_id] = nil
			end

			if dismantleProgress[user_id] then
				local vehName = dismantleProgress[user_id]
				dismantleList[vehName] = true
				dismantleProgress[user_id] = nil
			end
		end

		if openIdentity[user_id] then
			TriggerClientEvent("vRP:Identity",source)
			openIdentity[user_id] = nil
		end

		if Carry[user_id] then
			TriggerClientEvent("player:ropeCarry",Carry[user_id],source)
			TriggerClientEvent("player:Commands",Carry[user_id],false)
			vRPC.removeObjects(Carry[user_id])
			Carry[user_id] = nil
		end

		if Scanners[user_id] then
			TriggerClientEvent("inventory:updateScanner",source,false)
			TriggerClientEvent("inventory:Buttons",source,false)
			Scanners[user_id] = nil
		end

		vRPC.removeObjects(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkInventory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] ~= nil then
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.verifyWeapon(Item,Ammo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,Item)
		if consultItem[1] <= 0 then
			local wHash = itemAmmo(Item)

			if wHash ~= nil then
				if Ammos[user_id][wHash] then
					Ammos[user_id][wHash] = parseInt(Ammo)

					if Attachs[user_id][Item] ~= nil then
						for nameAttachs,_ in pairs(Attachs[user_id][Item]) do
							vRP.generateItem(user_id,nameAttachs,1)
						end

						Attachs[user_id][Item] = nil
					end

					if Ammos[user_id][wHash] > 0 then
						vRP.generateItem(user_id,wHash,Ammos[user_id][wHash])
						Ammos[user_id][wHash] = nil
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end

			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXISTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.existWeapon(Item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,Item)
		if consultItem[1] <= 0 then
			local wHash = itemAmmo(Item)

			if wHash ~= nil then
				if Ammos[user_id][wHash] then
					if Attachs[user_id][Item] ~= nil then
						for nameAttachs,_ in pairs(Attachs[user_id][Item]) do
							vRP.generateItem(user_id,nameAttachs,1)
						end

						Attachs[user_id][Item] = nil
					end

					if Ammos[user_id][wHash] > 0 then
						vRP.generateItem(user_id,wHash,Ammos[user_id][wHash])
						Ammos[user_id][wHash] = nil
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.dropWeapons(Item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,Item)
		if consultItem[1] <= 0 then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.preventWeapon(Item,Ammo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local wHash = itemAmmo(Item)

		if wHash ~= nil then
			if Ammos[user_id][wHash] then
				if Ammo > 0 then
					Ammos[user_id][wHash] = Ammo
				else
					Ammos[user_id][wHash] = nil
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeThrowable(nameItem)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.removeInventoryItem(user_id,nameItem,1,true)
		vRP.removeInventoryItem(user_id,nameItem,1,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDSITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local stealpedsitens = {
	{ item = "notepad", min = 1, max = 5 },
	{ item = "mouse", min = 1, max = 1 },
	{ item = "silverring", min = 1, max = 1 },
	{ item = "goldring", min = 1, max = 1 },
	{ item = "watch", min = 1, max = 2 },
	{ item = "ominitrix", min = 1, max = 1 },
	{ item = "bracelet", min = 1, max = 1 },
	{ item = "spray01", min = 1, max = 2 },
	{ item = "spray02", min = 1, max = 2 },
	{ item = "spray03", min = 1, max = 2 },
	{ item = "spray04", min = 1, max = 2 },
	{ item = "dices", min = 1, max = 2 },
	{ item = "dish", min = 1, max = 3 },
	{ item = "sneakers", min = 1, max = 2 },
	{ item = "rimel", min = 1, max = 3 },
	{ item = "blender", min = 1, max = 1 },
	{ item = "switch", min = 1, max = 3 },
	{ item = "brush", min = 1, max = 2 },
	{ item = "domino", min = 1, max = 3 },
	{ item = "floppy", min = 1, max = 4 },
	{ item = "deck", min = 1, max = 2 },
	{ item = "pliers", min = 1, max = 2 },
	{ item = "slipper", min = 1, max = 1 },
	{ item = "soap", min = 1, max = 1 },
	{ item = "dollars", min = 425, max = 525 },
	{ item = "card01", min = 1, max = 1 },
	{ item = "card02", min = 1, max = 1 },
	{ item = "card03", min = 1, max = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.StealPeds()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if (vRP.inventoryWeight(user_id) + 1) <= vRP.getBackpack(user_id) then
			local rand = math.random(#stealpedsitens)
			local value = math.random(stealpedsitens[rand]["min"],stealpedsitens[rand]["max"])

			vRP.generateItem(user_id,stealpedsitens[rand]["item"],value,true)
			vRP.upgradeStress(user_id,2)
		else
			TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:clearWeapons")
AddEventHandler("inventory:clearWeapons",function(user_id)
	if Ammos[user_id] then
		Ammos[user_id] = {}
		Attachs[user_id] = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:verifyObjects")
AddEventHandler("inventory:verifyObjects",function(Entity,Service)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		if Service == "Lixeiro" then
			if not vRPC.lastVehicle(source,"trash") then
				TriggerClientEvent("Notify",source,"important","Atenção","Precisa utilizar o veículo do Lixeiro.","amarelo",3000)
				return
			end
		end

		if Entity[1] ~= nil and Entity[2] ~= nil and Entity[4] ~= nil then
			local hash = Entity[1]
			local model = Entity[2]
			local coords = Entity[4]

			if verifyObjects[user_id] == nil then
				if Trashs[model] == nil then
					Trashs[model] = {}
				end

				if Trashs[model][hash] then
					TriggerClientEvent("Notify",source,"important","Atenção","Nada encontrado.","amarelo",5000)
					return
				end

				for k,v in pairs(Trashs[model]) do
					if #(v["coords"] - coords) <= 0.75 and os.time() <= v["timer"] then
						TriggerClientEvent("Notify",source,"important","Atenção","Nada encontrado.","amarelo",5000)
						return
					end
				end

				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

				verifyObjects[user_id] = { model,hash }
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				Trashs[model][hash] = { ["coords"] = coords, ["timer"] = os.time() + 3600 }

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						local itemSelect = { "",1 }

						if Service == "Lixeiro" then
							local randItem = math.random(90)
							if parseInt(randItem) >= 61 and parseInt(randItem) <= 70 then
								itemSelect = { "metalcan",math.random(5) }
							elseif parseInt(randItem) >= 51 and parseInt(randItem) <= 60 then
								itemSelect = { "battery",math.random(5) }
							elseif parseInt(randItem) >= 41 and parseInt(randItem) <= 50 then
								itemSelect = { "elastic",math.random(5) }
							elseif parseInt(randItem) >= 21 and parseInt(randItem) <= 40 then
								itemSelect = { "plasticbottle",math.random(5) }
							elseif parseInt(randItem) <= 20 then
								itemSelect = { "glassbottle",math.random(5) }
							end
						elseif Service == "Jornaleiro" then
							itemSelect = { "newspaper",math.random(2) }
						end

						if itemSelect[1] == "" then
							TriggerClientEvent("Notify",source,"important","Atenção","Nada encontrado.","amarelo",5000)
						else
							if (vRP.inventoryWeight(user_id) + (itemWeight(itemSelect[1]) * itemSelect[2])) <= vRP.getWeight(user_id) then
								vRP.generateItem(user_id,itemSelect[1],itemSelect[2],true)
								vRP.upgradeStress(user_id,1)
							else
								TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
								Trashs[model][hash] = nil
							end
						end

						verifyObjects[user_id] = nil
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			end
		else
			TriggerClientEvent("Notify",source,"important","Atenção","Nada encontrado.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:LOOTSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:lootSystem")
AddEventHandler("inventory:lootSystem",function(Entity,Service)
	local source = source
	local Entity = tostring(Entity)
	local user_id = vRP.getUserId(source)
	if user_id then
		if Loots[user_id] == nil and Active[user_id] == nil then
			if Boxes[Entity] == nil then
				Boxes[Entity] = {}
			end

			if Boxes[Entity][user_id] then
				if os.time() <= Boxes[Entity][user_id] then
					TriggerClientEvent("Notify",source,"important","Atenção","Nada encontrado.","amarelo",5000)
					return
				end
			end

			Loots[user_id] = Entity
			Active[user_id] = os.time() + 5
			TriggerClientEvent("Progress",source,5000)
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("inventory:Buttons",source,true)
			Boxes[Entity][user_id] = os.time() + lootItens[Service]["cooldown"]
			vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

			repeat
				if os.time() >= parseInt(Active[user_id]) then
					Active[user_id] = nil
					vRPC.stopAnim(source,false)
					TriggerClientEvent("inventory:Buttons",source,false)

					local itemSelect = { {"",1},{"",1},{"",1} }

					if math.random(100) <= lootItens[Service]["null"] then
						local randItem = math.random(#lootItens[Service]["list"])
						local randAmount = math.random(lootItens[Service]["list"][randItem]["min"],lootItens[Service]["list"][randItem]["max"])
						
						local randItem2 = math.random(#lootItens[Service]["list"])
						local randAmount2 = math.random(lootItens[Service]["list"][randItem2]["min"],lootItens[Service]["list"][randItem2]["max"])

						local randItem3 = math.random(#lootItens[Service]["list"])
						local randAmount3 = math.random(lootItens[Service]["list"][randItem3]["min"],lootItens[Service]["list"][randItem3]["max"])
						itemSelect = { 
							{lootItens[Service]["list"][randItem]["item"],randAmount},
							{lootItens[Service]["list"][randItem2]["item"],randAmount2},
							{lootItens[Service]["list"][randItem3]["item"],randAmount3} 
						}
					end
					
					if itemSelect[1][1] == "" or itemSelect[2][1] == "" or itemSelect[3][1] == "" then
						TriggerClientEvent("Notify",source,"important","Atenção","Nada encontrado.","amarelo",5000)
						
					else
						if (vRP.inventoryWeight(user_id) + (itemWeight(itemSelect[1][1]) * parseInt(itemSelect[1][2])) + (itemWeight(itemSelect[2][1]) * parseInt(itemSelect[2][2]))  + (itemWeight(itemSelect[3][1]) * parseInt(itemSelect[3][2]))) <= vRP.getWeight(user_id) then
							vRP.generateItem(user_id,itemSelect[1][1],itemSelect[1][2],true)
							vRP.generateItem(user_id,itemSelect[2][1],itemSelect[2][2],true)
							vRP.generateItem(user_id,itemSelect[3][1],itemSelect[3][2],true)
							vRP.upgradeStress(user_id,2)
						else
							TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
							Boxes[Entity][user_id] = nil
						end
					end

					Loots[user_id] = nil
				end

				Citizen.Wait(100)
			until Active[user_id] == nil
		end
	end
end)

-- RegisterCommand("stress",function(source)

-- 	vRP.upgradeStress(vRP.getUserId(source),2)
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:applyPlate")
AddEventHandler("inventory:applyPlate",function(Entity)
	local source = source
	local consultItem = {}
	local vehPlate = Entity[1]
	local user_id = vRP.getUserId(source)
	local idNetwork = NetworkGetEntityFromNetworkId(Entity[4])
	if user_id and Active[user_id] == nil then
		if Plates[vehPlate] == nil then
			consultItem = vRP.getInventoryItemAmount(user_id,"plate")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify",source,"important","Atenção","Precisa de <b>1x "..itemName("plate").."</b>.",5000)
				return
			end
		end

		local consultPliers = vRP.getInventoryItemAmount(user_id,"pliers")
		if consultPliers[1] <= 0 then
			TriggerClientEvent("Notify",source,"important","Atenção","Precisa de <b>1x "..itemName("pliers").."</b>.",5000)
			return
		end

		if Plates[vehPlate] ~= nil then
			if os.time() < Plates[vehPlate][1] then
				local plateTimers = parseInt(Plates[vehPlate][1] - os.time())
				if plateTimers ~= nil then
					TriggerClientEvent("Notify",source,"azul","Aguarde "..completeTimers(plateTimers)..".",5000)
				end

				return
			end
		end

		Active[user_id] = os.time() + 30
		TriggerClientEvent("Progress",source,30000)
		TriggerClientEvent("inventory:Buttons",source,true)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
		tryApplyPlate(idNetwork,source,consultItem,vehPlate)
	end
end)

function tryApplyPlate(idNetwork,source,consultItem,vehPlate)
	CreateThread(function()
		while true do 
			local user_id = vRP.getUserId(source)
			local ped = GetPlayerPed(source)
			local vehCoords = GetEntityCoords(idNetwork)
			local pedCoords = GetEntityCoords(ped)
			local distance = #(vehCoords - pedCoords)
			if distance < 5.0 then 
				if os.time() >= parseInt(Active[user_id]) then
					TriggerClientEvent("inventory:Buttons",source,false)
					if Plates[vehPlate] == nil then
						if vRP.tryGetInventoryItem(user_id,consultItem[2],1,true) then
							local newPlate = vRP.generatePlate()
							TriggerEvent("plateEveryone",newPlate)
							TriggerClientEvent("player:applyGsr",source)
							Plates[newPlate] = { os.time() + 3600,vehPlate }
							if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
								SetVehicleNumberPlateText(idNetwork,newPlate)
								TriggerClientEvent("Notify",source,"azul","Placa alterada.",5000)
							end
							Active[user_id] = nil
							vRPC.stopAnim(source,false)
						end
					else
						if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
							SetVehicleNumberPlateText(idNetwork,Plates[vehPlate][2])
						end
						if math.random(100) >= 50 then
							vRP.generateItem(user_id,"plate",1,true)
						else
							TriggerClientEvent("Notify",source,"azul","Após remove-la a mesma quebrou.",5000)
						end
						TriggerEvent("plateReveryone",vehPlate)
						Plates[vehPlate] = nil
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
					end
				end
			else
				TriggerClientEvent("Notify",source,"azul","O veículo está muito longe.",5000)
				Active[user_id] = nil
				vRPC.stopAnim(source,false)
				TriggerClientEvent("inventory:Buttons",source,false)
				break 
			end
			Wait(1)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CHECKSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:checkStockade")
AddEventHandler("inventory:checkStockade",function(Entity)
	local policeResult = vRP.numPermission("Police")
	if parseInt(#policeResult) <= 8 then
		TriggerClientEvent("Notify",source,"important","Atenção","Sistema indisponível no momento.","amarelo",5000)
		return false
	else
		local source = source
		local vehPlate = Entity[1]
		local user_id = vRP.getUserId(source)
		if user_id and Active[user_id] == nil then
			if Plates[vehPlate] then
				TriggerClientEvent("Notify",source,"cancel","Negado","Não foi encontrado o registro do veículo no sistema.","vermelho",5000)
				return
			end

			if Stockade[vehPlate] == nil then
				Stockade[vehPlate] = 0
			end

			if Stockade[vehPlate] >= 15 then
				TriggerClientEvent("Notify",source,"important","Atenção","Vazio.","amarelo",5000)
				return
			end

			if vRP.userPlate(vehPlate) then
				TriggerClientEvent("Notify",source,"important","Atenção","Veículo protegido pela seguradora.","amarelo",5000)
				return
			end

			local stockadeItens = { "WEAPON_CROWBAR","lockpick" }
			for k,v in pairs(stockadeItens) do
				local consultItem = vRP.getInventoryItemAmount(user_id,v)
				if consultItem[1] < 1 then
					TriggerClientEvent("Notify",source,"important","Atenção",""..itemName(v).." não encontrado.","amarelo",5000)
					return
				end

				if vRP.checkBroken(consultItem[2]) then
					TriggerClientEvent("Notify",source,"cancel","Negado",""..itemName(v).."quebrado.","negado",5000)
					return
				end
			end

			Stockade[vehPlate] = Stockade[vehPlate] + 1

			if vTASKBAR.taskHandcuff(source) then
				vRP.upgradeStress(user_id,10)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("player:applyGsr",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)
						vRP.generateItem(user_id,"dollars",math.random(225,275),true)
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			else
				local coords = vRPC.getEntityCoords(source)
				Stockade[vehPlate] = Stockade[vehPlate] - 1

				for k,v in pairs(policeResult) do
					async(function()
						vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Roubo ao Carro Forte", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stealTrunk(Entity)
	local source = source
	local vehNet = Entity[4]
	local vehPlate = Entity[1]
	local vehModels = Entity[2]
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local userPlate = vRP.userPlate(vehPlate)
		if not userPlate then
			if Trunks[vehPlate] == nil then
				Trunks[vehPlate] = os.time()
			end

			if os.time() >= Trunks[vehPlate] then
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
				Active[user_id] = os.time() + 100

				if vTASKBAR.stealTrunk(source) then
					Active[user_id] = os.time() + 30
					TriggerClientEvent("Progress",source,30000)
					TriggerClientEvent("inventory:Buttons",source,true)

					local activePlayers = vRPC.activePlayers(source)
					for _,v in ipairs(activePlayers) do
						async(function()
							TriggerClientEvent("player:syncDoorsOptions",v,vehNet,"open")
						end)
					end

					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.stopAnim(source,false)
							TriggerClientEvent("inventory:Buttons",source,false)

							local activePlayers = vRPC.activePlayers(source)
							for _,v in ipairs(activePlayers) do
								async(function()
									TriggerClientEvent("player:syncDoorsOptions",v,vehNet,"close")
								end)
							end

							if os.time() >= Trunks[vehPlate] then
								local randItens = math.random(#stealItens)
								if math.random(250) <= stealItens[randItens]["rand"] then
									local randAmounts = math.random(stealItens[randItens]["min"],stealItens[randItens]["max"])

									if (vRP.inventoryWeight(user_id) + (itemWeight(stealItens[randItens]["item"]) * randAmounts)) <= vRP.getWeight(user_id) then
										vRP.generateItem(user_id,stealItens[randItens]["item"],randAmounts,true)
										Trunks[vehPlate] = os.time() + 3600
										vRP.upgradeStress(user_id,2)
									else
										TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
									end
								else
									TriggerClientEvent("Notify",source,"important","Atenção","Nada encontrado.","amarelo",5000)
									Trunks[vehPlate] = os.time() + 3600
									vRP.upgradeStress(user_id,1)
								end
							end
						end

						Citizen.Wait(100)
					until Active[user_id] == nil
				else
					local activePlayers = vRPC.activePlayers(source)
					for _,v in ipairs(activePlayers) do
						async(function()
							TriggerClientEvent("inventory:vehicleAlarm",v,vehNet,vehPlate)
						end)
					end

					vRPC.stopAnim(source,false)
					Active[user_id] = nil

					local coords = vRPC.getEntityCoords(source)
					local policeResult = vRP.numPermission("Police")
					for k,v in pairs(policeResult) do
						async(function()
							TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehModels).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
						end)
					end
				end
			else
				TriggerClientEvent("Notify",source,"important","Atenção","Nada encontrado.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"important","Atenção","Veículo protegido pela seguradora.",1000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Animals")
AddEventHandler("inventory:Animals",function(Entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Entity[2] ~= nil and Entity[3] ~= nil then
			local nameItem = "switchblade"
			local consultItem = vRP.getInventoryItemAmount(user_id,nameItem)
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify",source,"important","Atenção","Necessário possuir um "..itemName(nameItem)..".","amarelo",5000)
				return
			end

			if vRP.checkBroken(consultItem[2]) then
				TriggerClientEvent("Notify",source,"cancel","Negado",""..itemName(nameItem).." quebrado.","vermelho",5000)
				return
			end

			local model = Entity[2]
			local netObjects = Entity[3]

			if Animals[model] == nil then
				Animals[model] = {}
			end

			if Animals[model][netObjects] == nil then
				Animals[model][netObjects] = 0
			end

			if verifyAnimals[user_id] == nil and Active[user_id] == nil and Animals[model][netObjects] < 5 then
				if (vRP.inventoryWeight(user_id) + itemWeight("meat")) <= vRP.getWeight(user_id) then
					if vTASKBAR.taskOne(source) then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)
						vRPC.playAnim(source,false,{"amb@medic@standing@kneel@base","base"},true)
						vRPC.playAnim(source,true,{"anim@gangops@facility@servers@bodysearch@","player_search"},true)

						TriggerClientEvent("inventory:Close",source)
						verifyAnimals[user_id] = { model,netObjects }
						TriggerClientEvent("inventory:Buttons",source,true)
						Animals[model][netObjects] = Animals[model][netObjects] + 1

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								verifyAnimals[user_id] = nil
								TriggerClientEvent("inventory:Buttons",source,false)

								if Animals[model] then
									if parseInt(Animals[model][netObjects]) <= 1 then
										vRP.generateItem(user_id,"meat",1,true)
									elseif parseInt(Animals[model][netObjects]) == 2 then
										vRP.generateItem(user_id,"meat",1,true)
									elseif parseInt(Animals[model][netObjects]) == 3 then
										local randItens = math.random(8)
										vRP.generateItem(user_id,"animalfat",randItens,true)
									elseif parseInt(Animals[model][netObjects]) == 4 then
										local randItens = math.random(4)
										vRP.generateItem(user_id,"leather",randItens,true)
									elseif parseInt(Animals[model][netObjects]) >= 5 then
										local randItens = math.random(2)
										Animals[model][netObjects] = nil
										TriggerEvent("tryDeletePed",netObjects)
										vRP.generateItem(user_id,"animalpelt",randItens,true)
									end
								end
							end

							Citizen.Wait(100)
						until Active[user_id] == nil
					end
				else
					TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"important","Atenção","Nada encontrado.","amarelo",5000)
		end
	end
end)

-------------------------------
-- cashmachine:invExplode
-------------------------------
-- evento que o chashmachine chama quando explode; dobra o item.
RegisterServerEvent("cashmachine:invExplode")
AddEventHandler("cashmachine:invExplode",function(source,nameItem,amount,t,u,i)
    local x,y,z,gridZone = vCLIENT.dropFunctions(source)
    local days = 1
    local durability = 0
    local splitName = splitString(nameItem,"-")
    local Number = 0
    repeat
        Number = Number + 1
    until Drops[tostring(Number)] == nil


    if splitName[2] ~= nil then
        durability = parseInt(os.time() - splitName[2])
        days = itemDurability(nameItem)
    end

    Drops[tostring(Number)] = {
        ["key"] = nameItem,
        ["amount"] = amount,
        ["coords"] = { t,u,i },
        ["name"] = itemName(nameItem),
        ["peso"] = itemWeight(nameItem),
        ["index"] = itemIndex(nameItem),
        ["days"] = days,
        ["durability"] = durability
    }

    TriggerClientEvent("drops:Adicionar",-1,tostring(Number),Drops[tostring(Number)])        
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local stealpedsList = {
	{ item = "notepad", min = 1, max = 5 },
	{ item = "mouse", min = 1, max = 1 },
	{ item = "silverring", min = 1, max = 1 },
	{ item = "goldring", min = 1, max = 1 },
	{ item = "watch", min = 1, max = 2 },
	{ item = "ominitrix", min = 1, max = 1 },
	{ item = "bracelet", min = 1, max = 1 },
	{ item = "spray01", min = 1, max = 2 },
	{ item = "spray02", min = 1, max = 2 },
	{ item = "spray03", min = 1, max = 2 },
	{ item = "spray04", min = 1, max = 2 },
	{ item = "dices", min = 1, max = 2 },
	{ item = "dish", min = 1, max = 3 },
	{ item = "WEAPON_SHOES", min = 1, max = 2 },
	{ item = "rimel", min = 1, max = 3 },
	{ item = "blender", min = 1, max = 1 },
	{ item = "switch", min = 1, max = 3 },
	{ item = "brush", min = 1, max = 2 },
	{ item = "domino", min = 1, max = 3 },
	{ item = "floppy", min = 1, max = 4 },
	{ item = "deck", min = 1, max = 2 },
	{ item = "pliers", min = 1, max = 2 },
	{ item = "slipper", min = 1, max = 1 },
	{ item = "soap", min = 1, max = 1 },
	{ item = "dollars", min = 425, max = 525 },
	{ item = "card01", min = 1, max = 1 },
	{ item = "card02", min = 1, max = 1 },
	{ item = "card03", min = 1, max = 1 },
	{ item = "card04", min = 1, max = 1 },
	{ item = "card05", min = 1, max = 1 }
	
}




local favelasCds = {
	{1309.46,-183.36,107.38},
	{1355.82,-734.01,67.21},
	{-2382.61,1763.36,212.07},
	{-1771.85,-247.51,52.64},
	{1258.04,-1091.24,54.16}
}


function cRP.favelaDistance(source)
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)

	for k,v in pairs(favelasCds) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 300 then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:StealPeds")
AddEventHandler("inventory:StealPeds",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if (vRP.inventoryWeight(user_id) + 1) <= vRP.getWeight(user_id) then
            vRP.upgradeStress(user_id,3)
            local rand = math.random(#stealpedsList)
            local value = math.random(stealpedsList[rand]["min"],stealpedsList[rand]["max"])
            vRP.generateItem(user_id,stealpedsList[rand]["item"],value,true)
            local ped = GetPlayerPed(source)
            local coords = GetEntityCoords(ped)
            local policeResult = vRP.numPermission("Police")
          
            for k,v in pairs(policeResult) do
                async(function()
                    vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
                    TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Roubo a pedestre", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Ligação Anônima", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
                end)
            end
        else
            TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local drugsList = {
	{ item = "cokesack", priceMin = 300, priceMax = 550, randMin = 2, randMax = 5 },
	{ item = "methsack", priceMin = 300, priceMax = 550, randMin = 2, randMax = 5 },
	{ item = "weedsack", priceMin = 300, priceMax = 550, randMin = 2, randMax = 5 },
	{ item = "oxy", priceMin = 300, priceMax = 550, randMin = 2, randMax = 5 },
	{ item = "lean", priceMin = 300, priceMax = 550, randMin = 2, randMax = 5 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.AmountDrugs()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(drugsList) do
			local randAmount = math.random(v["randMin"],v["randMax"])
			local randPrice = math.random(v["priceMin"],v["priceMax"])
			local consultItem = vRP.getInventoryItemAmount(user_id,v["item"])
			if consultItem[1] >= parseInt(randAmount) then
				userAmount[user_id] = { v["item"],randAmount,randPrice * randAmount }

				return true
			end
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRUGSPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:DrugsPeds")
AddEventHandler("inventory:DrugsPeds",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,userAmount[user_id][1],userAmount[user_id][2],true) then
			vRP.upgradeStress(user_id,3)
			TriggerClientEvent("player:applyGsr",source)
--[[ 			local status, boostnumber = exports["black_domination"]:UserHasDominatedArea() -- REPLACE DOMINATION ]]
			if status then 
				userAmount[user_id][3] = userAmount[user_id][3] * boostnumber
			end
			vRP.generateItem(user_id,"dollarsroll",userAmount[user_id][3],true)
			
			if math.random(100) >= 75 then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local policeResult = vRP.numPermission("Police")
				for k,v in pairs(policeResult) do
					async(function()
						vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Venda de Drogas", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Ligação Anônima", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:GUARDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("objects:Guardar")
AddEventHandler("objects:Guardar",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then 
		if Objects[Number] then
			vRP.giveInventoryItem(user_id,Objects[Number]["item"],1,true)
			TriggerClientEvent("objects:Remover",-1,Number)

			if tableSelect[Objects[Number]["item"]] then
				if tableSelect[Objects[Number]["item"]][Number] then
					tableSelect[Objects[Number]["item"]][Number] = nil
				end
			end

			Objects[Number] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:makeProducts")
AddEventHandler("inventory:makeProducts",function(Entity,Table)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local typeTable = splitString(Table,"-")[1]

		if tableList[typeTable] then
			if typeTable == "cemitery" then
				if not vTASKBAR.taskOne(source) then
					local coords = vRPC.getEntityCoords(source)
					local policeResult = vRP.numPermission("Police")

					for k,v in pairs(policeResult) do
						async(function()
							vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
							TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Roubo de Pertences", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
						end)
					end
				end
			end

			local model = Table
			local id = Entity[1] or Table

			if tableSelect[model] == nil then
				tableSelect[model] = {}
			end

			if tableSelect[model][id] == nil then
				tableSelect[model][id] = 0
			end

			local numberProgress = tableSelect[model][id] + 1

			if typeTable == "scanner" or typeTable == "cemitery" then
				numberProgress = math.random(#tableList[typeTable])
			end

			if tableList[typeTable][numberProgress]["item"] ~= nil then
				if vRP.checkMaxItens(user_id,tableList[typeTable][numberProgress]["item"],tableList[typeTable][numberProgress]["itemAmount"]) then
					TriggerClientEvent("Notify",source,"important","Atenção","Limite atingido.","amarelo",3000)
					return
				end

				if (vRP.inventoryWeight(user_id) + (itemWeight(tableList[typeTable][numberProgress]["item"]) * tableList[typeTable][numberProgress]["itemAmount"])) > vRP.getWeight(user_id) then
					TriggerClientEvent("Notify",source,"cancel","Negado","Mochila cheia.","vermelho",5000)
					return
				end
			end

			local tableNeed = {}
			local consultItem = {}
			if tableList[typeTable][numberProgress]["need"] ~= nil then
				local needItem = tableList[typeTable][numberProgress]["need"]

				if type(needItem) == "table" then
					for k,v in pairs(needItem) do
						consultItem = vRP.getInventoryItemAmount(user_id,v["item"])
						if consultItem[1] < v["amount"] then
							TriggerClientEvent("Notify",source,"important","Atenção","Necessário possuir <b>"..v["amount"].."x "..itemName(v["item"]).."</b>.","amarelo",5000)
							return
						end

						tableNeed[k] = { consultItem[2],v["amount"] }
					end
				else
					needAmount = tableList[typeTable][numberProgress]["needAmount"]
					consultItem = vRP.getInventoryItemAmount(user_id,needItem)
					if consultItem[1] < needAmount then
						TriggerClientEvent("Notify",source,"important","Atenção","Necessário possuir <b>"..needAmount.."x "..itemName(needItem).."</b>.","amarelo",5000)
						return
					end
				end
			end

			TriggerClientEvent("inventory:Buttons",source,true)
			Active[user_id] = os.time() + tableList[typeTable][numberProgress]["timer"]
			TriggerClientEvent("Progress",source,tableList[typeTable][numberProgress]["timer"] * 1000)

			if typeTable ~= "scanner" then
				if typeTable == "cemitery" then
					vRPC.playAnim(source,false,{"amb@medic@standing@tendtodead@idle_a","idle_a"},true)
				else
					vRPC.playAnim(source,false,{ tableList[typeTable]["anim"][1],tableList[typeTable]["anim"][2] },true)
				end
			end

			repeat
				if os.time() >= parseInt(Active[user_id]) then
					Active[user_id] = nil
					TriggerClientEvent("inventory:Buttons",source,false)

					if typeTable ~= "scanner" then
						vRPC.stopAnim(source,false)
					end

					if tableSelect[model] then
						if tableSelect[model][id] then
							tableSelect[model][id] = tableSelect[model][id] + 1

							if tableSelect[model][id] <= #tableList[typeTable] then
								if tableList[typeTable][numberProgress]["need"] ~= nil then
									local needItem = tableList[typeTable][numberProgress]["need"]

									if type(needItem) == "table" then
										for k,v in pairs(tableNeed) do
											vRP.removeInventoryItem(user_id,v[1],v[2],false)
										end
									else
										vRP.removeInventoryItem(user_id,consultItem[2],needAmount,false)
									end
								end

								if tableList[typeTable][numberProgress]["item"] ~= nil then
									vRP.generateItem(user_id,tableList[typeTable][numberProgress]["item"],tableList[typeTable][numberProgress]["itemAmount"],true)
								end

								if tableSelect[model][id] >= #tableList[typeTable] then
									tableSelect[model][id] = nil
									tableSelect[model] = nil
								end
							end
						end
					end
				end

				Citizen.Wait(100)
			until Active[user_id] == nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DESMANCHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Desmanchar")
AddEventHandler("inventory:Desmanchar",function(Entity)
	local source = source
	local vehName = Entity[2]
	local user_id = vRP.getUserId(source)

	dismantleList[vehName] = true;
	if user_id and dismantleList[vehName] and Active[user_id] == nil then
		dismantleList[vehName] = nil
		dismantleProgress[user_id] = vehName
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress",source,15000)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("inventory:Buttons",source,true)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source)
				vRP.upgradeStress(user_id,10)
				dismantleProgress[user_id] = nil
				TriggerClientEvent("player:applyGsr",source)
				TriggerClientEvent("inventory:Buttons",source,false)
				TriggerEvent("garages:deleteVehicle",Entity[4],Entity[1])

				vRP.generateItem(user_id,"plastic",math.random(8,10),true)
				vRP.generateItem(user_id,"glass",math.random(8,10),true)
				vRP.generateItem(user_id,"rubber",math.random(8,10),true)
				vRP.generateItem(user_id,"aluminum",math.random(4,6),true)
				vRP.generateItem(user_id,"copper",math.random(4,6),true)
				vRP.generateItem(user_id,"dollarsz",math.random(525,625),true)

				if math.random(1000) <= 25 then
					vRP.generateItem(user_id,"plate",1,true)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Dismantle")
AddEventHandler("inventory:Dismantle",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if os.time() >= dismantleTimer then
			dismantleUpdate()
		end

		local vehListNames = ""
		for k,v in pairs(dismantleList) do
			vehListNames = vehListNames.."<b>"..vehicleName(k).."</b>, "
		end

		TriggerClientEvent("Notify",source,"azul",vehListNames.." a lista vai ser atualizada em <b>"..(dismantleTimer - os.time()).."</b> segundos.",60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLEUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function dismantleUpdate()
	dismantleList = {}
	local amountVeh = 0
	local selectVehs = 0
	dismantleTimer = os.time() + 3600

	repeat
		selectVehs = math.random(#dismantleVehs)
		if dismantleList[dismantleVehs[selectVehs]] == nil then
			dismantleList[dismantleVehs[selectVehs]] = true
			amountVeh = amountVeh + 1
		end
	until amountVeh >= 10
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRINK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drink")
AddEventHandler("inventory:Drink",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress",source,15000)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("inventory:Buttons",source,true)
		vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","prop_plastic_cup_02",49,60309,0.0,0.0,0.1,0.0,0.0,130.0)
		
		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRP.upgradeThirst(user_id,20)
				vRPC.removeObjects(source,"one")
				TriggerClientEvent("inventory:Buttons",source,false)
			end
			
			Wait(100)
		until Active[user_id] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:removeTyres")
AddEventHandler("inventory:removeTyres",function(Entity,Tyre)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
			if vCLIENT.tyreHealth(source,Entity[4],Tyre) == 1000.0 then
				if vRP.checkMaxItens(user_id,"tyres",1) then
					TriggerClientEvent("Notify",source,"important","Atenção","Limite atingido.",3000)
					return
				end

				if vRP.userPlate(Entity[1]) then
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)
					vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

					if vTASKBAR.taskTyre(source) then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil

								local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
								if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
									if vCLIENT.tyreHealth(source,Entity[4],Tyre) == 1000.0 then
										vRP.generateItem(user_id,"tyres",1,true)

										local activePlayers = vRPC.activePlayers(source)
										for _,v in ipairs(activePlayers) do
											async(function()
												TriggerClientEvent("inventory:explodeTyres",v,Entity[4],Entity[1],Tyre)
											end)
										end
									end
								end
							end

							Citizen.Wait(100)
						until Active[user_id] == nil
					end

					TriggerClientEvent("inventory:Buttons",source,false)
					vRPC.removeObjects(source)
				end
			end
		end
	end
end)


RegisterServerEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle",function(Entity)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport  then
		TriggerClientEvent("inventory:Close",source)
		vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)
		TriggerClientEvent("Progress",source,20000)
		Wait(20000)
		vRPC.stopAnim(source,false)
		TriggerClientEvent("target:RollVehicle",source,Entity[4])
	end
end)