fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"server-side/interiors.lua",
	"server-side/informations.lua",
	"config-side/blockItens.lua",
	"server-side/propertys.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"server-side/informations.lua",
	"config-side/blockItens.lua",
	"server-side/*"
}

files {
	"web-side/*"
}