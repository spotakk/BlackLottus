local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("nation_skinshop")
fclient = {}
Tunnel.bindInterface("nation_skinshop", fclient)


---------------------------------------------------------------------------
-----------------------ANIMAÇÃO DE PARADO---------------------------
---------------------------------------------------------------------------

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function freezeAnim(dict, anim, flag, keep)
    if not keep then
        ClearPedTasks(PlayerPedId())
    end
    LoadAnim(dict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 2.0, 2.0, -1, flag or 1, 0, false, false, false)
    RemoveAnimDict(dict)
end

handsUp = false
handsup = function()
    handsUp = not handsUp
    if handsUp then
        freezeAnim("random@mugging3", "handsup_standing_base", 49)
    else
        freezeAnim("move_f@multiplayer", "idle")
    end
end



---------------------------------------------------------------------------
-----------------------CÂMERAS--------------------------
---------------------------------------------------------------------------

local cameras = {
    body = { coords = vec3(0.4, 2.1, 0.9), point = vec3(-0.7, -0.1, -0.2) },
    head = { coords = vec3(0.0, 0.7, 0.8), point = vec3(-0.1, 0.0, 0.6) },
    chest = { coords = vec3(0.0, 1.4, 0.7), point = vec3(-0.4, 0.0, 0.2) },
    legs = { coords = vec3(0.0, 1.3, 0.2), point = vec3(-0.4, 0.0, -0.5) },
    feet = { coords = vec3(0.0, 0.8, -0.5), point = vec3(-0.25, 0.0, -1.0) }
}


componentCams = {
    ["masks"] = "head",
    ["torsos"] = "chest",
    ["legs"] = "legs",
    ["bags"] = "chest",
    ["shoes"] = "feet",
    ["accessories"] = "body",
    ["undershirts"] = "chest",
    ["bodyArmors"] = "chest",
    ["decals"] = "body",
    ["tops"] = "chest",
    ["hats"] = "head",
    ["glasses"] = "head",
    ["ears"] = "head",
    ["watches"] = "legs",
    ["bracelets"] = "legs",
}

local activeCam

function interpCamera(cameraName)
    if cameras[cameraName] then
        if cameraName == activeCam then return end
        activeCam = cameraName
        local ped = PlayerPedId()
        local cam = cameras[cameraName]
        local coord = GetOffsetFromEntityInWorldCoords(ped, cam.coords)
        local tempCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coord, 0, 0, 0, 50.0)
        local pointCoords = GetOffsetFromEntityInWorldCoords(ped, cam.point)
        SetCamActive(tempCam, true)
        SetCamActiveWithInterp(tempCam, fixedCam, 600, true, true)
        PointCamAtCoord(tempCam, pointCoords)
        CreateThread(function()
            Wait(600)
            DestroyCam(fixedCam)
            fixedCam = tempCam
        end)
    end
end

function createCamera()
    local ped = PlayerPedId()
    local groundCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    if store and store.coords then
        SetEntityCoords(ped, store.coords.x, store.coords.y, store.coords.z - 0.97)
        if store.h then
            SetEntityHeading(ped, store.h)
        end
    end
    AttachCamToEntity(groundCam, ped, 0.5, -1.6, 0.0)
    SetCamRot(groundCam, 0, 0.0, 0.0)
    SetCamActive(groundCam, true)
    RenderScriptCams(true, false, 1, true, true)
    activeCam = "body"
    local cam = cameras[activeCam]
    local coord = GetOffsetFromEntityInWorldCoords(ped, cam.coords)
    fixedCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coord, 0, 0, 0, 50.0)
    local pointCoords = GetOffsetFromEntityInWorldCoords(ped, cam.point)
    PointCamAtCoord(fixedCam, pointCoords)
    SetCamActive(fixedCam, true)
    SetCamActiveWithInterp(fixedCam, groundCam, 1000, true, true)
    CreateThread(function()
        Wait(1000)
        DestroyCam(groundCam)
    end)
end

