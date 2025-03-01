-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("works", cRP)
vCLIENT = Tunnel.getInterface("works")

function cRP.modelPlayer()
	local source = source
	local ped = GetPlayerPed(source)
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		return "mp_m_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		return "mp_f_freemode_01"
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local works = {
	["Transportador"] = {
		["coords"] = { 354.27, 271.05, 103.04 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = true,
		["deliveryVehicle"] = 1747439474,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 10,
		["collectDuration"] = 10000,
		["collectText"] = "VASCULHAR",
		["deliveryText"] = "ENTREGAR",
		["collectAnim"] = { false, "amb@prop_human_atm@male@idle_a", "idle_a", true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 3
		},
		["collectCoords"] = {
			{ 264.76, 216.18, 101.67, 345.83 },
			{ 266.38, 214.51, 101.67, 246.62 },
			{ 265.81, 212.95, 101.67, 238.12 },
			{ 264.33, 212.0,  101.67, 150.24 },
			{ 263.2,  212.41, 101.67, 141.74 },
			{ 262.08, 212.83, 101.67, 147.41 },
			{ 263.56, 216.53, 101.67, 340.16 },
			{ 259.64, 217.97, 101.67, 340.16 },
			{ 258.24, 214.22, 101.67, 158.75 },
			{ 259.57, 213.76, 101.67, 155.91 }
		},
		["deliveryItem"] = "pouch",
		["deliveryName"] = "Malotes",
		["deliveryConsume"] = {
			["min"] = 2,
			["max"] = 3
		},
		["deliveryCoords"] = {
			{ 285.47,   143.37,   104.17, 158.75 },
			{ 527.36,   -160.7,   57.09,  272.13 },
			{ 1153.64,  -326.75,  69.2,   99.22 },
			{ 1167.01,  -456.07,  66.79,  345.83 },
			{ 1138.25,  -468.9,   66.73,  73.71 },
			{ 1077.71,  -776.5,   58.23,  187.09 },
			{ -254.37,  -692.5,   33.6,   147.41 },
			{ 296.46,   -894.25,  29.23,  249.45 },
			{ 295.76,   -896.14,  29.22,  252.29 },
			{ 129.22,   -1291.12, 29.27,  308.98 },
			{ 130.07,   -1292.65, 29.27,  303.31 },
			{ 289.1,    -1256.87, 29.44,  277.8 },
			{ 288.82,   -1282.36, 29.64,  272.13 },
			{ 126.85,   -1296.59, 29.27,  25.52 },
			{ 127.84,   -1296.03, 29.27,  28.35 },
			{ 33.16,    -1348.25, 29.49,  175.75 },
			{ 24.48,    -945.95,  29.35,  343.0 },
			{ 5.24,     -919.83,  29.55,  252.29 },
			{ 112.58,   -819.4,   31.34,  158.75 },
			{ 114.44,   -776.41,  31.41,  343.0 },
			{ 111.25,   -775.25,  31.44,  345.83 },
			{ -27.99,   -724.54,  44.23,  345.83 },
			{ -30.19,   -723.71,  44.23,  343.0 },
			{ -203.8,   -861.37,  30.26,  31.19 },
			{ -301.7,   -830.01,  32.42,  351.5 },
			{ -303.24,  -829.74,  32.42,  354.34 },
			{ -258.87,  -723.38,  33.48,  70.87 },
			{ -256.2,   -715.99,  33.53,  73.71 },
			{ -254.41,  -692.49,  33.6,   161.58 },
			{ -537.85,  -854.49,  29.28,  178.59 },
			{ -660.73,  -854.07,  24.48,  187.09 },
			{ -710.01,  -818.9,   23.72,  0.0 },
			{ -712.89,  -818.92,  23.72,  0.0 },
			{ -717.7,   -915.65,  19.21,  85.04 },
			{ -821.63,  -1081.88, 11.12,  31.19 },
			{ -1315.71, -834.75,  16.95,  314.65 },
			{ -1314.75, -836.03,  16.95,  314.65 },
			{ -1305.41, -706.37,  25.33,  127.56 },
			{ -1570.14, -546.72,  34.95,  218.27 },
			{ -1571.06, -547.39,  34.95,  215.44 },
			{ -1415.94, -212.04,  46.51,  235.28 },
			{ -1430.18, -211.06,  46.51,  113.39 },
			{ -1409.76, -100.47,  52.39,  104.89 },
			{ -1410.32, -98.75,   52.42,  110.56 },
			{ -1282.52, -210.92,  42.44,  306.15 },
			{ -1286.28, -213.44,  42.44,  119.06 },
			{ -1285.54, -224.32,  42.44,  306.15 },
			{ -1289.31, -226.78,  42.44,  124.73 },
			{ -1205.02, -326.3,   37.83,  113.39 },
			{ -1205.78, -324.8,   37.86,  116.23 },
			{ -866.69,  -187.74,  37.84,  121.89 },
			{ -867.63,  -186.07,  37.84,  119.06 },
			{ -846.31,  -341.26,  38.67,  113.39 },
			{ -846.81,  -340.2,   38.67,  116.23 },
			{ -721.06,  -415.58,  34.98,  269.3 },
			{ -556.18,  -205.18,  38.22,  119.06 },
			{ -57.66,   -92.65,   57.78,  294.81 },
			{ 89.73,    2.46,     68.29,  343.0 },
			{ -165.17,  232.77,   94.91,  90.71 },
			{ -165.16,  234.8,    94.91,  85.04 },
			{ 158.6,    234.23,   106.63, 343.0 },
			{ 228.18,   338.38,   105.56, 158.75 },
			{ 380.76,   323.4,    103.56, 158.75 },
			{ 357.01,   173.54,   103.07, 340.16 }
		},
		["deliveryPayment"] = {
			["min"] = 150,
			["max"] = 230,
			["item"] = "dollars"
		}
	},
	["Lenhador"] = {
		["coords"] = { -840.22, 5399.23, 34.61 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["deliveryVehicle"] = -667151410,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 150,
		["collectDuration"] = 3000,
		["collectText"] = "CORTAR",
		["deliveryText"] = "ENTREGAR",
		["collectAnim"] = { false, "melee@hatchet@streamed_core", "plyr_front_takedown_b", true },
		["collectConsume"] = {
			["min"] = 3,
			["max"] = 5
		},
		["collectCoords"] = {
			{ -642.97, 5461.49, 53.42, 161.0 },
			{ -632.4,  5466.41, 53.66, 283.15 },
			{ -629.19, 5470.14, 53.64, 312.44 },
			{ -625.47, 5474.39, 53.31, 131.34 },
			{ -620.03, 5488.33, 51.58, 312.19 },
			{ -633.65, 5505.16, 51.26, 33.24 },
			{ -637.87, 5503.96, 51.48, 57.04 },
			{ -662.4,  5496.55, 48.73, 120.35 },
			{ -666.62, 5497.73, 47.89, 88.0 },
			{ -660.21, 5490.28, 49.71, 293.86 },
			{ -637.85, 5441.62, 52.52, 192.87 },
			{ -616.07, 5433.55, 53.41, 228.47 },
			{ -615.3,  5424.46, 51.07, 102.64 },
			{ -595.79, 5450.51, 58.97, 315.87 },
			{ -586.94, 5447.71, 60.17, 265.4 },
			{ -597.49, 5472.95, 56.5,  23.67 },
			{ -583.59, 5490.44, 55.83, 24.95 },
			{ -588.84, 5493.79, 54.45, 32.45 },
			{ -617.65, 5489.06, 51.64, 93.35 },
			{ -619.22, 5498.12, 51.31, 122.45 }
		},
		["deliveryItem"] = "woodlog",
		["deliveryName"] = "Toras de Madeira",
		["deliveryConsume"] = {
			["min"] = 3,
			["max"] = 5
		},
		["deliveryCoords"] = {
			{ -513.92,  -1019.31, 23.47 },
			{ -1604.18, -832.26,  10.08 },
			{ -536.48,  -45.61,   42.57 },
			{ -53.01,   79.35,    71.62 },
			{ 581.16,   139.13,   99.48 },
			{ 814.39,   -93.48,   80.6 },
			{ 1106.93,  -355.03,  67.01 },
			{ 1070.71,  -780.46,  58.36 },
			{ 1142.82,  -986.58,  45.91 },
			{ 1200.55,  -1276.6,  35.23 },
			{ 967.81,   -1829.29, 31.24 },
			{ 809.16,   -2222.61, 29.65 },
			{ 684.61,   -2741.62, 6.02 },
			{ 263.47,   -2506.62, 6.45 },
			{ 94.66,    -2676.38, 6.01 },
			{ -43.87,   -2519.91, 7.4 },
			{ 182.93,   -2027.68, 18.28 },
			{ -306.86,  -2191.84, 10.84 },
			{ -570.95,  -1775.95, 23.19 },
			{ -350.03,  -1569.9,  25.23 },
			{ -128.36,  -1394.12, 29.57 },
			{ 67.84,    -1399.02, 29.37 },
			{ 343.13,   -1297.91, 32.51 },
			{ 485.92,   -1477.41, 29.29 },
			{ 139.81,   -1337.41, 29.21 },
			{ 263.82,   -1346.16, 31.93 },
			{ -723.33,  -1112.41, 10.66 },
			{ -842.54,  -1128.21, 7.02 },
			{ 488.46,   -898.56,  25.94 }
		},
		["deliveryPayment"] = {
			["min"] = 140,
			["max"] = 188,
			["item"] = "dollars"
		}
	},
	["Burguer"] = {
		["coords"] = { -1202.8, -895.67, 13.88 },
		["perm"] = "Burguer",
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["deliveryVehicle"] = -667151410,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 150,
		["collectDuration"] = 3000,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectAnim"] = { false, "amb@prop_human_parking_meter@female@idle_a", "idle_a_female", true },
		["collectConsume"] = {
			["min"] = 1,
			["max"] = 3
		},
		["collectCoords"] = {
			{ -1195.96, -897.99, 13.88, 340.16 },
			{ -1194.72, -898.43, 13.88, 334.49 },
			{ -1195.3,  -899.55, 13.88, 150.24 },
			{ -1196.7,  -899.15, 13.88, 161.58 },
			{ -1198.15, -898.65, 13.88, 158.75 },
			{ -1195.7,  -895.7,  13.88, 167.25 },
			{ -1194.18, -896.04, 13.88, 161.58 },
			{ -1190.75, -898.06, 13.88, 223.94 },
			{ -1191.62, -898.72, 13.88, 201.26 }
		},
		["deliveryItem"] = {
			"ketchup",
			"bread",
			"carne",
			"tomato"
		},
		["deliveryName"] = "Caixa de Lanches",
		["deliveryConsume"] = {
			["min"] = 1,
			["max"] = 2
		},
		["deliveryPayment"] = {
			["min"] = 140,
			["max"] = 188,
			["item"] = "dollars"
		}
	},
	["Minerador"] = {
		["coords"] = { -594.55, 2090.22, 131.66 },
		["upgradeStress"] = 3,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "MINERAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 500,
		["collectDuration"] = 10000,
		["collectAnim"] = { false, "amb@world_human_const_drill@male@drill@base", "base", true },
		["collectCoords"] = {
			{ -594.48, 2078.32, 131.49, 111.27 },
			{ -590.01, 2071.21, 131.25, 283.37 },
			{ -593.92, 2086.1,  131.55, 294.14 },
			{ -595.53, 2082.65, 131.4,  115.66 },
			{ -593.26, 2073.58, 131.48, 122.9 },
			{ -591.62, 2067.49, 131.14, 101.34 },
			{ -587.56, 2059.36, 130.62, 261.0 },
			{ -587.86, 2046.26, 129.73, 113.01 },
			{ -581.25, 2038.74, 128.9,  291.79 },
			{ -578.84, 2030.44, 128.46, 139.78 },
			{ -575.2,  2029.87, 128.16, 311.61 },
			{ -572.84, 2023.1,  127.97, 147.26 },
			{ -562.19, 2011.42, 127.37, 137.24 },
			{ -552.5,  1995.96, 127.13, 138.71 },
			{ -549.39, 1996.32, 127.04, 298.78 },
			{ -546.6,  1984.63, 127.14, 130.33 },
			{ -537.84, 1983.05, 127.03, 344.33 },
			{ -532.34, 1979.37, 127.16, 172.22 },
			{ -532.88, 1982.12, 126.98, 357.71 },
			{ -523.88, 1980.77, 126.76, 354.06 },
			{ -517.11, 1977.65, 126.66, 169.55 },
			{ -508.15, 1980.3,  126.18, 359.44 },
			{ -506.07, 1977.91, 126.22, 182.76 },
			{ -494.45, 1983.43, 125.12, 34.27 },
			{ -486.15, 1984.21, 124.43, 203.23 },
			{ -475.34, 1990.61, 123.75, 30.17 },
			{ -459.43, 1998.01, 123.66, 241.66 },
			{ -455.55, 2005.83, 123.56, 55.94 },
			{ -448.58, 2009.43, 123.65, 226.07 },
			{ -450.72, 2022.85, 123.48, 94.29 },
			{ -454.48, 2045.24, 122.86, 309.0 },
			{ -451.05, 2054.5,  122.26, 203.53 },
			{ -427.41, 2065.11, 120.49, 17.01 },
			{ -423.09, 2063.4,  120.07, 179.96 },
			{ -467.63, 2065.11, 120.78, 113.2 },
			{ -467.5,  2073.01, 120.68, 309.61 },
			{ -473.45, 2087.09, 120.04, 94.57 },
			{ -541.58, 1973.77, 126.99, 270.45 },
			{ -542.31, 1957.51, 126.71, 101.72 },
			{ -538.1,  1950.43, 126.15, 263.45 },
			{ -538.16, 1940.71, 125.71, 116.59 },
			{ -533.87, 1930.17, 124.8,  281.52 },
			{ -536.64, 1922.81, 124.26, 85.64 },
			{ -538.69, 1912.26, 123.55, 72.61 },
			{ -542.31, 1902.06, 123.11, 231.03 },
			{ -553.93, 1891.14, 123.04, 225.29 },
			{ -562.53, 1889.07, 123.17, 47.27 },
			{ -563.52, 1885.74, 123.07, 209.01 }
		}
	},
	["Mergulhador"] = {
		["coords"] = { 1520.56, 3780.08, 34.46 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "VASCULHAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 500,
		["collectDuration"] = 12500,
		["collectAnim"] = { false, "amb@prop_human_parking_meter@female@idle_a", "idle_a_female", true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 3
		},
		["collectCoords"] = {
			{ 1018.69, 4095.91, 12.7 },
			{ 963.91,  4036.36, 3.35 },
			{ 960.66,  3973.73, 1.11 },
			{ 1015.39, 3959.19, -3.0 },
			{ 1064.1,  3974.58, -12.5 },
			{ 1045.07, 4008.94, -12.45 },
			{ 995.48,  4048.54, 4.52 },
			{ 961.85,  4034.99, 2.95 },
			{ 907.1,   3958.09, -4.3 },
			{ 935.89,  3911.83, -9.69 },
			{ 927.22,  3836.77, 3.79 },
			{ 935.42,  3791.86, 16.85 },
			{ 975.34,  3800.73, 16.55 },
			{ 1030.63, 3823.97, 9.64 },
			{ 1068.02, 3863.78, -7.23 },
			{ 1138.51, 3991.73, -4.28 },
			{ 1093.69, 4050.16, 0.86 },
			{ 1045.61, 4141.31, 21.85 }
		},
		["deliveryItem"] = {
			"key",
			"octopus",
			"shrimp",
			"carp",
			"codfish",
			"catfish",
			"goldenfish",
			"horsefish",
			"tilapia",
			"pacu",
			"pirarucu",
			"tambaqui",
			"bait",
			"emptybottle",
			"plastic",
			"glass",
			"rubber",
			"aluminum",
			"copper",
			"silvercoin",
			"goldcoin"
		}
	},
	["Colheita"] = {
		["coords"] = { 406.08, 6526.16, 27.75 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 100,
		["collectDuration"] = 10000,
		["collectAnim"] = { false, "amb@prop_human_movie_bulb@base", "base", true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 4
		},
		["collectCoords"] = {
			{ 378.31, 6506.08, 27.95 },
			{ 370.4,  6506.21, 28.41 },
			{ 363.39, 6506.17, 28.54 },
			{ 355.69, 6505.39, 28.48 },
			{ 348.16, 6505.63, 28.8 },
			{ 340.0,  6505.86, 28.7 },
			{ 331.35, 6505.55, 28.51 },
			{ 322.12, 6505.06, 29.18 },
			{ 378.51, 6517.79, 28.34 },
			{ 370.41, 6517.69, 28.37 },
			{ 363.16, 6517.9,  28.29 },
			{ 355.94, 6517.51, 28.16 },
			{ 348.1,  6517.63, 28.75 },
			{ 339.35, 6517.47, 28.93 },
			{ 330.8,  6517.82, 28.95 },
			{ 322.4,  6517.65, 29.12 },
			{ 322.33, 6531.14, 29.12 },
			{ 329.9,  6531.26, 28.58 },
			{ 338.3,  6530.77, 28.54 },
			{ 345.53, 6531.32, 28.73 },
			{ 353.39, 6530.73, 28.39 },
			{ 361.42, 6530.99, 28.36 },
			{ 368.88, 6531.62, 28.39 }
		},
		["deliveryItem"] = {
			"tomato",
			"banana",
			"passion",
			"grape",
			"tange",
			"orange",
			"apple",
			"strawberry"
		}
	},
	["AgricultorTrigo"] = {
		["coords"] = { 2301.09, 5064.78, 45.81 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 100,
		["collectDuration"] = 10000,
		["collectAnim"] = { false, "amb@world_human_gardener_plant@female@base", "base_female", true },
		["collectConsume"] = {
			["min"] = 3,
			["max"] = 5
		},
		["collectCoords"] = {
			{ 2295.92, 5064.95, 46.17 },
			{ 2293.8,  5067.14, 46.34 },
			{ 2291.75, 5069.28, 46.49 },
			{ 2289.82, 5071.4,  46.64 },
			{ 2287.77, 5073.64, 46.81 },
			{ 2285.02, 5076.56, 46.98 },
			{ 2282.33, 5079.04, 47.04 },
			{ 2279.87, 5081.56, 47.15 },
			{ 2277.08, 5084.23, 47.25 },
			{ 2274.59, 5086.94, 47.43 },
			{ 2271.21, 5083.77, 46.69 },
			{ 2273.74, 5081.23, 46.71 },
			{ 2276.23, 5078.6,  46.74 },
			{ 2278.77, 5076.02, 46.67 },
			{ 2281.35, 5073.42, 46.54 },
			{ 2284.08, 5070.68, 46.35 },
			{ 2286.32, 5068.42, 46.27 },
			{ 2288.38, 5066.38, 46.19 },
			{ 2290.48, 5064.27, 46.1 },
			{ 2292.53, 5062.15, 46.0 },
			{ 2289.37, 5058.53, 45.73 },
			{ 2287.34, 5060.77, 45.81 },
			{ 2285.25, 5062.94, 45.87 },
			{ 2283.34, 5064.88, 45.92 },
			{ 2281.23, 5067.01, 45.97 },
			{ 2278.48, 5069.65, 46.12 },
			{ 2275.85, 5072.31, 46.22 },
			{ 2273.2,  5075.1,  46.3 },
			{ 2270.63, 5077.6,  46.35 },
			{ 2268.22, 5080.12, 46.42 },
			{ 2264.55, 5077.09, 46.17 },
			{ 2267.13, 5074.58, 46.08 },
			{ 2269.68, 5072.01, 45.97 },
			{ 2272.24, 5069.44, 45.85 },
			{ 2274.91, 5066.72, 45.71 },
			{ 2277.57, 5064.04, 45.53 },
			{ 2279.65, 5061.88, 45.46 },
			{ 2281.6,  5059.89, 45.43 },
			{ 2283.83, 5057.62, 45.39 },
			{ 2285.91, 5055.53, 45.34 },
			{ 2283.01, 5051.97, 44.97 },
			{ 2280.89, 5053.97, 45.06 },
			{ 2278.69, 5056.37, 45.12 },
			{ 2276.64, 5058.28, 45.17 },
			{ 2274.56, 5060.46, 45.24 },
			{ 2271.93, 5063.1,  45.33 },
			{ 2269.32, 5065.73, 45.49 },
			{ 2266.67, 5068.45, 45.68 },
			{ 2264.29, 5070.97, 45.87 },
			{ 2261.75, 5073.62, 46.05 }
		},
		["deliveryItem"] = "wheat"
	},
	["Motorista"] = {
		["coords"] = { 453.05, -607.72, 28.59 },
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		["collectVehicle"] = -2072933068,
		["usingVehicle"] = true,
		["collectRandom"] = false,
		["collectText"] = "PEGAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["collectConsume"] = {
			["min"] = 80,
			["max"] = 130
		},
		["collectCoords"] = {
			{ 418.92,   -571.03,  28.68 },
			{ 923.78,   186.7,    75.81 },
			{ 1644.11,  1166.89,  84.26 },
			{ 2104.23,  2630.44,  51.76 },
			{ 2402.38,  2918.04,  49.31 },
			{ 1786.57,  3356.21,  40.51 },
			{ 1620.82,  3813.85,  34.94 },
			{ 1911.6,   3793.09,  32.31 },
			{ 2493.37,  4088.69,  38.04 },
			{ 2068.51,  4693.82,  41.19 },
			{ 1676.39,  4822.41,  42.02 },
			{ 2250.19,  4986.36,  42.23 },
			{ 1667.97,  6397.56,  30.12 },
			{ 235.51,   6574.7,   31.57 },
			{ -85.11,   6584.3,   29.47 },
			{ -137.53,  6440.85,  31.42 },
			{ -235.39,  6304.34,  31.39 },
			{ -422.67,  6031.56,  31.34 },
			{ -756.66,  5515.02,  35.49 },
			{ -1538.42, 4976.01,  62.28 },
			{ -2246.9,  4283.26,  46.68 },
			{ -2731.13, 2292.23,  19.05 },
			{ -3233.06, 1009.3,   12.18 },
			{ -3002.44, 416.76,   14.97 },
			{ -1960.25, -504.23,  11.82 },
			{ -1371.7,  -982.24,  8.43 },
			{ -1166.92, -1471.31, 4.34 },
			{ -1052.56, -1511.78, 5.09 },
			{ -900.75,  -1206.71, 4.94 },
			{ -628.94,  -924.13,  23.28 },
			{ -557.24,  -845.49,  27.61 },
			{ -1059.11, -2066.85, 13.2 },
			{ -543.79,  -2194.84, 6.01 },
			{ -60.68,   -1806.51, 27.21 },
			{ 228.64,   -1837.9,  26.73 },
			{ 291.46,   -2002.07, 20.31 },
			{ 739.81,   -2233.34, 29.24 },
			{ 1045.03,  -2384.93, 30.28 },
			{ 1200.9,   -685.64,  60.6 },
			{ 954.37,   -146.43,  74.45 },
			{ 566.42,   218.64,   102.54 },
			{ -429.1,   252.36,   83.02 },
			{ -732.3,   3.21,     37.88 },
			{ -1244.38, -302.64,  37.32 },
			{ -1403.93, -566.3,   30.22 },
			{ -1202.05, -876.7,   13.28 },
			{ -691.37,  -961.63,  19.79 },
			{ -387.71,  -851.57,  31.5 },
			{ 149.9,    -1028.06, 29.25 },
			{ 120.26,   -1356.98, 29.19 },
			{ 118.29,   -785.88,  31.3 },
			{ 98.34,    -628.98,  31.57 }
		},
		["deliveryItem"] = "dollars"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collectAmount = {}
local paymentAmount = {}
local deliveryAmount = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.collectConsume(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if works[serviceName]["collectRandom"] then
			local amountItem = 0
			local selectItem = ""

			if serviceName == "Minerador" then
				local randomItem = math.random(100)

				if randomItem <= 1 then
					amountItem = 1
					selectItem = "emerald"
				elseif randomItem >= 2 and randomItem <= 3 then
					selectItem = "diamond"
					amountItem = math.random(2)
				elseif randomItem >= 4 and randomItem <= 8 then
					selectItem = "ruby"
					amountItem = math.random(2)
				elseif randomItem >= 9 and randomItem <= 16 then
					selectItem = "sapphire"
					amountItem = math.random(5)
				elseif randomItem >= 17 and randomItem <= 27 then
					selectItem = "amethyst"
					amountItem = math.random(5)
				elseif randomItem >= 28 and randomItem <= 44 then
					selectItem = "amber"
					amountItem = math.random(5)
				elseif randomItem >= 45 and randomItem <= 60 then
					selectItem = "turquoise"
					amountItem = math.random(5)
				end
			elseif
				serviceName == "Burguer" then
				local items = { "ketchup", "bread", "carne", "tomato" }
				local randomItem = items[math.random(#items)]
				selectItem = randomItem
				amountItem = math.random(1, 4)
			else
				local randomItem = math.random(#works[serviceName]["deliveryItem"])
				selectItem = works[serviceName]["deliveryItem"][randomItem]
				amountItem = math.random(works[serviceName]["collectConsume"]["min"],
					works[serviceName]["collectConsume"]["max"])
			end
			if (vRP.inventoryWeight(user_id) + (itemWeight(selectItem) * parseInt(amountItem))) <= vRP.getWeight(user_id) then
				vRP.generateItem(user_id, selectItem, amountItem, true)

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id, works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify", source, "vermelho", "Negado", "Mochila cheia.", 5000)
			end
		else
			local deliveryItem = works[serviceName]["deliveryItem"]
			collectAmount[user_id] = math.random(works[serviceName]["collectConsume"]["min"],
				works[serviceName]["collectConsume"]["max"])

			if (vRP.inventoryWeight(user_id) + (itemWeight(deliveryItem) * parseInt(collectAmount[user_id]))) <= vRP.getWeight(user_id) then
				vRP.generateItem(user_id, deliveryItem, collectAmount[user_id], true)

				if deliveryItem == "dollars" then
					if vRP.userPremium(user_id) then
						vRP.generateItem(user_id, deliveryItem, collectAmount[user_id] * 0.10, true)
					end
				end

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id, works[serviceName]["upgradeStress"])
				end

				collectAmount[user_id] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "vermelho", "Negado", "Mochila cheia.", 5000)
			end
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERYCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deliveryConsume(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local deliveryItem = works[serviceName]["deliveryPayment"]["item"]
		deliveryAmount[user_id] = math.random(works[serviceName]["deliveryConsume"]["min"],
			works[serviceName]["deliveryConsume"]["max"])
		paymentAmount[user_id] = math.random(works[serviceName]["deliveryPayment"]["min"],
			works[serviceName]["deliveryPayment"]["max"])

		if (vRP.inventoryWeight(user_id) + (itemWeight(deliveryItem) * parseInt(paymentAmount[user_id]))) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, works[serviceName]["deliveryItem"], deliveryAmount[user_id]) then
				local paymentPrice = parseInt(paymentAmount[user_id] * deliveryAmount[user_id])

				vRP.generateItem(user_id, deliveryItem, paymentPrice, true)

				if deliveryItem == "dollars" then
					if vRP.userPremium(user_id) then
						vRP.generateItem(user_id, deliveryItem, paymentPrice * 0.10, true)
					end
				end

				deliveryAmount[user_id] = nil
				paymentAmount[user_id] = nil

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id, works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Atenção",
					"Precisa de " ..
					parseFormat(deliveryAmount[user_id]) ..
					"x " .. itemName(works[serviceName]["deliveryItem"]) .. " para entregar.", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Negado", "Mochila cheia.", 5000)
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if works[serviceName]["perm"] == nil then
			return true
		end

		if vRP.hasGroup(user_id, works[serviceName]["perm"]) then
			return true
		end
	end

	TriggerClientEvent("Notify", source, "amarelo", "Atenção",
		"Voce não possui permissão do <b>" .. serviceName .. "<b/>",  2000)
	return false
end
