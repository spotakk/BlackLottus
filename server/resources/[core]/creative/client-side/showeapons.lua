Citizen.CreateThread(function()
	while true do
		DisplayHudWhenDeadThisFrame()
		Wait(0)
	end
end)

local weaponsDamage = {
    [GetHashKey('WEAPON_UNARMED')] = false,
    [GetHashKey('WEAPON_DAGGER')] = false,
    [GetHashKey('WEAPON_BAT')] = false,
    [GetHashKey('WEAPON_BOTTLE')] = false,
    [GetHashKey('WEAPON_CROWBAR')] = false,
    [GetHashKey('WEAPON_FLASHLIGHT')] = false,
    [GetHashKey('WEAPON_GOLFCLUB')] = false,
    [GetHashKey('WEAPON_HAMMER')] = false,
    [GetHashKey('WEAPON_HATCHET')] = false,
    [GetHashKey('WEAPON_KNUCKLE')] = false,
    [GetHashKey('WEAPON_KNIFE')] = false,
    [GetHashKey('WEAPON_MACHETE')] = false,
    [GetHashKey('WEAPON_SWITCHBLADE')] = false,
    [GetHashKey('WEAPON_NIGHTSTICK')] = false,
    [GetHashKey('WEAPON_WRENCH')] = false,
    [GetHashKey('WEAPON_BATTLEAXE')] = false,
    [GetHashKey('WEAPON_POOLCUE')] = false,
    [GetHashKey('WEAPON_STONE_HATCHET')] = false,
    [GetHashKey('WEAPON_PISTOL')] = true,
    [GetHashKey('WEAPON_PISTOL_MK2')] = true,
    [GetHashKey('WEAPON_COMBATPISTOL')] = true,
    [GetHashKey('WEAPON_APPISTOL')] = true,
    [GetHashKey('WEAPON_STUNGUN')] = true,
    [GetHashKey('WEAPON_PISTOL50')] = true,
    [GetHashKey('WEAPON_SNSPISTOL')] = true,
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = true,
    [GetHashKey('WEAPON_HEAVYPISTOL')] = true,
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = true,
    [GetHashKey('WEAPON_FLAREGUN')] = true,
    [GetHashKey('WEAPON_MARKSMANPISTOL')] = true,
    [GetHashKey('WEAPON_REVOLVER')] = true,
    [GetHashKey('WEAPON_REVOLVER_MK2')] = true,
    [GetHashKey('WEAPON_DOUBLEACTION')] = true,
    [GetHashKey('WEAPON_RAYPISTOL')] = true,
    [GetHashKey('WEAPON_CERAMICPISTOL')] = true,
    [GetHashKey('WEAPON_NAVYREVOLVER')] = true,
    [GetHashKey('WEAPON_GADGETPISTOL')] = true,
    [GetHashKey('WEAPON_MICROSMG')] = true,
    [GetHashKey('WEAPON_SMG')] = true,
    [GetHashKey('WEAPON_SMG_MK2')] = true,
    [GetHashKey('WEAPON_ASSAULTSMG')] = true,
    [GetHashKey('WEAPON_COMBATPDW')] = true,
    [GetHashKey('WEAPON_MACHINEPISTOL')] = true,
    [GetHashKey('WEAPON_MINISMG')] = true,
    [GetHashKey('WEAPON_RAYCARBINE')] = true,
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = true,
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = true,
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = true,
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = true,
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = true,
    [GetHashKey('WEAPON_MUSKET')] = false,
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = true,
    [GetHashKey('WEAPON_DBSHOTGUN')] = true,
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = true,
    [GetHashKey('WEAPON_COMBATSHOTGUN')] = true,
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = true,
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = true,
    [GetHashKey('WEAPON_CARBINERIFLE')] = true,
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] = true,
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = true,
    [GetHashKey('WEAPON_SPECIALCARBINE')] = true,
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = true,
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = true,
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = true,
    [GetHashKey('WEAPON_COMPACTRIFLE')] = true,
    [GetHashKey('WEAPON_MILITARYRIFLE')] = true,
    [GetHashKey('WEAPON_MG')] = true,
    [GetHashKey('WEAPON_COMBATMG')] = true,
    [GetHashKey('WEAPON_COMBATMG_MK2')] = true,
    [GetHashKey('WEAPON_GUSENBERG')] = true,
    [GetHashKey('WEAPON_SNIPERRIFLE')] = true,
    [GetHashKey('WEAPON_HEAVYSNIPER')] = true,
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = true,
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = true,
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = true,
    [GetHashKey('WEAPON_RPG')] = true,
    [GetHashKey('WEAPON_GRENADELAUNCHER')] = true,
    [GetHashKey('WEAPON_MINIGUN')] = true,
    [GetHashKey('WEAPON_FIREWORK')] = true,
    [GetHashKey('WEAPON_RAILGUN')] = true,
    [GetHashKey('WEAPON_HOMINGLAUNCHER')] = true,
    [GetHashKey('WEAPON_COMPACTLAUNCHER')] = true,
    [GetHashKey('WEAPON_RAYMINIGUN')] = true,
    [GetHashKey('WEAPON_GRENADE')] = true,
    [GetHashKey('WEAPON_BZGAS')] = true,
    [GetHashKey('WEAPON_MOLOTOV')] = true,
    [GetHashKey('WEAPON_STICKYBOMB')] = true,
    [GetHashKey('WEAPON_PROXMINE')] = true,
    [GetHashKey('WEAPON_SNOWBALL')] = true,

	[GetHashKey('WEAPON_FNSCAR')] = true,
	[GetHashKey('WEAPON_COLTXM177')] = true,
	[GetHashKey('WEAPON_FNFAL')] = true,
	[GetHashKey('WEAPON_PARAFAL')] = true,

}

AddEventHandler("gameEventTriggered",function(eventName, args)
    if eventName == "CEventNetworkEntityDamage" then
		if PlayerPedId() == args[1] then
			local _,bone = GetPedLastDamageBone(args[1])
			local _,v = GetCurrentPedWeapon(args[2])
			if IsEntityAPed(args[1]) and bone == 31086 and weaponsDamage[v] then
				SetEntityHealth(args[1],101)
			end
		end
	end
end)
