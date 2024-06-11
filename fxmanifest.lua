fx_version 'cerulean'
game 'gta5'

name "Active Jobs"
description "Job system to check if someone is in a job or how many are in the job."
author "Schokifresse"
version "1"

shared_scripts {
	'config/config.lua',
	'@es_extended/imports.lua'
}

server_scripts {
	'server/main.lua'
}
