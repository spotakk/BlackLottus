fx_version "bodacious"
game "gta5"

author 'Felp <contato@blacknetwork.com.br>'
description 'sistema de combustivel para fivem'
version '1.0'

client_scripts {
	"@vrp/lib/utils.lua",
	"utils/*",
	"config/*",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"utils/*",
	"config/*",
	"server/*"
}

ui_page "web-side/index.html"

files {
	"web-side/*",
	"web-side/**/*"
}