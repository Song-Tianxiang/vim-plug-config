
" substitute without E486
fun! s:Substitute(expr, pat, sub, flags)
    try
        return substitute(a:expr, a:pat, a:sub, a:flags)
    catch /E486/
        return expr
    endtry
endfun

fun! s:GetContent(plug, path, comment)
    if filereadable(a:path)
        let result = split(s:Substitute(g:plug_config_all_header, "\{plug\}", a:plug, "g"), "\n")
        let result = map(result, 'a:comment . v:val')
        let result += [""] + readfile(a:path) + [""]
        return result
    else
        return []
    endif
endfun

fun! plug_config#all#ShowAll()
    let content = []
    for plug in g:plugs_order
        let content += s:GetContent(plug, plug_config#path#ConfigPath(plug), '" ')
    endfor

    if len(Content)
        exec g:plug_config_edit_command . " plug-configs.vim"
        set buftype=nofile
        " use [:-2] to remove the last blank line
        call setline(1, content[:-2])
    endif

endfun
