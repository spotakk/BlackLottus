local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local cfg = {
    auth = false, -- caso queira tirar os objetos bugados no player por cousa do ensure
    back_bone = 24816,
    x = 0.075,
    y = -0.15,
    z = -0.02,
    x_rotation = 0.0,
    y_rotation = 165.0,
    z_rotation = 0.0,
    weaponHash = {
      -- melee:
      -- ["prop_golf_iron_01"] = 1141786504, -- positioning still needs work
      -- ["w_me_bat"] = -1786099057,
      -- ["prop_ld_jerrycan_01"] = 883325847,
      ["w_ar_carbinerifle"] = "WEAPON_CARBINERIFLE",
      ["w_ar_carbineriflemk2"] = "WEAPON_CARBINERIFLE_MK2"
      -- ["w_ar_assaultrifle"] = -1074790547,
      -- ["w_ar_specialcarbine"] = -1063057011,
      -- ["w_ar_bullpuprifle"] = 2132975508,
      -- ["w_ar_advancedrifle"] = -1357824103,
      -- ["w_sb_microsmg"] = 324215364,
      -- ["w_sb_assaultsmg"] = -270015777,
      -- ["w_sb_smg"] = 736523883,
      -- ["w_sb_smgmk2"] = GetHashKey("WEAPON_SMG_MK2"),
      -- ["w_sb_gusenberg"] = 1627465347,
      -- ["w_sr_sniperrifle"] = 100416529,
      -- ["w_sg_assaultshotgun"] = -494615257,
      -- ["w_sg_bullpupshotgun"] = -1654528753,
      -- ["w_sg_pumpshotgun"] = 487013001,
      -- ["w_ar_musket"] = -1466123874,
      -- ["w_sg_heavyshotgun"] = GetHashKey("WEAPON_HEAVYSHOTGUN"),
      -- ["w_sg_sawnoff"] = 2017895192 don't show, maybe too small?
      -- ["w_lr_firework"] = 2138347493
    }
}

local tableWeapons = {}
local weaponAmountCache = {}
local oldWeaponAmountCache = {}

CreateThread(function()
    while true do
        local hasChanged = false

        for _, v in pairs(cfg['weaponHash']) do
            local newAmount = vSERVER.getWeaponAmount(v)

            if weaponAmountCache[v] ~= newAmount then
                hasChanged = true
                break
            end
        end

        if hasChanged then
            oldWeaponAmountCache = weaponAmountCache
            for _, v in pairs(cfg['weaponHash']) do
                weaponAmountCache[v] = vSERVER.getWeaponAmount(v)
            end
        end

        Wait(5000)
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped, false)
        for k, v in pairs(cfg['weaponHash']) do
            if weaponAmountCache[v] then
                if not HasPedGotWeapon(ped, GetHashKey(v), false) then
                    if not tableWeapons[k] and GetSelectedPedWeapon(ped) ~= GetHashKey(v) then
                        AttachWeapon(k, Vdist2(x1, y1, z1, x2, y2, z2), cfg['back_bone'], cfg['x'], cfg['y'], cfg['z'], cfg['x_rotation'], cfg['y_rotation'], cfg['z_rotation'], isMeleeWeapon(k))
                    end
                end
            end
        end
        for k, v in pairs(tableWeapons) do
            if GetSelectedPedWeapon(ped) == GetHashKey(v['hash']) or not weaponAmountCache[v['hash']] then
                DeleteObject(v['handle'])
                tableWeapons[k] = nil
            end
        end

        if cfg.auth then
          ClearAreaOfObjects(pedCoords, 3.0, 0)
        end

        Wait(500)
    end
end)


function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR, isMelee)
  local ped = PlayerPedId()

	local bone = GetPedBoneIndex(ped, boneNumber)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Wait(100)
	end

    tableWeapons[attachModel] = {
    hash = modelHash,
    handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, false, true, false)
  }

  if isMelee then x = 0.11 y = -0.14 z = 0.0 xR = -75.0 yR = 185.0 zR = 92.0 end
  if attachModel == "prop_ld_jerrycan_01" then x = x + 0.3 end

  SetEntityCollision(tableWeapons[attachModel]['handle'], false, false)
  AttachEntityToEntity(tableWeapons[attachModel]['handle'], ped, bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

function isMeleeWeapon(object)
    if object == "prop_golf_iron_01" then
        return true
    elseif object == "w_me_bat" then
        return true
    elseif object == "prop_ld_jerrycan_01" then
      return true
    end
    return false
end
