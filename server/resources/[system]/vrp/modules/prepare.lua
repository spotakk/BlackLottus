-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("characters/allChars","SELECT * FROM characters")
vRP.prepare("characters/getUsers","SELECT * FROM characters WHERE id = @id")
vRP.prepare("characters/getPhone","SELECT id FROM characters WHERE phone = @phone")
vRP.prepare("characters/getSerial","SELECT id FROM characters WHERE serial = @serial")
vRP.prepare("characters/getBlood","SELECT id FROM characters WHERE blood = @blood")
vRP.prepare("characters/updatePort","UPDATE characters SET port = @port WHERE id = @id")
vRP.prepare("characters/updatePhone","UPDATE characters SET phone = @phone WHERE id = @id")
vRP.prepare("characters/removeCharacters","UPDATE characters SET deleted = 1 WHERE id = @id")
vRP.prepare("characters/updateLocate","UPDATE characters SET locate = @locate WHERE id = @id")
vRP.prepare("characters/addFines","UPDATE characters SET fines = fines + @fines WHERE id = @id")
vRP.prepare("characters/setPrison","UPDATE characters SET prison = @prison WHERE id = @user_id")
vRP.prepare("characters/updateGarages","UPDATE characters SET garage = garage + 1 WHERE id = @id")
vRP.prepare("characters/removeFines","UPDATE characters SET fines = fines - @fines WHERE id = @id")
vRP.prepare("characters/getCharacters","SELECT * FROM characters WHERE steam = @steam and deleted = 0")
vRP.prepare("characters/removePrison","UPDATE characters SET prison = prison - @prison WHERE id = @user_id")
vRP.prepare("characters/updateName","UPDATE characters SET name = @name, name2 = @name2 WHERE id = @user_id")
vRP.prepare("characters/lastCharacters","SELECT id FROM characters WHERE steam = @steam ORDER BY id DESC LIMIT 1")
vRP.prepare("characters/countPersons","SELECT COUNT(steam) as qtd FROM characters WHERE steam = @steam and deleted = 0")
vRP.prepare("characters/newCharacter","INSERT INTO characters(steam,name,name2,locate,sex,phone,serial,blood) VALUES(@steam,@name,@name2,@locate,@sex,@phone,@serial,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("bank/getInfos","SELECT bank FROM characters WHERE id = @user_id")
vRP.prepare("bank/addValue","UPDATE characters SET bank = bank + @bank WHERE id = @user_id ")
vRP.prepare("bank/remValue","UPDATE characters SET bank = bank - @bank WHERE id = @user_id")
vRP.prepare("bank/setValue","UPDATE characters SET bank = @bank WHERE id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("accounts/getInfos","SELECT * FROM accounts WHERE steam = @steam")
vRP.prepare("accounts/newAccount","INSERT INTO accounts(steam) VALUES(@steam)")
vRP.prepare("accounts/updateWhitelist","UPDATE accounts SET whitelist = 1 WHERE steam = @steam")
vRP.prepare("accounts/removeGems","UPDATE accounts SET gems = gems - @gems WHERE steam = @steam")
vRP.prepare("accounts/setPriority","UPDATE accounts SET priority = @priority WHERE steam = @steam")
vRP.prepare("accounts/infosUpdatechars","UPDATE accounts SET chars = chars + 1 WHERE steam = @steam")
vRP.prepare("accounts/infosUpdategems","UPDATE accounts SET gems = gems + @gems WHERE steam = @steam")
vRP.prepare("accounts/updatePremium","UPDATE accounts SET premium = premium + 2592000 WHERE steam = @steam")
vRP.prepare("accounts/setPremium","UPDATE accounts SET premium = @premium, priority = @priority WHERE steam = @steam")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("playerdata/getUserdata","SELECT dvalue FROM playerdata WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("playerdata/setUserdata","REPLACE INTO playerdata(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("entitydata/removeData","DELETE FROM entitydata WHERE dkey = @dkey")
vRP.prepare("entitydata/getData","SELECT dvalue FROM entitydata WHERE dkey = @dkey")
vRP.prepare("entitydata/setData","REPLACE INTO entitydata(dkey,dvalue) VALUES(@dkey,@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vehicles/plateVehicles","SELECT * FROM vehicles WHERE plate = @plate")
vRP.prepare("vehicles/getVehicles","SELECT * FROM vehicles WHERE user_id = @user_id")
vRP.prepare("vehicles/removeVehicles","DELETE FROM vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/selectVehicles","SELECT * FROM vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/paymentArrest","UPDATE vehicles SET arrest = 0 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/moveVehicles","UPDATE vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/plateVehiclesUpdate","UPDATE vehicles SET plate = @plate WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/rentalVehiclesDays","UPDATE vehicles SET rental = rental + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/countVehicles","SELECT COUNT(vehicle) as qtd FROM vehicles WHERE user_id = @user_id AND work = @work AND rental <= 0")
vRP.prepare("vehicles/arrestVehicles","UPDATE vehicles SET arrest = UNIX_TIMESTAMP() + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/updateVehiclesTax","UPDATE vehicles SET tax = UNIX_TIMESTAMP() + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/rentalVehiclesUpdate","UPDATE vehicles SET rental = UNIX_TIMESTAMP() + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/addVehicles","INSERT IGNORE INTO vehicles(user_id,vehicle,plate,work,tax) VALUES(@user_id,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 604800)")
vRP.prepare("vehicles/rentalVehicles","INSERT IGNORE INTO vehicles(user_id,vehicle,plate,work,rental,tax) VALUES(@user_id,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 2592000,UNIX_TIMESTAMP() + 604800)")
vRP.prepare("vehicles/updateVehicles","UPDATE vehicles SET engine = @engine, body = @body, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres, nitro = @nitro WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("propertys/selling","DELETE FROM propertys WHERE name = @name")
vRP.prepare("propertys/permissions","SELECT * FROM propertys WHERE name = @name")
vRP.prepare("propertys/totalHomes","SELECT name,tax FROM propertys WHERE owner = 1")
vRP.prepare("propertys/userList","SELECT name FROM propertys WHERE user_id = @user_id")
vRP.prepare("propertys/countUsers","SELECT COUNT(*) as qtd FROM propertys WHERE user_id = @user_id")
vRP.prepare("propertys/countPermissions","SELECT COUNT(*) as qtd FROM propertys WHERE name = @name")
vRP.prepare("propertys/userOwnermissions","SELECT * FROM propertys WHERE name = @name AND owner = 1")
vRP.prepare("propertys/removePermissions","DELETE FROM propertys WHERE name = @name AND user_id = @user_id")
vRP.prepare("propertys/userPermissions","SELECT * FROM propertys WHERE name = @name AND user_id = @user_id")
vRP.prepare("propertys/updateOwner","UPDATE propertys SET user_id = @nuser_id WHERE user_id = @user_id AND name = @name")
vRP.prepare("propertys/updateTax","UPDATE propertys SET tax = UNIX_TIMESTAMP() + 2592000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/updateVault","UPDATE propertys SET vault = vault + 10, price = price + 10000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/updateFridge","UPDATE propertys SET fridge = fridge + 10, price = price + 10000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/newPermissions","INSERT IGNORE INTO propertys(name,interior,user_id,owner) VALUES(@name,@interior,@user_id,@owner)")
vRP.prepare("propertys/buying","INSERT IGNORE INTO propertys(name,interior,price,user_id,tax,residents,vault,fridge,owner) VALUES(@name,@interior,@price,@user_id,UNIX_TIMESTAMP() + 604800,@residents,@vault,@fridge,1)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("prison/cleanRecords","DELETE FROM prison WHERE nuser_id = @nuser_id")
vRP.prepare("prison/getRecords","SELECT * FROM prison WHERE nuser_id = @nuser_id ORDER BY id DESC")
vRP.prepare("prison/insertPrison","INSERT INTO prison(police,nuser_id,services,fines,text,date) VALUES(@police,@nuser_id,@services,@fines,@text,@date)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("fines/getFines2","SELECT * FROM mid_fines WHERE user_id = @user_id ORDER BY id DESC")
vRP.prepare("fines/removeFines2","DELETE FROM mid_fines WHERE id = @id AND user_id = @user_id")
vRP.prepare("fines/insertFines2","INSERT INTO mid_fines (user_id,nuser_id,date,price,text) VALUES(@user_id,@nuser_id,@date,@price,@text)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNEDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("banneds/getBanned","SELECT * FROM banneds WHERE steam = @steam")
vRP.prepare("banneds/removeBanned","DELETE FROM banneds WHERE steam = @steam")
vRP.prepare("banneds/insertBanned","INSERT INTO banneds(steam) VALUES(@steam)")

vRP.prepare("accounts/setwl","UPDATE accounts SET whitelist = @whitelist WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("chests/getChests","SELECT * FROM chests WHERE name = @name")
vRP.prepare("chests/upgradeChests","UPDATE chests SET weight = weight + 25 WHERE name = @name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("races/checkResult","SELECT * FROM races WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/requestRanking","SELECT * FROM races WHERE raceid = @raceid ORDER BY points ASC LIMIT 5")
vRP.prepare("races/updateRecords","UPDATE races SET points = @points, vehicle = @vehicle WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/insertRecords","INSERT INTO races(raceid,user_id,name,vehicle,points) VALUES(@raceid,@user_id,@name,@vehicle,@points)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("fidentity/getResults","SELECT * FROM fidentity WHERE id = @id")
vRP.prepare("fidentity/lastIdentity","SELECT id FROM fidentity ORDER BY id DESC LIMIT 1")
vRP.prepare("fidentity/newIdentity","INSERT INTO fidentity(name,name2,locate,blood) VALUES(@name,@name2,@locate,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANSMARTPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("smartphone/cleanCalls","DELETE FROM smartphone_calls WHERE created_at < (UNIX_TIMESTAMP() - 86400 * 3)")
vRP.prepare("smartphone/cleanTorMessages","DELETE FROM smartphone_tor_messages WHERE created_at < (UNIX_TIMESTAMP() - 86400 * 3)")
vRP.prepare("smartphone/cleanMessages","DELETE FROM smartphone_whatsapp_messages WHERE created_at < (UNIX_TIMESTAMP() - 86400 * 7)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("black/playerdata","DELETE FROM playerdata WHERE dvalue = '[]' OR dvalue = '{}'")
vRP.prepare("black/entitydata","DELETE FROM entitydata WHERE dvalue = '[]' OR dvalue = '{}'")
-- vRP.prepare("black/cleanBanks","DELETE FROM smartphone_bank WHERE (DATEDIFF(CURRENT_DATE,data) >= 7)")
vRP.prepare("black/cleanPremium","UPDATE accounts SET premium = '0', priority = '0' WHERE UNIX_TIMESTAMP() >= premium")

-----------------------------------------------------------------------------------------------------------------------------------------
-- Vitale Group Manager
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("groupSystem/setData","INSERT INTO gregos_members(user_id,name,cargo,status,organizacao) VALUES(@user_id ,@name,@cargo,@status , @organizacao)")
vRP.prepare("groupSystem/checkData","SELECT * FROM gregos_members WHERE user_id = @user_id ")
vRP.prepare("groupSystem/membersData","SELECT * FROM gregos_members WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/updateData","UPDATE gregos_members SET cargo = @cargo WHERE user_id = @user_id")
vRP.prepare("groupSystem/deleteData","DELETE FROM gregos_members WHERE user_id = @user_id")
vRP.prepare("groupSystem/updateStatus","UPDATE gregos_members SET status = @status WHERE user_id = @user_id")
vRP.prepare("groupSystem/HowStatus","SELECT count(status) FROM gregos_members WHERE status = @status AND organizacao = @organizacao")
vRP.prepare("groupSystem/membersQtd","SELECT count(user_id) FROM gregos_members WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/orgQtd","SELECT membros FROM gregos_organizacao WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/updateDataMembers","UPDATE gregos_organizacao SET membros = @membros WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/groupMensage","SELECT mensagem FROM gregos_organizacao WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/setMensage","UPDATE gregos_organizacao SET mensagem = @mensagem WHERE organizacao = @organizacao")

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCLEANERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.execute("black/playerdata")
	vRP.execute("black/entitydata")
	-- vRP.execute("black/cleanBanks")
	vRP.execute("black/cleanPremium")
	vRP.execute("smartphone/cleanCalls")
	vRP.execute("smartphone/cleanMessages")
	vRP.execute("smartphone/cleanTorMessages")
end)