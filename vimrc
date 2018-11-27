set nu
syn on
 
set shiftwidth=8
set tabstop=8
set autoindent
" Replace tabs with spaces
"set expandtab
 
set statusline+=%F
set statusline+=\
set statusline+=%l[%L]/%v
set laststatus=2

highlight OverLength ctermbg=white ctermfg=black guibg=#592929
match OverLength /\%81v.\+/
set colorcolumn=81
highlight ColorColumn ctermbg=white

set fo=croq
ab com /*<CR>/<Up>
colorscheme desert

set pastetoggle=<F2>

set undofile " Keep undo history between sessions
set undodir=~/.vim/undodir " Don't forget to create this directory

" Mappings

" Delete preprocessor directives that are used to comment a block of code
" (#if 1, #endif)

nmap <F2> %dd<C-O>dd

" Delete a block of code commented out using preprocessor directives
" (#if 1, #endif)

nmap <F3> d%

