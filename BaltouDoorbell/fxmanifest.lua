fx_version 'cerulean'
game 'gta5'

author 'Baltou'
description 'Jouer un son unique lorsqu\'on entre dans un magasin'
version '1.0.0'

client_scripts {
    'config.lua',
    'client.lua'
}

server_script 'server.lua'

files {
    'html/index.html',
    'html/sounds/sound1.ogg',
    'html/sounds/sound2.ogg'
}

ui_page 'html/index.html'
