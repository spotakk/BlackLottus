fx_version "adamant"
game "gta5"
lua54 "yes"

shared_scripts {"auth/config.lua"}
client_scripts {     "@vrp/lib/utils.lua" }  server_scripts {     "@vrp/lib/vehicles.lua",     "@vrp/lib/utils.lua" }  ui_page "web-side/build/index.html"  files {     "web-side/build/",     "web-side/build/**/" }

script_version "1.0.0"

server_scripts {"server.lua"}
client_scripts {"client.lua"}