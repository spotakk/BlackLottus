local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPReceiver = {}
Tunnel.bindInterface("black_combustivel",vRPReceiver)
vRPSend = Tunnel.getInterface("black_combustivel")
Config = {}