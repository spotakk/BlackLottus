--------------------------------------------------------------------------------------------------------------------------------
--  VARIÁVEIS
--------------------------------------------------------------------------------------------------------------------------------
local inAnimation = false
--------------------------------------------------------------------------------------------------------------------------------
--  CAVALINHO 2 
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cavalinho2",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'move_m@hiking',
				lib2 = 'sil_int-29',
				anim1 = 'idle',
				anim2 = 'mp_m_freemode_01^3_dual-29',
				distans = -0.07,
				distans2 = 0.0,
				height = 0.45,
				spin = 0.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  OMBRO
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ombro",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'missfinale_c2mcs_1',
				anim1 = 'fin_c2_mcs_1_camman',
				lib2 = 'nm',
				anim2 = 'firemans_carry',
				distans = 0.15,
				distans2 = 0.27,
				height = 0.63,
				spin = 0.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  CASAL
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("casal",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'anim@heists@box_carry@',
				anim1 = 'idle',
				lib2 = 'timetable@reunited@ig_10',
				anim2 = 'base_amanda',
				distans = 0.55,
				distans2 = -0.6,
				height = 0.45,
				spin = 90.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  CASAL 1
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("casal1",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'timetable@trevor@ig_1',
				anim1 = 'ig_1_thedontknowwhy_trevor',
				lib2 = 'timetable@trevor@ig_1',
				anim2 = 'ig_1_thedontknowwhy_patricia',
				distans = 0.0,
				distans2 = 0.65,
				height = 0.0,
				spin = 0.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  CASAL 2
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("casal2",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'timetable@trevor@ig_1',
				anim1 = 'ig_1_thedesertissobeautiful_trevor',
				lib2 = 'timetable@trevor@ig_1',
				anim2 = 'ig_1_thedesertissobeautiful_patricia',
				distans = 0.0,
				distans2 = 0.65,
				height = 0.0,
				spin = 0.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  CASAL 3
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("casal3",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'anim@heists@box_carry@',
				anim1 = 'idle',
				lib2 = 'mp_ped_interaction',
				anim2 = 'kisses_guy_a',
				distans = 0.65,
				distans2 = 0.0,
				height = 0.0,
				spin = 180.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  CASAL 3
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("casal4",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'anim@heists@box_carry@',
				anim1 = 'idle',
				lib2 = 'amb@lo_res_idles@',
				anim2 = 'world_human_lean_male_foot_up_lo_res_base',
				distans = 0.4,
				distans2 = 0.0,
				height = 0.0,
				spin = 0.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  CASAL 3
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("abracar",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'anim@heists@box_carry@',
				anim1 = 'idle',
				lib2 = 'anim@heists@prison_heiststation@cop_reactions',
				anim2 = 'cop_a_idle',
				distans = 0.3,
				distans2 = 0.0,
				height = 0.0,
				spin = 0.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  CASAL 3
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("abracar2",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'anim@heists@box_carry@',
				anim1 = 'idle',
				lib2 = 'anim@heists@box_carry@',
				anim2 = 'idle',
				distans = 0.3,
				distans2 = 0.0,
				height = 0.0,
				spin = 180.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  SEXO 1 
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sexo",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'rcmpaparazzo_2',
				anim1 = 'shag_loop_a',
				lib2 = 'rcmpaparazzo_2',
				anim2 = 'shag_loop_poppy',
				distans = 0.2,
				distans2 = -0.05,
				height = 0.01,
				spin = 0.1		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  SEXO 2
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sexo2",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'misscarsteal2pimpsex',
				anim1 = 'pimpsex_punter',
				lib2 = 'misscarsteal2pimpsex',
				anim2 = 'pimpsex_hooker',
				distans = 0.6,
				distans2 = -0.1,
				height = 0.01,
				spin = 180.0		,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  SEXO 2
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sexo3",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'misscarsteal2pimpsex', 
				anim1 = 'pimpsex_punter', 
				lib2 = 'misscarsteal2pimpsex', 
				anim2 = 'shagloop_hooker', 
				distans = 0.42, 
				distans2 = 0.1, 
				height = -0.06, 
				spin = 180.0, 
				length = 100000, 
				controlFlagMe = 49, 
				controlFlagTarget = 33, 
				animFlagTarget = 1
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  SEXO 2
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sexo4",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'amb@world_human_sunbathe@male@back@idle_a',
				anim1 = 'idle_a',
				lib2 = 'mini@prostitutes@sexlow_veh',
				anim2 = 'low_car_sex_loop_female',
				distans = 0.30,
				distans2 = 0.8,
				height = -0.2,
				spin = 360.0		,
				length = 100000,
				controlFlagMe = 110,
				controlFlagTarget = 99,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  SEXO 6
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sexo5",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				lib = 'timetable@ron@ig_5_p3',
				anim1 = 'ig_5_p3_base',
				lib2 = 'misscarsteal2pimpsex',
				anim2 = 'pimpsex_hooker',
				distans = 0.55,
				distans2 = -0.08,
				height = -0.19,
				spin = 180.0,
				length = 999999,
				controlFlagMe = 110,
				controlFlagTarget = 99,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  CARREGAR
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("carregar",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				animationType  = "Carregar",
				lib = 'missfinale_c2mcs_1',
				anim1 = 'fin_c2_mcs_1_camman',
				lib2 = 'nm',
				anim2 = 'firemans_carry',
				distans = 0.15,
				distans2 = 0.27,
				height = 0.63,
				spin = 0.0,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  CAVALINHO
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cavalinho",function(source, args, rawCommand)
	local nplayer = vRP.getNearestPlayer(3)
	if nplayer then 
		if not inAnimation then
			inAnimation = true
			local plyAnimation = { 	
				animationType  = "Cavalinho",
				lib = 'anim@arena@celeb@flat@paired@no_props@',
				anim1 = 'piggyback_c_player_a',
				anim2 = 'piggyback_c_player_b',
				distans = -0.07,
				distans2 = 0.0,
				height = 0.45,
				spin = 0.0,
				length = 100000,
				controlFlagMe = 49,
				controlFlagTarget = 33,
				animFlagTarget = 1,
			}
			TriggerServerEvent('vrp_animations:startSync', nplayer, plyAnimation)
		else
			inAnimation = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent('vrp_animationsOne:stopSync', nplayer)
		end
	end
end,false)
--------------------------------------------------------------------------------------------------------------------------------
--  SYNCA PRO PRIMEIRO PED
--------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_animations:startSync1')
AddEventHandler('vrp_animations:startSync1', function(plyAnimation)
	local ped = PlayerPedId()
	local animationLib = plyAnimation["lib"]
	if plyAnimation["animationType"] == "Carregar" then 
		RequestAnimDict(animationLib)
		while not HasAnimDictLoaded(animationLib) do
			Citizen.Wait(10)
		end
		Wait(500)
		if plyAnimation["controlFlagMe"] == nil then plyAnimation["controlFlagMe"] = 0 end
		TaskPlayAnim(ped, animationLib, plyAnimation["anim1"], 8.0, -8.0, plyAnimation["length"], plyAnimation["controlFlagMe"], 0, false, false, false)
	elseif plyAnimation["animationType"] == "Cavalinho" then 
		RequestAnimDict(animationLib)
		while not HasAnimDictLoaded(animationLib) do
			Citizen.Wait(10)
		end
		Wait(500)
		if plyAnimation["controlFlagMe"] == nil then plyAnimation["controlFlagMe"] = 0 end
		TaskPlayAnim(ped, animationLib, plyAnimation["anim1"], 8.0, -8.0, plyAnimation["length"], plyAnimation["controlFlagMe"], 0, false, false, false)
	else
		RequestAnimDict(animationLib)
		while not HasAnimDictLoaded(animationLib) do
			Citizen.Wait(10)
		end
		Wait(500)
		if plyAnimation["controlFlagMe"] == nil then plyAnimation["controlFlagMe"] = 0 end
		TaskPlayAnim(ped, animationLib, plyAnimation["anim1"], 8.0, -8.0, plyAnimation["length"], plyAnimation["controlFlagMe"], 0, false, false, false)
	end
	Citizen.Wait(plyAnimation["length"])
end)
--------------------------------------------------------------------------------------------------------------------------------
--  SYNCA PRO SEGUNDO PED
--------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_animations:startSync2')
AddEventHandler('vrp_animations:startSync2', function(nsource, plyAnimation)
	local ped = PlayerPedId()
	local twoPed = GetPlayerPed(GetPlayerFromServerId(nsource))
	if plyAnimation["animationType"] == "Carregar" then 
		inAnimation = true
		local animationLib = plyAnimation["lib2"]
		RequestAnimDict(animationLib)
		while not HasAnimDictLoaded(animationLib) do
			Citizen.Wait(10)
		end
		if plyAnimation["spin"] == nil then plyAnimation["spin"] = 180.0 end
		if plyAnimation["controlFlagTarget"] == nil then plyAnimation["controlFlagTarget"] = 0 end
		AttachEntityToEntity(ped, twoPed, 0, plyAnimation["distans2"], plyAnimation["distans"], plyAnimation["height"], 0.5, 0.5, plyAnimation["spin"], false, false, false, false, 2, false)
		TaskPlayAnim(ped, animationLib, plyAnimation["anim2"], 8.0, -8.0, plyAnimation["length"], plyAnimation["controlFlagTarget"], 0, false, false, false)
	elseif plyAnimation["animationType"] == "Cavalinho" then 
		inAnimation = true
		local animationLib = plyAnimation["lib"]
		RequestAnimDict(animationLib)
		while not HasAnimDictLoaded(animationLib) do
			Citizen.Wait(10)
		end
		if plyAnimation["spin"] == nil then plyAnimation["spin"] = 180.0 end
		if plyAnimation["controlFlagTarget"] == nil then plyAnimation["controlFlagTarget"] = 0 end
		AttachEntityToEntity(ped, twoPed, 0, plyAnimation["distans2"], plyAnimation["distans"], plyAnimation["height"], 0.5, 0.5, plyAnimation["spin"], false, false, false, false, 2, false)
		TaskPlayAnim(ped, animationLib, plyAnimation["anim2"], 8.0, -8.0, plyAnimation["length"], plyAnimation["controlFlagTarget"], 0, false, false, false)
	else
		inAnimation = true
		local animationLib = plyAnimation["lib2"]
		RequestAnimDict(animationLib)
		while not HasAnimDictLoaded(animationLib) do
			Citizen.Wait(10)
		end
		if plyAnimation["spin"] == nil then plyAnimation["spin"] = 180.0 end
		if plyAnimation["controlFlagTarget"] == nil then plyAnimation["controlFlagTarget"] = 0 end
		AttachEntityToEntity(ped, twoPed, 0, plyAnimation["distans2"], plyAnimation["distans"], plyAnimation["height"], 0.5, 0.5, plyAnimation["spin"], false, false, false, false, 2, false)
		TaskPlayAnim(ped, animationLib, plyAnimation["anim2"], 8.0, -8.0, plyAnimation["length"], plyAnimation["controlFlagTarget"], 0, false, false, false)
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
--  STOPA AS ANIMAÇÕES
--------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_animations:stopSync')
AddEventHandler('vrp_animations:stopSync', function(animationType)
	inAnimation = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.19, 0.19)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

