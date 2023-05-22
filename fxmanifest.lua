fx_version 'adamant'
game 'gta5'

author 'Reborn'
website "http://bit.ly/rebornsaves1"

server_scripts{
    "@vrp/lib/utils.lua",
    "server-side/server.lua",
}

client_scripts{
    "@vrp/lib/utils.lua",
    "client-side/client.lua",
}

ui_page "web-side/index.html"

files{
    "web-side/**",
    "web-side/**/**",
}              