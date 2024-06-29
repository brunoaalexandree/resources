fx_version "cerulean"

description "Basic React (TypeScript) & Lua Game Scripts Boilerplate"
author "Project Error"
version '1.0.0'
repository 'https://github.com/project-error/fivem-react-boilerplate-lua'

lua54 'yes'

games {
  "gta5",
  "rdr3"
}

client_scripts {
  "@vrp/lib/utils.lua",
  "client-side/*"
}

server_scripts {
  "@vrp/lib/utils.lua",
  "server-side/*"
}

files {
  'web/build/index.html',
  'web/build/**/*'
}

ui_page 'web/build/index.html'
