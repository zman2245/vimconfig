call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nu
set smartindent
syntax on
filetype on
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

" turn on autocompletion
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

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" pathogen! Vim plugin manager
call pathogen#infect()
nnoremap ,m :w <BAR> !lessc % > %:t:r.css<CR><space>

" make tabs autocomplete 'smartly'
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_close_html = match(substr, "<\/") != -1 " position of '</', if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  " if (!has_period && !has_slash)
  "  return "\<C-X>\<C-P>"                         " existing text matching
  if ( !has_close_html && has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
