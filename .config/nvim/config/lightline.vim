"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The lightline.vim theme
let g:lightline = {
	\ 'colorscheme': 'darcula',
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\ 			  [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
	\ }

" Always show statusline
set laststatus=2
