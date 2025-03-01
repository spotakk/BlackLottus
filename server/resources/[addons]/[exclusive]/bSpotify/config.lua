License = '77168b08-fdf3-4d23-a717-381bb4ecfbf5'
Domain = 'http://89.213.5.174:4001'

cfg = {}

cfg.distanceToVolume = 20.0 -- A distância que ficará com o volume em 1,0, então se o volume for 0,5 a distância será 15,0, se o volume for 0,2 a distância será 6. 
cfg.dlayToEveryone = true -- A música no carro será tocada para todos? Ou apenas para as pessoas que estão nesse veículo? Se false, o Distance Volume não fará nada
cfg.dommandVehicle = "som"
cfg.permissao = "Admin"
cfg.zones = {
	{
		name = "Mechanic Zone", -- The name of the radio, it doesn't matter
		coords = vector3(-212.52,-1341.59,34.89), -- the position where the music is played
		job = "vip", --the job that can change the music
		range = 30.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=Emap7LU6hYk&t",-- the default link, if nill it won't play nothing
		isplaying = true, -- will the music play when the server start?
		loop = false,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(-212.53,-1341.61,34.89) -- where the player can change the music
	},
	{
		name = "Vanilla Zone", -- The name of the radio, it doesn't matter
		coords = vector3(116.57,-1287.63,28.27), -- the position where the music is played
		job = "Vanilla", --the job that can change the music
		range = 30.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=W9iUh23Xrsg",-- the default link, if nill it won't play nothing
		isplaying = true, -- the music will play when the server start?
		loop = false,-- when the music stops it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(120.54,-1281.46,29.49) -- where the player can change the music
	},
}