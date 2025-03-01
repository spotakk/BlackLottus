local desmanche =
"https://discord.com/api/webhooks/1131731841301352549/bmcBjrOacpzUdMgEws2ev-TqvBar98jLr-BSmX3sT_72_NX33dK_JtEkVDh_iMyUmx2z"

function SendWebhookMessage(webhook, message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ content = message }),
            { ['Content-Type'] = 'application/json' })
    end
end

------------------------------------------------------
-- CONFIG
------------------------------------------------------
local RestritoParaDesmanche = true -- É restrito para quem tiver só a permissão do desmanche? (TRUE/FALSE)
local PermissaoDesmanche = 'TheLost' or 'Bennys'                       -- Se RestritoParaDesmanche for TRUE, aqui deverá ter a permissão que será verifiada.

local PrecisaDeItem = false          -- Precisa de item para iniciar o desmanche? (TRUE/FALSE)
local ItemNecessario = 'plate'      -- Qual item precisa para iniciar o desmanche?
local QtdNecessaria = 1             -- Quantos itens precisará para iniciar o desmanche?


-- local CarrosDesmanches = {
    -- -------------------------------------------------------------------------|
    -- ----- CONCESSIONÁRIA ----------------------------------------------------|
    -- -------------------------------------------------------------------------|
    -- ["amarok"] = math.random(5000, 10000),
    -- ["audirs7"] = math.random(5000, 10000),
    -- ["bmws"] = math.random(5000, 10000),
    -- ["bmwz4"] = math.random(5000, 10000),
    -- ["brz13"] = math.random(5000, 10000),
    -- ["corvettec8"] = math.random(5000, 10000),
    -- ["demonhawkk"] = math.random(5000, 10000),
    -- ["rangerovervelar"] = math.random(5000, 10000),
    -- ["r1250"] = math.random(5000, 10000),
    -- ["panamera "] = math.random(5000, 10000)

-- }

------------------------------------------------------
------------------------------------------------------
------------------------------------------------------


-- RETORNA VEICULOS PERMITIDOS
function src.GetVehs()
    return CarrosDesmanches
end

-- FUNÇÃO VERIFICAR PERMISSÃO DO DESMANCHE
function src.CheckPerm()
    local source = source
    local user_id = vRP.getUserId(source)
    if RestritoParaDesmanche then
        if vRP.hasPermission(user_id, PermissaoDesmanche) then
            return true
        end
        return false
    end
    return true
end

-- FUNÇÃO PRA VERIFICAR SE POSSUI O ITEM
function src.CheckItem()
    local source = source
    local user_id = vRP.getUserId(source)
    if PrecisaDeItem then
        if vRP.tryGetInventoryItem(user_id, ItemNecessario, QtdNecessaria) then
            return true
        end
        return false
    end
    return true
end

vRP.prepare("getVeh/plate", "SELECT * FROM vehicles WHERE plate=@plate ")



function containsSupra(str)
    local pattern = "%u+"
    return string.find(str, pattern) ~= nil
end











-- -- FUNÇÃO PARA GERAR O PAGAMENTO E OS ITENS
-- function src.GerarPagamento(nomeFeio, placa)
    -- local source = source
    -- local user_id = vRP.getUserId(source)
    -- local nameUp = string.lower(nomeFeio)

    -- for k, v in pairs(CarrosDesmanches) do
        -- local kup = string.lower(k)
        -- local findString, d = string.find(kup, string.gsub(nameUp, "%s+", ""), 1, false)
        -- if (findString) then
            -- local consult = vRP.query("vehicles/plateVehicles", { plate = placa })
            -- local result = vehicleGems(k) * 150
            -- local sourceP = vRP.getUserSource(consult[1]["user_id"])
            -- TriggerClientEvent("Notify", sourceP, "Amarelo",
                -- "O seguro encontrou seu carro desmanchado o valor para recuperar sera R$" .. result, 5000)
            -- vRP.addFines(consult[1]["user_id"], result)
            -- vRP.giveInventoryItem(user_id, 'dollarsroll', v, true) -- DINHEIRO SUJO
        -- end
    -- end

    -- TriggerClientEvent("garages:Delete", source)
-- end



-- local vehglobal = {
    -- ["zentorno"] = {"Zentorno", 40, 200, "rental", 0},
    -- ["ndguincho"] = {"Guincho", 40, 10000, "cars", 0},
-- }

-- function src.GerarPagamento(nomeFeio, placa)
    -- local source = source
    -- local user_id = vRP.getUserId(source)
    -- local nameUp = string.lower(nomeFeio)

    -- for k, v in pairs(vehglobal) do
        -- local kup = string.lower(k)
        -- local findString, d = string.find(kup, string.gsub(nameUp, "%s+", ""), 1, false)
        -- if (findString) then
            -- local consult = vRP.query("vehicles/plateVehicles", { plate = placa })
            -- local vehicleType = v[4] -- Type is stored in the fourth element of the vehicle info table
            -- local price

            -- if vehicleType == "rental" then
                -- price = v[3] * 150
            -- elseif vehicleType == "cars" then
                -- price = v[3] / 4
            -- else
                -- price = 0 -- If the vehicle type is not recognized, set the price to 0 (or handle it as you wish)
            -- end

            -- local sourceP = vRP.getUserSource(consult[1]["user_id"])
            -- TriggerClientEvent("Notify", sourceP, "Amarelo", "O seguro encontrou seu carro desmanchado o valor para recuperar sera R$" .. price, 5000)
            -- vRP.addFines(consult[1]["user_id"], price)
            -- vRP.giveInventoryItem(user_id, 'dollarsroll', v[2], true) -- DINHEIRO SUJO
        -- end
    -- end

    -- TriggerClientEvent("garages:Delete", source)
-- end