---------------------------------------------------------------------------
-----------------------DEIXAR OUTROS PLAYERS INVISÍVEIS--------------------------
---------------------------------------------------------------------------

function setPlayersVisible(bool)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, not bool)
    SetEntityInvincible(ped, not bool) -- COMENTAR CASO DE PROBLEMAS COM ANTI CHEAT
    if bool then
        for _, player in ipairs(GetActivePlayers()) do
            local otherPlayer = GetPlayerPed(player)
            if ped ~= otherPlayer then
                SetEntityVisible(otherPlayer, bool)
            end
        end
    else
        CreateThread(function()
            while inMenu do
                for _, player in ipairs(GetActivePlayers()) do
                    local otherPlayer = GetPlayerPed(player)
                    if ped ~= otherPlayer then
                        SetEntityVisible(otherPlayer, bool)
                    end
                end
                InvalidateIdleCam()
                Wait(1)
            end
        end)
    end
end

---------------------------------------------------------------------------
-----------------------LOJAS DE ROUPAS--------------------------
---------------------------------------------------------------------------


defaultPrices = {
    ["masks"] = 50,
    ["torsos"] = 20,
    ["legs"] = 200,
    ["bags"] = 150,
    ["shoes"] = 200,
    ["accessories"] = 90,
    ["undershirts"] = 100,
    ["bodyArmors"] = 300,
    ["decals"] = 50,
    ["tops"] = 300,
    ["hats"] = 120,
    ["glasses"] = 180,
    ["ears"] = 40,
    ["watches"] = 40,
    ["bracelets"] = 35,
}



customClothes = {

}

function format(n)
    local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
    return left .. (num:reverse():gsub('(%d%d%d)', '%1.'):reverse()) .. right
end

function isCloth(index, value)
    return type(index) == "number" and type(value) == "table" -- verificar se está acessando o indice de uma roupa
end

isComponentBlocked = function(id, component)
    --if component == "bodyArmors" then return true end
    return customClothes[id] and customClothes[id][component] and customClothes[id][component].blocked
end

isClothBlocked = function(id, component, index, gender)
    if customClothes[id] and customClothes[id][component] and customClothes[id][component][gender] then
        local c = customClothes[id][component][gender]
        return (c.type == "insert" and (not c[index] or (type(c[index]) == "table" and c[index].blocked))) or
        (c.type == "remove" and c[index] and (type(c[index]) == "boolean" or (type(c[index]) == "table" and c[index].blocked)))
    end
    return false
end

getBlockedComponentTextures = function(cloth, id, component, index, gender)
    for i = 0, cloth.textures do
        if not cloth[i] then
            cloth[i] = { blocked = false }
        else
            cloth[i].blocked = false
        end
        if customClothes[id] and customClothes[id][component] and customClothes[id][component][gender] and customClothes[id][component][gender][index] then
            local c = customClothes[id][component][gender][index]
            if type(c) == "table" and c.textures and c.textures[i] then
                cloth[i].blocked = c.textures[i].blocked
            end
        end
    end
    return cloth
end

getClothPrice = function(id, component, index, gender)
    if id == "nation_creator" then return 0 end
    if customClothes[id] and customClothes[id][component] and customClothes[id][component][gender] then
        local c = customClothes[id][component][gender]
        if c[index] then
            local price = c[index]
            if type(price) == "table" then
                price = price.price or c.defaultPrice or defaultPrices[component]
            elseif type(price) == "boolean" then
                price = c.defaultPrice
            end
            return price
        else
            return c.defaultPrice or defaultPrices[component]
        end
    end
    return defaultPrices[component]
end



getClothes = function(id)
    local clothes = getAllClothes()
    local gender = getGender()
    for component, v in pairs(clothes) do
        v.blocked = isComponentBlocked(id, component)
        for index, j in pairs(v) do
            if isCloth(index, j) then
                j.price = getClothPrice(id, component, index, gender)
                j.blocked = isClothBlocked(id, component, index, gender)
                j = getBlockedComponentTextures(j, id, component, index, gender)
            end
        end
    end
    return clothes
end

