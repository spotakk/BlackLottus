fx_version 'cerulean'
games { 'gta5' }

ui_page 'nui/index.html'

shared_scripts {
	"config.lua"
}

client_scripts {
	'@vrp/lib/utils.lua',
	'client.lua',
}

files {
	'nui/index.html',
	'nui/script.js',
	'nui/source/*',
	'nui/main.css',
}

server_scripts {
	'@vrp/lib/utils.lua',
  'server.lua',
}