if v:progname =~? "evim"
  finish
endif
 
" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim
 
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif
 
if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif
 
" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!
 
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END
 
" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
 
" number lines
set number
 
" ThePrimeagean presets
 
syntax on
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
 
" set colorcolumn=80
 
" colorscheme gruvbox 
set background=dark
 
set ts=4 sw=4

" STATUSLINE STUFF:

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#MatchParen#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#

set statusline+=%#StatusLine#
set statusline+=\ %f
set statusline+=%m\ 

set statusline+=%=
set statusline+=\ %c\ \|\ %B\ 

set statusline+=%#MatchParen#
set statusline+=\ %L\ \| 
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ 

set laststatus=2

" MAPPINGS

:map wq :wq<Return>
:map ,. :q!<Return>
:map ,n :!node %<Return>
