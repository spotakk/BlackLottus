local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_tattoos")
func = {}
Tunnel.bindInterface("nation_tattoos", func)


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
    ["ears"] = "ears",
    ["watches"] = "watches",
    ["bracelets"] = "bracelets",
    ["accessory"] = "accessories",
    ["decals"] = "decals"
}

function func.saveClothes(myCloths)
    local source = source
    local user_id = vRP.getUserId(source)

    local cloths = {}
    for cloth, comp in pairs(skinData) do
        local item = myCloths[comp][1]
        local texture = myCloths[comp][2]

        cloths[cloth] = { item = item, texture = texture }
    end

    Wait(1000)
    vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Clothings", value = json.encode(cloths,{indent=false}) })
end


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
    return not permission or vRP.hasPermission(user_id, permission)
end


function func.saveChar(t)
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local char = getUserChar(user_id)
        char.tattoos, char.overlay = t.tattoos, t.overlay
        --[[ vRP._setUData(user_id, "nation_char", json.encode(char,{indent=false})) ]]
        vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "nation_char", value = json.encode(char,{indent=false}) })
    end
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

function func.getTattoos()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local char = getUserChar(user_id)
        return (char.tattoos or {}), (char.overlay or 0)
    end
    return false
end

function getUserChar(user_id)
    local data = getUData(user_id, "nation_char")
    if data and data ~= "" then
        local char = json.decode(data)
        if char then
            return char
        end
    end
    return {}
end


function getUData(user_id, key)
    local data  = vRP.query("playerdata/getUserdata",{ user_id = user_id, key = key })
    if #data > 0 then
		return data[1].dvalue
	else
		return ""
	end
end