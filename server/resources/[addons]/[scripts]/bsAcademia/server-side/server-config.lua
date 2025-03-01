-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("exercicios",cRP)
vCLIENT = Tunnel.getInterface("gregos-exercicios")
vSERVER = Tunnel.getInterface("exercicios")


-----------------------------------------------------------------------------------------------------------------------------------------
-- Exercicios
-----------------------------------------------------------------------------------------------------------------------------------------
local Config = {
    -- BARRA é o nome do exercicio
	[1] = {
        ["nome"] = "Barra",
		["coords"] = {-1204.85,-1564.27,4.6,28.35},
		--Aqui temos a duração de cada sessão desse exercicio, ou seja, acada 13 segundos acaba e seta a mochila
		["duration"] = 13,
        -- Importante se a animação tiver props envolvidos deixe nill caso contrario
        ["animationName"] = "malhar2",
        -- de quanto em quanto a mochila vai aumentar
        ["backpackUp"] = 1.0,
        -- evento de anim especifico caso tenha, do contrario colocar nil
        ["event"] = "emotes"
	},
    [2] = {
        ["nome"] = "Biceps",
		["coords"] = {-1202.72,-1565.35,4.62,218.27},
		["duration"] = 13,
		["animation"] = {"amb@world_human_muscle_free_weights@male@barbell@base","base"},
        ["animationName"] = "malhar",
        ["backpackUp"] = 1.0,
        ["event"] = "emotes"
	},
    [3] = {
        ["nome"] = "Barra",
		["coords"] = {-1225.047,-1600.19,4.18,85.04},
		["duration"] = 13,
        ["animationName"] = "malhar2",
        ["backpackUp"] = 1.0,
        ["event"] = "emotes"
	},
    [4] = {
        ["nome"] = "Barra",
		["coords"] = {-1240.25,-1599.69,4.16,31.19},
		["duration"] = 13,
        ["animationName"] = "malhar2",
        ["backpackUp"] = 1.0,
        ["event"] = "emotes"
	},
    [5] = {
        ["nome"] = "Barra",
		["coords"] = {-1200.03,-1571.18,4.6,223.94},
		["duration"] = 13,

        ["animationName"] = "malhar2",
        ["backpackUp"] = 1.0,
        ["event"] = "emotes"
	},
    [6] = {
        ["nome"] = "Biceps",
		["coords"] = {-1196.88,-1573.14,4.62,31.19},
		["duration"] = 13,

        ["animationName"] = "malhar",
        ["backpackUp"] = 1.0,
        ["event"] = "emotes"
	},
    [7] = {
        ["nome"] = "Flexao",
		["coords"] = {-1206.35,-1568.08,4.6,121.89},
		["duration"] = 13,

        ["animationName"] = "flexao",
        ["backpackUp"] = 1.0,
        ["event"] = "emotes"
	},
    [8] = {
        ["nome"] = "Flexao",
		["coords"] = {-1207.92,-1566.3,4.6,130.4},
		["duration"] = 13,
	
        ["animationName"] = "flexao",
        ["backpackUp"] = 1.0,
        ["event"] = "emotes"
	},
    [9] = {
        ["nome"] = "Abdominal",
		["coords"] = {-1201.58,-1561.35,4.62,121.89},
		["duration"] = 13,

        ["animationName"] = "abdominal",
        ["backpackUp"] = 1.0,
        ["event"] = "emotes"
	},
    [10] = {
        ["nome"] = "Abdominal",
		["coords"] = {-1199.73,-1563.54,4.62,121.89},
		["duration"] = 13,
        ["animationName"] = "abdominal",
        ["backpackUp"] = 1.0,
        ["event"] = "emotes"
	},
    
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	vCLIENT.updateAcademia(source,Config)
end)


Citizen.CreateThread(function()
	Citizen.Wait(1000)
	vCLIENT.updateAcademia(-1,Config)
end)