getCartTotal = function(cart, initialClothes, storeId)
    local total = 0
    local gender = getGender()
    for component, index in pairs(cart) do
        if initialClothes[component] then
            local i = initialClothes[component][1]
            if index >= 0 and index ~= i then
                total = total + getClothPrice(storeId, component, index, gender)
            end
        end
    end
    return math.floor(total)
end


getPopupText = function(total) -- TEXTO QUE VAI APARECER NO POPUP NA HORA DE COMPRAR
    return "você deseja pagar o valor de $ <b>" .. format(total or 0) .. "</b> ?"
end

skinshops = {
    [1] = {
        clothes = getClothes, permission = nil, coords = vec3(75.43, -1392.83, 29.37)
    },
    [2] = {
        clothes = getClothes, permission = nil, coords = vec3(-710.018, -153.072, 37.415)
    },
    [3] = {
        clothes = getClothes, permission = nil, coords = vec3(-163.261, -302.83, 39.733)
    },
    [4] = {
        clothes = getClothes, permission = nil, coords = vec3(425.51, -806.27, 29.49)
    },
    [5] = {
        clothes = getClothes, permission = nil, coords = vec3(-829.413, -1073.71, 11.5)
    },
    [6] = {
        clothes = getClothes, permission = nil, coords = vec3(-1450.32, -237.514, 49.81)
    },
    [7] = {
        clothes = getClothes, permission = nil, coords = vec3(12.138, 6514.402, 31.877)
    },
    [8] = {
        clothes = getClothes, permission = nil, coords = vec3(125.112, -223.696, 54.557)
    },
    [9] = {
        clothes = getClothes, permission = nil, coords = vec3(-1083.9, -2732.77, 14.6)
    },
    [10] = {
        clothes = getClothes, permission = nil, coords = vec3(-1101.27, 2710.63, 19.1)
    },
    [11] = {
        clothes = getClothes, permission = nil, coords = vec3(-3170.66, 1043.62, 20.86)
    },
    [12] = {
        clothes = getClothes, permission = nil, coords = vec3(1196.81, 2710.16, 38.22)
    },
    [13] = {
        clothes = getClothes, permission = nil, coords = vec3(615.23, 2763.42, 42.08)
    },
    [14] = {
        clothes = getClothes, permission = nil, coords = vec3(606.19085693359, 10.993266105652, 82.741844177246)
    },
    [15] = {
        clothes = getClothes, permission = nil, coords = vec3(-1192.61, -768.61, 17.32)
    },
    [16] = {
        clothes = getClothes, permission = nil, coords = vec3(1372.34, -104.4, 124.78)
    },
    [17] = {
        clothes = getClothes, permission = nil, coords = vec3(474.46, -1085.5, 38.7)
    },
    [18] = {
        clothes = getClothes, permission = nil, coords = vec3(-920.26, -2037.81, 9.4) -- FAVELA PRAIA
    },
    [19] = {
        clothes = getClothes, permission = nil, coords = vec3(-969.08795166016, -1065.2648925781, 5.7862596511841)
    },
    [20] = {
        clothes = getClothes, permission = nil, coords = vec3(-992.0263671875, -1098.0269775391, 7.0329532623291)
    },
    [21] = {
        clothes = getClothes, permission = nil, coords = vec3(-1025.0863037109, -1038.0546875, 5.8544669151306)
    },
    [22] = {
        clothes = getClothes, permission = nil, coords = vec3(-1047.2467041016, -1172.7924804688, 5.9276084899902)
    },
    [23] = {
        clothes = getClothes, permission = nil, coords = vec3(-1034.3504638672, -1152.5480957031, 7.0330810546875)
    },
    [24] = {
        clothes = getClothes, permission = nil, coords = vec3(-940.59484863281, -939.37982177734, 7.0330853462219)
    },
    [25] = {
        clothes = getClothes, permission = nil, coords = vec3(-969.88250732422, -879.42596435547, 5.7788381576538)
    },
    [26] = {
        clothes = getClothes, permission = nil, coords = vec3(-996.17864990234, -881.73883056641, 6.8843030929565)
    },
    [27] = {
        clothes = getClothes, permission = nil, coords = vec3(162.0386505127, -1237.8605957031, 14.1988019)
    },
    [28] = {
        clothes = getClothes, permission = nil, coords = vec3(134.09625244141, -1920.7840576172, 21.380420684814)
    },
    [29] = {
        clothes = getClothes, permission = nil, coords = vec3(25.461236953735, -1836.9232177734, 24.601421356201)
    },
    [30] = {
        clothes = getClothes, permission = nil, coords = vec3(173.20530700684, -1862.7503662109, 24.393407821655)
    },
    [31] = {
        clothes = getClothes, permission = nil, coords = vec3(171.30599975586, -1919.9760742188, 21.373430252075)
    },
    [32] = {
        clothes = getClothes, permission = nil, coords = vec3(135.87355041504, -1965.91015625, 18.860427856445)
    },
    [33] = {
        clothes = getClothes, permission = nil, coords = vec3(284.02304077148, -1975.6986083984, 21.576553344727)
    },
    [34] = {
        clothes = getClothes, permission = nil, coords = vec3(316.62097167969, -1933.0915527344, 25.00205039978)
    },
    [35] = {
        clothes = getClothes, permission = nil, coords = vec3(1294.6239013672, -585.58117675781, 74.825675964355)
    },
    [36] = {
        clothes = getClothes, permission = nil, coords = vec3(1315.5327148438, -593.56713867188, 76.341232299805)
    },
    [37] = {
        clothes = getClothes, permission = nil, coords = vec3(1334.3977050781, -604.43505859375, 74.705627441406)
    },
    [38] = {
        clothes = getClothes, permission = nil, coords = vec3(1364.3627929688, -619.31066894531, 77.805099487305)
    },
    [39] = {
        clothes = getClothes, permission = nil, coords = vec3(1394.5843505859, -603.49908447266, 77.580352783203)
    },
    [40] = {
        clothes = getClothes, permission = nil, coords = vec3(1401.7993164063, -567.06646728516, 77.592666625977)
    },
    [41] = {
        clothes = getClothes, permission = nil, coords = vec3(1378.0510253906, -546.93676757813, 74.68782043457)
    },
    [42] = {
        clothes = getClothes, permission = nil, coords = vec3(1356.1143798828, -536.26287841797, 76.985153198242)
    },
    [43] = {
        clothes = getClothes, permission = nil, coords = vec3(1332.9801025391, -527.22955322266, 72.441688537598)
    },
    [44] = {
        clothes = getClothes, permission = nil, coords = vec3(1310.2330322266, -516.45397949219, 74.555351257324)
    },
    [45] = {
        clothes = getClothes, permission = nil, coords = vec3(1252.6925048828, -611.47082519531, 69.571067810059)
    },
    [46] = {
        clothes = getClothes, permission = nil, coords = vec3(1237.0766601563, -728.80633544922, 60.718368530273)
    },
    [47] = {
        clothes = getClothes, permission = nil, coords = vec3(-1570.787109375, -3013.4379882813, -74.406158447266)
    },
    [48] = {
        clothes = getClothes, permission = nil, coords = vec3(-3202.29, 785.33, 14.08)
    },
    [49] = {
        clothes = getClothes, permission = nil, coords = vec3(828.60223388672, -956.10949707031, 22.087633132935)
    },
    -- [50] = {
    --     clothes = getClothes, permission = nil, coords = vec3(455.26672363281, -997.70538330078, 30.691986083984)
    -- },
    [51] = {
        clothes = getClothes, permission = nil, coords = vec3(-187.456, 2070.294, 145.573)
    },
    [52] = {
        clothes = getClothes, permission = nil, coords = vec3(-18.9, -1054.65, 32.4)
    },
    [53] = {
        clothes = getClothes, permission = nil, coords = vec3(-652.61, -1230.11, 11.54)
    },
    [54] = {
        clothes = getClothes, permission = nil, coords = vec3(104.811, -1303.450, 28.768)
    }, --Vanilla
    [55] = {
        clothes = getClothes, permission = nil, coords = vec3(-817.98327636719, 267.53305053711, 82.795715332031)
    }, --Cupula
    [56] = {
        clothes = getClothes, permission = nil, coords = vec3(-812.05773925781, 175.68231201172, 76.745384216309)
    }, --Guilda
    [57] = {
        clothes = getClothes, permission = nil, coords = vec3(982.20880126953, -97.974647521973, 74.97428894043)
    }, --The Lost 2
    [58] = {
        clothes = getClothes, permission = nil, coords = vec3(-1503.8543701172, 102.28115081787, 55.658149719238)
    }, --Roma
    [59] = {
        clothes = getClothes, permission = nil, coords = vec3(1509.78, 6557.65, 12.25)
    }, --Hydra
    [60] = {
        clothes = getClothes, permission = nil, coords = vec3(-742.47009277344, 504.87805175781, 109.56958770752)
    }, --Division
    [61] = {
        clothes = getClothes, permission = nil, coords = vec3(9.8398189544678, 528.33190917969, 170.61720275879)
    }, --Capital
    [62] = {
        clothes = getClothes, permission = nil, coords = vec3(-82.907417297363, 832.39495849609, 235.71807861328)
    }, --Cdl
    [63] = {
        clothes = getClothes, permission = nil, coords = vec3(1400.0144042969, 1139.404296875, 114.3335723877)
    }, --Galo
    [64] = {
        clothes = getClothes, permission = nil, coords = vec3(-3076.85, 1673.85, 31.31)
    }, --perals
    [65] = {
        clothes = getClothes, permission = nil, coords = vec3(143.64709472656, 328.89312744141, 116.60824584961)
    }, --The Lost
    [66] = {
        clothes = getClothes, permission = nil, coords = vec3(-1478.7889404297, -43.128997802734, 62.021831512451)
    }, --AVA
    [67] = {
        clothes = getClothes, permission = nil, coords = vec3(-1132.71484375, 364.97598266602, 74.933952331543)
    }, --Zero
    [68] = {
        clothes = getClothes, permission = nil, coords = vec3(-520.16796875, 500.3860168457, 112.44404602051)
    }, --Rikers
    [69] = {
        clothes = getClothes, permission = nil, coords = vec3(-696.62347412109, 633.54760742188, 155.1820526123)
    }, --Triade
    [70] = {
        clothes = getClothes, permission = nil, coords = vec3(-60.807075500488, 994.90747070313, 239.51539611816)
    }, --Comando Sul
    [71] = {
        clothes = getClothes, permission = nil, coords = vec3(5009.9409179688, -5789.7670898438, 17.831697463989)
    }, --GTM
    [72] = {
        clothes = getClothes, permission = nil, coords = vec3(-573.81439208984, 293.5055847168, 79.176666259766)
    }, --Tequila
    [73] = {
        clothes = getClothes, permission = nil, coords = vec3(-1402.7158203125, -609.62615966797, 30.319568634033)
    }, --BAHAMAS
    [74] = {
        clothes = getClothes, permission = nil, coords = vec3(2515.35, -343.52, 101.89)
    }, --Bravo
    [75] = {
        clothes = getClothes, permission = nil, coords = vec3(-824.26, -1236.18, 7.33)
    }, --Brooklyn
    [76] = {
        clothes = getClothes, permission = nil, coords = vec3(-214.23809814453, -1340.8670654297, 34.89440536499)
    }, --Benny's
    [77] = {
        clothes = getClothes, permission = nil, coords = vec3(-440.41748046875, -309.06704711914, 34.99898910522)
    },
    [78] = {
        clothes = getClothes, permission = nil, coords = vec3(2527.7529296875, -330.82943725586, 94.092178344727)
    },
    [79] = {
        clothes = getClothes, permission = nil, coords = vec3(478.22592163086, -982.00061035156, 30.689525604248)
    },
    [80] = {
        clothes = getClothes, permission = nil, coords = vec3(2525.9,-443.55,106.91)
    },
    [81] = {
        clothes = getClothes, permission = nil, coords = vec3(2520.82,-448.86,106.91)
    },
    ["admin"] = {
        clothes = getClothes
    },

    ["nation_creator"] = {
        clothes = getClothes
    },
}

