vim9script noclear

if exists("g:loaded_vim_plug_config")
    finish
endif
g:loaded_vim_plug_config = 1

if !exists("g:plugs")
    finish
endif

import autoload "plugconfig.vim"

def Default(options: dict<any>)
    for [opt, val] in items(options)
        if !exists(opt)
            execute  opt .. $" = '{val}'"
        endif
    endfor
enddef

Default({
    "g:plug_config_autoload": 1,
    "g:plug_config_dir": expand("~/.vim/config"),
    "g:plug_config_edit_command": "edit",
})

if !isdirectory(g:plug_config_dir)
    mkdir(g:plug_config_dir, "p")
endif

if !exists(":PlugConfig")
    command -nargs=1 -complete=custom,plugconfig.PlugList
                \ PlugConfig plugconfig.EditConfig(<q-args>)
endif

if !exists(":PlugLoad")
    command -nargs=1 -complete=custom,plugconfig.PlugList
                \ PlugLoad plugconfig.LoadConfig(<q-args>)
endif

if !exists(":PlugLoadAll")
    command PlugLoadAll plugconfig.LoadConfigAll()
endif

if str2nr(g:plug_config_autoload)
    plugconfig.LoadConfigAll()
endif
