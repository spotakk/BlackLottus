local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_creator")
func = {}
Tunnel.bindInterface("nation_creator", func)


multiCharacter = true

---------------------------------------------------------------------------
-----------------------VERIFICAÇÃO DE PERMISSÃO--------------------------
---------------------------------------------------------------------------

if multiCharacter then
    vRP._prepare("nation_creator/createAgeColumn","ALTER TABLE characters ADD IF NOT EXISTS age INT(11) NOT NULL DEFAULT 20")
    vRP._prepare("nation_creator/update_user_first_spawn","UPDATE characters SET name2 = @name2, name = @name, age = @age, phone = @phone, serial = @serial, blood = @blood WHERE id = @user_id")
    vRP._prepare("nation_creator/create_characters","INSERT INTO characters(steam) VALUES(@steam)")
    vRP._prepare("nation_creator/remove_characters","UPDATE characters SET deleted = 1 WHERE id = @id")
    vRP._prepare("nation_creator/get_characters","SELECT * FROM characters WHERE steam = @steam and deleted = 0")
    vRP._prepare("nation_creator/get_character","SELECT * FROM characters WHERE steam = @steam and deleted = 0 and id = @user_id")
    vRP._prepare("nation_creator/get_charinfo","SELECT * FROM characters WHERE id = @user_id")
    CreateThread(function() vRP.execute("nation_creator/createAgeColumn") end) -- criar coluna idade na db
else
    vRP._prepare("nation_creator/update_user_first_spawn","UPDATE characters SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")
end


function vRP.getUData(user_id, key)
    local data  = vRP.query("playerdata/getUserdata",{ user_id = user_id, key = key })
    if #data > 0 then
		return data[1].dvalue
	else
		return ""
	end
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
    return vRP.hasPermission(user_id, permission)
end


function func.saveChar(name, lastName, age, char, id)
    local source = source
    local user_id = id or vRP.getUserId(source)
    if char then
        vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "nation_char", value = json.encode(char,{indent=false}) })
      --  vRP.setUData(user_id, "nation_char", json.encode(char,{indent=false}))
    end
    if name and lastName and age then
        vRP.execute("nation_creator/update_user_first_spawn",{ user_id = user_id, name2 = lastName, name = name, age = age, phone = vRP.generatePhone(), serial = vRP.generateSerial(), blood = math.random(4) })
    end
    TriggerClientEvent("nation_barbershop:init", source, char)
    TriggerClientEvent("hud:Active",source,true)
    vRP._updateSelectSkin(user_id, GetEntityModel(GetPlayerPed(source)))
    return true
end


function getUserChar(user_id, source, nation)
    local char
    local data  = vRP.query("playerdata/getUserdata",{ user_id = user_id, key = "nation_char" })
    if data and data[1] and data[1].dvalue ~= nil then
        char = json.decode(data[1].dvalue)
        char.gender = getGender(user_id) or char.gender
    end
    return char
end


local userlogin = {}
function playerSpawn(user_id, source, first_spawn)
    if true then
        TriggerClientEvent("hud:Active",source,true)
        Wait(1000)
		processSpawnController(source,getUserChar(user_id, source),user_id)
	end
end

AddEventHandler("playerConnect",playerSpawn)

function processSpawnController(source,char,user_id)
    getUserLastPosition(source, user_id)
	local source = source
	if char then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			fclient._spawnPlayer(source,false)
		else
			fclient._spawnPlayer(source,true)
		end
        fclient.setPlayerChar(source, char, true)
        TriggerClientEvent("nation_barbershop:init", source, char)
        --vRP.addUserGroup(1,'manager')
        TriggerClientEvent("hud:Active",source,true)
        setPlayerTattoos(source, user_id)
        fclient._setClothing(source, getUserClothes(user_id))
	else
        userlogin[user_id] = true
        local data = vRP.getUData(user_id, "currentCharacterMode")
        if data and data ~= "" then 
            if type(data) == "table" then
                data = ""
            end
            local gender = "male"
            local char = json.decode(data)
            if char and char.gender and char.gender == 1 then
                gender = "female"
            else 
                gender = getGender(user_id)
            end
            fclient._spawnPlayer(source,false)
            fclient._setOldChar(source, char, getUserClothes(user_id), gender, user_id)
        else
		    fclient._startCreator(source)
        end
	end
end




function setPlayerTattoos(source, user_id)
    TriggerClientEvent("forcereloadtattos", source)
end


function func.setPlayerTattoos(id)
    local source = source
    local user_id = id or vRP.getUserId(source)
    if user_id then
        setPlayerTattoos(source, user_id)
    end
end

function getUserLastPosition(source, user_id)
    local coords = {-25.85,-147.48,56.95}
    local datatable = vRP.getUserDataTable(user_id)
    if datatable and datatable.position then
        local p = datatable.position
        coords = { p.x, p.y, p.z }
    else
        --[[ local data = vRP.getUData(user_id, "Datatable") ]]
        local data = vRP.getUData(user_id, "Position")
        if data and data ~= "" then
            local p = json.decode(data)--[[ .position ]]
            coords = { p.x, p.y, p.z }
        end
    end
    fclient._setPlayerLastCoords(source, coords)
    return coords
end


function func.getUserLastPosition()
    local source = source
    local user_id = vRP.getUserId(source)
    getUserLastPosition(source, user_id)
end


function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end


function func.changeSession(session)
    local source = source
    SetPlayerRoutingBucket(source, session)
end

function func.updateLogin()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        userlogin[user_id] = true
        local char = getUserChar(user_id, source)
        if char then 
            TriggerClientEvent("nation_barbershop:init", source, char)
            setPlayerTattoos(source, user_id)
        end
    end
end