-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
local vehglobal = {
	
	["nd600lt3"] = {"Mc Laren Senna",40,10000,"work",0 },--bennys
	["ndguincho"] = {"Guincho",40,10000,"work",0 },---bennys
	["ndmaverick2"] = {"Maverick",40,10000,"work",0 },--bennys
	["ndr1200mec"] = {"R1200",40,10000,"work",0 },--bennys
	
	["VRdm1200"] = {"DM 1200",40,10000,"work",0 },--policia
	["VRq8"] = {"Audi Q8",40,10000,"work",0 },--policia
	["VRraptor"] = {"Raptor",40,10000,"work",0 },--policia
	["VRrs5"] = {"Audi RS5",40,10000,"work",0 },--policia
	["VRrs6"] = {"Audi RS6",40,10000,"work",0 },--policia
	["VRrs6av"] = {"Audi A6",40,10000,"work",0 },--policia
	["VRtahoe"] = {"Tahoe",40,10000,"work",0 },--policia
	["VRa4"] = {"Audi A4",40,10000,"work",0 },--policia
	["VRa3"] = {"Audi A3",40,10000,"work",0 },--policia

	["polr34"] = {"Nissan Skyline R34",40,10000,"work",0 },--speed
	["polgtr50"] = {"Nissan GTR 50",40,10000,"work",0 },--speed
	["polgt17"] = {"Ford GT",40,10000,"work",0 },--speed
	["polgtr"] = {"Nissan GTR R35",40,10000,"work",0 },--speed

	["WRr1200"] = {"R1200",40,10000,"work",0 },--tatica
	["WRTiger900"] = {"Tiger 900",40,10000,"work",0 },--policia

	["WRbmwx6"] = {"BMW X6",40,10000,"work",0 },--dip
	["WRbmwx7"] = {"BMW X7",40,10000,"work",0 },--dip
	["WRxc90"] = {"XC 90",40,10000,"work",0 },--dip
	["WRyukon"] = {"Yukon",40,10000,"work",0 },--dip
	["WRgle"] = {"Mercedes GLE",40,10000,"work",0 },--dip
	["WRm5"] = {"BMW M5",40,10000,"work",0 },--dip

	["bcat"] = {"Caveirão CORE",40,10000,"work",0 },--tatica
	["WRsilverado"] = {"Silverado",40,10000,"work",0 },--tatica
	["WRclassxv2"] = {"Mercedes XCLASS",40,10000,"work",0 },--tatica



	["polmav"] = { "Polmav",40,2000,"work",0 },--heli policia
	["Wra45"] = { "Mercedes A45",10,1000,"work",0 },------policia
	
	["B412"] = {"Caçador B412",40,5000,"work",0 },--heli policia
	
	["Wrgle53"] = {"Mercedes GLE",40,10000,"work",0 },--ambulancia
	["Wrasprinter"] = {"Sprinter",40,10000,"work",0 },---ambulancia
	["pbus"] = { "Pbus",0,1000,"work",0 },--bus policia
	
	
	["supervolito"] = {"SUPER VOLITO",20,10,"work", 0 },--heli hp
	["sw4graubomb"] = {"SW4",20,10,"work", 0 },--CARROHP
	["WR19ranger"] = {"WR19 RANGER",20,10,"work", 0 },--DIP
	["exypolicia"] = {"exypolicia",20,10,"work", 0 },---POLICIA
	["WRa45"] = {"WRA45",20,10,"work", 0 },---policia

-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHVIPS
-----------------------------------------------------------------------------------------------------------------------------------------
		
	["mercedesamg63"] = { "Mercedes C63-S",50,80,"rental",0 }, -- X
	["vwtouareg"] = { "Volkswagen Touareg",60,50,"rental",0 }, -- X
	["nissangtr50"] = { "Nissan GT-R 50th",30,80,"rental",0 },  -- X
	["audirs6"] = { "Audi RS6",50,80,"rental",0 }, -- X
	["aventador"] = { "Lamborghini Aventador",30,100,"rental",0 }, -- X
	["bentleybacalar"] = { "Bentley Bacalar",50,80,"rental",0 }, -- X
	["bloodline"] = { "Bloodline King",30,50,"rental",0 }, -- X
	["bmwi8"] = { "BMW I8",30,80,"rental",0 }, -- X
	["bmwm1wb"] = { "BMW M1 Widebody",50,80,"rental",0 }, -- X
	["bmwm4gts"] = { "BMW M4 GTS",50,80,"rental",0 }, -- X
	["bmwm5e34"] = { "BMW M5 e34",40,80,"rental",0 }, -- X
	["bugattiatlantic"] = { "Bugatti Atlantic",40,100,"rental",0 }, -- X
	["camaro"] = { "Chevrolet Camaro",35,80,"rental",0 }, -- X
	["civictyper"] = { "Honda Civic Type-R",50,80,"rental",0 }, -- X
	["corvettec7"] = { "Corvette C7",40,80,"rental",0 }, -- X
	["dodgecharger1970"] = { "Dodge Charger 1970",40,50,"rental",0 }, -- X
 	["dodgechargerrt69"] = { "Dodge Charger RT69",50,50,"rental",0 }, -- X
	["dodgechargersrt"] = { "Dodge Charger SRT",40,50,"rental",0 }, -- X
	["escalade2021"] = { "Escalade 2021",50,70,"rental",0 },-- X
	["escaladegt900"] = { "Escalade GT900",50,70,"rental",0 },-- X
	["ferrari812"] = { "Ferrari 812",30,100,"rental",0 },-- X
	["ferrarif12"] = { "Ferrari F12",30,100,"rental",0 },-- X
	["ferrarif40"] = { "Ferrari F40",30,100,"rental",0 },-- X
	["ferrariitalia"] = { "Ferrari Italia",30,100,"rental",0 },-- X
	["fordmustang"] = { "Ford Mustang",40,80,"rental",0 },-- X
	["golfgti"] = { "Golf GTi",50,50,"rental",0 },-- X
	["golfmk7"] = { "Golf Mk7",40,50,"rental",0 },-- X
	["jeepcherokee"] = { "Jeep Cherokee",40,80,"rental",0 },-- X
	["lamborghinihuracan"] = { "Lamborghini Huracan",40,100,"rental",0 },-- X
	["lamborghinihuracanlw"] = { "Lamborghini LW",40,100,"rental",0 },-- X
	["lancerevolution9"] = { "Lancer Evolution IX",50,70,"rental",0 },-- X
	["lancerevolutionx"] = { "Lancer Evolution X",50,80,"rental",0 },-- X-- X
	["m8competition"] = { "BMW M8 Competition",50,80,"rental",0 },-- X
	["mazdarx7"] = { "Mazda RX7",40,80,"rental",0 },-- X
	["mazdarx72"] = { "Mazda RX7 RB",40,80,"rental",0 },-- X
	["mclarensenna"] = { "McLaren Senna",30,100,"rental",0 },
	["mercedesgt63"] = { "Mercedes GT63",50,80,"rental",0 },
	["mercedesg65"] = { "Mercedes G65",50,80,"rental",0 },
	["mustang1969"] = { "Ford Mustang 1969",40,60,"rental",0 },
	["mustangfast"] = { "Mustang Fastback",50,80,"rental",0 },
	["nissangtr"] = { "Nissan GT-R R35",30,70,"rental",0 },
	["nissangtr2"] = { "Nissan GT-R EE",30,75,"rental",0 },
	["nissangtr3"] = { "Nissan GT-R RB",30,80,"rental",0 },-- X
	["nissangtrnismo"] = { "Nissan GT-R Nismo",40,80,"rental",0 },-- X
	["skyliner34"] = { "Skyline R34",40,80,"rental",0 },-- X
	["skyliner342"] = { "Skyline R34 FF",40,80,"rental",0 },-- X
	["subaruimpreza"] = { "Subaru Impreza",50,70,"rental",0 }, -- X
	["subarubrz"] = { "Subaru Brz RB",50,70,"rental",0 }, -- X
	["toyotasupra"] = { "Toyota Supra",40,70,"rental",0 }, -- X
	["toyotasupra2"] = { "Toyota Supra 2020",40,80,"rental",0 }, -- X
	["porsche911"] = { "Porsche 911 GT3",40,100,"rental",0 },
	["urbandevil"] = { "Urban Devil",30,50,"rental",0 },
	["wheelchair"] = { "Cadeira de Rodas",10,0,"rental",0 }, -- X
	["s1000rr1"] = { "s1000rr1",10,60,"rental",0 }, -- X
	["350z"] = { "Nissan 350z RB",40,70,"rental",0 }, -- X
	["audir8"] = { "Audi R8",40,80,"rental",0 }, -- X
	["r6"] = { "Yamaha R6",25,60,"rental",0 },-- X
	["silvias15"] = { "Nissan Silvia S15",30,70,"rental",0 },-- X
	["rangerover"] = { "Range Rover",60,80,"rental",0 },-- X
	["shelbygt500"] = { "Shelby GT500",50,90,"rental",0 },-- X
	["panameramansory"] = { "Porsche Panamera",50,90,"rental",0 },-- X
	
	
	---ADICIONADOS----
	["teslamodels"] = { "Tesla",50,70,"rental",0 },-- X-----------------------

	["20xmax"] = { "20XMAX",50,10,"rental",0 },-- X
	["A1GT63"] = { "A1GT63",50,100,"rental",0 },-- X

	["lbstrx"] = { "LBSTRX",50,90,"rental",0 },-- X

	

	["hummersuv"] = { "Hummer SUV",50,90,"rental",0 },-- X
	["apolloevo"] = { "Apollo Evo",50,100,"rental",0 },-- X
	["xclass"] = { "Xclass",50,70,"rental",0 },-- X
	["golcl"] = { "Gol CL",50,30,"rental",0 },-- X
	["c8p1"] = { "C8P1",50,100,"rental",0 },-- X
	["bentaygaplsd"] = { "Bentaygaplsd",50,90,"rental",0 },-- X

	
	
	
------REVISADOS
	["amarok"] = {"Volkswagem Amarok",40,60,"rental", 0 },
	["audirs7"] = {"Audi RS7",40,80,"rental", 0 },
	["bmws"] = {"BMW S1000RR",20,65,"rental", 0 },
	["bmwz4"] = {"BMW Z4",40,80,"rental", 0 },

	["c7"] = {"Corvette C7",40,80,"rental", 0 },
	["corvettec8"] = {"Corvette C8",40,90,"rental", 0 },
	["h2carb"] = {"H2carb",20,70,"rental", 0 },
	["rmodg65"] = {"Mercedes G65",40,65,"rental", 0 },
	["r1250"] = {"R1250",20,80,"rental", 0 },
	
	
	
	["2f2fgts"] = {"VF-GTS",40,70,"rental", 0 },
	["2f2fmle7"] = {"VF-MlE7",40,70,"rental", 0 },
	["2f2fs2000"] = {"VF-S2000",40,70,"rental", 0 },
	["ff4wrx"] = {"VF-4WRX",40,70,"rental", 0 },
	
	["fnfcivic"] = {"VF-CIVIC",40,70,"rental", 0 },
	["fnflan"] = {"VF-LAN",40,70,"rental", 0 },
	["fnfmits"] = {"VF-MITS",40,70,"rental", 0 },
	
	["fnfmk4"] = {"VF-MK4",40,80,"rental", 0 },
	["fnfrx7"] = {"VF-RX7",40,70,"rental", 0 },
	
	["skidoo800R"] = {"Skidoo 800R",40,40,"rental", 0 },
	
	["amarokkids"] = {"Amarok Kids",10,10,"rental", 0 },
	["gtrkids"] = {"GTR Kids",10,10,"rental", 0 },
	["jeepag"] = {"Jeep Kids",10,10,"rental", 0 },
	["limao"] = {"Limao Kids",10,10,"rental", 0 },
	["mouseag"] = {"Mouse Kids",10,10,"rental", 0 },
	["porscheag"] = {"Porsche Kids",10,10,"rental", 0 },
	["skyline"] = {"Skyline Kids",10,10,"rental", 0 },
	["stingray"] = {"Stingray Kids",10,10,"rental", 0 },
	["trash2"] = {"C.Lixo Kids",10,10,"rental", 0 },
	["dog_R1250baby"] = {"R1250 Kids",10,10,"rental", 0 },
	
	
	["africa"] = {"Africat",10,60,"rental", 0 },
	["cbb"] = {"CBB",10,60,"rental", 0 },
	["DirtBike"] = {"DIRT BIKE",10,10,"rental", 0 },
	["R1200GS"] = {"R1200 GS",10,75,"rental", 0 },
	["s1000rr"] = {"S1000 RR",10,10,"rental", 0 },
	["tenere1200"] = {"tenere1200",10,75,"rental", 0 },
	["xj6"] = {"xj6",10,70,"rental", 0 },
	["z1000"] = {"z1000",10,70,"rental", 0 },
	
	
	
	
	
	["21CAMARO"] = {"CAMARO 21",20,90,"rental", 0 },
	["180sx"] = {"180SX",30,50,"rental", 0 },
	["2013LP560"] = {"Lamborghini LP 2013",20,100,"rental", 0 },
	["a80"] = {"A80",20,50,"rental", 0 },
	["agerars"] = {"AGERA RS",20,100,"rental", 0 },
	["amgone"] = {"AMGONE",20,90,"rental", 0 },
	
	["auditt"] = {"AUDI TT",20,70,"rental", 0 },
	["bc"] = {"BC",20,100,"rental", 0 },
	["bmwboltz"] = {"BMW BOLTZ",20,0,"rental", 0 },
	["bmwm8"] = {"BMW M8",20,90,"rental", 0 },
	["brz"] = {"BRZ",20,90,"rental", 0 },
	["chironss"] = {"BUGATTI CHIRON",20,100,"rental", 0 },
	["cls63s"] = {"CLS63S",20,70,"rental", 0 },
	
	
	
	["dodgeram2500"] = {"RAM 2500",100,80,"rental", 0 },
	["Evoque"] = {"Evoque",40,80,"rental", 0 },
	["f822"] = {"FERRARI F822",20,100,"rental", 0 },
	["f850"] = {"F850",10,80,"rental", 0 },
	["g7cross"] = {"SAVEIRO G7",30,60,"rental", 0 },
	["gle63"] = {"GLE63",20,10,"rental", 0 },
	["golf7gti"] = {"GOLF 7 GTI",20,60,"rental", 0 },
	["gs2013"] = {"GS 2013",20,80,"rental", 0 },
	["gxa45"] = {"GXA 45",20,70,"rental", 0 },
	["lp700"] = {"LAMBORGHINI LP700",20,100,"rental", 0 },
	["lwgtr"] = {"LW GTR",20,90,"rental", 0 },
	["m2"] = {"BMW M2",20,80,"rental", 0 },
	["m3e46"] = {"BMW M3E46",20,70,"rental", 0 },
	["m4clw"] = {"BMW M4CLW",20,90,"rental", 0 },
	
	["m4f82"] = {"BMW M4F82",20,80,"rental", 0 },
	["mansamgt21"] = {"MANSAM GT 21",20,90,"rental", 0 },
	["mansm8civil"] = {"MANSAM M8",20,85,"rental", 0 },
	["mustangeleanor"] = {"MUSTANG ELEANOR",20,60,"rental", 0 },
	["nissanr33tbk"] = {"NISSAN R33 TBK",20,70,"rental", 0 },
	["pistaspider19"] = {"FERRARI SPYDER 19",20,100,"rental", 0 },
	["pm19"] = {"PORSCHE M19",20,90,"rental", 0 },
	["r820"] = {"AUDI R820",20,80,"rental", 0 },
	
	
	["rmodcharger69"] = {"CHARGER 69",20,60,"rental", 0 },
	["rmodf12tdf"] = {"FERRARI F12",20,100,"rental", 0 },
	["rmodgt63"] = {"GT63",20,90,"rental", 0 },
	["rmodjeep"] = {"JEEP",40,70,"rental", 0 },
	
	["rmodm5e34"] = {"M5E34",20,60,"rental", 0 },
	["rmodrover"] = {"ROVER",40,80,"rental", 0 },
	["rmodrs6r"] = {"RS6R",20,90,"rental", 0 },
	["rmodrs7"] = {"RS7",20,90,"rental", 0 },
	
	["s10hc"] = {"S10 HC",80,70,"rental", 0 },
	["silvia"] = {"SILVIA",20,90,"rental", 0 },
	["urusd"] = {"LAMBORGHINI URUS D",20,95,"rental", 0 },
	["velar"] = {"VELAR",20,90,"rental", 0 },
	
	["viper"] = {"VIPER",20,90,"rental", 0 },
	["xxxxx"] = {"XXXXX",100,100,"rental", 0 },
	
	






-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
	
--	["nd600lt"] = {"Mc Laren P1",40,10000,"work",0 },
--	["nd911"] = {"Porsche 911",40,10000,"work",0 },
--	["ndamarok"] = {"Volkswagen Amarok",40,10000,"work",0 },
--	["ndcamaropol"] = {"Chevrolet Camaro",40,10000,"work",0 },
--	["ndfocuspol"] = {"Ford Focus",40,10000,"work",0 },
--	["ndnovitecpol"] = {"Masserati",40,10000,"work",0 },
--	["ndskyline"] = {"Nissan Skyline",40,10000,"work",0 },
--	["ndr1200pol"] = {"R1200",40,10000,"work",0 },
--	["cdacivic"] = {"Honda Civic",40,10000,"work",0 },
--	["porschemacan"] = {"Porsche Macan",40,10000,nil, 0 },
--	["q8prior"] = {"Audi Q8 Prior",40,10000,nil, 0 },
--	["opalass4"] = {"opalass4",40,65000,"cars",0 },
--	["opalass"] = {"opalass",40,50000,"cars",0},
--	["488"] = {"Ferrari 488",40,10000,nil, 0 },
--	["911r"] = {"Porsche 911R",40,10000,nil, 0 },
--	["918spyder"] = {"Porsche 918 Spyder",40,10000,nil, 0 },
--	["a45amg"] = {"Mercedes A45",40,10000,nil, 0 },
--	["ayamahar1"] = {"Yamaha R1",20,10000,nil, 0 },
--	["bdivo"] = {"Bugatti Divo",40,10000,nil, 0 },
--	["brz13"] = {"Subaru BRZ 2013",40,10000,nil, 0 },
--	["c63b"] = {"Mercedes C63B",40,10000,"rental",50 },
--	["c63hr"] = {"Mercedes C63HR",40,10000,nil, 0 },
--	["chevroletcamarozl1"] = {"Camaro ZL1",40,10000,nil, 0 },

--	["demonhawkk"] = {"Jeep Hawk",40,10000,nil, 0 },
--	["dodgecharger"] = {"Dodge Charger",40,10000,nil, 0 },
--	["eclipse"] = {"Eclipse",40,10000,nil, 0 },
--	["gt63"] = {"Mercedes GT63",40,10000,nil, 0 },
--	["gtr50"] = {"Nissan GTR R50",40,10000,nil, 0 },
--	["hondacbr650r"] = {"Honda CBR 650R",40,10000,nil, 0 },
--	["lamborghinievo"] = {"Lamborghini Evo",40,10000,nil, 0 },
--	["lamborghinigallardo"] = {"Lamborghini Gallardo",40,10000,nil, 0 },
--	["nh2r"] = {"NH2R",40,10000,nil, 0 },
--	["nissansilvias15"] = {"Nissan Silvia S15",40,10000,nil, 0 },
--	["nissanskyliner34"] = {"Nissan Skyline R34",40,10000,nil, 0 },
--	["rangerovervelar"] = {"Velar",40,10000,nil, 0 },
--	["panamera"] = {"Porsche Panamera",40,10000,nil, 0 },	
--  ["jettagli"] = {"Jetta Gli",40,1500000,nil, 0 },
--  ["fz07"] = {"Yamaha FZ07 Boost",40,10000,nil, 0},
--	["focusrs"] = {"Focus RS Boost",40,10000,nil, 0},


	-- ["ambulancia"] = {"Ambulância",40,10000,"work",0 },
	-- ["astron"] = { "Astron",40,170000,"cars",0 },
	-- ["baller7"] = { "Baller 7",50,140000,"cars",0 },
	-- ["buffalo4"] = { "Buffalo 4",30,140000,"cars",0 },
	-- ["champion"] = { "Champion",20,170000,"cars",0 },
	-- ["cinquemila"] = { "Cinquemila",30,250000,"cars",0 },
	-- ["comet7"] = { "Comet 7",20,250000,"cars",0 },
	-- ["deity"] = { "Deity",40,200000,"cars",0 },
	-- ["granger2"] = { "Granger 2",65,150000,"cars",0 },
	-- ["ignus"] = { "Ignus",20,350000,"cars",0 },
	-- ["iwagen"] = { "Iwagen",40,170000,"cars",0 },
	-- ["jubilee"] = { "Jubilee",40,150000,"cars",0 },
	-- ["mule5"] = { "Mule 5",0,1000,nil,0 },
	-- ["patriot3"] = { "Patriot 3",40,180000,"cars",0 },
	-- ["reever"] = { "Reever",20,190000,"bikes",0 },
	-- ["shinobi"] = { "Shinobi",20,180000,"bikes",0 },
	-- ["youga4"] = { "Youga 4",40,90000,"cars",0 },
	["zeno"] = { "Zeno",20,290000,"cars",0 },
	["dinghy"] = { "Dinghy",0,2000,"work",0 },
	["dinghy2"] = { "Dinghy 2",40,100,"work",0 },
	["dinghy3"] = { "Dinghy 3",40,100,"work",0 },
	["dinghy4"] = { "Dinghy 4",40,100,"work",0 },
	["jetmax"] = { "Jetmax",0,2000,"work",0 },
	["marquis"] = { "Marquis",0,2000,"work",0 },
	["seashark"] = { "Seashark",0,2000,"work",0 },
	["seashark2"] = { "Seashark 2",40,100,"work",0 },
	["seashark3"] = { "Seashark 3",40,100,"work",0 },
	["speeder"] = { "Speeder",0,2000,"work",0 },
	["speeder2"] = { "Speeder 2",40,100,"work",0 },
	["squalo"] = { "Squalo",0,2000,"work",0 },
	["submersible"] = { "Submersible",40,100,"work",0 },
	["submersible2"] = { "Submersible 2",40,100,"work",0 },
	["suntrap"] = { "Suntrap",0,2000,"work",0 },
	["toro"] = { "Toro",0,2000,"work",0 },
	["toro2"] = { "Toro 2",40,100,"work",0 },
	["tropic"] = { "Tropic",0,2000,"work",0 },
	["tropic2"] = { "Tropic 2",40,100,"work",0 },
	["tug"] = { "Tug",40,100,"work",0 },
	["benson"] = { "Benson",300,75000,"work",75 },
	["biff"] = { "Biff",40,100,"work",0 },
	["cerberus"] = { "Cerberus",40,100,"work",0 },
	["cerberus2"] = { "Cerberus 2",40,100,"work",0 },
	["cerberus3"] = { "Cerberus 3",40,100,"work",0 },
	["hauler"] = { "Hauler",40,100,"work",0 },
	["hauler2"] = { "Hauler 2",40,100,"work",0 },
	["mule"] = { "Mule",200,50000,"work",0 },
	["mule2"] = { "Mule 2",40,100,"work",0 },
	["mule3"] = { "Mule 3",40,100,"work",0 },
	["mule4"] = { "Mule 4",40,100,"work",0 },
	["packer"] = { "Packer",0,500,"work",0 },
	["phantom"] = { "Phantom",40,100,"work",0 },
	["phantom2"] = { "Phantom 2",40,100,"work",0 },
	["phantom3"] = { "Phantom 3",40,100,"work",0 },
	["pounder"] = { "Pounder",400,100000,"work",0 },
	["pounder2"] = { "Pounder 2",40,100,"work",0 },
	["stockade"] = { "Stockade",40,1000,"work",0 },
	["stockade3"] = { "Stockade 3",40,100,"work",0 },
	["terbyte"] = { "Terbyte",2000,100,"work",100 },
	["blista"] = { "Blista",20,30000,"cars",0 },
	["brioso"] = { "Brioso",20,30000,"cars",0 },
	["dilettante"] = { "Dilettante",30,50000,"cars",0 },
	["dilettante2"] = { "Dilettante 2",40,100,"work",0 },
	["issi2"] = { "Issi 2",25,50000,"cars",0 },
	["issi3"] = { "Issi 3",35,90000,"cars",0 },
	["issi4"] = { "Issi 4",40,100,"work",0 },
	["issi5"] = { "Issi 5",40,100,"work",0 },
	["issi6"] = { "Issi 6",40,100,"work",0 },
	["panto"] = { "Panto",20,24000,"cars",0 },
	["prairie"] = { "Prairie",15,20000,"cars",0 },
	["rhapsody"] = { "Rhapsody",15,10000,"cars",0 },
	["cogcabrio"] = { "Cogcabrio",50,90000,"cars",0 },
	["exemplar"] = { "Exemplar",20,90000,"cars",0 },
	["f620"] = { "F620",30,64000,"cars",0 },
	["felon"] = { "Felon",30,70000,"cars",0 },
	["felon2"] = { "Felon 2",35,70000,"cars",0 },
	["jackal"] = { "Jackal",30,110000,"cars",0 },
	["oracle"] = { "Oracle",30,50000,"cars",0 },
	["oracle2"] = { "Oracle 2",40,70000,"cars",0 },
	["sentinel"] = { "Sentinel",30,50000,"cars",0 },
	["sentinel2"] = { "Sentinel 2",35,70000,"cars",0 },
	["windsor"] = { "Windsor",30,90000,"cars",0 },
	["windsor2"] = { "Windsor 2",40,110000,"cars",0 },
	["zion"] = { "Zion",30,70000,"cars",0 },
	["zion2"] = { "Zion 2",35,90000,"cars",0 },
	["bmx"] = { "Bmx",0,1000,"work",0 },
	["cruiser"] = { "Cruiser",0,1000,"work",0 },
	["fixter"] = { "Fixter",0,1000,"work",0 },
	["scorcher"] = { "Scorcher",0,1000,"work",0 },
	["tribike"] = { "Tribike",0,1000,"work",0 },
	["tribike2"] = { "Tribike 2",0,1000,"work",0 },
	["tribike3"] = { "Tribike 3",0,1000,"work",0 },
	["ambulance"] = { "Ambulance",10,1000,"work",0 },
	["ambulance2"] = { "Ambulance 2",10,1000,"work",0 },
	["fbi"] = { "Fbi",0,100,"work",0 },
	["fbi2"] = { "Fbi 2",0,100,"work",0 },
	["firetruk"] = { "Firetruk",0,1000,"work",0 },
	["lguard"] = { "Lguard",0,1000,"work",0 },
	["police"] = { "Police",40,100,"work",0 },
	["police2"] = { "Police 2",40,100,"work",0 },
	["police3"] = { "Police 3",40,100,"work",0 },
	["police4"] = { "Police 4",20,100,"work",0 },
	["policeb"] = { "Harley FLH1200",0,100,"work",0 },
	["hondanc700"] = { "Honda NC700",0,1000,"work",0 },
	["bmwr1200"] = { "BMW R1200",0,1000,"work",0 },
	["policeold1"] = { "Policeold 1",40,100,"work",0 },
	["policeold2"] = { "Policeold 2",40,100,"work",0 },
	["policet"] = { "Police T",40,100,"work",0 },
	["pranger"] = { "Pranger",40,100,"work",0 },
	["predator"] = { "Predator",40,100,"work",0 },
	["riot"] = { "Riot",0,1000,"work",0 },
	["riot2"] = { "Riot 2",40,100,"work",0 },
	["sheriff"] = { "Sheriff",40,100,"work",0 },
	["sheriff2"] = { "Sheriff 2",40,100,"work",0 },
	["akula"] = { "Akula",40,100,"work",0 },
	["annihilator"] = { "Annihilator",40,100,"work",0 },
	["buzzard"] = { "Buzzard",40,100,"work",0 },
	["buzzard2"] = { "Buzzard 2",0,2000,"work",0 },
	["cargobob"] = { "Cargobob",40,100,"work",0 },
	["cargobob2"] = { "Cargobob 2",40,100,"work",0 },
	["cargobob3"] = { "Cargobob 3",40,100,"work",0 },
	["cargobob4"] = { "Cargobob 4",40,100,"work",0 },
	["frogger"] = { "Frogger",0,2000,"work",0 },
	["frogger2"] = { "Frogger 2",40,100,"work",0 },
	["havok"] = { "Havok",0,2000,"work",0 },
	["hunter"] = { "Hunter",40,100,"work",0 },
	["maverick"] = { "Maverick",0,2000,"work",0 },
	["maverick2"] = { "Maverick 2",0,4000,"work",0 },
	["savage"] = { "Savage",40,100,"work",0 },
	["seasparrow"] = { "Seasparrow",40,100,"work",0 },
	["skylift"] = { "Skylift",40,100,"work",0 },
	["supervolito"] = { "Supervolito",0,2000,"work",0 },
	["supervolito2"] = { "Supervolito 2",40,100,"work",0 },
	["swift"] = { "Swift",0,2000,"work",0 },
	["swift2"] = { "Swift 2",0,2000,"work",0 },
	["valkyrie"] = { "Valkyrie",40,100,"work",0 },
	["valkyrie2"] = { "Valkyrie 2",40,100,"work",0 },
	["volatus"] = { "Volatus",0,2000,"work",0 },
	["bulldozer"] = { "Bulldozer",40,100,"work",0 },
	["cutter"] = { "Cutter",40,100,"work",0 },
	["dump"] = { "Dump",40,100,"work",0 },
	["flatbed"] = { "Flatbed",0,1000,"work",0 },
	["guardian"] = { "Guardian",50,310000,"cars",0 },
	["handler"] = { "Handler",40,100,"work",0 },
	["mixer"] = { "Mixer",40,100,"work",0 },
	["mixer2"] = { "Mixer 2",40,100,"work",0 },
	["rubble"] = { "Rubble",40,100,"work",0 },
	["tiptruck"] = { "Tiptruck",40,100,"work",0 },
	["tiptruck2"] = { "Tiptruck 2",40,100,"work",0 },
	["apc"] = { "Apc",40,100,"work",0 },
	["barracks"] = { "Barracks",40,100,"work",0 },
	["barracks2"] = { "Barracks 2",40,100,"work",0 },
	["barracks3"] = { "Barracks 3",40,100,"work",0 },
	["barrage"] = { "Barrage",40,100,"work",0 },
	["chernobog"] = { "Chernobog",40,100,"work",0 },
	["crusader"] = { "Crusader",40,100,"work",0 },
	["halftrack"] = { "Halftrack",40,100,"work",0 },
	["khanjali"] = { "Khanjali",40,100,"work",0 },
	["rhino"] = { "Rhino",40,100,"work",0 },
	["scarab"] = { "Scarab",40,100,"work",0 },
	["scarab2"] = { "Scarab 2",40,100,"work",0 },
	["scarab3"] = { "Scarab 3",40,100,"work",0 },
	["thruster"] = { "Thruster",40,100,"work",0 },-----------------mochila a jato
	["trailersmall2"] = { "Trailersmall 2",40,100,"work",0 },
	["akuma"] = { "Akuma",20,350000,"bikes",0 },
	["avarus"] = { "Avarus",20,190000,"bikes",0 },
	["bagger"] = { "Bagger",20,190000,"bikes",0 },
	["bati"] = { "Bati",20,310000,"bikes",0 },
	["bati2"] = { "Bati 2",20,330000,"bikes",0 },
	["bf400"] = { "Bf400",20,330000,"bikes",0 },
	["carbonrs"] = { "Carbon RS",20,210000,"bikes",0 },
	["chimera"] = { "Chimera",20,170000,"bikes",0 },
	["cliffhanger"] = { "Cliffhanger",20,270000,"bikes",0 },
	["daemon"] = { "Daemon",20,190000,"bikes",0 },
	["daemon2"] = { "Daemon 2",20,190000,"bikes",0 },
	["defiler"] = { "Defiler",20,290000,"bikes",0 },
	["deathbike"] = { "Deathbike",40,100,"work",0 },
	["deathbike2"] = { "Deathbike 2",20,65000,"work",0 },
	["deathbike3"] = { "Deathbike 3",20,65000,"work",0 },
	["diablous"] = { "Diablous",20,210000,"bikes",0 },
	["diablous2"] = { "Diablous 2",20,210000,"bikes",0 },
	["double"] = { "Double",20,310000,"bikes",0 },
	["enduro"] = { "Enduro",20,170000,"work",0 },
	["esskey"] = { "Esskey",20,190000,"bikes",0 },
	["faggio"] = { "Faggio",10,2000,"bikes",0 },
	["faggio2"] = { "Faggio 2",10,2000,"bikes",0 },
	["faggio3"] = { "Faggio 3",10,2000,"bikes",0 },
	["fcr"] = { "Fcr",20,190000,"bikes",0 },
	["fcr2"] = { "Fcr 2",20,190000,"bikes",0 },
	["gargoyle"] = { "Gargoyle",20,210000,"bikes",0 },
	["hakuchou"] = { "Hakuchou",20,310000,"bikes",0 },
	["hakuchou2"] = { "Hakuchou 2",20,350000,"bikes",0 },
	["hexer"] = { "Hexer",20,210000,"bikes",0 },
	["innovation"] = { "Innovation",20,230000,"bikes",0 },
	["lectro"] = { "Lectro",20,230000,"bikes",0 },
	["manchez"] = { "Manchez",20,190000,"bikes",0 },
	["nemesis"] = { "Nemesis",20,170000,"bikes",0 },
	["nightblade"] = { "Nightblade",20,230000,"bikes",0 },
	["oppressor"] = { "Oppressor",20,130000,"work",0 },
	["oppressor2"] = { "Oppressor 2",20,130000,"work",0 },
	["pcj"] = { "Pcj",20,170000,"bikes",0 },
	["ratbike"] = { "Ratbike",20,130000,"work",0 },
	["ruffian"] = { "Ruffian",20,210000,"bikes",0 },
	["sanchez"] = { "Sanchez",15,190000,"bikes",0 },
	["sanchez2"] = { "Sanchez 2",15,190000,"bikes",0 },
	["sanctus"] = { "Sanctus",20,190000,"bikes",0 },
	["shotaro"] = { "Shotaro",20,130000,"work",0 },
	["sovereign"] = { "Sovereign",20,250000,"work",0 },
	["thrust"] = { "Thrust",20,190000,"bikes",0 },
	["vader"] = { "Vader",20,190000,"bikes",0 },
	["vindicator"] = { "Vindicator",20,210000,"bikes",0 },
	["vortex"] = { "Vortex",20,210000,"bikes",0 },
	["wolfsbane"] = { "Wolfsbane",20,210000,"bikes",0 },
	["zombiea"] = { "Zombie A",20,210000,"bikes",0 },
	["zombieb"] = { "Zombie B",20,210000,"bikes",0 },
	["blade"] = { "Blade",55,150000,"cars",0 },
	["buccaneer"] = { "Buccaneer",30,50000,"cars",0 },
	["buccaneer2"] = { "Buccaneer 2",35,70000,"cars",0 },
	["chino"] = { "Chino",40,90000,"cars",0 },
	["chino2"] = { "Chino 2",45,90000,"cars",0 },
	["clique"] = { "Clique",35,130000,"cars",0 },
	["coquette3"] = { "Coquette 3",40,210000,"cars",0 },
	["deviant"] = { "Deviant",50,170000,"cars",0 },
	["dominator"] = { "Dominator",50,130000,"cars",0 },
	["dominator2"] = { "Dominator 2",50,130000,"cars",0 },
	["dominator3"] = { "Dominator 3",30,170000,"cars",0 },
	["dominator4"] = { "Dominator 4",40,100,"work",0 },
	["dominator5"] = { "Dominator 5",40,100,"work",0 },
	["dominator6"] = { "Dominator 6",40,100,"work",0 },
	["dukes"] = { "Dukes",40,110000,"cars",0 },
	["dukes2"] = { "Dukes 2",40,40000,"cars",0 },
	["faction"] = { "Faction",50,110000,"cars",0 },
	["faction2"] = { "Faction 2",40,110000,"cars",0 },
	["faction3"] = { "Faction 3",50,110000,"cars",0 },
	["ellie"] = { "Ellie",50,170000,"cars",0 },
	["gauntlet"] = { "Gauntlet",40,90000,"cars",0 },
	["gauntlet2"] = { "Gauntlet 2",40,100,"work",0 },
	["hermes"] = { "Hermes",40,150000,"cars",0 },
	["hotknife"] = { "Hotknife",30,150000,"cars",0 },
	["hustler"] = { "Hustler",40,130000,"cars",0 },
	["impaler"] = { "Impaler",50,150000,"cars",0 },
	["impaler2"] = { "Impaler 2",40,100,"work",0 },---------------pensar
	["impaler3"] = { "Impaler 3",40,100,"work",0 },---------------pensar
	["impaler4"] = { "Impaler 4",40,100,"work",0 },
	["imperator"] = { "Imperator",40,100,"work",0 },
	["imperator2"] = { "Imperator 2",40,100,"work",0 },
	["imperator3"] = { "Imperator 3",40,100,"work",0 },
	["lurcher"] = { "Lurcher",40,100,"work",0 },-------------hallowen
	["moonbeam"] = { "Moonbeam",50,150000,"cars",0 },
	["moonbeam2"] = { "Moonbeam 2",40,150000,"cars",0 },
	["nightshade"] = { "Nightshade",30,170000,"cars",0 },
	["phoenix"] = { "Phoenix",40,100,"work",0 },
	["picador"] = { "Picador",50,170000,"cars",0 },
	["ratloader"] = { "Ratloader",40,1000,"work",0 },
	["ratloader2"] = { "Ratloader 2",40,130000,"cars",0 },
	["ruiner"] = { "Ruiner",50,110000,"cars",0 },
	["ruiner2"] = { "Ruiner 2",40,100,"work",0 },-----paraquedas
	["ruiner3"] = { "Ruiner 3",40,100,"work",0 },----fodido
	["sabregt"] = { "Sabre GT",45,90000,"cars",0 },
	["sabregt2"] = { "Sabregt 2",50,90000,"cars",0 },
	["slamvan"] = { "Slamvan",50,130000,"cars",0 },
	["slamvan2"] = { "Slamvan 2",50,130000,"cars",0 },
	["slamvan3"] = { "Slamvan 3",40,150000,"cars",0 },
	["slamvan4"] = { "Slamvan 4",40,100,"work",0 },
	["slamvan5"] = { "Slamvan 5",40,100,"work",0 },
	["slamvan6"] = { "Slamvan 6",40,100,"work",0 },
	["stalion"] = { "Stalion",30,110000,"cars",0 },
	["stalion2"] = { "Stalion 2",30,110000,"cars",0 },
	["tampa"] = { "Tampa",40,130000,"cars",0 },
	["tampa3"] = { "Tampa 3",40,100,"work",0 },
	["tulip"] = { "Tulip",50,150000,"cars",0 },
	["vamos"] = { "Vamos",50,170000,"cars",0 },
	["vigero"] = { "Vigero",30,90000,"cars",0 },
	["virgo"] = { "Virgo",50,90000,"cars",0 },
	["virgo2"] = { "Virgo 2",50,90000,"cars",0 },
	["virgo3"] = { "Virgo 3",50,110000,"cars",0 },
	["voodoo"] = { "Voodoo",45,90000,"cars",0 },
	["voodoo2"] = { "Voodoo 2",25,90000,"cars",0 },
	["yosemite"] = { "Yosemite",50,150000,"cars",0 },
	["bfinjection"] = { "Bfinjection",20,70000,"cars",0 },
	["bifta"] = { "Bifta",20,90000,"cars",0 },
	["blazer"] = { "Blazer",10,150000,"cars",0 },
	["blazer2"] = { "Blazer 2",0,1000,"work",0 },
	["blazer3"] = { "Blazer 3",10,150000,"cars",0 },
	["blazer4"] = { "Blazer 4",10,150000,"cars",0 },
	["blazer5"] = { "Blazer 5",40,100,"work",0 },
	["bodhi2"] = { "Bodhi 2",40,90000,"cars",0 },
	["brawler"] = { "Brawler",40,170000,"cars",0 },
	["bruiser"] = { "Bruiser",40,100,"work",0 },
	["bruiser2"] = { "Bruiser 2",40,100,"work",0 },
	["bruiser3"] = { "Bruiser 3",40,100,"work",0 },--------carro gigante
	["brutus"] = { "Brutus",40,100,"work",0 },
	["brutus2"] = { "Brutus 2",40,100,"work",0 },
	["brutus3"] = { "Brutus 3",40,100,"work",0 },
	["caracara"] = { "Caracara",40,100,"work",0 },
	["dloader"] = { "Dloader",40,70000,"cars",0 },
	["dubsta3"] = { "Dubsta 3",55,130000,"cars",0 },
	["dune"] = { "Dune",40,100,"work",0 },
	["dune2"] = { "Dune 2",40,100,"work",0 },
	["dune3"] = { "Dune 3",40,100,"work",0 },
	["dune4"] = { "Dune 4",40,100,"work",0 },
	["dune5"] = { "Dune 5",40,100,"work",0 },
	["freecrawler"] = { "Freecrawler",50,190000,"cars",0 },
	["insurgent"] = { "Insurgent",40,100,"work",0 },
	["insurgent2"] = { "Insurgent 2",40,100,"work",0 },
	["insurgent3"] = { "Insurgent 3",40,100,"work",0 },
	["kalahari"] = { "Kalahari",20,70000,"cars",0 },
	["kamacho"] = { "Kamacho",50,410000,"cars",0 },
	["marshall"] = { "Marshall",40,100,"work",0 },
	["mesa3"] = { "Mesa 3",50,150000,"cars",0 },
	["monster"] = { "Monster",40,100,"work",0 },
	["monster3"] = { "Monster 3",40,100,"work",0 },
	["monster4"] = { "Monster 4",40,100,"work",0 },
	["monster5"] = { "Monster 5",40,100,"work",0 },
	["menacer"] = { "Menacer",40,100,"work",0 },
	["nightshark"] = { "Nightshark",40,100,"work",0 },
	["rancherxl"] = { "Rancher XL",40,130000,"cars",0 },
	["rancherxl2"] = { "Rancher XL2",40,100,"work",0 },
	["rebel"] = { "Rebel",40,90000,"cars",0 },
	["rebel2"] = { "Rebel 2",45,90000,"cars",0 },
	["rcbandito"] = { "RC Bandito",40,100,"work",0 },-------carinhopequeno
	["riata"] = { "Riata",45,90000,"cars",0 },
	["sandking"] = { "Sandking",50,150000,"cars",0 },
	["sandking2"] = { "Sandking 2",55,150000,"cars",0 },
	["technical"] = { "Technical",40,100,"work",0 },
	["technical2"] = { "Technical 2",40,100,"work",0 },
	["technical3"] = { "Technical 3",40,100,"work",0 },
	["trophytruck"] = { "Trophytruck",20,190000,"cars",0 },
	["trophytruck2"] = { "Trophytruck 2",40,100,"work",0 },
	["alphaz1"] = { "Alphaz 1",40,100,"work",0 },
	["avenger"] = { "Avenger",40,100,"work",0 },---superheli
	["avenger2"] = { "Avenger 2",40,100,"work",0 },-----superheli
	["besra"] = { "Besra",40,100,"work",0 },
	["blimp"] = { "Blimp",40,100,"work",0 },------propaganda
	["blimp2"] = { "Blimp 2",40,100,"work",0 },
	["blimp3"] = { "Blimp 3",40,100,"work",0 },
	["bombushka"] = { "Bombushka",40,100,"work",0 },
	["cargoplane"] = { "Cargoplane",40,100,"work",0 },
	["cuban800"] = { "Cuban800",0,2000,"work",0 },
	["dodo"] = { "Dodo",0,2000,"work",0 },
	["duster"] = { "Duster",40,100,"work",0 },
	["howard"] = { "Howard",40,100,"work",0 },
	["hydra"] = { "Hydra",40,100,"work",0 },
	["jet"] = { "Jet",40,100,"work",0 },
	["lazer"] = { "Lazer",40,100,"work",0 },
	["luxor"] = { "Luxor",0,2000,"work",0 },
	["luxor2"] = { "Luxor 2",40,100,"work",0 },
	["mammatus"] = { "Mammatus",0,2000,"work",0 },
	["microlight"] = { "Microlight",40,100,"work",0 },------aviãozinho
	["miljet"] = { "Miljet",0,2000,"work",0 },
	["mogul"] = { "Mogul",40,100,"work",0 },
	["molotok"] = { "Molotok",40,100,"work",0 },
	["nimbus"] = { "Nimbus",0,2000,"work",0 },
	["nokota"] = { "Nokota",40,100,"work",0 },
	["pyro"] = { "Pyro",40,100,"work",0 },
	["rogue"] = { "Rogue",40,100,"work",0 },
	["seabreeze"] = { "Seabreeze",40,100,"work",0 },
	["shamal"] = { "Shamal",0,2000,"work",0 },
	["starling"] = { "Starling",40,100,"work",0 },
	["strikeforce"] = { "Strikeforce",40,100,"work",0 },
	["stunt"] = { "Stunt",40,100,"work",0 },
	["titan"] = { "Titan",40,100,"work",0 },
	["tula"] = { "Tula",40,100,"work",0 },
	["velum"] = { "Velum",0,2000,"work",0 },
	["velum2"] = { "Velum 2",40,100,"work",0 },
	["vestra"] = { "Vestra",40,100,"work",0 },
	["volatol"] = { "Volatol",40,100,"work",0 },
	["baller"] = { "Baller",50,90000,"cars",0 },
	["baller2"] = { "Baller 2",50,90000,"cars",0 },
	["baller3"] = { "Baller 3",50,110000,"cars",0 },
	["baller4"] = { "Baller 4",50,110000,"cars",0 },
	["baller5"] = { "Baller 5",50,410000,"cars",0 },
	["baller6"] = { "Baller 6",50,510000,"cars",0 },
	["bjxl"] = { "Bjxl",40,70000,"cars",0 },
	["cavalcade"] = { "Cavalcade",40,70000,"cars",0 },
	["cavalcade2"] = { "Cavalcade 2",45,70000,"cars",0 },
	["contender"] = { "Contender",40,250000,"cars",0 },
	["dubsta"] = { "Dubsta",50,110000,"cars",0 },
	["dubsta2"] = { "Dubsta 2",55,130000,"cars",0 },
	["fq2"] = { "Fq2",40,70000,"cars",0 },
	["granger"] = { "Granger",65,130000,"cars",0 },
	["gresley"] = { "Gresley",35,70000,"cars",0 },
	["habanero"] = { "Habanero",35,70000,"cars",0 },
	["huntley"] = { "Huntley",35,70000,"cars",0 },
	["landstalker"] = { "Landstalker",40,90000,"cars",0 },
	["mesa"] = { "Mesa",40,90000,"cars",0 },
	["mesa2"] = { "Mesa 2",40,100,"work",0 },
	["patriot"] = { "Patriot",50,130000,"cars",0 },
	["patriot2"] = { "Patriot 2",50,170000,"cars",0 },
	["radi"] = { "Radi",35,70000,"cars",0 },
	["rocoto"] = { "Rocoto",35,70000,"cars",0 },
	["seminole"] = { "Seminole",35,70000,"cars",0 },
	["serrano"] = { "Serrano",35,70000,"cars",0 },
	["toros"] = { "Toros",50,190000,"cars",0 },
	["xls"] = { "Xls",35,90000,"cars",0 },
	["xls2"] = { "Xls 2",50,510000,"cars",0 },
	["asea"] = { "Asea",30,50000,"cars",0 },
	["asea2"] = { "Asea 2",40,100,"work",0 },
	["asterope"] = { "Asterope",20,30000,"cars",0 },
	["cog55"] = { "Cog55",50,150000,"cars",0 },
	["cog552"] = { "Cog55 2",50,410000,"cars",0 },
	["cognoscenti"] = { "Cognoscenti",50,130000,"cars",0 },
	["cognoscenti2"] = { "Cognoscenti 2",50,410000,"cars",0 },
	["emperor"] = { "Emperor",25,5000,"cars",0 },
	["emperor2"] = { "Emperor 2",20,2000,"cars",0 },
	["emperor3"] = { "Emperor 3",40,100,"work",0 },
	["fugitive"] = { "Fugitive",30,150000,"cars",0 },
	["glendale"] = { "Glendale",50,90000,"cars",0 },
	["ingot"] = { "Ingot",40,15000,"cars",0 },
	["intruder"] = { "Intruder",40,90000,"cars",0 },
	["limo2"] = { "Limo 2",40,100,"work",0 },
	["premier"] = { "Premier",35,70000,"cars",0 },
	["primo"] = { "Primo",30,90000,"cars",0 },
	["primo2"] = { "Primo 2",40,90000,"cars",0 },
	["regina"] = { "Regina",40,70000,"cars",0 },
	["romero"] = { "Romero",30,110000,"cars",0 },
	["schafter2"] = { "Schafter 2",40,90000,"cars",0 },
	["schafter5"] = { "Schafter 5",50,410000,"cars",0 },
	["schafter6"] = { "Schafter 6",50,410000,"cars",0 },
	["stafford"] = { "Stafford",40,150000,"cars",0 },
	["stanier"] = { "Stanier",25,50000,"cars",0 },
	["stratum"] = { "Stratum",40,30000,"cars",0 },
	["stretch"] = { "Stretch",40,150000,"cars",0 },
	["superd"] = { "Superd",40,130000,"cars",0 },
	["surge"] = { "Surge",40,130000,"cars",0 },
	["tailgater"] = { "Tailgater",40,130000,"cars",0 },
	["warrener"] = { "Warrener",40,110000,"cars",0 },
	["washington"] = { "Washington",40,50000,"cars",0 },
	["airbus"] = { "Airbus",40,100,"work",0 },
	["brickade"] = { "Brickade",40,100,"work",0 },
	["bus"] = { "Bus",0,1000,"work",0 },
	["coach"] = { "Coach",40,100,"work",0 },
	["pbus2"] = { "Pbus 2",40,100,"work",0 },
	["rallytruck"] = { "Rally Truck",40,100,"work",0 },
	["rentalbus"] = { "Rental Bus",40,100,"work",0 },
	["taxi"] = { "Taxi",0,500,"work",0 },
	["tourbus"] = { "Tour Bus",40,100,"work",0 },
	["trash"] = { "Trash",40,1000,"work",0 },
--	["trash2"] = { "Trash 2",40,100,"work",0 },
	["wastelander"] = { "Wastelander",40,100,"work",0 },
	["alpha"] = { "Alpha",40,70000,"cars",0 },
	["banshee"] = { "Banshee",30,150000,"cars",0 },
	["bestiagts"] = { "Bestia GTS",50,190000,"cars",0 },
	["blista2"] = { "Blista 2",30,70000,"cars",0 },
	["blista3"] = { "Blista 3",35,70000,"cars",0 },
	["buffalo"] = { "Buffalo",50,110000,"cars",0 },
	["buffalo2"] = { "Buffalo 2",50,110000,"cars",0 },
	["buffalo3"] = { "Buffalo 3",50,110000,"cars",0 },
	["carbonizzare"] = { "Carbonizzare",50,70000,"cars",0 },
	["comet2"] = { "Comet 2",40,110000,"cars",0 },
	["comet3"] = { "Comet 3",40,130000,"cars",0 },
	["comet4"] = { "Comet 4",40,130000,"cars",0 },
	["comet5"] = { "Comet 5",40,170000,"cars",0 },
	["coquette"] = { "Coquette",40,150000,"cars",0 },
	["deveste"] = { "Deveste",40,100,"work",0 },
	["elegy"] = { "Elegy",50,190000,"cars",0 },
	["elegy2"] = { "Elegy 2",30,170000,"cars",0 },
	["feltzer2"] = { "Feltzer 2",50,170000,"cars",0 },
	["flashgt"] = { "Flash GT",40,190000,"cars",0 },
	["furoregt"] = { "Furore GT",35,90000,"cars",0 },
	["fusilade"] = { "Fusilade",35,90000,"cars",0 },
	["futo"] = { "Futo",40,110000,"cars",0 },
	["gb200"] = { "Gb200",40,110000,"cars",0 },
	["hotring"] = { "Hotring",50,150000,"cars",0 },
	["italigto"] = { "Itali GTO",30,250000,"cars",0 },
	["jester"] = { "Jester",30,130000,"cars",0 },
	["jester2"] = { "Jester 2",30,150000,"cars",0 },
	["jester3"] = { "Jester 3",30,170000,"cars",0 },
	["khamelion"] = { "Khamelion",30,170000,"cars",0 },
	["kuruma"] = { "Kuruma",50,190000,"cars",0 },
	["kuruma2"] = { "Kuruma 2",40,100,"work",0 },
	["lynx"] = { "Lynx",35,150000,"cars",0 },
	["massacro"] = { "Massacro",50,170000,"cars",0 },
	["massacro2"] = { "Massacro 2",50,170000,"cars",0 },
	["neon"] = { "Neon",30,290000,"cars",0 },
	["ninef"] = { "Ninef",40,150000,"cars",0 },
	["ninef2"] = { "Ninef 2",40,170000,"cars",0 },
	["omnis"] = { "Omnis",40,130000,"cars",0 },
	["pariah"] = { "Pariah",30,170000,"cars",0 },
	["penumbra"] = { "Penumbra",40,150000,"cars",0 },
	["raiden"] = { "Raiden",40,250000,"cars",0 },
	["rapidgt"] = { "Rapid GT",20,190000,"cars",0 },
	["rapidgt2"] = { "Rapidgt GT2",20,190000,"cars",0 },
	["raptor"] = { "Raptor",40,100,"work",0 },
	["revolter"] = { "Revolter",40,100,"work",0 },
	["ruston"] = { "Ruston",20,150000,"cars",0 },
	["schafter3"] = { "Schafter 3",50,130000,"cars",0 },
	["schafter4"] = { "Schafter 4",50,150000,"cars",0 },
	["schlagen"] = { "Schlagen",30,170000,"cars",0 },
	["schwarzer"] = { "Schwarzer",50,130000,"cars",0 },
	["sentinel3"] = { "Sentinel 3",30,170000,"cars",0 },
	["seven70"] = { "Seven 70",20,170000,"cars",0 },
	["specter"] = { "Specter",20,170000,"cars",0 },
	["specter2"] = { "Specter 2",20,170000,"cars",0 },
	["streiter"] = { "Streiter",35,70000,"cars",0 },
	["sultan"] = { "Sultan",30,190000,"cars",0 },
	["surano"] = { "Surano",35,70000,"cars",0 },
	["tampa2"] = { "Tampa 2",35,150000,"cars",0 },
	["tropos"] = { "Tropos",35,130000,"cars",0 },
	["verlierer2"] = { "Verlierer 2",20,210000,"cars",0 },
	["zr380"] = { "Zr380",40,100,"work",0 },
	["zr3802"] = { "Zr380 2",40,100,"work",0 },
	["zr3803"] = { "Zr380 3",40,100,"work",0 },
	["ardent"] = { "Ardent",40,100,"work",0 },
	["btype"] = { "Btype",50,170000,"cars",0 },
	["btype2"] = { "Btype 2",50,170000,"cars",0 },
	["btype3"] = { "Btype 3",50,190000,"cars",0 },
	["casco"] = { "Casco",50,170000,"cars",0 },
	["cheetah2"] = { "Cheetah 2",40,100,"work",0 },
	["coquette2"] = { "Coquette 2",40,170000,"cars",0 },
	["deluxo"] = { "Deluxo",40,100,"work",0 },---delorean
	["fagaloa"] = { "Fagaloa",50,130000,"cars",0 },
	["feltzer3"] = { "Feltzer 3",50,150000,"cars",0 },
	["gt500"] = { "GT 500",40,150000,"cars",0 },
	["infernus2"] = { "Infernus 2",20,250000,"cars",0 },
	["jb700"] = { "JB 700",30,100,"work",0 },
	["mamba"] = { "Mamba",50,170000,"cars",0 },
	["manana"] = { "Manana",35,70000,"cars",0 },
	["michelli"] = { "Michelli",40,90000,"cars",0 },
	["monroe"] = { "Monroe",50,130000,"cars",0 },
	["peyote"] = { "Peyote",35,70000,"cars",0 },
	["pigalle"] = { "Pigalle",40,90000,"cars",0 },
	["rapidgt3"] = { "Rapid GT3",50,150000,"cars",0 },
	["retinue"] = { "Retinue",40,150000,"cars",0 },
	["savestra"] = { "Savestra",40,170000,"cars",0 },
	["stinger"] = { "Stinger",50,130000,"cars",0 },
	["stingergt"] = { "Stinger GT",50,150000,"cars",0 },
	["stromberg"] = { "Stromberg",40,100,"work",0 },
	["swinger"] = { "Swinger",50,130000,"cars",0 },
	["torero"] = { "Torero",40,100,"work",0 },
	["tornado"] = { "Tornado",40,90000,"cars",0 },
	["tornado2"] = { "Tornado 2",45,90000,"cars",0 },
	["tornado3"] = { "Tornado 3",40,100,"work",0 },
	["tornado4"] = { "Tornado 4",40,100,"work",0 },
	["tornado5"] = { "Tornado 5",50,110000,"cars",0 },
	["tornado6"] = { "Tornado 6",40,100,"work",0 },
	["turismo2"] = { "Turismo 2",30,210000,"cars",0 },
	["viseris"] = { "Viseris",40,100,"work",0 },
	["z190"] = { "Z190",40,130000,"cars",0 },
	["ztype"] = { "Ztype",50,250000,"cars",0 },
	["cheburek"] = { "Cheburek",50,90000,"cars",0 },
	["adder"] = { "Adder",20,250000,"cars",0 },
	["autarch"] = { "Autarch",20,290000,"cars",0 },
	["banshee2"] = { "Banshee 2",20,210000,"cars",0 },
	["bullet"] = { "Bullet",30,170000,"cars",0 },
	["cheetah"] = { "Cheetah",20,230000,"cars",0 },
	["cyclone"] = { "Cyclone",20,330000,"cars",0 },
	["entity2"] = { "Entity 2",30,290000,"cars",0 },
	["entityxf"] = { "Entity XF",20,290000,"cars",0 },
	["fmj"] = { "Fmj",20,210000,"cars",0 },
	["gp1"] = { "Gp1",20,290000,"cars",0 },
	["infernus"] = { "Infernus",20,170000,"cars",0 },
	["italigtb"] = { "Italigtb",20,250000,"cars",0 },
	["italigtb2"] = { "Italigtb 2",20,250000,"cars",0 },
	["le7b"] = { "Le7b",40,100,"work",0 },
	["nero"] = { "Nero",20,250000,"cars",0 },
	["nero2"] = { "Nero 2",20,270000,"cars",0 },
	["osiris"] = { "Osiris",20,210000,"cars",0 },
	["penetrator"] = { "Penetrator",30,190000,"cars",0 },
	["pfister811"] = { "Pfister 811",20,250000,"cars",0 },
	["prototipo"] = { "Prototipo",40,100,"work",0 },
	["reaper"] = { "Reaper",20,190000,"cars",0 },
	["sc1"] = { "Sc1",40,210000,"cars",0 },
	["scramjet"] = { "Scramjet",40,100,"work",0 },
	["sheava"] = { "Sheava",30,250000,"cars",0 },
	["sultanrs"] = { "Sultan RS",30,210000,"cars",0 },
	["t20"] = { "T20",20,290000,"cars",0 },
	["taipan"] = { "Taipan",20,290000,"cars",0 },
	["tempesta"] = { "Tempesta",20,210000,"cars",0 },
	["tezeract"] = { "Tezeract",20,350000,"cars",0 },
	["turismor"] = { "Turismo R",20,250000,"cars",0 },
	["tyrant"] = { "Tyrant",20,290000,"cars",0 },
	["tyrus"] = { "Tyrus",20,330000,"cars",0 },
	["vacca"] = { "Vacca",20,240000,"cars",0 },
	["vagner"] = { "Vagner",20,290000,"cars",0 },
	["vigilante"] = { "Vigilante",40,100,"work",0 },
	["visione"] = { "Visione",20,410000,"cars",0 },
	["voltic"] = { "Voltic",20,250000,"cars",0 },
	["voltic2"] = { "Voltic 2",40,100,"work",0 },
	["xa21"] = { "Xa21",20,290000,"cars",0 },
	["zentorno"] = { "Zentorno",20,310000,"cars",0 },
	["armytanker"] = { "Armytanker",40,100,"work",0 },
	["armytrailer"] = { "Armytrailer",40,100,"work",0 },
	["armytrailer2"] = { "Armytrailer 2",40,100,"work",0 },
	["baletrailer"] = { "Baletrailer",40,100,"work",0 },
	["boattrailer"] = { "Boattrailer",40,100,"work",0 },
	["cablecar"] = { "Cablecar",40,100,"work",0 },
	["docktrailer"] = { "Docktrailer",40,100,"work",0 },
	["freighttrailer"] = { "Freighttrailer",40,100,"work",0 },
	["graintrailer"] = { "Graintrailer",40,100,"work",0 },
	["proptrailer"] = { "Proptrailer",40,100,"work",0 },
	["raketrailer"] = { "Raketrailer",40,100,"work",0 },
	["tr2"] = { "Tr2",40,100,"work",0 },
	["tr3"] = { "Tr3",40,100,"work",0 },
	["tr4"] = { "Tr4",40,100,"work",0 },
	["trflat"] = { "Trflat",40,100,"work",0 },
	["tvtrailer"] = { "Tvtrailer",40,100,"work",0 },
	["tanker"] = { "Tanker",40,100,"work",0 },
	["tanker2"] = { "Tanker 2",40,100,"work",0 },
	["trailerlarge"] = { "Trailerlarge",40,100,"work",0 },
	["trailerlogs"] = { "Trailerlogs",40,100,"work",0 },
	["trailersmall"] = { "Trailersmall",40,100,"work",0 },
	["trailers"] = { "Trailers",40,100,"work",0 },
	["trailers2"] = { "Trailers 2",40,100,"work",0 },
	["trailers3"] = { "Trailers 3",40,100,"work",0 },
	["trailers4"] = { "Trailers 4",40,100,"work",0 },
	["freight"] = { "Freight",40,100,"work",0 },
	["freightcar"] = { "Freightcar",40,100,"work",0 },
	["freightcont1"] = { "Freightcont 1",40,100,"work",0 },
	["freightcont2"] = { "Freightcont 2",40,100,"work",0 },
	["freightgrain"] = { "Freightgrain",40,100,"work",0 },
	["metrotrain"] = { "Metrotrain",40,100,"work",0 },
	["tankercar"] = { "Rankercar",40,100,"work",0 },
	["airtug"] = { "Airtug",40,100,"work",0 },
	["caddy"] = { "Caddy",20,70000,"cars",0 },
	["caddy2"] = { "Caddy 2",20,70000,"cars",0 },
	["caddy3"] = { "Caddy 3",10,50000,"cars",0 },
	["docktug"] = { "Docktug",40,100,"work",0 },
	["forklift"] = { "Forklift",40,100,"work",0 },
	["mower"] = { "Mower",40,100,"work",0 },
	["ripley"] = { "Ripley",40,100,"work",0 },
	["sadler"] = { "Sadler",40,100,"work",0 },
	["sadler2"] = { "Sadler 2",40,100,"work",0 },
	["scrap"] = { "Scrap",40,100,"work",0 },
	["towtruck"] = { "Towtruck",40,100,"work",0 },
	["towtruck2"] = { "Towtruck 2",0,1000,"work",0 },
	["tractor"] = { "Tractor",40,100,"work",0 },
	["tractor2"] = { "Tractor 2",40,100,"work",0 },
	["tractor3"] = { "Tractor 3",40,100,"work",0 },
	["utillitruck"] = { "Utillitruck",40,100,"work",0 },
	["utillitruck2"] = { "Utillitruck 2",40,100,"work",0 },
	["utillitruck3"] = { "Utillitruck 3",40,100,"work",0 },
	["bison"] = { "Bison",50,70000,"cars",0 },
	["bison2"] = { "Bison 2",40,100,"work",0 },
	["bison3"] = { "Bison 3",40,100,"work",0 },
	["bobcatxl"] = { "Bobcat XL",50,110000,"cars",0 },
	["boxville"] = { "Boxville",40,100,"work",0 },
	["boxville2"] = { "Boxville 2",40,100,"work",0 },
	["boxville3"] = { "Boxville 3",40,100,"work",0 },
	["boxville4"] = { "Boxville",40,100,"work",0 },
	["boxville5"] = { "Boxville 5",40,100,"work",0 },
	["burrito"] = { "Burrito",40,70000,"cars",0 },
	["burrito2"] = { "Burrito 2",40,70000,"cars",0 },
	["burrito3"] = { "Burrito 3",40,70000,"cars",0 },
	["burrito4"] = { "Burrito 4",40,70000,"cars",0 },
	["burrito5"] = { "Burrito 5",40,100,"work",0 },
	["camper"] = { "Camper",50,70000,"cars",0 },
	["gburrito"] = { "Gburrito",50,130000,"cars",0 },
	["gburrito2"] = { "Gburrito 2",10,1000,"work",0 },
	["journey"] = { "Journey",40,100,"work",0 },
	["minivan"] = { "Minivan",40,90000,"cars",0 },
	["minivan2"] = { "Minivan 2",50,110000,"cars",0 },
	["paradise"] = { "Paradise",50,90000,"cars",0 },
	["pony"] = { "Pony",40,70000,"cars",0 },
	["pony2"] = { "Pony 2",40,90000,"cars",0 },
	["rumpo"] = { "Rumpo",30,70000,"cars",0 },
	["rumpo2"] = { "Rumpo 2",40,90000,"cars",0 },
	["rumpo3"] = { "Rumpo 3",50,350000,"cars",0 },
	["speedo"] = { "Speedo",50,70000,"cars",0 },
	["speedo2"] = { "Speedo 2",40,100,"work",0 },
	["speedo4"] = { "Speedo 4",40,100,"work",0 },
	["surfer"] = { "Surfer",40,70000,"cars",0 },
	["surfer2"] = { "Surfer 2",40,70000,"cars",0 },
	["taco"] = { "Taco",15,2000,"cars",0 },
	["youga"] = { "Youga",30,70000,"cars",0 },
	["youga2"] = { "Youga 2",75,5000,"work",0 },
	["asbo"] = { "Asbo",20,90000,"cars",0 },
	["kanjo"] = { "Kanjo",30,90000,"cars",0 },
	["minitank"] = { "Minitank",40,1000,"work",0 },----controle  remoto
	["yosemite2"] = { "Yosemite 2",50,170000,"cars",0 },
	["caracara2"] = { "Caracara 2",50,190000,"cars",0 },
	["everon"] = { "Everon",50,250000,"cars",0 },
	["rebla"] = { "Rebla",40,170000,"cars",0 },
	["komoda"] = { "Komoda",30,250000,"cars",0 },
	["imorgon"] = { "Imorgon",40,250000,"cars",0 },
	["vstr"] = { "Vstr",40,190000,"cars",0 },
	["club"] = { "Club",20,90000,"cars",0 },
	["dukes3"] = { "Dukes 3",40,1000,"work",0 },
	["gauntlet5"] = { "Gauntlet 5",40,210000,"cars",0 },
	["yosemite3"] = { "Yosemite 3",50,190000,"cars",0 },
	["openwheel1"] = { "Openwheel 1",40,1000,"work",0 },
	["openwheel2"] = { "Openwheel 2",40,1000,"work",0 },
	["landstalker2"] = { "Landstalker 2",50,190000,"cars",0 },
	["seminole2"] = { "Seminole 2",45,110000,"cars",0 },
	["glendale2"] = { "Glendale 2",50,150000,"cars",0 },
	["coquette4"] = { "Coquette 4",30,250000,"cars",0 },
	["penumbra2"] = { "Penumbra 2",30,210000,"cars",0 },
	["manana2"] = { "Manana 2",35,110000,"cars",0 },
	["peyote3"] = { "Peyote 3",45,130000,"cars",0 },
	["tigon"] = { "Tigon",30,310000,"cars",0 },
	["youga3"] = { "Youga 3",40,1000,"work",0 },
	["stryder"] = { "Stryder",40,1000,"work",0 },
	["gauntlet3"] = { "Gauntlet 3",40,170000,"cars",0 },
	["gauntlet4"] = { "Gauntlet 4",40,210000,"cars",0 },
	["peyote2"] = { "Peyote 2",45,130000,"cars",0 },
	["hellion"] = { "Hellion",50,150000,"cars",0 },
	["outlaw"] = { "Outlaw",20,170000,"cars",0 },
	["vagrant"] = { "Vagrant",30,290000,"cars",0 },
	["zhaba"] = { "Zhaba",40,1000,"work",0 },
	["formula"] = { "Formula",40,1000,"work",0 },
	["formula2"] = { "Formula 2",40,1000,"work",0 },
	["novak"] = { "Novak",40,190000,"cars",0 },
	["drafter"] = { "Drafter",40,130000,"cars",0 },
	["issi7"] = { "Issi 7",40,210000,"cars",0 },
	["jugular"] = { "Jugular",30,250000,"cars",0 },
	["locust"] = { "Locust",20,190000,"cars",0 },
	["neo"] = { "Neo",20,210000,"cars",0 },
	["paragon"] = { "Paragon",30,210000,"cars",0 },
	["paragon2"] = { "Paragon 2",40,100,"work",0 },
	["sugoi"] = { "Sugoi",30,170000,"cars",0 },
	["sultan2"] = { "Sultan 2",30,250000,"cars",0 },
	["dynasty"] = { "Dynasty",40,170000,"cars",0 },
	["jb7002"] = { "JB 7002",40,1000,"work",0 },
	["nebula"] = { "Nebula",40,190000,"cars",0 },
	["retinue2"] = { "Retinue 2",40,190000,"cars",0 },
	["zion3"] = { "Zion 3",40,170000,"cars",0 },
	["emerus"] = { "Emerus",20,290000,"cars",0 },
	["furia"] = { "Furia",20,410000,"cars",0 },
	["krieger"] = { "Krieger",20,290000,"cars",0 },
	["s80"] = { "S80",40,1000,"work",0 },
	["thrax"] = { "Thrax",50,290000,"cars",0 },
	["zorrusso"] = { "Zorrusso",20,290000,"cars",0 },
	["avisa"] = { "Avisa",20,10000,"work",0 },
	["dinghy5"] = { "Dinghy 5",20,10000,"work",0 },
	["kosatka"] = { "Kosatka",20,10000,"work",0 },
	["longfin"] = { "Longfin",20,10000,"work",0 },
	["patrolboat"] = { "Patrolboat",20,10000,"work",0 },
	["brioso2"] = { "Brioso 2",35,90000,"cars",0 },
	["weevil"] = { "Weevil",35,130000,"cars",0 },
	["annihilator2"] = { "Annihilator 2",20,10000,"work",0 },
	["seasparrow2"] = { "Seasparrow 2",20,10000,"work",0 },
	["seasparrow3"] = { "Seasparrow 3",20,10000,"work",0 },
	["vetir"] = { "Vetir",20,10000,"work",0 },
	["manchez2"] = { "Manchez 2",20,10000,"work",0 },
	["verus"] = { "Verus",20,10000,"work",0 },
	["winky"] = { "Winky",20,10000,"work",0 },
	["alkonost"] = { "Alkonost",20,10000,"work",0 },
	["squaddie"] = { "Squaddie",20,10000,"work",0 },
	["italirsx"] = { "Itali RSX",20,330000,"cars",0 },
	["veto"] = { "Veto",10,1000,"work",0 },
	["veto2"] = { "Veto 2",10,1000,"work",0 },
	["toreador"] = { "Toreador",20,10000,"work",0 },
	["slamtruck"] = { "Slamtruck",20,10000,"work",0 },
	["dominator7"] = { "Dominator 7",20,190000,"cars",0 },
	["tailgater2"] = { "Tailgater 2",40,210000,"cars",0 },
	["zr350"] = { "ZR 350",20,190000,"cars",0 },
	["calico"] = { "Calito",20,290000,"cars",0 },
	["futo2"] = { "Futo 2",40,130000,"cars",0 },
	["euros"] = { "Euros",30,190000,"cars",0 },
	["jester4"] = { "Jester 4",30,250000,"cars",0 },
	["remus"] = { "Remus",20,210000,"cars",0 },
	["comet6"] = { "Comet 6",30,250000,"cars",0 },
	["growler"] = { "Growler",30,250000,"cars",0 },
	["vectre"] = { "Vectre",40,250000,"cars",0 },
	["cypher"] = { "Cypher",20,310000,"cars",0 },
	["sultan3"] = { "Sultan 3",30,370000,"cars",0 },
	["rt3000"] = { "RT 3000",20,170000,"cars",0 },
	
	
	

}


