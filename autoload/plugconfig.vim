vim9script

def ConfigPath(plug: string): string
    var filename: string
    if plug =~ "\.vim$"
        filename = plug
    else
        filename = plug .. ".vim"
    endif
        
    return resolve(g:plug_config_dir .. "/" .. filename)
enddef

const pluglist = g:plugs_order->deepcopy()->reverse()

def Plugins(): list<string>
    return pluglist
enddef

export def PlugList(A: string = "", L: string = "", P: number = 0): string
  var plugins = join(Plugins(), "\n")
  return plugins
enddef

export def EditConfig(plug: string)
    var path = ConfigPath(plug)
    exec g:plug_config_edit_command .. " " .. path
enddef

export def LoadConfig(plug: string)
    var path = ConfigPath(plug)
    if filereadable(path)
        exec "source " .. path
    endif
enddef

export def LoadConfigAll()
    var plug_list = Plugins()
    for plug in plug_list
        LoadConfig(plug)
    endfor
enddef

export def FZFPlugConfig()
    var list = Plugins()
    g:fzf#run(g:fzf#wrap({source: list, sink: 'PlugConfig', options: '--multi'}))
enddef

