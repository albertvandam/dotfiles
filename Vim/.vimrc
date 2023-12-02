set gfn=Fira\ Code:h14,Menlo:h14

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Column set to column 100
set colorcolumn=100

" Column color set to grey
highlight ColorColumn ctermbg=1

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" Show the mode you are on the last line.
set showmode

" Set to show line numbers
set number
  
set t_Co=256
set mouse=a
  
" Enable syntax highlighting
syntax on

" Escape on kj keybinding
:imap kj <Esc>

" Set how many lines of history VIM should remember
set history=500

" :W sudo saves the file
command W w !sudo tee % > /dev/null

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Always show current position
set ruler
" Heigh of command bar
set cmdheight=2

"A buffer becomes hidden when it is abandoned
set hid

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
" If a pattern contains an uppercase letter, it is case sensitive.
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
" Highlight possible results when typing
set incsearch

" Show matching brackets when text indicator is over them
set showmatch 

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Always show the status line
set laststatus=2

 
" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfunction

if v:version < 802
    packadd! dracula
endif
syntax enable
colorscheme dracula
