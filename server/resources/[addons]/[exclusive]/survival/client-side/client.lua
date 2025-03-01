local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("survival")


cRP = {}
Tunnel.bindInterface("survival",cRP)

local deadPlayer = false
local coma = false
local noCops = false
local busted = false
local cop = false
LocalPlayer["state"]["Active"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:playerActive")
AddEventHandler("vRP:playerActive",function(user_id,name)
	LocalPlayer["state"]["Active"] = true

	Citizen.Wait(10000)

	SetEntityInvincible(ped,false)
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 100
        if LocalPlayer["state"]["Active"] then
            local ped = PlayerPedId()
                if GetEntityHealth(ped) <= 101 and not coma then
                    coma = true

                    if IsPedInAnyVehicle(ped) then
                        TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
                    end
                    
                    local x,y,z = table.unpack(GetEntityCoords(ped))
                    NetworkResurrectLocalPlayer(x,y,z,true,true,false)

                    SetEntityHealth(ped,101)
                    SetEntityInvincible(ped,true)
                    TriggerEvent("inventory:Close",source)	
                    -- TriggerEvent("inventory:Buttons",source,true)
					TriggerEvent("player:blockCommands",source,true)
                    -- aqui uso o Trigger do server usando um boolean para 
                    -- bloquear o uso de itens enquanto esta morto
                    TriggerServerEvent("inventory:inComa",true)
                    TriggerServerEvent("pma-voice:toggleMute",true)
                    TriggerEvent("radio:outServers")
                -- TriggerEvent("hudActived",false)

                    SendNuiMessage(json.encode({ coma = true }))
                    activeFunction()
                end
            end 
        Wait(sleep)
    end
end)

function cRP.finishDeath()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		deadPlayer = false
		TriggerEvent("hudActived",true)
		ClearPedBloodDamage(ped)
		SetEntityHealth(ped,200)
		SetEntityInvincible(ped,false)
	end
end

function cRP.revivePlayer(health)
	SetEntityHealth(PlayerPedId(),health)
	SetEntityInvincible(PlayerPedId(),false)
	TriggerEvent("hudActived",true)
    -- TriggerClientEvent("player:blockCommands",source,false)
	
	if deadPlayer then
		deadPlayer = false
		ClearPedTasks(PlayerPedId())
	end
end

function cRP.deadPlayer()
    return coma
end

local called = false

activeFunction = function()
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if GetEntityHealth(ped) > 101 and coma and not busted then
                coma = false
                -- enquanto o player estiver vivo ele pode usar os itens
                TriggerServerEvent("inventory:inComa",false)
                TriggerServerEvent("pma-voice:toggleMute",false)
                -- TriggerEvent("inventory:Buttons",source,false)
                SendNuiMessage(json.encode({ coma = false}))
                SendNuiMessage(json.encode({ action = "hide"}))
                SetNuiFocus(false, false)
                called = false
            end

            if coma then
                SetPedToRagdoll(ped,2000,2000,0,0,0,0)
                SetEntityHealth(ped,101)
                BlockWeaponWheelThisFrame()

                --[[ DisableAllControlActions(true) ]]
            end
            Citizen.Wait(4)
        end    
    end)
end

RegisterNUICallback("haveCops",function(data,cb)
    local bool = vSERVER.checkEmergency()
    if not bool then noCops = true end
    cb(bool)
end)

RegisterNUICallback("atualizeInfo",function()
    SetNuiFocus(true, true)
    --[[ registerDeath() ]]
end)

RegisterNUICallback("reset",function()
    busted = true
    if GetEntityHealth(PlayerPedId()) <= 101 and coma then
        SetNuiFocus(false, false)
        vSERVER.ClearGunsAnDead()
        revive(PlayerPedId())
        vSERVER.ResetPedToHospital()
        SendNuiMessage(json.encode({action = "hide"}))
        return
    end
end)

--[[ registerDeath = function()
    busted = true
    Citizen.CreateThread(function()
        while true do
            if GetEntityHealth(PlayerPedId()) <= 101 and coma then
                if IsDisabledControlJustPressed(0,47) then
                    SetNuiFocus(false, false)
                    vSERVER.ClearGunsAnDead()
                    revive(PlayerPedId())
                    vSERVER.ResetPedToHospital()
                    SendNuiMessage(json.encode({action = "hide"}))
                    return
                end
            end
            Citizen.Wait(1)
        end
    end)
end ]]

local cure = false
function cRP.startCure()
	local ped = PlayerPedId()

	if cure then
		return
	end

	cure = true
	TriggerEvent("Notify","hospital","O tratamento começou, espere o paramédico libera-lo.",3000)

	if cure then
		repeat
			Citizen.Wait(1000)
			if GetEntityHealth(ped) > 101 then
				SetEntityHealth(ped,GetEntityHealth(ped)+1)
			end
		until GetEntityHealth(ped) >= 200 or GetEntityHealth(ped) <= 101
			TriggerEvent("Notify","hospital","Tratamento concluído.",3000)
			cure = false
			blockControls = false
	end
end

RegisterNetEvent("cop:Action")
AddEventHandler("cop:Action",function(bool)
    cop = bool
end)

revive = function(ped)
    called = false
    busted = false
    coma = false
    noCops = false
    TriggerEvent("resetBleeding")
    TriggerEvent("resetDiagnostic")
    TriggerServerEvent("clearInventory")
    TriggerServerEvent("removerfinalizado")
    TriggerServerEvent("chest:playerDied")
    TriggerServerEvent("survival:playerNeeds")
    TriggerEvent("hudActived",true)
    ClearPedBloodDamage(ped)
    SetEntityInvincible(ped,false)
    DoScreenFadeOut(1000)
    SetEntityHealth(ped,400)
    SetPedArmour(ped,0)
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(),338.98+0.0001,-1394.36+0.0001,32.51+0.0001,1,0,0,1)
    FreezeEntityPosition(ped,true)
    SetTimeout(5000,function()
        FreezeEntityPosition(ped,false)
        TriggerServerEvent("chest:playerDied")
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
    end)
end

RegisterNetEvent("survival:resetPlayer")
AddEventHandler("survival:resetPlayer",function()
    called = false
    busted = false
    coma = false
    noCops = false
end)