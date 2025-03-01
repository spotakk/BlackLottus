--------------------------------------------------------------------
-- CONFIG
---------------------------------------------------------------------
-- FV
local IniciarServico = {472.15,-1310.75,29.22,116.23} -- Onde se inicia o serviço e verifica a existência de um carro
local LocalDesmancharCarro = {479.78,-1318.56,29.2,300.48} -- Onde deve haver o carro que será desmanchado para poder continuar o desmanche
local LocalFerramentas = {473.69,-1313.84,29.2,113.39} -- Local onde 'pegará' as ferramentas
local AnuncioChassi = {472.12,-1310.7,29.22,107.72} -- Onde finalizará a missão para entregar o chassi e receber dinheiro e itens
local Computador = {472.12,-1310.79,29.22,121.89} -- Local onde ficará o computador de venda
---------------------------------------------------------------------
--VARIAVEIS
---------------------------------------------------------------------
local blips = {}

local permitido = true
local etapa = 0 
local PosVeh = {}
local PecasRemovidas = {}
local TipoVeh = ''
local qtdPecasRemovidas = 0
local PecasVeh = 0


local CarrosDesmanches = {

    -------------------------------------------------------------------------|
    ----- CONCESSIONÁRIA ----------------------------------------------------|
    -------------------------------------------------------------------------| 
    
        ["bmws"] = 30000,
        ["gb200"] = 30000,
        ["amarok"] = 38000,
        ["eletran17"] = 40000,
        ["evoq"] = 145000,
        ["osiris"] = 11500,
        ["nissangtr"] = 50000,
        ["nissangtr2"] = 80000,
        ["nissangtr3"] = 90000,
        ["nissangtrnismo"] = 150000, 
        ["xj"] = 65000, 
        ["bf400"] = 95000, 
        ["z1000"] = 10000, 
        ["dune"] = 45000,
        ["audirs6"] = 60500, 
        ["audirs7"] = 60500, 
        ["bmwm3f80"] = 60000, 
        ["dodgechargersrt"] = 80000,
        ["focusrs"] = 40000,
        ["fordmustang"] = 60000,
        ["hondafk8"] = 75000,
        ["lancerevolution9"] = 60500,
        ["mazdarx7"] = 42000,
        ["mercedesa45"] = 42000,
        ["mustangmach1"] = 38000,
        ["nissan370z"] = 38000,
        ["nissangtr"] = 38000,
        ["nissangtrnismo"] = 38000,
        ["nissanskyliner35"] = 80000,
        ["porsche930"] = 42000,
        ["raptor2017"] = 38000,
        ["teslaprior"] = 60500,
        ["ruiner"] = 80000,
        ["verlierer2"] = 15000,
        ["sentinel"] = 5000,
        ["intruder"] = 15000,
        ["asea"] = 18000,
        ["sultan"] = 30000,
        ["casco"] = 9000,
        ["zentorno"] = 80000,
        ["voltic"] = 25000,
        ["sanchez"] = 20000,
        ["manchez"] = 17820,
        ["cbtwister"] = 17820,
        ["santafe"] = 45000,
        ["Panto"] = 5000,
        ["t20"] = 40000,
        ["r1"] = 90000,
        ["zx10r"] = 90000,
        ["tiger"] = 13000,
        ["i8"] = 78000,
        ["ferrariitalia"] = 25000,
        ["lamborghinihuracan"] = 90000,
        ["laferrari15"] = 80000,
        ["tyrant"] = 550000,
        ["r1200"] = 75000,
        ["audirs6"] = 50000,
        ["bmwi8"] = 80000,
        ["bmwm3e36"] = 50000,
        ["ferrari812"] = 50000,
        ["bmwm4gts"] = 50000,
        ["dodgechargersrt"] = 50000,
        ["ferrari812"] = 250000,
        ["ferrarif12"] = 200000,
        ["fordmustang"] = 50000,
        ["lamborghinihuracan"] = 70000,
        ["lancerevolutionx"] = 50000,
        ["mclarenp1"] = 100000,
        ["mercedesgt63"] = 70000,
        ["mustangfast"] = 30000,
        ["silvias15"] = 50000,
        ["subaruimpreza"] = 50000,
        ["teslaprior"] = 50000,
        ["toyotasupra"] = 50000,
        ["audirs6"] = 50000,
        ["kuruma"] = 30000,
        ["nm_corvette"] = 300000,
        ["dm1200"] = 70000,
        ["jesko2020"] = 300000,
        ["s1000rr"] = 100000,
        ["r6"] = 150000,
        ["r1"] = 150000,
        ["bmwg20"] = 100000,
        ["mercedesamg63"] = 80000,
        ["dodgechargerrt69"] = 50000,
        ["nissangtr50"] = 87000,
        ["astonmartindbs"] = 123000,
        ["ferrarif40"] = 200000,
        ["panameramansory"] = 200000,
        ["lamborghinihuracanlw"] = 200000,
        ["bmw1wb"] = 50000,
        ["shelbygt500"] = 80000,
        ["bloodline"] = 20000,
        ["urbandevil"] = 20000,
        ["350z"] = 200000,
        ["porsche911"] = 150000,
        ["jeepcherokee"] = 80000,
        ["golfmk7"] = 50000,
        ["bmwm5e34"] = 70000,
        ["dodgecharger1970"] = 60000,
        ["hachura"] = 80000,
        ["escalade2021"] = 80000,
        ["escaladegt900"] = 100000,
        ["golfgti"] = 90000,
        ["acuransx"] = 60000,
        ["toyotasupra2"] = 60000,
        ["subarubrz"] = 150000,
        ["subaruimpreza"] = 50000,
        ["skyliner34"] = 200000,
        ["skyliner342"] = 300000, 
        ["mustangfast"] = 70000,
        ["mercedesgt63"] = 300000,
        ["mclarensenna"] = 234000,
        ["mazdarx7"] = 30000,
        ["mazdarx72"] = 60000,
        ["civictyper"] = 50000,
        ["slamtruck"] = 70000,
        ["italirsx"] = 300000,
        ["squaddie"] = 30000,
        ["weevil"] = 30000,
        ["brioso2"] = 12378,
        ["zorrusso"] = 50934,
        ["thrax"] = 60000,
        ["krienger"] = 80000,
        ["furia"] = 50000,
        ["emerus"] = 150000,
        ["zion3"] = 30000,
        ["retinue2"] = 20000,
        ["nebula"] = 20000,
        ["jb7002"] = 20000,
        ["dynasty"] = 15000,
        ["sultan2"] = 25000,
        ["sugoi"] = 45000,
        ["paragon2"] = 90000,
        ["paragon"] = 40000,
        ["neo"] = 40000,
        ["locust"] = 80000,
        ["jugular"] = 100000,
        ["issi7"] = 20000,
        ["drafter"] = 50000,
        ["novak"] = 50000,
        ["vagrant"] = 40000, 
        ["outlaw"] = 60000,
        ["hellion"] = 30000,
        ["peyote2"] = 25000,
        ["gauntlet3"]= 50000,
        ["gauntlet4"] = 70000,
        ["tigon"] = 28989,
        ["peyote3"] = 30000,
        ["manana2"] = 67000,
        ["penumbra2"] = 70000,
        ["coquette4"] = 100000,
        ["seminole2"] = 43902,
        ["glendale"] = 13819,
        ["landstalker2"] = 40000,
        ["landstalker"] = 30000,  
        ["mule"] = 30000, 
        ["mule3"] =30000, 
        ["pounder"] = 90000,   
        ["blista"] =30000,
        ["dilettante"] =68549, 
        ["issi2"] =25367, 
        ["issi3"] =23546,  
        ["prairie"] =46757,  
        ["rhapsody"] =15366 ,
        ["cogcabrio"] = 31267, 
        ["exemplar"] =32136,
        ["f620"] = 42341, 
        ["felon"] =34123, 
        ["felon2"] =12313,  
        ["jackal"] =54535,  
        ["oracle"] =42344, 
        ["oracle2"] =42342,
        ["sentinel"] =23433,
        ["sentinel2"] =32323, 
        ["windsor"] =37218,  
        ["windsor2"] =38129, 
        ["zion2"] =34526, 
        ["fixter"] =23423, 
        ["scorcher"] =32423, 
        ["tribike"] =42342, 
        ["tribike2"] =23423,  
        ["tribike3"] =2342,   
        ["lguard"] =12312, 
        ["pbus"] =31231, 
        ["flatbed"] =32131, 
        ["guardian"] =32312, 
        ["trailersmall2"] =23342, 
        ["akuma"] =45345,  
        ["avarus"] =53453,
        ["bagger"] =31233,
        ["bati"] =74353, 
        ["bati2"] =44353,
        ["bf400"] =34545,  
        ["carbonrs"] =34534, 
        ["chimera"] =34535, 
        ["cliffhanger"] =23426, 
        ["daemon"] =23444,
        ["daemon2"] =34234, 
        ["defiler"] =23423, 
        ["diablous"] =23423, 
        ["diablous2"] =27456,
        ["double"] =23123,
        ["enduro"] =12373,
        ["esskey"] =31233,
        ["faggio"] =13231, 
        ["faggio2"] =12313,
        ["faggio3"] =13212,
        ["fcr"] =53453, 
        ["fcr2"] =34534,  
        ["gargoyle"] =43534, 
        ["hakuchou"] =34534, 
        ["hakuchou2"] =45344, 
        ["hexer"] =34545,  
        ["innovation"] =45344, 
        ["lectro"] =45454,
        ["manchez"] =34543, 
        ["nemesis"] =45343, 
        ["nightblade"] =43534, 
        ["oppressor"] =34534, 
        ["pcj"] =45435, 
        ["ruffian"] =45454, 
        ["sanchez"] =34534, 
        ["sanchez2"] =34543, 
        ["sanctus"] =45345, 
        ["thrust"] =34534,
        ["vader"] =34534,  
        ["vindicator"] =34534, 
        ["vortex"] =34534,
        ["wolfsbane"] =34534, 
        ["zombiea"] =34534, 
        ["zombieb"] =34534, 
        ["blade"] =34534, 
        ["buccaneer"] =34534, 
        ["buccaneer2"] =34534, 
        ["chino"] =34534,
        ["chino2"] =34534,
        ["clique"] =35454,  
        ["coquette3"] =42344, 
        ["deviant"] =43432,
        ["dominator"] =34345,
        ["dominator2"] =42343, 
        ["dominator3"] =43243, 
        ["dukes"] =34342, 
        ["faction"] =43423,
        ["faction2"] =43243, 
        ["faction3"] =43243, 
        ["ellie"] =43435, 
        ["gauntlet"] =43242,
        ["hermes"] =21323,  
        ["hotknife"] =23123, 
        ["hustler"] =32322,
        ["impaler"] =23232,
        ["moonbeam"] =23455, 
        ["moonbeam2"] =45354, 
        ["nightshade"] =34534, 
        ["picador"] =54355,
        ["ratloader2"] =45345, 
        ["ruiner"] =43543,  
        ["sabregt"] =34534,
        ["sabregt2"] =67567, 
        ["slamvan"] =43534,
        ["stalion"] =76765,
        ["stalion2"] =34234, 
        ["tampa"] =34234, 
        ["tulip"] =34343, 
        ["vamos"] =34344, 
        ["vigero"] =43434, 
        ["virgo"] =44433, 
        ["virgo2"] =34344,
        ["virgo3"] =34344,
        ["voodoo"] =54544,  
        ["voodoo2"] =43234,
        ["yosemite"] =43244, 
        ["bfinjection"] =23432,
        ["bifta"] =23432, 
        ["blazer"] =12333,  
        ["blazer3"] =12333, 
        ["blazer4"] =12333, 
        ["bodhi2"] =12333,  
        ["brawler"] =12333,
        ["dloader"] =12333,  
        ["dubsta3"] =12333, 
        ["freecrawler"] =12333, 
        ["kalahari"] =31235,
        ["kamacho"] =23423,
        ["mesa3"] =23423,  
        ["rancherxl"] =42344, 
        ["rebel"] =42344, 
        ["riata"] =23433,
        ["sandking"] =34343, 
        ["sandking2"] =34322, 
        ["trophytruck"] =23444, 
        ["velum"] =34234, 
        ["baller"] =34343, 
        ["baller2"] =23445, 
        ["baller3"] =34542, 
        ["baller4"] =34542, 
        ["baller5"] =35432, 
        ["baller6"] =45423, 
        ["bjxl"] =23423, 
        ["cavalcade"] =23441, 
        ["cavalcade2"] =34234, 
        ["contender"] =54344, 
        ["dubsta"] =75656,  
        ["dubsta2"] =76566, 
        ["fq2"] =67656, 
        ["granger"] =56756,
        ["gresley"] =34563,  
        ["habanero"] =53454,
        ["huntley"] =45434,  
        ["landstalker"] =43454, 
        ["mesa"] =34544, 
        ["patriot"] =45345,
        ["patriot2"] =54354, 
        ["radi"] =34544, 
        ["rocoto"] =54543, 
        ["seminole"] =34545,
        ["serrano"] =34545,  
        ["toros"] =45453, 
        ["xls"] =23245, 
        ["xls2"] =44545, 
        ["asea"] =45345,
        ["asterope"] =54354,
        ["cog55"] =34545, 
        ["cog552"] =45444,
        ["cognoscenti"] =34545, 
        ["cognoscenti2"] =34544, 
        ["emperor"] =54345, 
        ["emperor2"] =34544,
        ["fugitive"] =34544, 
        ["glendale"] =34543, 
        ["ingot"] =23425,
        ["intruder"] =32423,
        ["premier"] =34456,  
        ["primo"] =34356,
        ["primo2"] =67678,  
        ["regina"] =87676, 
        ["romero"] =67666, 
        ["schafter2"] =67676, 
        ["schafter5"] =67677, 
        ["schafter6"] =67676, 
        ["stafford"] =67677, 
        ["stanier"] =67645,  
        ["stratum"] =34543,  
        ["stretch"] =34543,
        ["superd"] =34543,  
        ["surge"] =34543, 
        ["tailgater"] =34543, 
        ["warrener"] =34543, 
        ["washington"] =34543, 
        ["bus"] =34543, 
        ["taxi"] =34543, 
        ["trash"] =34543, 
        ["alpha"] =34543, 
        ["banshee"] =34543,
        ["bestiagts"] =34543, 
        ["blista2"] =34543,
        ["blista3"] =34543,
        ["buffalo"] =34543,
        ["buffalo2"] =34543, 
        ["buffalo3"] =34543, 
        ["carbonizzare"] =34543, 
        ["comet2"] =31234,
        ["comet3"] =23432,
        ["comet4"] =32434,
        ["comet5"] =23434,
        ["coquette"] =23434, 
        ["elegy2"] =34342,
        ["feltzer2"] =23434, 
        ["flashgt"] =23434, 
        ["furoregt"] =23434, 
        ["fusilade"] =34323,
        ["futo"] =23433,
        ["hotring"] =43434,
        ["italigto"] =34343, 
        ["jester"] =34234,  
        ["jester2"] =43234, 
        ["jester3"] =23434, 
        ["khamelion"] =23433,
        ["kuruma"] =34323,  
        ["lynx"] =34324, 
        ["massacro"] =32432, 
        ["massacro2"] =65645, 
        ["neon"] =45645, 
        ["ninef"] =45656, 
        ["ninef2"] =45655,
        ["omnis"] =45656, 
        ["pariah"] =45655,  
        ["penumbra"] =45656, 
        ["raiden"] =45656,  
        ["rapidgt"] =45654, 
        ["rapidgt2"] =45655, 
        ["ruston"] =45656,  
        ["schafter3"] =43245, 
        ["schafter4"] =23243, 
        ["schlagen"] =31232, 
        ["schwarzer"] =12312,
        ["sentinel3"] =12323, 
        ["seven70"] =12312, 
        ["specter"] =12323,
        ["specter2"] =21323, 
        ["streiter"] =21345,
        ["sultan"] =45344,  
        ["surano"] =12312, 
        ["tampa2"] =23433,
        ["tropos"] =23433,  
        ["verlierer2"] =23434, 
        ["btype"] =54534, 
        ["btype2"] =12343,
        ["btype3"] =43433,
        ["casco"] =23433, 
        ["fagaloa"] =34344,
        ["feltzer3"] =34322, 
        ["gt500"] =23244,  
        ["infernus2"] =32433, 
        ["mamba"] =34343, 
        ["manana"] =34343, 
        ["michelli"] =34343,
        ["monroe"] =32343,  
        ["peyote"] =45645, 
        ["pigalle"] =34534,  
        ["rapidgt3"] =34545,
        ["retinue"] =34544,
        ["savestra"] =34545, 
        ["stinger"] =45454,
        ["stingergt"] =45344, 
        ["swinger"] =34545,
        ["tornado"] =34545,  
        ["tornado2"] =54345, 
        ["tornado5"] =34534, 
        ["turismo2"] =45433, 
        ["z190"] =34534,
        ["ztype"] =34534, 
        ["cheburek"] =34534,
        ["adder"] =34534, 
        ["autarch"] =34534, 
        ["banshee2"] =34534, 
        ["bullet"] =34534, 
        ["cheetah"] =34534, 
        ["cyclone"] =34534, 
        ["entity2"] =34534, 
        ["entityxf"] =34534,
        ["fmj"] =34534, 
        ["gp1"] =34534, 
        ["infernus"] =34534, 
        ["italigtb"] =34534, 
        ["italigtb2"] =34534, 
        ["le7b"] =34534, 
        ["nero"] =34534, 
        ["nero2"] =34534, 
        ["osiris"] =34534, 
        ["penetrator"] =34534, 
        ["pfister811"] =34534, 
        ["reaper"] =34534, 
        ["sc1"] =54354, 
        ["sheava"] =34543, 
        ["sultanrs"] =34545, 
        ["t20"] =45433, 
        ["taipan"] =34544, 
        ["tempesta"] =34545, 
        ["tezeract"] =45433, 
        ["turismor"] =34544, 
        ["tyrant"] =23434, 
        ["tyrus"] =23434, 
        ["vacca"] =23434, 
        ["vagner"] =23432, 
        ["visione"] =23434, 
        ["voltic"] =23434, 
        ["xa21"] =23434, 
        ["zentorno"] =23434, 
        ["bobcatxl"] =23434, 
        ["burrito"] =23434, 
        ["burrito2"] =34322, 
        ["burrito3"] =34322, 
        ["burrito4"] =34322,
        ["camper"] =34322, 
        ["gburrito"] =34322, 
        ["minivan"] =34322, 
        ["minivan2"] =34322, 
        ["paradise"] =34322, 
        ["pony"] =34322, 
        ["pony2"] =34322, 
        ["rumpo"] =34322, 
        ["rumpo2"] =34322, 
        ["rumpo3"] =34322, 
        ["speedo"] =34322, 
        ["surfer"] =34322,
        ["surfer2"] =42344, 
        ["taco"] =23432, 
        ["youga"] =23433, 
        ["asbo"] =23434, 
        ["kanjo"] =34323, 
        ["yosemite2"] =23243, 
        ["caracara2"] =23343, 
        ["everon"] =23434, 
        ["rebla"] =23434, 
        ["komoda"] =23423, 
        ["imorgon"] =23423, 
        ["vstr"] =23434, 
        ["club"] =53453, 
        ["gauntlet5"] =34544, 
        ["yosemite3"] =23423    
    }
    
