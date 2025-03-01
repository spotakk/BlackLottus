-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("crafting",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
----------------------------------------------------------------------------------------------------------
-- FAVELAS
----------------------------------------------------------------------------------------------------------
	["Barragem"] = {
		["perm"] = "Barragem",
		["list"] = {
			["tableweed"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			},
			["weedsack"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["saquinho"] = 1,
					["weed"] = 1
				}
			}
		}
	},
    ["Helipa"] = {
		["perm"] = "Helipa",
		["list"] = {
			["tablecoke"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			},
			["cokesack"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["saquinho"] = 1,
					["cocaine"] = 1
				}
			}
		}
	},
	["Igreja"] = {
		["perm"] = "Igreja",
		["list"] = {
			["tablemeth"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			},
			["methsack"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["saquinho"] = 1,
					["meth"] = 1
				}
			}
		}
	},
	["Esgoto"] = {
		["perm"] = "Esgoto",
		["list"] = {
			["tablelean"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			}
		}
	},
	["Porto"] = {
		["perm"] = "Porto",
		["list"] = {
			["tableoxy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			}
		}
	},
	
----------------------------------------------------------------------------------------------------------
-- EXTRAS
----------------------------------------------------------------------------------------------------------
	["Burguer"] = {
		["perm"] = "Burguer",
		["list"] = {
			["hamburger2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tomato"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["carne"] = 1
				}
			},
			["hamburger3"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tomato"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["carne"] = 1
				}
			},
			["hamburger4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tomato"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["carne"] = 1
				}
			},
			["hamburger5"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tomato"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["carne"] = 1					
					
				}
			}
		}
	},
	["BurguerJuice"] = {
		["perm"] = "Burguer",
		["list"] = {
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["orange"] = 1
				}
			},
			["grapejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["grape"] = 2
				}
			},
			["bananajuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["banana"] = 2
				}
			},
			["strawberryjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["strawberry"] = 2					
					
				}
			}
		}
	},
	["LavagemPUB"] = {
		["list"] = {
			["dollars"] = {
				["amount"] = 1000,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 2000
				}
			}
		}
	},
	["Utilspub"] = {
		["list"] = {
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 6,
					["copper"] = 6,
					["glass"] = 4,
					["rubber"] = 4,
					["plastic"] = 4
				}
			},
			["c4"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 10,
					["copper"] = 9,
					["glass"] = 8,
					["rubber"] = 8,
					["plastic"] = 10
				}
			},
			["lockpick2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 6,
					["copper"] = 6,
					["glass"] = 4,
					["rubber"] = 4,
					["plastic"] = 4
				}
			}
		}
	},
	["Lockpick"] = {
		["list"] = {
			["lockpick2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 10
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 10
				}
			},
			["handcuff"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 18

				}
			}
		}
	},
	["Lixeiro"] = {
		["list"] = {
			["glass"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["glassbottle"] = 1
				}
			},
			["plastic"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["plasticbottle"] = 1
				}
			},
			["rubber"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["elastic"] = 1
				}
			},
			["aluminum"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["metalcan"] = 1
				}
			},
			["copper"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["battery"] = 1
				}
			}
		}
	},
	["fuelShop"] = {
		["list"] = {
			["WEAPON_PETROLCAN"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 50
				}
			},
			["WEAPON_PETROLCAN_AMMO"] = {
				["amount"] = 4500,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 200
				}
			}
		}
	},