nearestSkinshops = {}
mainThread = function()

    local innerTable = {}
    for shopId, infos in pairs(skinshops) do
        if infos.coords then
            innerTable[#innerTable+1] = { infos.coords.x, infos.coords.y, infos.coords.z, 1, 'E', 'Loja de roupas', 'Pressione para acessar'}
        end
    end

    TriggerEvent("hoverfy:insertTable",innerTable)

    local getNearestSkinshops = function()
        while true do
            if not inMenu then
                local myCoords = GetEntityCoords(PlayerPedId())
                for k, v in pairs(skinshops) do
                    if v and v.coords then
                        local distance = #(myCoords - v.coords)
                        if nearestSkinshops[k] then
                            if distance > 10 then
                                nearestSkinshops[k] = nil
                            end
                        else
                            if distance <= 10 then
                                nearestSkinshops[k] = v
                            end
                        end
                    end
                end
            end
            Wait(500)
        end
    end

    -- addBlips()
    CreateThread(getNearestSkinshops)

    while true do
        local idle = 500
        local ped = PlayerPedId()
        local myCoords = GetEntityCoords(ped)
        if not inMenu then
            for skinShopId, v in pairs(nearestSkinshops) do
                if v and v.coords and GetEntityHealth(ped) > 101 then
                    idle = 5
                    local coords = v.coords
                    -- DrawText3D(coords.x, coords.y, coords.z, "~p~[SKIN SHOP]\n~w~~b~[E]~w~ PARA ACESSAR")
                    local distance = #(myCoords - v.coords)
                    if IsControlJustPressed(0, 38) and distance < 1.5 then
                        if v.permission then
                            if func.checkPermission(v.permission) then
                                toggleMenu(skinShopId)
                            end
                        else
                            toggleMenu(skinShopId)
                        end
                    end
                end
            end
        end
        Wait(idle)
    end
end



-- function addBlips()
--     for _, v in pairs(skinshops) do
--         local coords = v.coords
--         if coords then
--             local blip = AddBlipForCoord(coords)
--             SetBlipSprite(blip, v.id or 73)
--             SetBlipColour(blip, v.color or 13)
--             SetBlipScale(blip, 0.4)
--             SetBlipAsShortRange(blip, true)
--             BeginTextCommandSetBlipName("STRING")
--             AddTextComponentString(v.name or "Loja de Roupas")
--             EndTextCommandSetBlipName(blip)
--         end
--     end
-- end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextScale(0.45, 0.45)
    SetTextFont(6)
    SetTextProportional(true)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

RegisterCommand('skinshop', function() -- COMANDO DE ADMIN
    if func.checkPermission({ "Admin" }) then
        toggleMenu("admin")
    end
end)


RegisterNetEvent("nation_skinshop:toggleMenu")
AddEventHandler("nation_skinshop:toggleMenu", function(menu)
    toggleMenu(menu)
end)




--------- CREATIVE V3 ------------

local skinData = {
    ["pants"] = "legs",
    ["arms"] = "torsos",
    ["tshirt"] = "undershirts",
    ["torso"] = "tops",
    ["vest"] = "bodyArmors",
    ["backpack"] = "bags",
    ["shoes"] = "shoes",
    ["mask"] = "masks",
    ["hat"] = "hats",
    ["glass"] = "glasses",
    ["ear"] = "ears",
    ["watch"] = "watches",
    ["bracelet"] = "bracelets",
    ["accessory"] = "accessories",
    ["decals"] = "decals"
}



function fclient.getCloths()
    local myCloths = getMyClothes()
    local cloths = {}
    for cloth, comp in pairs(skinData) do
        local item = myCloths[comp][1]
        local texture = myCloths[comp][2]
        cloths[cloth] = { item = item, texture = texture }
    end
    return cloths
end

function resetClothing(data)
    --[[
    {"watch":{"item":-1,"texture":0},"accessory":{"item":14,"texture":0},
    "backpack":{"item":14,"texture":0},"vest":{"item":0,"texture":0},
    "mask":{"item":12,"texture":0},"hat":{"item":-1,"texture":0},
    "bracelet":{"item":-1,"texture":0},"glass":{"item":13,"texture":0},
    "arms":{"item":0,"texture":0},"ear":{"item":-1,"texture":0},
    "shoes":{"item":9,"texture":0},"pants":{"item":61,"texture":0},
    "decals":{"item":0,"texture":0},"torso":{"item":5,"texture":0},
    "tshirt":{"item":5,"texture":0}}
    ]]

    --[[ {"vest":{"item":0,"texture":0},"decals":{"item":0,"texture":0},"ear":{"item":-1,"texture":0},"arms":{"item":0,"texture":0},"mask":{"item":12,"texture":0},"shoes":{"item":9,"texture":0},"backpack":{"item":14,"texture":0},"tshirt":{"item":5,"texture":0},"hat":{"item":1,"texture":0},"torso":{"item":5,"texture":0},"glass":{"item":8,"texture":0},"pants":{"item":61,"texture":0},"watch":{"item":-1,"texture":0},"accessory":{"item":14,"texture":0},"bracelet":{"item":-1,"texture":0}} ]]

    local ped = PlayerPedId()

    SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 2)
    SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 2)
    SetPedComponentVariation(ped, 8, data["tshirt"].item, data["tshirt"].texture, 2)
    SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 2)
    SetPedComponentVariation(ped, 11, data["torso"].item, data["torso"].texture, 2)
    SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 2)
    SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 2)
    SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 2)
    SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 2)
    SetPedComponentVariation(ped, 5, data["backpack"].item, data["backpack"].texture, 2)



    if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
        SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, 2)
    else
        ClearPedProp(ped, 0)
    end

    if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
        SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, 2)
    else
        ClearPedProp(ped, 1)
    end

    if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
        SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, 2)
    else
        ClearPedProp(ped, 2)
    end

    if data["watch"].item ~= -1 and data["watch"].item ~= 0 then
        SetPedPropIndex(ped, 6, data["watch"].item, data["watch"].texture, 2)
    else
        ClearPedProp(ped, 6)
    end

    if data["bracelet"].item ~= -1 and data["bracelet"].item ~= 0 then
        SetPedPropIndex(ped, 7, data["bracelet"].item, data["bracelet"].texture, 2)
    else
        ClearPedProp(ped, 7)
    end
