
fun! plug_config#load#LoadSingleConfig(plug)
    let path = plug_config#path#ConfigPath(a:plug)
    if filereadable(path)
        exec "source " . path
    endif
endfun

fun! plug_config#load#LoadPlugConfigs()
    for plug in g:plugs_order
        call plug_config#load#LoadSingleConfig(plug)
    endfor
endfun
