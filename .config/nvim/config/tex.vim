""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" LaTeX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

autocmd BufRead,BufNewFile *.tex set filetype=tex

let g:tex_conceal = ""
let g:tex_flavor = "latex"

let g:latex_view_general_viewer = 'zathura'

map <C-c><C-c> :VimtexCompile<CR>
map <C-c><C-v> :VimtexView<CR>
map <C-c>c     :VimtexClean<CR>

" For snippet_complete marker.
if has('conceal')
  set conceallevel=0 concealcursor=c
endif
