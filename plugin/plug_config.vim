vim9script noclear

if exists("g:loaded_vim_plug_config")
    finish
endif
g:loaded_vim_plug_config = true

if !exists("g:plugs")
    finish
endif

import autoload "plugconfig.vim"

extend(g:, {
    plug_config_autoload: true,
    plug_config_edit_command: "tabnew",
    plug_config_dir: expand("~/.vim/plug-config"),
    plug_config_fzf: false,
}, 'keep')

if !isdirectory(g:plug_config_dir->expand())
    mkdir(g:plug_config_dir->expand(), "p")
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

if g:plug_config_fzf && !exists(":FZFPlugConfig")
    command FZFPlugConfig plugconfig.FZFPlugConfig()
endif

if g:plug_config_autoload
    plugconfig.LoadConfigAll()
endif