end

RegisterNetEvent("vrp_skinshop:skinData")
AddEventHandler("vrp_skinshop:skinData", function(status)
    if status ~= "clean" then
        resetClothing(status)
    end
end)

RegisterNetEvent("skinshop:skinData")
AddEventHandler("skinshop:skinData", function(status)
    if status ~= "clean" then
        resetClothing(status)
    end
end)

-- RegisterNetEvent("updateRoupas")
-- AddEventHandler("updateRoupas", function(status)
--     resetClothing(status)
--     func.updateClothes()
-- end)



--------- NYO GUARDA ROUPAS ------------

--[[ local skinData = {
	["legs"] = 4,
	["torsos"] = 3,
	["undershirts"] = 8,
	["tops"] = 11,
	["bodyArmors"] = 9,
	["bags"] = 5,
	["shoes"] = 6,
	["masks"] = 1,
	["hats"] = "p0",
	["glasses"] = "p1",
	["ears"] = "p2",
	["watches"] = "p7",
	["bracelets"] = "p7",
	["accessories"] = 7,
	["decals"] = 10
}



function fclient.getCloths()
    local myCloths = getMyClothes()
    local cloths = {}
    for cloth, comp in pairs(skinData) do
        local item = myCloths[cloth][1]
        local texture = myCloths[cloth][2]
        cloths[comp] = { item, texture }
    end
    return cloths
end





]]
