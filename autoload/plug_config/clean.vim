
fun! s:IsFileEmpty(path)
    return join(readfile(a:path)) == ""
endfun

fun! plug_config#clean#Clean()
    let deleteList = []
    let list = split(glob(g:plug_config_dir . "/*.vim"))
    for path in list 
        let base = fnamemodify(path, ":t:r")
        if !has_key(g:plugs, base) || s:IsFileEmpty(path)
            let deleteList += [path]
        endif
    endfor
    if len(deleteList) && confirm("Delete the following files?\n\n" . join(deleteList, "\n") . "\n", "&Yes\n&No", 2) == 1
        for path in deleteList
            call delete(path)
        endfor
    endif
endfun