----------------------------------------------------------------------------------------------------------
-- FACÇÕES
----------------------------------------------------------------------------------------------------------
	["TheLost"] = {
		["perm"] = "TheLost",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 12,
					["gunpowder"] = 10
				}
			},
			["lockpick2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 10
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 12,
					["gunpowder"] = 10
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 14,
					["gunpowder"] = 10
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 14,
					["copper"] = 12
				}
			},
			["vest"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 16,
					["copper"] = 10
				}
			}
		}
	},
	["Tequila"] = {
		["perm"] = "Tequila",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 13,
					["gunpowder"] = 10
				}
			},
			["lockpick2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 10
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 13,
					["gunpowder"] = 10
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 14,
					["gunpowder"] = 10
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 14,
					["copper"] = 12
				}
			},
			["vest"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 16,
					["copper"] = 10
				}
			}
		}
	},
	["Vinhedo"] = {
		["perm"] = "Vinhedo",
		["list"] = {
			["WEAPON_APPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 15,
					["cabo"] = 15
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 30,
					["cabo"] = 50
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 20,
					["cabo"] = 20
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 35,
					["cabo"] = 35
				}
			},
			["WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 35,
					["cabo"] = 35
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 20,
					["cabo"] = 20
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 15,
					["cabo"] = 15
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 20,
					["cabo"] = 20
				}
			}
		}
	},
	["Mafia"] = {
		["perm"] = "Mafia",
		["list"] = {
			["WEAPON_APPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 15,
					["cabo"] = 15
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 30,
					["cabo"] = 50
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 20,
					["cabo"] = 20
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 35,
					["cabo"] = 35
				}
			},
			["WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 35,
					["cabo"] = 35
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 50,
					["cabo"] = 50
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 20,
					["cabo"] = 20
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 15,
					["cabo"] = 15
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 20,
					["cabo"] = 20
				}
			}
		}
	},
	["Roxos"] = {
		["perm"] = "Roxos",
		["list"] = {
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 14,
					["copper"] = 10
				}
			},
			["c4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 20,
					["copper"] = 20
				}
			},
			["handcuff"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 18
				}
			},
			["hood"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 20,
					["copper"] = 20
				}
			},
		}
	},
	["Groove"] = {
		["perm"] = "Groove",
		["list"] = {
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 14,
					["copper"] = 10
				}
			},
			["c4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 20,
					["copper"] = 20
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 14,
					["gunpowder"] = 10
				}
			}
		}
	},
	["Bennys"] = {
		["perm"] = "Bennys",
		["list"] = {
			["plate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 10,
					["rubber"] = 8
				}
			},
			["nitro"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 10,
					["rubber"] = 8
				}
			},
			["notebook"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 30,
					["rubber"] = 8
				}
			}
		}
	},
	["Vanilla"] = {
		["perm"] = "Vanilla",
		["list"] = {
			["card01"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 20,
					["rubber"] = 18
				}
			},
			["card02"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 20,
					["rubber"] = 18
				}
			},
			["card03"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 10,
					["rubber"] = 8
				}
			},
			["card04"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 30,
					["rubber"] = 20
				}
			},
			["card05"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 40,
					["rubber"] = 28
				}
			},
			["dollars"] = {
				["amount"] = 100000,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 100000,
					["cedulas"] = 1000
				}
			}
		}
	},
	["Bahamas"] = {
		["perm"] = "Bahamas",
		["list"] = {
			["attachsFlashlight"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 18
				}
			},
			["attachsCrosshair"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 18
				}
			},
			["attachsSilencer"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 18
				}
			},
			["attachsMagazine"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 18
				}
			},
			["attachsGrip"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 18
				}
			},
			["dollars"] = {
				["amount"] = 100000,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 100000,
					["cedulas"] = 1000
				}
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(craftType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getFines(user_id) > 0 then 
			TriggerClientEvent("Notify",source,"cancel","Negado","Multas pendentes encontradas.","vermelho",5000)

			return false
		end

		if exports["hud_v2"]:Wanted(user_id) then
			return false
		end

		if craftList[craftType]["perm"] ~= nil then
			if not vRP.hasGroup(user_id,craftList[craftType]["perm"]) then
				return false
			end
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestCrafting(craftType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(craftList[craftType]["list"]) do
			local craftList = {}
			for k,v in pairs(v["require"]) do
				table.insert(craftList,{ name = itemName(k), amount = v })
			end

			table.insert(inventoryShop,{ name = itemName(k), index = itemIndex(k), key = k, peso = itemWeight(k), list = craftList, amount = parseInt(v["amount"]), desc = itemDescription(k) })
		end

		local inventoryUser = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			inventoryUser[k] = v
		end
		local identity = vRP.userIdentity(user_id)

		return inventoryShop,inventoryUser,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),identity["name"].." "..identity["name2"],user_id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionCrafting(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		if craftList[shopType]["list"][shopItem] then
			if vRP.checkMaxItens(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"] * shopAmount) then
				
				TriggerClientEvent("Notify",source,"important","Atenção","Limite atingido.","amarelo",3000)
				TriggerClientEvent("crafting:Update",source,"requestCrafting")
				return
			end

			if (vRP.inventoryWeight(user_id) + (itemWeight(shopItem) * parseInt(shopAmount))) <= vRP.getWeight(user_id) then
				if shopItem == "nails" then
					local Inventory = vRP.userInventory(user_id)
					if Inventory then
						for k,v in pairs(Inventory) do
							if string.sub(v["item"],1,5) == "badge" then
								vRP.removeInventoryItem(user_id,v["item"],1,false)
								vRP.generateItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"] * shopAmount,false,slot)
								break
							end
						end
					end
				else
					for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
						local consultItem = vRP.getInventoryItemAmount(user_id,k)
						if consultItem[1] < parseInt(v * shopAmount) then
							return
						end

						if vRP.checkBroken(consultItem[2]) then
							TriggerClientEvent("Notify",source,"cancel","Negado","Item quebrado.","vermelho",3000)
							
							return
						end
					end

					for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
						local consultItem = vRP.getInventoryItemAmount(user_id,k)
						vRP.removeInventoryItem(user_id,consultItem[2],parseInt(v * shopAmount))
					end

					vRP.generateItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"] * shopAmount,false,slot)
				end
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionDestroy(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end
		local splitName = splitString(shopItem,"-")

		if craftList[shopType]["list"][splitName[1]] then
			if craftList[shopType]["list"][splitName[1]]["destroy"] then
				if vRP.checkBroken(shopItem) then
					TriggerClientEvent("Notify",source,"vermelho","Itens quebrados reciclados.",5000)
					TriggerClientEvent("crafting:Update",source,"requestCrafting")
					return
				end

				if vRP.tryGetInventoryItem(user_id,shopItem,craftList[shopType]["list"][splitName[1]]["amount"]) then
					for k,v in pairs(craftList[shopType]["list"][splitName[1]]["require"]) do
						if parseInt(v) <= 1 then
							vRP.generateItem(user_id,k,1)
						else
							vRP.generateItem(user_id,k,v / 2)
						end
					end
				end
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:populateSlot")
AddEventHandler("crafting:populateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
			vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			TriggerClientEvent("crafting:Update",source,"requestCrafting")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:updateSlot")
AddEventHandler("crafting:updateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inventory = vRP.userInventory(user_id)
		if inventory[tostring(slot)] and inventory[tostring(target)] and inventory[tostring(slot)]["item"] == inventory[tostring(target)]["item"] then
			if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
				vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			end
		else
			vRP.swapSlot(user_id,slot,target)
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end)


function cRP.modelPlayer()
	local source = source
	local ped = GetPlayerPed(source)
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			return "mp_m_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			return "mp_f_freemode_01"
	end

	return false
end