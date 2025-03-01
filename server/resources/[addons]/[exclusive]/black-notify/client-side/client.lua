RegisterNetEvent("Notify")
RegisterNetEvent("Notify")
AddEventHandler("Notify", function(a, b, c, d,f)
	if type(b) == "string" then
		b = string.gsub(b, "<b>", "")
		b = string.gsub(b, "</b>", "")
	end
	local typeNotify,title,description,duration;
	local typeNotifyIcon = {
		["important"] = "amarelo",
		["verde"] = "verde",
		["check"] = "verde",
		["azul"] = "verde",
		["vermelho"] = "vermelho",
		["unlocked"] = "vermelho",
		["cancel"] = "vermelho",
		["locked"] = "verde",
		["negado"] = "vermelho",
		["pm"] = "police",
		["hospital"] = "hospital",
		["mechanic"] = "mechanic"
	}

	if f and (type(f) == "number" or tonumber(f) > 10) then
		title = b
		typeNotify = typeNotifyIcon[a] or a
		description = c
		duration = tonumber(f)
	elseif type(d) == "number" then
		typeNotify = typeNotifyIcon[a] or a
		title = b
		description = c
		duration = d
	elseif type(c) == "number" then
		typeNotify = typeNotifyIcon[a] or a
		title = "Atenção"
		description = b
		duration = c
	else 
		title = "Atenção"
		typeNotify = typeNotifyIcon[a] or a
		description = b
		duration = 5000
	end

	SendNUIMessage({ action = "setVisible",data = true })
    SendNUIMessage({ 
        action = "set:notify",
        data = {
            type = typeNotify,
            title = title,
            message = description,
            delay = duration 
        }
    })
end)