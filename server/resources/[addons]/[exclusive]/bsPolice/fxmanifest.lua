fx_version "adamant"
game "gta5"
version "1.0.1"

ui_page "web/build/index.html"

lua54 "yes"

client_scripts {
	"license.lua",
	"@vrp/lib/utils.lua",
	"@PolyZone/client.lua",
	"client.lua"
}
server_scripts {
	"license.lua",
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"config.json",
	"web/build/*",
	"web/build/**/*",
}