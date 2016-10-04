" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

execute pathogen#infect()

syntax enable
set background=dark
colorscheme solarized

" Jump to the last cursor position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Tabs, indentation and lines
filetype plugin indent on
" 4 spaces please
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smartindent
" No line-wrapping
set nowrap


" Interactions

" Start scrolling slightly before the cursor reaches an edge
set scrolloff=3
set sidescrolloff=5
" Scroll sideways a character at a time, rather than a screen at a time
set sidescroll=1
" Allow motions and back-spacing over line-endings etc
set backspace=indent,eol,start
set whichwrap=h,l,b,<,>,~,[,]
" Underscores denote words
set iskeyword-=_

" Visual decorations

" Show status line
set laststatus=2
" Show what mode you’re currently in
set showmode
" Show what commands you’re typing
set showcmd
" Allow modelines
set modeline
" Show current line and column position in file
set ruler
" Show file title in terminal tab
set title
" Set relative line numbers if we can...
if exists("+relativenumber")
    " Due to a problem with relative line numbers not persisting across new
    " tabs and splits, set no line numbers at all...
    set nonumber
    " ..then set relative ones.
    set relativenumber
" ...otherwise let’s just have regular ones.
else
    set number
endif
" Limit line-length to 77 columns by highlighting col 78 onward
if exists("+colorcolumn")
    set colorcolumn=78
endif
" Highlight current line
set cursorline
" Don’t keep results highlighted after searching...
set nohlsearch
" ...just highlight as we type
set incsearch
" Ignore case when searching...
set ignorecase
" ...except if we input a capital letter
set smartcase



" https://github.com/mathiasbynens/dotfiles/blob/master/.vimrc

" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·
set list

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>


" strip trailing spaes on save
let blacklist = ['markdown']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :call StripWhitespace()


" file browser view
let g:netrw_liststyle=3

" markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"au BufRead,BufNewFile *.md setlocal textwidth=78
autocmd Filetype markdown setlocal wrap
autocmd Filetype markdown setlocal linebreak
autocmd Filetype markdown setlocal nolist
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'js=javascript']

autocmd Filetype json setlocal tabstop=2
autocmd Filetype css setlocal tabstop=2
autocmd Filetype scss setlocal tabstop=2
autocmd Filetype html setlocal tabstop=2

" emmet shortcut
let g:user_emmet_leader_key='<C-E>'

" commentary
autocmd FileType javascript setlocal commentstring=//\ %s

" syntastic plugin
" set statusline =%#warningmsg#
" set statusline =%{SyntasticStatuslineFlag()}
" set statusline =%*
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" set statusline =%#warningmsg#
" set statusline =%{SyntasticStatuslineFlag()}
" set statusline =%*
" let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_error_symbol = '>'
" let g:syntastic_style_error_symbol = '⁉️'
" let g:syntastic_warning_symbol = '⚠️'
" let g:syntastic_style_warning_symbol = '💩 '
" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn
