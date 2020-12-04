"
"		  _ ____
"		 | |  _ \				  Jader Brasil <___________@gmail.com>
"		 | | |_) |						 nvim configuration file
"	 _	 | |  _ <
"	| |__| | |_) |
"	 \____/|____/
"
"
" $ figlet JB -f big
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vim Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
	if !executable("curl")
		echoerr "You have to install curl or vim-plug yourself."
		execute q!
	endif

	echo "Installing vim-plug...\n"
	silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

	autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Basic Packages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'itchyny/lightline.vim'						" Lightline statusbar

" File management
Plug 'vifm/vifm.vim'								" Vifm
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'		" Highligh Nerdtree
Plug 'ryanoasis/vim-devicons'						" Icons for Nerdtree

" Productivity
" Plug 'jreybert/vimagit'								" git
Plug 'tpope/vim-fugitive'
" Plug 'w0rp/ale'									  " Asynchronous Lint Engine
Plug 'SirVer/ultisnips'								" Snippets
Plug 'honza/vim-snippets'							" Snippets
Plug 'ap/vim-css-color'								" Color highligh
Plug 'jceb/vim-orgmode'

" Other
Plug 'tpope/vim-commentary'							" comment utils(gcc)
Plug 'vim-scripts/grep.vim'							" grep integration
"Plug 'vim-scripts/CSApprox'						" themes support
"Plug 'Yggdroot/indentLine'							" auto indentation
Plug 'sheerun/vim-polyglot'							" prog lang pack

" Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'								" fzf integration

Plug 'vimwiki/vimwiki'								" My wiki

"Plug 'Shougo/vimproc.vim', {'do' : 'make'}			" Asynchronous Exec Lib

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Specific Packages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lang
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}  " go
Plug 'PotatoesMaster/i3-vim-syntax'				   " i3 config
Plug 'kovetskiy/sxhkd-vim'						   " sxhkd
Plug 'neovimhaskell/haskell-vim'

" Plug 'racer-rust/vim-racer'						 " rust
Plug 'rust-lang/rust.vim'						   " rust

" write markdown
Plug 'junegunn/goyo.vim'						   " Distraction-free viewing
Plug 'junegunn/limelight.vim'					   " Hyperfocus on a range
Plug 'junegunn/vim-emoji'						   " Vim needs emojis!
Plug 'vim-pandoc/vim-pandoc'					   " Pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'				   " Pandoc Syntax

" Color schemes
" Plug 'tomasr/molokai'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'

" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
"	  " Sources: https://github.com/ncm2/ncm2/wiki
"	  Plug 'ncm2/ncm2-bufword'
"	  Plug 'ncm2/ncm2-path'
"	  Plug 'ncm2/ncm2-racer'
"	  Plug 'ncm2/ncm2-go'
"	  Plug 'ncm2/ncm2-match-highlight'

"	  Plug 'ncm2/ncm2-ultisnips'

" latex
Plug 'lervag/vimtex'

call plug#end()


" Required:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" 'list'
set showbreak=﬋\
set listchars=tab:»\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

"" Tabs.
set tabstop=4
set softtabstop=0
set shiftwidth=4
set noexpandtab

"" Map leader to ,
let mapleader=' '
let maplocalleader = "\\"

"" Searching
set nohlsearch
set ignorecase
set smartcase

"" Shell
set fileformats=unix,mac
if exists('$SHELL')
	set shell=$SHELL
else
	set shell=/bin/sh
endif

"" Other
set clipboard=unnamed,unnamedplus
set number relativenumber

set mouse=a
set go=a "guioptions
set nocompatible

" Conceal cursor
set concealcursor=c

set wildmode=longest,list,full " autocompletion

" Disable automatic commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Extra Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
for f in split(glob('~/.config/nvim/config/[^#]*.vim'), '\n')
	exe 'source' f
endfor

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General Mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Copy/Paste/Cut
noremap YY "+y<CR>
noremap <Leader>p "+gP<CR>
noremap XX "+x<CR>

"" Terminal
nnoremap <silent> <leader>sh :terminal<CR>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <C-S-t> :tabnew<CR>
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<Space>
nnoremap tm  :tabm<Space>
nnoremap tq  :tabclose<CR>

"" Set working directory
nnoremap <Leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('*s:setupWrapping')
  function s:setupWrapping()
	set wrap
	set wm=2
	set textwidth=79
  endfunction
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Autocmd Rules
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END
set autoread

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" Retab automatically
" autocmd BufRead * :%retab!

autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