function src.GerarPagamento(nomeFeio, placa)
    local source = source
    local user_id = vRP.getUserId(source)
    local nameUp = string.lower(nomeFeio)

    for k, v in pairs(vehglobal) do
        local kup = string.lower(k)
        local findString, d = string.find(kup, string.gsub(nameUp, "%s+", ""), 1, false)
        if (findString) then
			print(placa, 'detected plate')
            local consult = vRP.query("vehicles/plateVehicles", { plate = placa })
            local vehicleType = v[4] 
            local price = 0 
            local notificationSent = false 

            if vehicleType == "rental" then
                price = v[3] * 410
                local dollarsrollAmount = math.floor(v[3] * 400) 
                if consult[1] and consult[1]["user_id"] then
                    local sourceP = vRP.getUserSource(consult[1]["user_id"])
                    vRP.giveInventoryItem(user_id, 'dollarsroll', dollarsrollAmount, true) -- DINHEIRO SUJO
                    vRP.addFines(consult[1]["user_id"], price)
                    if not notificationSent then
                        TriggerClientEvent("Notify", sourceP, "pm", "Sucesso", "O seguro encontrou seu carro desmanchado o valor para recuperar sera R$" .. price, "verde", 5000)
                        notificationSent = true
                    end
                else
                    TriggerClientEvent("Notify", source, "pm", "Sucesso", "As peças desse veículo não possuem número para poderem ser falsificadas.", "verde", 5000)
                end

                break -- Exit the loop once a match is found
            elseif vehicleType == "cars" then
                price = v[3] / 5
                if consult[1] and consult[1]["user_id"] then
                    local sourceP = vRP.getUserSource(consult[1]["user_id"])
                    vRP.giveInventoryItem(user_id, 'dollarsroll', v[3] * (1 / 6), true) -- DINHEIRO SUJO
                    vRP.addFines(consult[1]["user_id"], price)
                    if not notificationSent then
                        TriggerClientEvent("Notify", sourceP, "pm", "Sucesso", "O seguro encontrou seu carro desmanchado o valor para recuperar sera R$" .. price, "verde", 5000)
                        notificationSent = true
                    end
                else
                    TriggerClientEvent("Notify", source, "pm", "Sucesso", "As peças desse veículo não possuem número para poderem ser falsificadas.", "verde", 5000)
                end

                break 
            elseif vehicleType == "work" then
                local sourceP = vRP.getUserSource(user_id)
                TriggerClientEvent("Notify", sourceP, "pm", "Sucesso", "Não é possível fazer comércio com esses tipos de peças deste veículo", "verde", 5000)

                break 
            end
        end
    end

    TriggerClientEvent("garages:Delete", source)
end



