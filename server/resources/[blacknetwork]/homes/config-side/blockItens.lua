

Config = {}



Config.fridge =  {
      ["fries"] = false
}

Config.hotel = {
      ["vault"] = vec3(2.31,6.13,0.2)
}

Config.BlockChest = function (item) 

      return Config.fridge[item] 

end