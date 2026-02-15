" =========================
" Basic editor behavior
" =========================

" Enable mouse usage (all modes)
set mouse=a

" Tabs defaults
set tabstop=4
set softtabstop=0
set shiftwidth=4
set noexpandtab

" IDE options
set number
set copyindent
set preserveindent

" Keep the cursor vertically centered when possible
set scrolloff=10

" Show matching brackets
set showmatch

" Cursor line: subtle background
set cursorline
highlight CursorLine cterm=NONE ctermbg=236 guibg=#2a2a2a

" Cursor column: slightly different shade to distinguish
set cursorcolumn
highlight CursorColumn cterm=NONE ctermbg=235 guibg=#242424

" Highlight search matches
set hlsearch
set incsearch
highlight Search
      \ cterm=underline
      \ ctermfg=NONE
      \ ctermbg=238
      \ guifg=#000000
      \ guibg=#3a3a3a
highlight IncSearch
      \ cterm=underline
      \ ctermfg=NONE
      \ ctermbg=240
      \ guifg=#000000
      \ guibg=#444444

" =========================
" Syntax
" =========================

" Enable syntax highlighting
syntax on

" Replace tabs with spaces for Python files
augroup python_indentation
  autocmd!
  autocmd FileType python setlocal expandtab
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal softtabstop=4
augroup END

" =========================
" Leader key (practical default)
" =========================

let mapleader=" "

" =========================
" Hotkeys (toggles)
" =========================

" Toggle line numbers (normal mode)
nnoremap <leader>n :set number!<CR>

" Toggle cursor line + column highlight (normal mode)
nnoremap <leader>c :set cursorline! cursorcolumn!<CR>

" Open new horizontal window (split)
nnoremap <leader>w :split<CR>

" Open new vertical window (vsplit)
nnoremap <leader>v :vsplit<CR>

" Open directory browser (netrw) in current window
nnoremap <leader>e :Explore<CR>

" Optional: open directory browser in vertical split
" nnoremap <leader>E :Vexplore<CR>

" Switch to next window
nnoremap <leader><Tab> <C-w>w

" Clear search highlighting quickly
nnoremap <leader>/ :nohlsearch<CR>

" =========================
" Status line
" =========================

" Always show the status line
set laststatus=2

" Status line contents:
set statusline=
set statusline+=%F            " Full file path
set statusline+=\ \|\         " Separator
set statusline+=Line:%l         " Current line number
set statusline+=\ Column:%c      " Current column number

" Active status line
highlight StatusLine
      \ cterm=bold
      \ ctermfg=250
      \ ctermbg=238
      \ guifg=#d0d0d0
      \ guibg=#3a3a3a

" Inactive status line
highlight StatusLineNC
      \ cterm=NONE
      \ ctermfg=244
      \ ctermbg=235
      \ guifg=#909090
      \ guibg=#262626


" Reapply status line styling after colorscheme changes
augroup statusline_colors
  autocmd!
  autocmd ColorScheme *
        \ highlight StatusLine cterm=bold ctermfg=250 ctermbg=238 guifg=#d0d0d0 guibg=#3a3a3a |
        \ highlight StatusLineNC cterm=NONE ctermfg=244 ctermbg=235 guifg=#909090 guibg=#262626
augroup END

" =========================
" Restore last cursor position
" =========================

augroup restore_cursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
augroup END
