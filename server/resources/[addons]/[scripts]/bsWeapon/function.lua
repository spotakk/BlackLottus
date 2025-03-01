local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

kyo = {}
Tunnel.bindInterface(GetCurrentResourceName(), kyo)

kyo.getWeaponAmount = function(weapon)
    if vRP.getInventoryItemAmount(vRP.getUserId(source), weapon)[1] > 0 then
        return true
    end
    return false
end
