
fun! plug_config#path#ConfigPath(plug)
    return resolve(g:plug_config_dir . "/" . a:plug . ".vim")
endfun