---------------------------------------------------------------------
-- CODIGO
---------------------------------------------------------------------

Citizen.CreateThread(function() 

    lepitopi = CreateObject(GetHashKey("prop_laptop_lester"),Computador[1], Computador[2], Computador[3]-0.97,true,true,true)
    SetEntityHeading(lepitopi, Computador[4])

    while true do
        local ThreadDelay = 5000
        if permitido then
            ThreadDelay = 0
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            if etapa == 0 then
                local dist = Vdist(pedCoords, IniciarServico[1], IniciarServico[2], IniciarServico[3])
                if dist < 10 then
                    ThreadDelay = 0
                    DrawMarker(21, IniciarServico[1], IniciarServico[2], IniciarServico[3]-0.5, 0, 0, 0, 180.0, 0, 0, 0.4, 0.4, 0.4, 207, 158, 25, 150, 0, 0, 0, 1)
                    if dist < 2 then
                        ThreadDelay = 0
                        text3D(IniciarServico[1], IniciarServico[2], IniciarServico[3]-0.5, '~y~[E] ~w~PARA DESMANCHAR O VEÍCULO')
                        if IsControlJustPressed(0,38) then
                            veh = CheckVeiculo(LocalDesmancharCarro[1], LocalDesmancharCarro[2], LocalDesmancharCarro[3])
                            if veh then 
                                local VehPermitido, ClasseVeh = CheckClasse(veh)
                                placa = GetVehicleNumberPlateText(veh)
                                
                                local model = GetEntityModel(veh)
                                nomeCarro = GetDisplayNameFromVehicleModel(model)
                               
                                if VehPermitido then 
                                    if true then
                                        if serverAPI.CheckItem() then    
                                            if ClasseVeh == 8 then
                                                TipoVeh = 'moto'
                                            else
                                                TipoVeh = 'carro'
                                            end
                                            -- NOTIFICACAO AQUI
                                            TriggerEvent('Notify',"check","Sucesso",'Veículo localizado! <br> Placa:'..placa..'<br>Pegue as ferramentas para desmanchar o veículo.',"verde",5000)
                                            etapa = 1
                                            FreezeEntityPosition(veh, true) 
                                            SetVehicleDoorsLocked(veh, 4)
                                        else
                                            TriggerEvent('Notify',"cancel","Negado",'Você necessita de um <b>cartão de desmanche</b> para iniciar o serviço.',"vermelho",5000)
                                        end
                                    else
                                        TriggerEvent('Notify',"cancel","Negado",'Esse veículo não pode ser desmanchado.',"vermelho",5000)
                                    end
                                else
                                    TriggerEvent('Notify',"cancel","Negado",'O veículo precisa ser um carro, van ou moto.',"vermelho",5000)
                                end
                            else 
                                TriggerEvent("Notify","cancel","Negado",'Não há nenhum carro próximo para ser desmanchado.',"vermelho",5000)
                            end
                        end
                    end
                end
            elseif etapa == 1 then
                local dist = Vdist(pedCoords, LocalFerramentas[1], LocalFerramentas[2], LocalFerramentas[3])
                if dist < 10 then
                    DrawMarker(21, LocalFerramentas[1], LocalFerramentas[2], LocalFerramentas[3]-0.5, 0, 0, 0, 180.0, 0, 0, 0.4, 0.4, 0.4, 207, 158, 25, 150, 0, 0, 0, 1)
                    if dist < 1 then
                        text3D(LocalFerramentas[1], LocalFerramentas[2], LocalFerramentas[3]-0.5, '~y~[E] ~w~PARA PEGAR AS ~y~FERRAMENTAS')
                        if IsControlJustPressed(0,38) then
                            if TipoVeh == 'carro' then
                                PosVeh['Porta_Direita'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"handle_dside_f"))
                                PosVeh['Porta_Esquerda'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"handle_pside_f"))
                                PosVeh['Roda_EsquerdaFrente'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lf"))
                                PosVeh['Roda_DireitaFrente'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_rf"))
                                PosVeh['Roda_EsquerdaTras'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lr"))
                                PosVeh['Roda_DireitaTras'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_rr"))
                                PosVeh['Capo'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"bumper_f"))
                                PecasVeh = 7
                            else
                                PosVeh['Roda_Frente'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lf"))
                                PosVeh['Roda_Tras'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lr"))
                                PosVeh['Banco'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"chassis_dummy"))
                                PecasVeh = 3
                            end
                            FreezeEntityPosition(ped, true)
                            SetEntityHeading(ped, LocalFerramentas[4])
                            vRP.playAnim(false,{"amb@medic@standing@tendtodead@idle_a","idle_a"},true)
                            TriggerEvent('progress', 5000, 'PEGANDO FERRAMENTAS')

                            Wait(5000)  

                            etapa = 2
                            TriggerEvent('Notify',"check","Sucesso",'Você pegou todas as ferramentas, vá e desmanche o veículo.',"verde",5000)
                            FreezeEntityPosition(ped, false)
                            ClearPedTasks(ped)
                        end
                    end
                end
            elseif etapa == 2 then

           
                for k , v in pairs(PosVeh) do
                    local x,y,z = table.unpack(v)
                    if not PecasRemovidas[k] then
                        local dist = Vdist(pedCoords, x,y,z)
                        if dist < 10 then
                            DrawMarker(21, x, y, z+1, 0, 0, 0, 180.0, 0, 0, 0.4, 0.4, 0.4, 207, 158, 25, 150, 0, 0, 0, 1)
                            if dist < 1.0 then
                                text3D(x, y, z+0.5, '~y~[E] ~w~PARA DESMANCHAR')
                                if IsControlJustPressed(0, 38) then
                                    if k == 'Capo' or k == 'pMalas' then
                                        vRP.playAnim(false, {{"mini@repair" , "fixing_a_player"}}, true)
                                        vRP._playAnim(false,{task='WORLD_HUMAN_WELDING'},true)
                                    elseif k == 'Porta_Direita' or k == 'Porta_Esquerda' or k == 'Banco' then
                                        vRP._playAnim(false,{task='WORLD_HUMAN_WELDING'},true)
                                    else
                                        vRP.playAnim(false, {{"amb@medic@standing@tendtodead@idle_a" , "idle_a"}}, true)
                                        vRP._playAnim(false,{task='WORLD_HUMAN_WELDING'},true)
                                    end
                                    Wait(5000)
                                    ClearPedTasks(ped)
                                    PecasRemovidas[k] = true
                                    qtdPecasRemovidas = qtdPecasRemovidas + 1
                                    if TipoVeh == 'carro' then
                                        if k == 'Roda_EsquerdaFrente' then
                                            SetVehicleTyreBurst(veh, 0, true, 1000)
                                        elseif k == 'Roda_DireitaFrente' then
                                            SetVehicleTyreBurst(veh, 1, true, 1000)
                                        elseif k == 'Roda_EsquerdaTras' then
                                            SetVehicleTyreBurst(veh, 4, true, 1000)
                                        elseif k == 'Roda_DireitaTras' then
                                            SetVehicleTyreBurst(veh, 5, true, 1000)
                                        elseif k == 'Porta_Direita' then
                                            SetVehicleDoorBroken(veh, 0, true)
                                        elseif k == 'Porta_Esquerda' then
                                            SetVehicleDoorBroken(veh, 1, true)
                                        elseif k == 'Capo' then
                                            SetVehicleDoorBroken(veh, 4, true)
                                        end
                                    else
                                        if k == 'Roda_Frente' then
                                            SetVehicleTyreBurst(veh, 0, true, 1000)
                                        elseif k == 'Roda_Tras' then
                                            SetVehicleTyreBurst(veh, 4, true, 1000)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                end 

                if ( qtdPecasRemovidas  == PecasVeh or  qtdPecasRemovidas >= 6) then
                    etapa = 3
                    TriggerEvent('Notify',"check","Sucesso",'Vá até a bancada e anuncie o chassi do veículo.',"verde",5000)
                end
            elseif etapa == 3 then
                local dist = Vdist(pedCoords, AnuncioChassi[1], AnuncioChassi[2], AnuncioChassi[3])
                if dist < 10 then
                    DrawMarker(21, AnuncioChassi[1], AnuncioChassi[2], AnuncioChassi[3]-0.5, 0, 0, 0, 180.0, 0, 0, 0.4, 0.4, 0.4, 207, 158, 25, 150, 0, 0, 0, 1)
                    if dist < 1 then
                        text3D(AnuncioChassi[1], AnuncioChassi[2], AnuncioChassi[3]-0.5, '~y~[E] ~w~PARA ANUNCIAR O ~y~CHASSI')
                        if IsControlJustPressed(0,38) then
                            FreezeEntityPosition(ped, true)
                            SetEntityCoords(ped, AnuncioChassi[1], AnuncioChassi[2], AnuncioChassi[3]-0.97)
                            SetEntityHeading(ped, AnuncioChassi[4])
                            vRP.playAnim(false, {{"amb@medic@standing@timeofdeath@base", "loop"}}, true)
                            TriggerEvent('progress', 5000, 'ANUNCIANDO CHASSI DO VEÍCULO')
                            Wait(5000)
                            FreezeEntityPosition(ped, false)
                            ClearPedTasks(ped)
                            serverAPI.GerarPagamento(nomeCarro,placa)
                            etapa = 0 
                            PosVeh = {}
                            PecasRemovidas = {}
                            TipoVeh = ''
                            qtdPecasRemovidas = 0
                            PecasVeh = 0
                        end
                    end
                end
            end



            if etapa > 0 then
                if IsControlJustPressed(0,168) then
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                    etapa = 0 
                    PosVeh = {}
                    PecasRemovidas = {}
                    TipoVeh = ''
                    qtdPecasRemovidas = 0
                    PecasVeh = 0
                    TriggerEvent('Notify',"check","Sucesso",'Você cancelou o serviço.',"verde",5000)
                end
            end


        end
        Citizen.Wait(ThreadDelay)
    end
end)


Citizen.CreateThread(function() 
    while true do
        if serverAPI.CheckPerm() then
            permitido = true
        else
            permitido = false
        end
        Wait(5000)
    end
end) 

----------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------- FUNCOES AUXILIARES
----------------------------------------------------------------------------------------------------------------------------------

-- DEBUG
-- RegisterCommand('etapa', function("verde", args, rawCmd)
--     veh = CheckVeiculo(LocalDesmancharCarro[1], LocalDesmancharCarro[2], LocalDesmancharCarro[3])
--     PosVeh['Porta_Direita'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"handle_dside_f"))
--     PosVeh['Porta_Esquerda'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"handle_pside_f"))
--     PosVeh['Roda_EsquerdaFrente'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lf"))
--     PosVeh['Roda_DireitaFrente'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_rf"))
--     PosVeh['Roda_EsquerdaTras'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lr"))
--     PosVeh['Roda_DireitaTras'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_rr"))
--     PosVeh['Capo'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"bumper_f"))
--     PecasVeh = 1
--     TipoVeh = 'carro'

--     -- PosVeh['Roda_Frente'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lf"))
--     -- PosVeh['Roda_Tras'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lr"))
--     -- PosVeh['Banco'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"chassis_dummy"))
--     -- PecasVeh = 3
--     -- TipoVeh = 'moto'

--     etapa = 2

--     placa = GetVehicleNumberPlateText(veh)
--     nomeCarro = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
--     modeloCarro = GetLabelText(nomeCarro)
-- end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- Check Classe
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckClasse(veh)
    local classe = GetVehicleClass(veh)
    if classe ~= 0 and classe ~= 1 and classe ~= 2 and classe ~= 3 and classe ~= 4 and classe ~= 5 and classe ~= 6 and classe ~= 7 and classe ~= 8 and classe ~= 9 and classe ~= 11 and classe ~= 12 then
        return false, 0
    else
        return true, classe
    end
end

function CheckVehPermitido(nomeCarro)
    local vehs = serverAPI.GetVehs()
    for k , v in pairs(vehs) do
        if string.upper(nomeCarro) == string.upper(k) then
            return true
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function text3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)

	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAR VAGA VAGA
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckVeiculo(x,y,z)
    local check = GetClosestVehicle(x,y,z,5.001,0,71)
    if DoesEntityExist(check) then
        return check
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
function DeletarVeiculo( entity )
    SetEntityAsMissionEntity(entity, true, true)
    DeleteVehicle(entity)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAW TXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end