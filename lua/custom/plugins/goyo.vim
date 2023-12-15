function! s:goyo_enter()
    set linebreak
    set spell
endfunction


function! s:goyo_leave()
    set nolinebreak
    set nospell
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


