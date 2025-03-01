local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Prepare = vRP.prepare
Query = vRP.query
getUserId = vRP.getUserId
playersList = vRP.userList
userIdentity = vRP.userIdentity
hasGroup = vRP.hasGroup
userSource = vRP.userSource
request = vRP.request
inventoryWeight = vRP.inventoryWeight
getWeight = vRP.getWeight
generateItem = vRP.generateItem
tryGetInventoryItem = vRP.tryGetInventoryItem
setPermission = vRP.setPermission
remPermission = vRP.remPermission