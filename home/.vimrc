" =========================
" Leader key (practical default)
" =========================

let mapleader=" "

" =========================
" Plugins and additions
" =========================

filetype plugin indent on

" =========================
" Basic editor behavior
" =========================

" Tabs defaults
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Filetype-specific overrides
augroup indentation_rules
  autocmd!
  
  " Bash / shell scripts → keep real tabs
  autocmd FileType sh,bash,zsh setlocal noexpandtab
  
  " Makefiles → must use real tabs
  autocmd FileType make setlocal noexpandtab softtabstop=0
  
augroup END

" IDE options
set number
set copyindent
set preserveindent

" Keep the cursor vertically centered when possible
set scrolloff=15

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

" Ensure quickfix window opens automatically
set errorformat=%f:%l:%c:\ %m
set errorformat+=%f:%l:\ %m

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
" Visuals
" =========================

" Tab visualization
set listchars=tab:▸\ ,trail:·,nbsp:⎵,extends:…,precedes:…,eol:↲

" Cursor line: subtle background
set cursorline
highlight CursorLine cterm=NONE ctermbg=236 guibg=#2a2a2a

" Cursor column: slightly different shade to distinguish
set cursorcolumn
highlight CursorColumn cterm=NONE ctermbg=235 guibg=#242424

" Special characters
highlight SpecialKey
      \ cterm=NONE
      \ ctermfg=250
      \ ctermbg=NONE
      \ guifg=#c0c0c0
      \ guibg=NONE

" Non-printable characters
highlight NonText
      \ cterm=NONE
      \ ctermfg=250
      \ ctermbg=NONE
      \ guifg=#c0c0c0
      \ guibg=NONE

" Reapply after colorscheme changes
augroup listchars_color
  autocmd!
  autocmd ColorScheme *
    \ highlight SpecialKey cterm=NONE ctermfg=250 guifg=#c0c0c0 |
    \ highlight NonText    cterm=NONE ctermfg=250 guifg=#c0c0c0
augroup END

" =========================
" Hotkeys (toggles)
" =========================

" Toggle line numbers (normal mode)
nnoremap <leader>n :set number!<CR>

" Toggle cursor line + column highlight (normal mode)
nnoremap <leader>c :set cursorline! cursorcolumn!<CR>

" Toggle special characters
nnoremap <leader>l :set list!<CR>

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

" Quickfix navigation shortcuts

" Next / previous quickfix item
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>

" First / last quickfix item
nnoremap <leader>qf :cfirst<CR>
nnoremap <leader>ql :clast<CR>

" Open / close quickfix window
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :cclose<CR>

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

" =========================
" Linters integration
" =========================

augroup yamllint_integration
  autocmd!
  " Only for YAML files
  autocmd FileType yaml nnoremap <buffer> <leader>y :call RunYamllint()<CR>
augroup END

function! RunYamllint()
  if !executable('yamllint')
    echo "yamllint not found in PATH"
    return
  endif
  silent cexpr system('yamllint -f parsable ' . shellescape(expand('%:p')))
  if len(getqflist()) > 0
    copen
  else
    echo "No yamllint issues"
  endif
endfunction
