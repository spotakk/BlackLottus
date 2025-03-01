Config = {}
Config["HowLong"] = 5 -- Em segundos
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("timeset", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.hasGroup(user_id, "Admin") then
			GlobalState["Hours"] = parseInt(args[1])
			GlobalState["Minutes"] = parseInt(args[2])

			if args[3] then
				GlobalState["Weather"] = args[3]
			end
		end
	end
end)


RegisterCommand("weather", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.hasGroup(user_id, "Admin") then

			if args[1] then
				GlobalState["Weather"] = args[1]
			end
		end
	end
end)