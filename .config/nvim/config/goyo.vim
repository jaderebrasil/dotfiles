"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Goyo + Limelight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Maps for Markdown
nnoremap <Leader>tg :Goyo<CR>
nnoremap <Leader>tl :Limelight!!<CR>

" Defing md as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

"" Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

"" Goyo
let g:goyo_width  = "75%"
let g:goyo_height = "94%"

"" Gruvbox
let g:gruvbox_contrast_dark='soft'

function! s:markdown_room(on)
    echom "Markdown Room: " . a:on
    if a:on
        "set spell
        "set background=light
        colo gruvbox
    else
        "set nospell
        "set background=dark
        colo default
    endif
endfunction

function! s:goyo_before()
    "let is_markdown = &filetype == "markdown" || &filetype == "rst" || &filetype == "text"
    call s:markdown_room(1)

    " :q close Goyo
    let b:quitting = 0
    autocmd QuitPre <buffer> let b:quitting = 1
endfunction

function! s:goyo_after()
    call s:markdown_room(0)

    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        qa
    endif
endfunction

let g:goyo_callbacks = [ function('s:goyo_before'), function('s:goyo_after') ]
