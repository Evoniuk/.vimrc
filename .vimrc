if v:progname =~? "evim"
  finish
endif

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
 
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" enable italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
 
" relative numbering by default, absolute numbering 
" when window loses focus or in insert mode
set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" enable line number in file explorer
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
 
syntax on
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
 
set background=dark
colorscheme newelf
 
set ts=4 sw=4

" STATUSLINE STUFF

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" put current git branch on statusline
set statusline=
set statusline+=%#MatchParen#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#

" put file name with modification status
set statusline+=%#StatusLine#
set statusline+=\ %f
set statusline+=%m\ 

" put current column and hex value of current char
set statusline+=%=
set statusline+=\ %c\ \|\ %B\ 

" put total lines and encoding
set statusline+=%#MatchParen#
set statusline+=\ %L\ \| 
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ 

set laststatus=2

" MAPPINGS

:nmap <Bslash><Bslash> :w<Return>
:nmap <bar><bar> :wq<Return>

:map Y y$

" use j and k to traverse displayed lines (e.g. when lines wrap)
:nmap j gj
:nmap k gk

:nmap <C-o> o<Esc>k

":map ;' $
":map '; 0
":map ;. G
":map .; gg
":nmap .. <C-f>
":nmap ;; <C-b>

":nmap ,. i
":imap ., <Esc>
