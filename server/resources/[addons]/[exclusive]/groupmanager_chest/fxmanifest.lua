
fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}
dependecy "groupmanager_v2"

server_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"server-side/*"
}

shared_scripts {
	"@groupmanager_v2/config.lua"
}

files {
	"web-side/*"
}