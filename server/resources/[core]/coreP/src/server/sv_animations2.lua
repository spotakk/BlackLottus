RegisterServerEvent('vrp_animations:startSync')
AddEventHandler('vrp_animations:startSync', function(nplayer, plyAnimation)
	local source = source 
	TriggerClientEvent('vrp_animations:startSync2', nplayer,source, plyAnimation)
	TriggerClientEvent('vrp_animations:startSync1', source, plyAnimation)
end)
--------------------------------------------------------------------------------------------------------------------------------
--  STOPA ANIMAÇÃO
--------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('vrp_animationsOne:stopSync')
AddEventHandler('vrp_animationsOne:stopSync', function(nplayer, plyAnimation)
	local source = source 
	TriggerClientEvent('vrp_animations:stopSync', source,plyAnimation)
	TriggerClientEvent('vrp_animations:stopSync', nplayer,plyAnimation)
end)
--------------------------------------------------------------------------------------------------------------------------------
-- PEGAR DE REFEM
--------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)