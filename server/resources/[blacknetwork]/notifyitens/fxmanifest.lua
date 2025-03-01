fx_version "bodacious"
game "gta5"

ui_page "web-side/build/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}
files {
	"web-side/build/*",
	"web-side/build/**/*",
}
