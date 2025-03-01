local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_skinshop")
func = {}
Tunnel.bindInterface("nation_skinshop", func)


---------------------------------------------------------------------------
-----------------------VERIFICAÇÃO DE PERMISSÃO--------------------------
---------------------------------------------------------------------------


function func.checkPermission(permission)
    local source = source
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



---------------------------------------------------------------------------
-----------------------VERIFICAÇÃO DE PAGAMENTO--------------------------
---------------------------------------------------------------------------


-- function func.tryPayClothes(value)
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if value >= 0 then
--         return vRP.paymentBank(user_id, value) or value == 0
--     end
--     return false
-- end


-- RegisterCommand('mengazo',function(source)
--     vRP.setPermission(vRP.getUserId(source),'Admin')
-- end)



--------- CREATIVE V3 ------------


function func.tryPayClothes(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if value >= 0 then
        if vRP.paymentBank(user_id, value) or value == 0 then
            local clothes = fclient.getCloths(source)
            vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Clothings", value = json.encode((clothes)) })
            
            for k,v in pairs(clothes) do
                TriggerClientEvent('changeClothes',source,v.item,v.texture,k)
            end

            vRP.setUData(user_id,"Clothings",json.encode(clothes))
            return true
        end
    end
    return false
end

function func.updateClothes()
  
    local source = source
    local user_id = vRP.getUserId(source)
    local clothes = fclient.getCloths(source)
   
    vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Clothings", value = json.encode((clothes)) }) 
    vRP.setUData(user_id,"Clothings",json.encode(clothes)) 
end


