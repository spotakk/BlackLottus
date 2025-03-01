-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")

chekin = Tunnel.getInterface("checkin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local Selected = {}
local Sucess = false
LocalPlayer["state"]["Target"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXCLUSIVES
-----------------------------------------------------------------------------------------------------------------------------------------
local Exclusives = {
	{ 943.23,-1497.87,30.11,"Desmanche" },
	{ -1172.57,-2037.65,13.75,"Desmanche" },
	{ -574.2,-1669.71,19.23,"Desmanche" },
	{ 1358.14,-2095.41,52.0,"Desmanche" },
	{ 602.47,-437.82,24.75,"Desmanche" },
	{ -413.86,-2179.29,10.31,"Desmanche" },
	{ 376.61,-1612.39,29.28,"Reboque" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:DISMANTLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Dismantles")
AddEventHandler("target:Dismantles",function()
	for k,v in pairs(Exclusives) do
		if v[4] == "Desmanche" then
			TriggerEvent("NotifyPush",{ code = 20, title = "Localização do Desmanche", x = v[1], y = v[2], z = v[3], blipColor = 60 })
			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local tyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Interação auricular.","keyboard","LMENU")

	AddCircleZone("makePaper",vec3(-533.18,5292.15,74.17),0.75,{
		name = "makePaper",
		heading = 3374176
	},{
		distance = 0.75,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Produzir",
				tunnel = "products",
				service = "paper"
			}
		}
	})

	AddCircleZone("tabletVehicles01",vec3(-57.2,-1097.38,26.42),212.6,{
		name = "tabletVehicles01",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("Yoga01",vec3(-492.83,-217.31,35.61),0.75,{
		name = "Yoga01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga02",vec3(-492.87,-219.03,36.55),0.75,{
		name = "Yoga02",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga03",vec3(-492.89,-220.68,36.51),0.75,{
		name = "Yoga03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga04",vec3(-490.21,-220.91,36.51),0.75,{
		name = "Yoga04",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga05",vec3(-490.18,-219.24,36.58),0.75,{
		name = "Yoga05",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga06",vec3(-490.16,-217.33,36.63),0.75,{
		name = "Yoga06",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddTargetModel({ -1691644768,-742198632 },{
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher",
				tunnel = "police",
				service = "emptybottle"
			},
			{
				event = "inventory:Drink",
				label = "Beber",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1631638868,2117668672,-1498379115,-1519439119,-289946279 },{
		
		options = {
			{
				event = "target:animDeitar",
				label = "Deitar",
				tunnel = "client"
			},
			{
				event = "target:Treatment",
				label = "Tratamento",
				tunnel = "client"

			},
		},
		distance = 1.0
	})

	AddTargetModel({ -171943901,-109356459,1805980844,-99500382,1262298127,1737474779,2040839490,1037469683,867556671,-1521264200,-741944541,-591349326,-293380809,-628719744,-1317098115,1630899471,38932324,-523951410,725259233,764848282,2064599526,536071214,589738836,146905321,47332588,-1118419705,538002882,-377849416,96868307,-1195678770,-853526657,652816835 },{
		options = {
			{
				event = "target:animSentar",
				label = "Sentar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ 690372739 },{
		options = {
			{
				event = "shops:coffeeMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -654402915,1421582485 },{
		options = {
			{
				event = "shops:donutMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 992069095,1114264700 },{
		options = {
			{
				event = "shops:sodaMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1129053052 },{
		options = {
			{
				event = "shops:burgerMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -1581502570 },{
		options = {
			{
				event = "shops:hotdogMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -272361894 },{
		options = {
			{
				event = "shops:Chihuahua",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1099892058 },{
		options = {
			{
				event = "shops:waterMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -832573324,-1430839454,1457690978,1682622302,402729631,-664053099,1794449327,307287994,-1323586730,111281960,-541762431,-745300483,-417505688 },{
		options = {
			{
				event = "inventory:Animals",
				label = "Esfolar",
				tunnel = "police"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ 684586828,577432224,-1587184881,-1426008804,-228596739,1437508529,-1096777189,-468629664,1143474856,-2096124444,-115771139,1329570871,-130812911 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			}
		},
		distance = 0.75
	})
	
	AddTargetModel({ -206690185,666561306,218085040,-58485588,1511880420,682791951 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			},
			{
				event = "player:enterTrash",
				label = "Esconder",
				tunnel = "client"
			},
			{
				event = "player:checkTrash",
				label = "Verificar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1211559620,1363150739,-1186769817,261193082,-756152956,-1383056703,720581693,1287257122,917457845,-838860344 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Jornaleiro"
			}
		},
		distance = 0.75
	})

	
	AddCircleZone("dollarsRoll01",vec3(-610.87,-1089.48,25.86),0.5,{
		name = "dollarsRoll01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Empacotar 100 Rolos",
				tunnel = "police",
				service = "dollars100"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 500 Rolos",
				tunnel = "police",
				service = "dollars500"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 1000 Rolos",
				tunnel = "police",
				service = "dollars1000"
			}
		}
	})
	
	AddCircleZone("dollarsRoll03",vec3(-1181.8,-888.09,19.97),0.5,{
		name = "dollarsRoll03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Empacotar 100 Rolos",
				tunnel = "police",
				service = "dollars100"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 500 Rolos",
				tunnel = "police",
				service = "dollars500"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 1000 Rolos",
				tunnel = "police",
				service = "dollars1000"
			}
		}
	})
	
	AddCircleZone("dollarsRoll03",vec3(825.87,-828.52,26.34),0.5,{
		name = "dollarsRoll03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Empacotar 100 Rolos",
				tunnel = "police",
				service = "dollars100"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 500 Rolos",
				tunnel = "police",
				service = "dollars500"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 1000 Rolos",
				tunnel = "police",
				service = "dollars1000"
			}
		}
	})

	AddCircleZone("foodJuice01",vec3(-1190.78,-904.23,13.99),0.5,{
		name = "foodJuice01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	AddCircleZone("foodJuice02",vec3(-1190.12,-905.16,13.99),0.5,{
		name = "foodJuice02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	AddCircleZone("foodJuice03",vec3(1585.82,6459.13,26.02),0.5,{
		name = "foodJuice03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	AddCircleZone("foodJuice04",vec3(810.69,-764.42,26.77),0.5,{
		name = "foodJuice04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	AddCircleZone("foodBurger01",vec3(-1197.38,-897.58,13.88),0.5,{ 
		name = "foodBurger01",
		heading = 34867
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "foodBurger"
			}
		}
	})

--[[ 	AddCircleZone("jewelry01",vec3(-626.67,-238.58,38.05),0.75,{
		name = "jewelry01",
		heading = 3374176
	},{
		shop = "1",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry02",vec3(-625.66,-237.86,38.05),0.75,{
		name = "jewelry02",
		heading = 3374176
	},{
		shop = "2",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry03",vec3(-626.84,-235.35,38.05),0.75,{
		name = "jewelry03",
		heading = 3374176
	},{
		shop = "3",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry04",vec3(-625.83,-234.6,38.05),0.75,{
		name = "jewelry04",
		heading = 3374176
	},{
		shop = "4",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry05",vec3(-626.9,-233.15,38.05),0.75,{
		name = "jewelry05",
		heading = 3374176
	},{
		shop = "5",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry06",vec3(-627.94,-233.92,38.05),0.75,{
		name = "jewelry06",
		heading = 3374176
	},{
		shop = "6",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry07",vec3(-620.22,-234.44,38.05),0.75,{
		name = "jewelry07",
		heading = 3374176
	},{
		shop = "7",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry08",vec3(-619.16,-233.7,38.05),0.75,{
		name = "jewelry08",
		heading = 3374176
	},{
		shop = "8",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry09",vec3(-617.56,-230.57,38.05),0.75,{
		name = "jewelry09",
		heading = 3374176
	},{
		shop = "9",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry10",vec3(-618.29,-229.49,38.05),0.75,{
		name = "jewelry10",
		heading = 3374176
	},{
		shop = "10",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry11",vec3(-619.68,-227.63,38.05),0.75,{
		name = "jewelry11",
		heading = 3374176
	},{
		shop = "11",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry12",vec3(-620.43,-226.56,38.05),0.75,{
		name = "jewelry12",
		heading = 3374176
	},{
		shop = "12",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry13",vec3(-623.92,-227.06,38.05),0.75,{
		name = "jewelry13",
		heading = 3374176
	},{
		shop = "13",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry14",vec3(-624.97,-227.84,38.05),0.75,{
		name = "jewelry14",
		heading = 3374176
	},{
		shop = "14",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry15",vec3(-624.42,-231.08,38.05),0.75,{
		name = "jewelry15",
		heading = 3374176
	},{
		shop = "15",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry16",vec3(-623.98,-228.18,38.05),0.75,{
		name = "jewelry16",
		heading = 3374176
	},{
		shop = "16",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry17",vec3(-621.08,-228.58,38.05),0.75,{
		name = "jewelry17",
		heading = 3374176
	},{
		shop = "17",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry18",vec3(-619.72,-230.43,38.05),0.75,{
		name = "jewelry18",
		heading = 3374176
	},{
		shop = "18",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry19",vec3(-620.14,-233.31,38.05),0.75,{
		name = "jewelry19",
		heading = 3374176
	},{
		shop = "19",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry20",vec3(-623.05,-232.95,38.05),0.75,{
		name = "jewelry20",
		heading = 3374176
	},{
		shop = "20",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelryHacker",vec3(-631.38,-230.24,38.05),0.75,{
		name = "jewelryHacker",
		heading = 3374176
	},{
		distance = 0.75,
		options = {
			{
				event = "robberys:initJewelry",
				label = "Hackear",
				tunnel = "server"
			}
		}
	}) ]]

	AddCircleZone("divingStore",vec3(1521.08,3780.19,34.46),0.5,{
		name = "divingStore",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "shops:divingSuit",
				label = "Comprar Traje",
				tunnel = "server"
			},{
				event = "hud:rechargeOxigen",
				label = "Reabastecer Oxigênio",
				tunnel = "client"
			}
		}
	})


	AddCircleZone("cemiteryMan",vec3(-1745.57,-205.19,57.37),0.75,{
		name = "cemiteryMan",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "cemitery:initBody",
				label = "Conversar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("CassinoWheel",vec3(1111.64,226.99,-49.64),0.5,{
		name = "CassinoWheel",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "luckywheel:Target",
				label = "Roda da Fortuna",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetEnable()
	if LocalPlayer["state"]["Active"] then
		local ped = PlayerPedId()

		if LocalPlayer["state"]["Buttons"] or LocalPlayer["state"]["Commands"] or LocalPlayer["state"]["Handcuff"] or Sucess or IsPedArmed(ped,6) or IsPedInAnyVehicle(ped) or not MumbleIsConnected() or LocalPlayer["state"]["Route"] > 900000 then
			return
		end

		LocalPlayer["state"]["Target"] = true
		SendNUIMessage({ response = "openTarget" })

		while LocalPlayer["state"]["Target"] do
			local hitZone,entCoords,entity = RayCastGamePlayCamera()

			if hitZone == 1 then
				local coords = GetEntityCoords(ped)

				for k,v in pairs(Zones) do
					if Zones[k]:isPointInside(entCoords) then
						if #(coords - Zones[k]["center"]) <= v["targetoptions"]["distance"] then

							if v["targetoptions"]["shop"] ~= nil then
								Selected = v["targetoptions"]["shop"]
							end

							if v["targetoptions"]["shopserver"] ~= nil then
								Selected = v["targetoptions"]["shopserver"]
							end

							SendNUIMessage({ response = "validTarget", data = Zones[k]["targetoptions"]["options"] })

							Sucess = true
							while Sucess do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if not Zones[k]:isPointInside(entCoords) or #(coords - Zones[k]["center"]) > v["targetoptions"]["distance"] then
									Sucess = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					end
				end

				if GetEntityType(entity) ~= 0 then
					if IsEntityAVehicle(entity) then
						local vehPlate = GetVehicleNumberPlateText(entity)
						if #(coords - entCoords) <= 1.5 and vehPlate ~= "PDMSPORT" then
							local vehNet = nil
							local Combustivel = false
							local vehModel = GetEntityModel(entity)
							local Menu = {}
							SetEntityAsMissionEntity(entity,true,true)

							if NetworkGetEntityIsNetworked(entity) then
								vehNet = VehToNet(entity)
							end

							Selected = { vehPlate,vRP.vehicleModel(vehModel),entity,vehNet }

							
							local StatusQFuel = exports["black_combustivel"]:GetStatus()
							if StatusQFuel.name then
								table.insert(Menu,{ event = StatusQFuel.event, label = StatusQFuel.name, tunnel = "client",typefuel = true })
								--goto pular
							end

							
							if not Combustivel then
								if GlobalState["vehPlates"][vehPlate] then
									if GetVehicleDoorLockStatus(entity) == 1 then
										for k,Tyre in pairs(tyreList) do
											local Wheel = GetEntityBoneIndexByName(entity,k)
											if Wheel ~= -1 then
												local cWheel = GetWorldPositionOfEntityBone(entity,Wheel)
												local Distance = #(coords - cWheel)
												if Distance <= 1.0 then
													Selected[5] = Tyre
													table.insert(Menu,{ event = "inventory:removeTyres", label = "Retirar Pneu", tunnel = "client" })
												end
											end
										end

										table.insert(Menu,{ event = "trunkchest:openTrunk", label = "Abrir Porta-Malas", tunnel = "server" })
									end

									table.insert(Menu,{ event = "garages:vehicleKey", label = "Criar Chave Cópia", tunnel = "police" })
									table.insert(Menu,{ event = "player:RollVehicle", label = "Desvirar", tunnel = "server"  })
									table.insert(Menu,{ event = "inventory:applyPlate", label = "Trocar Placa", tunnel = "server" })
								else
									if Selected[2] == "stockade" then
										table.insert(Menu,{ event = "inventory:checkStockade", label = "Vasculhar", tunnel = "police" })
									end
								end

								if not IsThisModelABike(vehModel) then
									if GetEntityBoneIndexByName(entity,"boot") ~= -1 then
										local Trunk = GetEntityBoneIndexByName(entity,"boot")
										local cTrunk = GetWorldPositionOfEntityBone(entity,Trunk)
										local Distance = #(coords - cTrunk)
										if Distance <= 1.75 then
											if GetVehicleDoorLockStatus(entity) == 1 then
												table.insert(Menu,{ event = "player:enterTrunk", label = "Entrar no Porta-Malas", tunnel = "client" })
											end

											table.insert(Menu,{ event = "inventory:stealTrunk", label = "Arrombar Porta-Malas", tunnel = "client" })
										
										end
									end
								end



								if LocalPlayer["state"]["Police"] then
									table.insert(Menu,{ event = "police:runPlate", label = "Verificar Placa", tunnel = "police" })
									table.insert(Menu,{ event = "police:impound", label = "Registrar Veículo", tunnel = "police" })

									if GlobalState["vehPlates"][vehPlate] then
										table.insert(Menu,{ event = "police:runArrest", label = "Apreender Veículo", tunnel = "police" })
									end
								else
									for _,v in pairs(Exclusives) do
										local Distance = #(coords - vector3(v[1],v[2],v[3]))
										if Distance <= 10 then
											if v[4] == "Desmanche" and vehPlate == "DISM"..(1000 + LocalPlayer["state"]["Id"]) then
												table.insert(Menu,{ event = "inventory:Desmanchar", label = "Desmanchar", tunnel = "police" })
											elseif v[4] == "Reboque" then
												table.insert(Menu,{ event = "towdriver:Tow", label = "Rebocar", tunnel = "client" })
												table.insert(Menu,{ event = "impound:Check", label = "Impound", tunnel = "police" })
											end
										end
									end
								end
							else
								Selected[5] = false
							end
							--::pular::
							SendNUIMessage({ response = "validTarget", data = Menu })

							Sucess = true
							while Sucess do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords,entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									Sucess = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					elseif IsPedAPlayer(entity) then
						if #(coords - entCoords) <= 1.0 then
							local index = NetworkGetPlayerIndexFromPed(entity)
							local source = GetPlayerServerId(index)
							local Menu = {}

							Selected = { source }

							if LocalPlayer["state"]["Police"] then
								table.insert(Menu,{ event = "police:runInspect", label = "Revistar", tunnel = "police" })
								table.insert(Menu,{ event = "police:prisonClothes", label = "Uniforme Presidiário", tunnel = "police" })
								table.insert(Menu,{ event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" })
							elseif LocalPlayer["state"]["Paramedic"] then
								if GetEntityHealth(entity) <= 101 then
									table.insert(Menu,{ event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" })
								else
									table.insert(Menu,{ event = "paramedic:Treatment", label = "Tratamento", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:Repose", label = "Colocar de Repouso", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:Bandage", label = "Passar Ataduras", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:presetBurn", label = "Roupa de Queimadura", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:presetPlaster", label = "Colocar Gesso", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:extractBlood", label = "Extrair Sangue", tunnel = "paramedic" })
								end

								table.insert(Menu,{ event = "paramedic:Diagnostic", label = "Informações", tunnel = "paramedic" })
								table.insert(Menu,{ event = "paramedic:Bed", label = "Deitar Paciente", tunnel = "paramedic" })
							else
								table.insert(Menu,{ event = "police:runInspect", label = "Revistar", tunnel = "police" })
							end

							SendNUIMessage({ response = "validTarget", data = Menu })

							Sucess = true
							while Sucess do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords,entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									Sucess = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					else
						for k,v in pairs(Models) do
							if DoesEntityExist(entity) then
								if k == GetEntityModel(entity) then
									if #(coords - entCoords) <= Models[k]["distance"] then
										local objNet = nil
										if NetworkGetEntityIsNetworked(entity) then
											objNet = ObjToNet(entity)
										end

										Selected = { entity,k,objNet,GetEntityCoords(entity) }

										SendNUIMessage({ response = "validTarget", data = Models[k]["options"] })

										Sucess = true
										while Sucess do
											local ped = PlayerPedId()
											local coords = GetEntityCoords(ped)
											local _,entCoords,entity = RayCastGamePlayCamera()

											if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
												SetCursorLocation(0.5,0.5)
												SetNuiFocus(true,true)
											end

											if GetEntityType(entity) == 0 or #(coords - entCoords) > Models[k]["distance"] then
												Sucess = false
											end

											Citizen.Wait(1)
										end

										SendNUIMessage({ response = "leftTarget" })
									end
								end
							end
						end
					end
				end
			end

			Citizen.Wait(100)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
local bedAttach = false
local beds = {
	[1631638868] = { 0.0,0.0 },
	[2117668672] = { 0.0,0.0 },
	[-1498379115] = { 1.0,90.0 },
	[-1519439119] = { 1.0,0.0 },
	[-289946279] = { 1.0,0.0 },
	[-935625561] = { 0.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:animDeitar")
AddEventHandler("target:animDeitar",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(Selected[1])

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + beds[Selected[2]][1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(Selected[1]) + beds[Selected[2]][2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)

			if Selected[2] == -935625561 then
				AttachEntityToEntity(ped,Selected[1],11816,0.0,0.0,1.0,0.0,0.0,0.0,false,false,false,false,2,true)
				bedAttach = Selected[1]
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Treatment")
AddEventHandler("target:Treatment",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		
		if chekin.checkParamedicServices() then 
			return 
		end
		if GetEntityHealth(ped) > 101 then
			LocalPlayer["state"]["Cancel"] = true
			LocalPlayer["state"]["Commands"] = true
			local objCoords = GetEntityCoords(Selected[1])

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + beds[Selected[2]][1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(Selected[1]) + beds[Selected[2]][2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
			
			if Selected[2] == -935625561 then
				AttachEntityToEntity(ped,Selected[1],11816,0.0,0.0,1.0,0.0,0.0,0.0,false,false,false,false,2,true)
				bedAttach = Selected[1]
			end
			TriggerEvent('checkin:startTreatment')
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDPICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:bedPickup")
AddEventHandler("target:bedPickup",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local spawnObjects = 0
			local uObject = NetworkGetEntityFromNetworkId(Selected[3])
			local objectControl = NetworkRequestControlOfEntity(uObject)
			while not objectControl and spawnObjects <= 1000 do
				objectControl = NetworkRequestControlOfEntity(uObject)
				spawnObjects = spawnObjects + 1
				Citizen.Wait(1)
			end

			AttachEntityToEntity(uObject,ped,11816,0.0,1.25,-0.15,0.0,0.0,0.0,false,false,false,false,2,true)
			bedAttach = Selected[1]
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDDETACH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:bedDetach")
AddEventHandler("target:bedDetach",function()
	if bedAttach then
		DetachEntity(PlayerPedId(),false,false)
		FreezeEntityPosition(bedAttach,true)
		DetachEntity(bedAttach,false,false)
		bedAttach = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:bedDestroy")
AddEventHandler("target:bedDestroy",function()
	if not LocalPlayer["state"]["Commands"] and LocalPlayer["state"]["Paramedic"] then
		TriggerServerEvent("tryDeleteObject",Selected[3])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PACIENTEDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:pacienteDeitar")
AddEventHandler("target:pacienteDeitar",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(coords["x"],coords["y"],coords["z"],0.9,k,0,0,0)
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + v[1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(object) + v[2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)

			if k == -935625561 then
				AttachEntityToEntity(ped,object,11816,0.0,0.0,1.0,0.0,0.0,0.0,false,false,false,false,2,true)
				bedAttach = object
			end

			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SENTAR
-----------------------------------------------------------------------------------------------------------------------------------------
local chairs = {
	[-171943901] = 0.0,
	[-109356459] = 0.5,
	[1805980844] = 0.5,
	[-99500382] = 0.3,
	[1262298127] = 0.0,
	[1737474779] = 0.5,
	[2040839490] = 0.0,
	[1037469683] = 0.4,
	[867556671] = 0.4,
	[-1521264200] = 0.0,
	[-741944541] = 0.4,
	[-591349326] = 0.5,
	[-293380809] = 0.5,
	[-628719744] = 0.5,
	[-1317098115] = 0.5,
	[1630899471] = 0.5,
	[38932324] = 0.5,
	[-523951410] = 0.5,
	[725259233] = 0.5,
	[764848282] = 0.5,
	[2064599526] = 0.5,
	[536071214] = 0.5,
	[589738836] = 0.5,
	[146905321] = 0.5,
	[47332588] = 0.5,
	[-1118419705] = 0.5,
	[538002882] = -0.1,
	[-377849416] = 0.5,
	[96868307] = 0.5,
	[-1195678770] = 0.7,
	[-853526657] = -0.1,
	[652816835] = 0.8
}

RegisterNetEvent("target:animSentar")
AddEventHandler("target:animSentar",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(Selected[1])

			FreezeEntityPosition(Selected[1],true)
			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + chairs[Selected[2]],1,0,0,0)
			if chairs[Selected[2]] == 0.7 then
				SetEntityHeading(ped,GetEntityHeading(Selected[1]))
			else
				SetEntityHeading(ped,GetEntityHeading(Selected[1]) - 180.0)
			end

			vRP.playAnim(false,{ task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetDisable()
	if Sucess or not LocalPlayer["state"]["Target"] then
		return
	end

	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ response = "closeTarget" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("selectTarget",function(data)
	Sucess = false
	SetNuiFocus(false,false)
	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ response = "closeTarget" })

	if data["tunnel"] == "client" then
		TriggerEvent(data["event"],Selected)
	elseif data["tunnel"] == "server" then
		TriggerServerEvent(data["event"],Selected)
	elseif data["tunnel"] == "shop" then
		TriggerEvent(data["event"],Selected)
	elseif data["tunnel"] == "shopserver" then
		TriggerServerEvent(data["event"],Selected)
	elseif data["tunnel"] == "boxes" then
		TriggerServerEvent(data["event"],Selected,data["service"])
	elseif data["tunnel"] == "paramedic" then
		TriggerServerEvent(data["event"],Selected[1])
	elseif data["tunnel"] == "police" then
		TriggerServerEvent(data["event"],Selected,data["service"])
	elseif data["tunnel"] == "products" then
		TriggerServerEvent(data["event"],data["service"])
	elseif data["tunnel"] == "objects" then
		TriggerServerEvent(data["event"],Selected[3])
	else
		TriggerServerEvent(data["event"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSETARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeTarget",function()
	Sucess = false
	SetNuiFocus(false,false)
	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:resetDebug")
AddEventHandler("target:resetDebug",function()
	Sucess = false
	SetNuiFocus(false,false)
	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
	local rotation = GetGameplayCamRot()
	local adjustedRotation = vector3((math.pi / 180) * rotation["x"],(math.pi / 180) * rotation["y"],(math.pi / 180) * rotation["z"])
	local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.sin(adjustedRotation[1]))

	return vector3(Coords[1] + direction[1] * Distance, Coords[2] + direction[2] * Distance, Coords[3] + direction[3] * Distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera()
	local Ped = PlayerPedId()
	local Cam = GetGameplayCamCoord()
	local Cam2 = GetCoordsFromCam(10.0,Cam)
	local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam,Cam2,-1,Ped,4)
	local a,Hit,Coords,b,Entity = GetShapeTestResult(Handle)

	return Hit,Coords,Entity
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(Name,Center,Radius,Options,Target)
	Zones[Name] = CircleZone:Create(Center,Radius,Options)
	Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(Name)
	if Zones[Name] then
		Zones[Name] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(Model,Options)
	for _,v in pairs(Model) do
		Models[v] = Options
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name,Text)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"][1]["label"] = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBOXZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddBoxZone(Name,Center,Length,Width,Options,Target)
    Zones[Name] = BoxZone:Create(Center,Length,Width,Options)
    Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText",LabelText)
exports("AddBoxZone",AddBoxZone)
exports("RemCircleZone",RemCircleZone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)