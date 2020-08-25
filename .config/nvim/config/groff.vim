autocmd BufRead,BufNewFile *.man set filetype=groff
autocmd BufRead,BufNewFile *.mom set filetype=groff

autocmd BufRead,BufNewFile *.man let s:groof_macro="man"
autocmd BufRead,BufNewFile *.mom let s:groof_macro="mom"


function! GroffZathura()
	if s:groof_macro == "man"
        execute "silent !zathura " . bufname('%') . ".pdf&"
	elseif s:groof_macro == "mom"
		execute "silent !zathura " . bufname('%') . ".ps&"
	endif
endfunction

function! GroffCompile()
	if s:groof_macro == "man"
		execute "silent !groff -Tpdf -k -man " . bufname('%') . " > " . bufname('%') . ".pdf"
	elseif s:groof_macro == "mom"
		execute "silent !groff -k -mom " . bufname('%') . " > " . bufname('%') . ".ps"
	endif
endfunction

function! GroffClean()
	if s:groof_macro == "man"
        execute "silent !rm " . bufname('%') . ".pdf"
	elseif s:groof_macro == "mom"
		execute "silent !rm " . bufname('%') . ".ps"
	endif
endfunction

" groff -man
autocmd BufRead *.man :call GroffCompile()
autocmd BufWritePost *.man :call GroffCompile()
autocmd VimLeave *.man :call GroffClean()

" groff -mom
autocmd BufRead *.mom :call GroffCompile()
autocmd BufWritePost *.mom :call GroffCompile()
autocmd VimLeave *.mom :call GroffClean()


" Opens zathura
"<CR> is needed only for maps not for commands
au Filetype groff nmap <localleader>lv :call GroffZathura()<CR>




	" silent :%s/\*\*\([^\*]\)\*\*/\\fB\1\\fR/g
	" silent :%s/\*\([^\*]\+\)\*/\\fI\1\\fR/g
	" silent :%s/^# \([^#]\+\)/.HEADING 1 "\\\*[headcolor]\1"/g
	" silent :%s/^## \([^#]\+\)/.HEADING 2 "\\\*[headcolor]\1"/g
	" silent :%s/^#### \([^#]\+\)/.HEADING 4 "\\\*[headcolor]\1"/g
	" silent :%s/^### \([^#]\+\)/.HEADING 3 "\\\*[headcolor]\1"/g