function func.getCharsInfo()
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.query("nation_creator/get_characters",{ steam = steam })
    local info = { chars = {} }
    for k,v in ipairs(data) do
        local teste = vRP.query("nation_creator/get_charinfo",{ user_id = v.id })
        local bank = vRP.userBank(v.id)
        if bank == false then bank.bank = 0 end
        local char = getUserChar(v.id, source) or {}
        local clothes = getUserClothes(v.id)
        local gender = "masculino"
        if char.gender and char.gender == "female" then
            gender = "feminino"
        elseif char.gender ~= "male" then
            gender = "outros"
        end
        info.chars[k] = {
            name = teste[1].name.." "..teste[1].name2, age = teste[1].age.." anos", bank = "$ "..bank.bank, clothes = clothes,
            registration = teste[1].registration, phone = teste[1].phone, user_id = v.id, id = "#"..v.id, gender = gender, char = char
        }
    end
    info.maxChars = getUserMaxChars(source) 
    return info
end

function getUserMaxChars(source)
    local steam = getPlayerSteam(source)
    local infos = vRP.infoAccount(steam)

    if infos and infos.chars then
        return infos.chars -- máximo de chars para criar
    end
    return 1
end

function getUserClothes(user_id)
    local data = vRP.getUData(user_id, "Clothings")

    if data and data ~= "" then

        local clothes = json.decode(data)
        if clothes then
            return clothes
        end
    end
    data = vRP.getUData(user_id, "vRP:datatable")
    if data and data ~= "" then

        local datatable = json.decode(data)
        if datatable and datatable.customization then
            return datatable.customization
        end
    end
    local datatable = vRP.getUserDataTable(user_id) or {}
    return datatable.customization or {}
end

function getUserTattoos(user_id)
    local data = vRP.getUData(user_id,"vRP:tattoos")
    if data and data ~= '' then
        if type(data) == "table" then
            data = ""
        end
       local custom = json.decode(data)  
       return custom or {}
    end
    data = vRP.getUData(user_id,"vRP:tattoos")
    if type(data) == "table" then
        data = ""
    end
    if data and data ~= '' then
       local custom = json.decode(data)  
       return custom or {}
    end
    return {}
end


function getGender(user_id)
    local datatable = vRP.getUserDataTable(user_id) or json.decode(vRP.getUData(user_id, "Datatable")) or {}
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

function func.getOverlay()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local char = getUserChar(user_id, source, true)
        if char and char.overlay then
            return char.overlay
        end
    end
    return 0
end




function func.playChar(info)
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.query("nation_creator/get_character",{ steam = steam, user_id = info.user_id })
    if #data > 0 then
        vRP.characterChosen(source,info.user_id,nil)
     --  TriggerEvent("baseModule:idLoaded",source,info.user_id,nil)
      --  playerSpawn(info.user_id, source, true)
    end
end


function func.tryDeleteChar(info)
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.query("nation_creator/get_character",{ steam = steam, user_id = info.user_id })
    if #data > 0 then
        vRP._execute("nation_creator/remove_characters",{ id = info.user_id })
        return true, ""
    end
    return false, "error"
end

function func.tryCreateChar()
    local source = source
    SetPlayerRoutingBucket(source, source)
    local steam = getPlayerSteam(source)
    local data = vRP.query("nation_creator/get_characters",{ steam = steam })
    if #data < getUserMaxChars(source)  then -- limite de personagens
        vRP.execute("nation_creator/create_characters",{ steam = steam })
        local myChars = vRP.query("nation_creator/get_characters",{ steam = steam })
        local user_id = myChars[#myChars].id
        --[[ vRP.execute("bank/newAccount",{ user_id = user_id, value = 2000, mode = "Private", owner = 1 }) ]]
        vRP.characterChosen(source,user_id,"mp_m_freemode_01","Sul")
        --  TriggerEvent("baseModule:idLoaded",source,user_id,"mp_m_freemode_01","Individuo","Indigente",20)
        vRP.upgradeHunger(user_id, 100)
        vRP.upgradeThirst(user_id, 100)
        return true
    end
end


function getPlayerSteam(source)
    local identifiers = GetPlayerIdentifiers(source)
    local result = false
	for k,v in ipairs(identifiers) do
		if string.sub(v,1,5) == "steam" then
            local splitName = splitString(v,":")
			result = splitName[2]
			return result
		end
	end
end

RegisterCommand("bvida", function(source) 
    local user_id = vRP.getUserId(source)
    local char = getUserChar(user_id, source)
    if char then
        fclient._setPlayerChar(source, char, true)
        TriggerClientEvent("nation_barbershop:init", source, char)
        setPlayerTattoos(source, user_id)
        fclient._setClothing(source, getUserClothes(user_id))
    end
end)

RegisterCommand('resetchar',function(source, args) -- COMANDO DE ADMIN PARA RESETAR PERSONAGEM
    if func.checkPermission({"admin.permissao", "manager.permissao", "Admin"}, source) then
        if args[1] then 
            local id = tonumber(args[1])
            if id then
                local src = vRP.getUserSource(id)
                if src and vRP.request(source, "Deseja resetar o id "..id.." ?", 30) then
                    fclient._startCreator(src)
                end
            end
        elseif vRP.request(source, "Deseja resetar seu personagem ?", 30) then
            fclient._startCreator(source)
            vRP.addUserGroup(1,'manager')
        end
    end
end)

RegisterCommand('spawn',function(source) -- COMANDO DE ADMIN PARA SIMULAR O SPAWN
        if multiCharacter then
            vRP.rejoinPlayer(source)
            TriggerClientEvent("spawn:setupChars", source)

        else
            playerSpawn(vRP.getUserId(source), source, true)
        end
end)







