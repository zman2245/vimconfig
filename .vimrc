filetype off
" pathogen! Vim plugin manager
" call pathogen#infect()
nnoremap ,m :w <BAR> !lessc % > %:t:r.css<CR><space>
" let mapleader = "\\"

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
" call add(g:pathogen_disabled, 'supertab')
 call add(g:pathogen_disabled, 'minibufexpl')
 call add(g:pathogen_disabled, 'ultisnips')
" call add(g:pathogen_disabled, 'ack')
 call add(g:pathogen_disabled, 'command-t')
 call add(g:pathogen_disabled, 'fugitive')
 call add(g:pathogen_disabled, 'git')
 call add(g:pathogen_disabled, 'gundo')
 call add(g:pathogen_disabled, 'makegreen')
 call add(g:pathogen_disabled, 'pep8')
 call add(g:pathogen_disabled, 'py.test')
 call add(g:pathogen_disabled, 'pydoc')
 call add(g:pathogen_disabled, 'surround')
" call add(g:pathogen_disabled, 'syntastic')
 call add(g:pathogen_disabled, 'vim-less')

call pathogen#infect()
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

set nu
set smartindent
syntax on
filetype on
filetype plugin indent on
set nocompatible

" avoid linux adding incremented tabs on copy-paste
" set paste //this messes with insert mode mappings

set showcmd
set nowrap
set tabstop=4
set ignorecase
set smartcase
colo desert
set history=1000
set viminfo='20,\"10000

set tags=tags;/

set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set smarttab

" mappings I like for split view
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-_> <C-w><C-_>

" mapping for nice pasting
set pastetoggle=<F10>
inoremap <C-v> <F10><C-r>+<F10>

" Ack file searching
nmap <leader>a <Esc>:Ack!

" turn on autocompletion
set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

autocmd Filetype gitcommit setlocal spell textwidth=72

" PHP-specific
au BufReadPost *.phpt set syntax=php

" Python-specific
let g:SuperTabDefaultCompletionType = "context"

" pydoc
set completeopt=menuone,longest,preview

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" Syntastic config
let g:syntastic_python_checkers=['pyflakes']

" Make vim recognize virtual env
" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
