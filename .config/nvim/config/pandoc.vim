"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Pandoc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pandoc#folding#fold_yaml = 1
let g:pandoc#folding#fold_fenced_codeblocks = 1
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#folding#mode = ["syntax"]
let g:pandoc#modules#enabled = ["formatting", "folding", "toc"]
let g:pandoc#formatting#mode = "h"

syn region pandocEmphasis matchgroup=Operator start=/\(\_^\|\s\)\@<=\*\S\@=/ end=/\S\@<=\*\(\s\|\_$\)\@=/ contains=@Spell concealends
syn region pandocEmphasis matchgroup=Operator start=/\(\_^\|\s\)\@<=_\S\@=/ end=/\S\@<=_\(\s\|\_$\)\@=/ contains=@Spell concealends
