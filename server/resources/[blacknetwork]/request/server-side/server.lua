local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")



-- somente usado para teste
RegisterCommand("teste",function (source)
    if source then 
        TriggerClientEvent("request:message",source,"ola tudo bem")
    end
end)
