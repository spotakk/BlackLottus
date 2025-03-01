

fx_version "bodacious"
game "gta5"
lua54 "yes"
ui_page "web-side/index.html"
client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*.lua"
}
files {
	"web-side/*",
	"web-side/**/*"
}