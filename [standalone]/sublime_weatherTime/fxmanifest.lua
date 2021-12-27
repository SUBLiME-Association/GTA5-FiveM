fx_version 'cerulean'
games { 'gta5' };

author 'SUP2Ak / COSSART'
description 'script weather + time'
version 'init v0'


ui_page "ui/index.html"

files {
  "ui/index.html",
  "ui/style.css",
  "ui/img/**/*.svg",
  "ui/app.js",
}

--server_scripts {}

client_scripts {
  "client/script.js"
}

server_scripts {
  --"server/script.js"
}
