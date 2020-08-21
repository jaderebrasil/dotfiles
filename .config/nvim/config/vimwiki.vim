"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vim Wiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

let g:vimwiki_list = [{'path': '~/Documentos/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

autocmd BufEnter *.md :set concealcursor=cn

map <Leader>v :VimwikiIndex

" Use <TAB> to select the popup menu:
    inoremap <expr> <C-Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <C-S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" enable global highlighting
" let g:vimwiki_folding='expr'
let g:vimwiki_global_ext = 0

"au FileType vimwiki set filetype=vimwiki.markdown
