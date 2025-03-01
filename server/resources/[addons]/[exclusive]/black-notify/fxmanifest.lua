fx_version 'bodacious'
game "gta5"
lua54 "yes"

files {
    "client-side/nui/**",
}

ui_page "client-side/nui/index.html"

shared_scripts {
    "shared/module.lua"
}

client_scripts {
    "client-side/client.lua"
}
