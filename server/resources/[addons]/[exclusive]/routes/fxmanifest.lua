fx_version "bodacious"
game "gta5"

ui_page "nui/build/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

shared_scripts {
	"config.lua"
}
server_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"nui/build/*",
	"nui/build/**/*"
}