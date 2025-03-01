-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("RazeBank",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREAPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/Get_Transactions","SELECT * FROM RazeBank_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC")
vRP.prepare("vRP/Transactions",'SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `RazeBank_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY')
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERINFO
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.GetPlayerInfo()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    local sex = vRPclient.getModelPlayer(source)
	if tostring(sex) == "mp_m_freemode_01" then
        sex = "m"
    else
        sex = "f"
    end
    local data = {
        playerName = identity.name .. " " .. identity.name2,
        playerBankMoney = vRP.getBank(user_id),
        walletMoney = vRP.getInventoryItemAmount(user_id,"dollars") or 0,
        sex = sex,
    }
    return data
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestWanted()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
			return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSYSTEMS
-----------------------------------------------------------------------------------------------------------------------------------------
atmTimers = os.time()
local robberys = {}
function cRP.checkSystems(shopId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policeResult = vRP.numPermission("Police")
		if (robberys[user_id + shopId] and robberys[user_id + shopId].shopId == shopId) then
			TriggerClientEvent("Notify", source, "important", "Atenção","Você precisa aguardar "..robberys[user_id + shopId].time - os.time().." Segundos.","amarelo", 5000)
		else
			if not (os.time() < atmTimers) then
				if parseInt(#policeResult) < 0 then
					TriggerClientEvent("Notify", source, "important", "Atenção","Sistema indisponível no momento.","amarelo", 5000)
					return false
				else
					local consultItem = vRP.getInventoryItemAmount(user_id,"floppy")
					if consultItem[1] <= 0 then
							TriggerClientEvent("Notify", source, "important", "Atenção","Necessário possuir um <b>Disquete</b>.","amarelo", 5000)
						return false
					end
				end
	
				robberys[user_id + shopId] = { shopId = shopId, time = os.time() + 300 }
				vRP.upgradeStress(user_id,10)
				atmTimers = os.time() + 30
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				TriggerClientEvent("player:applyGsr",source)
	
				vRP.tryGetInventoryItem(user_id,'floppy',1,true)
	
				for k,v in pairs(policeResult) do
					async(function()
--[[ 						vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET") ]]
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Caixa Eletrônico", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
	
				return true
			else
				TriggerClientEvent("Notify", source, "important", "Atenção","Você precisa aguardar "..atmTimers - os.time().." Segundos.","amarelo", 5000)
			end
		end
	end

	return false
end

CreateThread(function ()
	while true do
		for key, value in pairs(robberys) do
			if (os.time() >= value.time) then
				robberys[key] = nil
			end
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.GetPIN()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.query("characters/getUsers",{ id = user_id })
	
	return identity[1]["pincode"]
end

function cRP.paymentSystems(value)
	local source = source
	local user_id = vRP.getUserId(source)

	vRP.giveInventoryItem(user_id, 'dollarsroll', value, true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSITMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:DepositMoney")
AddEventHandler("RazeBank:DepositMoney", function(amount)
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.tryGetInventoryItem(user_id,"dollars", amount) then 
		vRP.addBank(user_id,amount,"Private")

		TriggerEvent('RazeBank:AddDepositTransaction', amount, source)
		TriggerClientEvent('RazeBank:updateTransactions', source, vRP.getBank(user_id), vRP.getInventoryItemAmount(user_id,"dollars"))
		TriggerClientEvent("Notify",source,"verde","Você depositou $"..amount,5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:WithdrawMoney")
AddEventHandler("RazeBank:WithdrawMoney", function(amount)
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.paymentBank(user_id,amount) then
		vRP.giveInventoryItem(user_id,"dollars",amount,true)
		TriggerEvent('RazeBank:AddWithdrawTransaction', amount, source)
		TriggerClientEvent('RazeBank:updateTransactions', source, vRP.getBank(user_id), vRP.getInventoryItemAmount(user_id,"dollars"))
		TriggerClientEvent("Notify",source,"verde","Você sacou $"..amount,5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:TransferMoney")
AddEventHandler("RazeBank:TransferMoney", function(amount, nuser_id)
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
    if user_id ~= nuser_id then
        if vRP.paymentBank(user_id,amount) then
            if nuser_id ~= nil then
                vRP.addBank(nuser_id, amount)

                for i=1, #vRP.getUsers(), 1 do
                    local xForPlayer = vRP.getUserId(vRP.getUsers()[i])
                    if xForPlayer == nuser_id then
						local identity2 = vRP.userIdentity(xForPlayer)
                        TriggerClientEvent('RazeBank:updateTransactions', vRP.getUsers()[i], vRP.getBank(nuser_id), vRP.getInventoryItemAmount(nuser_id,"dollars"))
                        TriggerClientEvent('okokNotify:Alert', vRP.getUsers()[i], "BANK", "Você recebeu $"..amount.." from "..identity2.name .. " " .. identity2.name2, 5000, 'success')
                    end
                end
                TriggerEvent('RazeBank:AddTransferTransaction', amount, nuser_id, source)
				TriggerClientEvent('RazeBank:updateTransactions', source, vRP.getBank(user_id), vRP.getInventoryItemAmount(user_id,"dollars"))
				TriggerClientEvent("Notify",source,"verde","Você transferiu $"..amount.." para "..identity.name .. " " .. identity.name2,5000)
            end
        else
			TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
        end
    else
		TriggerClientEvent("Notify",source,"vermelho","Você não pode transferir para si mesmo.",5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETOVERVIEWTRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.GetOverviewTransactions()
	local source = source
	local user_id = vRP.getUserId(source)
	local playerIdentifier = user_id
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	local result = vRP.query("vRP/Get_Transactions", { identifier = playerIdentifier })

	local result2 = vRP.query("vRP/Transactions", { })
	for k, v in pairs(result2) do
		local type = v.type
		local receiver_identifier = v.receiver_identifier
		local sender_identifier = v.sender_identifier
		local value = tonumber(v.value)

		if v.day1 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day1_total = day1_total + value
					income = income + value
				elseif type == "withdraw" then
					day1_total = day1_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day1_total = day1_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day1_total = day1_total - value
					outcome = outcome - value
				end
			end
			
		elseif v.day2 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day2_total = day2_total + value
					income = income + value
				elseif type == "withdraw" then
					day2_total = day2_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day2_total = day2_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day2_total = day2_total - value
					outcome = outcome - value
				end
			end

		elseif v.day3 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day3_total = day3_total + value
					income = income + value
				elseif type == "withdraw" then
					day3_total = day3_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day3_total = day3_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day3_total = day3_total - value
					outcome = outcome - value
				end
			end

		elseif v.day4 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day4_total = day4_total + value
					income = income + value
				elseif type == "withdraw" then
					day4_total = day4_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day4_total = day4_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day4_total = day4_total - value
					outcome = outcome - value
				end
			end

		elseif v.day5 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day5_total = day5_total + value
					income = income + value
				elseif type == "withdraw" then
					day5_total = day5_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day5_total = day5_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day5_total = day5_total - value
					outcome = outcome - value
				end
			end

		elseif v.day6 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day6_total = day6_total + value
					income = income + value
				elseif type == "withdraw" then
					day6_total = day6_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day6_total = day6_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day6_total = day6_total - value
					outcome = outcome - value
				end
			end

		elseif v.day7 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day7_total = day7_total + value
					income = income + value
				elseif type == "withdraw" then
					day7_total = day7_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day7_total = day7_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day7_total = day7_total - value
					outcome = outcome - value
				end
			end

		end
	end

	totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

	table.remove(allDays)
	table.insert(allDays, day1_total)
	table.insert(allDays, day2_total)
	table.insert(allDays, day3_total)
	table.insert(allDays, day4_total)
	table.insert(allDays, day5_total)
	table.insert(allDays, day6_total)
	table.insert(allDays, day7_total)
	table.insert(allDays, income)
	table.insert(allDays, outcome)
	table.insert(allDays, totalIncome)

	return result, playerIdentifier, allDays
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDDEPOSITTRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:AddDepositTransaction")
AddEventHandler("RazeBank:AddDepositTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local user_id = vRP.getUserId(_source)
	local identity = vRP.userIdentity(user_id)

	MySQL.Async.insert('INSERT INTO RazeBank_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = 'bank',
		['@receiver_name'] = 'Bank Account',
		['@sender_identifier'] = tostring(user_id),
		['@sender_name'] = identity.name .. " " .. identity.name2,
		['@value'] = tonumber(amount),
		['@type'] = 'deposit'
	}, function (result)
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSALARI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:AddSalaryTransaction")
AddEventHandler("RazeBank:AddSalaryTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local user_id = vRP.getUserId(_source)
	local identity = vRP.userIdentity(user_id)

	MySQL.Async.insert('INSERT INTO RazeBank_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = 'bank',
		['@receiver_name'] = 'Pagamento',
		['@sender_identifier'] = tostring(user_id),
		['@sender_name'] = identity.name .. " " .. identity.name2,
		['@value'] = tonumber(amount),
		['@type'] = 'salary'
	}, function (result)
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDWITHDRAWTRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:AddWithdrawTransaction")
AddEventHandler("RazeBank:AddWithdrawTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local user_id = vRP.getUserId(_source)
	local identity = vRP.userIdentity(user_id)

	MySQL.Async.insert('INSERT INTO RazeBank_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = tostring(user_id),
		['@receiver_name'] = identity.name .. " " .. identity.name2,
		['@sender_identifier'] = 'bank',
		['@sender_name'] = 'Bank Account',
		['@value'] = tonumber(amount),
		['@type'] = 'withdraw'
	}, function (result)
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTRANSFERTRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:AddTransferTransaction")
AddEventHandler("RazeBank:AddTransferTransaction", function(amount, xTarget, source_, targetName, targetIdentifier)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local user_id = vRP.getUserId(_source)
	local identity = vRP.userIdentity(user_id)
	local identity2 = vRP.userIdentity(xTarget)

	if targetName == nil then
		MySQL.Async.insert('INSERT INTO RazeBank_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(xTarget),
			['@receiver_name'] = identity2.name .. " " .. identity2.name2,
			['@sender_identifier'] = tostring(user_id),
			['@sender_name'] = identity.name .. " " .. identity.name2,
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	elseif targetName ~= nil and targetIdentifier ~= nil then
		MySQL.Async.insert('INSERT INTO RazeBank_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(targetIdentifier),
			['@receiver_name'] = tostring(targetName),
			['@sender_identifier'] = tostring(user_id),
			['@sender_name'] = identity.name .. " " .. identity.name2,
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPINDB
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("RazeBank:UpdatePINDB")
AddEventHandler("RazeBank:UpdatePINDB", function(pin, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.paymentBank(user_id,1000) then
		MySQL.Async.execute('UPDATE characters SET pincode = @pin WHERE id = @identifier', {
            ['@pin'] = pin,
            ['@identifier'] = user_id,
        }, function(changed)
        end)
		vRP.updateUserPincode(user_id, pin)
        TriggerClientEvent('RazeBank:updateIbanPinChange', source)
		TriggerClientEvent('RazeBank:updateMoney',source, vRP.getBank(user_id), vRP.getInventoryItemAmount(user_id,"dollars"))
		TriggerClientEvent("Notify",source,"verde","PIN trocado com sucesso para "..pin,5000)
    else
		TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.finesPayment(id,price)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.paymentBank(user_id,parseInt(price)) then
            vRP.delFines(user_id,parseInt(price))
        else
            TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",5000)
        end
    end
end