
fun! plug_config#edit#EditConfig(plug)
    let path = plug_config#path#ConfigPath(a:plug)
    call mkdir(g:plug_config_dir, "p")
    exec g:plug_config_edit_command . " " . path
endfun

