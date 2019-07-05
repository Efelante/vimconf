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

set listchars=tab:>-

" Mappings

" Delete preprocessor directives that are used to comment a block of code
" (#if 1, #endif)

nmap <F2> %dd<C-O>dd

" Delete a block of code commented out using preprocessor directives
" (#if 1, #endif)

nmap <F3> d%

" Enable/disable whitespace characters visibility

nmap <F5> :set list!<CR>
noremap <F5>:set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>
" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

" Plugin section
call plug#begin('~/.vim/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'scrooloose/nerdtree'
	Plug 'tpope/vim-fugitive'
call plug#end()
