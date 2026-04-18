"
" General behaviour
"
set nocompatible        " must be on top
set mouse=              " disable mouse
set showcmd             " display vim commands at the bottom
set encoding=utf-8

" Always use english language in vim application
language messages C.UTF-8

if has("win32")
  " Requires the font `Hack` from https://sourcefoundry.org/hack/
  set guifont=Hack:h12

  " Remove toolbar and menubar
  set guioptions-=T
  set guioptions-=m

  " Make backspace behave normally
  set backspace=2

  if has("directx")
    set renderoptions=type:directx
  endif

  " Use powershell instead of cmd as the shell
  set shell=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
  set shellcmdflag=-ExecutionPolicy\ Unrestricted\ -NoProfile\ -Command
endif

" Searching
set hlsearch    " highlight all matches
set incsearch   " search as you type
set ignorecase  " ignore case in search patterns
set smartcase   " ...unless the pattern has capital letters


"
" Statusline
"
set laststatus=2  " more visible status bar
set wildmenu      " better tab completion in status bar

" Display git branch in lightline status line
let g:lightline = {
    \   'active': {
    \     'left': [
    \       [ 'mode', 'paste' ],
    \       [ 'gitbranch', 'readonly', 'relativepath', 'modified' ]
    \     ]
    \   },
    \   'component_function': {
    \     'gitbranch': 'FugitiveHead'
    \   },
    \ }


"
" Color settings
"

" These are needed for true color support in terminals other than xterm when
" using `termguicolors`. A notable example is tmux terminals.
" See `:help xterm-true-color` for more information.
function AddTcOptions()
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endfunction

if &term ==# "screen-256color"
  call AddTcOptions()

  " Ensure AddTcOptions() are ran again if a plugin messes with the terminal. This
  " is the case with vim-gnupg, which is why you get no colors in tmux terminals
  " without this workaround when editing gpg files.
  autocmd TermChanged * call AddTcOptions()
endif

if &t_Co == 256 || has("gui_running")
  if &term != "rxvt-unicode-256color"
    set termguicolors
  endif
endif

let g:lightline.colorscheme = 'solarized'

"
" Formatting and display
"
filetype plugin indent on
syntax on
set background=dark

" Text width
"set textwidth=79
"set nowrap         " do not wrap long lines when displayed
"set colorcolumn=+1 " display indicator line at textwidth + 1

" Defaults for tabs and indentation
set expandtab      " use spaces for tabs by default
set shiftwidth=4
set tabstop=4
set softtabstop=-1

" Make tabs, trailing and non-breaking spaces, and line continuations visible
set list
set listchars=tab:▸\ ,extends:»,precedes:«,trail:·,nbsp:·

" Change default splitbehaviour
set splitbelow splitright

"
" Core UX improvements
"
set number              " show absolute line numbers
set relativenumber      " ...and relative numbers (great for motions)
set cursorline          " highlight current line

set scrolloff=3         " keep at least 3 lines above/below cursor
set sidescrolloff=5     " minimal context when scrolling sideways

set hidden              " allow unsaved buffers in background
set confirm             " ask instead of failing on :q / :wq

set clipboard=unnamedplus   " use system clipboard (if supported)

set showmatch           " highlight matching bracket
set matchtime=2         " how long to show the match (in tenths of a second)

"
" Small QoL mappings
"
" Save with Ctrl-s
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>
vnoremap <C-s> <C-c>:w<CR>

" Quit with Ctrl-q
nnoremap <C-q> :q<CR>

