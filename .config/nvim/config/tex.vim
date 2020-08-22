""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" LaTeX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

autocmd BufRead,BufNewFile *.tex set filetype=tex

let g:tex_conceal = ""
let g:tex_flavor = "latex"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=c
endif
