fx_version "adamant"
game "gta5"
version "1.0.1"

ui_page 'web/build/index.html'

lua54 'yes'

client_scripts {
	"client.lua"
}
shared_scripts {
	"config.lua"
}

server_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"lib/*.lua",
	"server.lua"
}

files {
	"web/build/*",
	"web/build/**/*",
}