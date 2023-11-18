
if exists("g:vim_plug_config_defined")
    finish
endif
let g:vim_plug_config_defined = 1

if !exists("g:plugs")
    finish
endif

fun! s:SetDefault(variable, default)
    if !exists(a:variable)
        let {a:variable} = a:default
    endif
endf

call s:SetDefault("g:plug_config_autoload", 1)
call s:SetDefault("g:plug_config_dir", expand("~/.vim") . "/plug-config")
call s:SetDefault("g:plug_config_edit_command", "edit")
call s:SetDefault("g:plug_config_all_header", 'Configs for plug: {plug}')

function! s:ListPlugins(ArgLead, CmdLine, CursorPos)
  let plugins = join(g:plugs_order, "\n")
  return plugins
endfunction

command! -nargs=1 -bar -complete=custom,s:ListPlugins  PlugConfigEdit call plug_config#edit#EditConfig("<args>")
command! -nargs=1 -bar -complete=custom,s:ListPlugins PlugConfigLoad call plug_config#load#LoadSingleConfig("<args>")
command! -nargs=0 -bar PlugConfigLoadAll call plug_config#load#LoadPlugConfigs()
command! -nargs=0 -bar PlugConfigAll call plug_config#all#ShowAll()
command! -nargs=0 -bar PlugConfigClean call plug_config#clean#Clean()

if g:plug_config_autoload
    PlugConfigLoadAll
endif
