

fx_version "bodacious"
game "gta5"
lua54 "yes"
client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}
server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*"
}
client_script "scripting_lua.lua"