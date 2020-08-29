" Gruvbox

" Important!!
if has('termguicolors')
  set termguicolors
endif

" For dark version.
set background=dark

" " Set contrast.
" " This configuration option should be placed before `colorscheme gruvbox-material`.
" " Available values: 'hard', 'medium'(default), 'soft'
" let g:gruvbox_material_background = 'soft'

" colorscheme gruvbox-material

let g:gruvbox_contrast_dark = "medium"
let g:gruvbox_contrast_light = "hard"
let g:gruvbox_invert_selection = 0

colo gruvbox
