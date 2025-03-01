fx_version 'bodacious'
games { 'gta5' }

author 'Kiminaze'

shared_scripts {
	'@vrp/lib/utils.lua'
}

client_scripts {
	--'@NativeUILua-Reloaded/src/NativeUIReloaded.lua',
	'@NativeUI/NativeUI.lua',
	'config.lua',
	'client.lua'
}

server_script 'server.lua'
