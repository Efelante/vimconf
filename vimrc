set nu
syn on
 
set shiftwidth=4
set tabstop=4
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

" Set highlighting for the search results
set hlsearch

set fo=croq
ab com /*<CR>/<Up>
colorscheme desert

set pastetoggle=<F2>

set undofile " Keep undo history between sessions
set undodir=~/.vim/undodir " Don't forget to create this directory

set listchars=tab:>-

set textwidth=80
set backspace=2

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

" Set the Go to function definition hotkey
nmap <F12> :tab cs find g <C-r><C-w> <CR>

" Set the build hotkey
nmap <F7> :make<C-r><C-w> <CR>

" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
inoremap <C-k> <C-^>

nmap <C-s> O@step 

" if system('uname -r') =~ "microsoft"
" 	augroup Yank
" 		autocmd!
" 		autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
" 	augroup END
" endif


" Cscope settings
" Use cstag (fix Ctrl+} error (tag not found))
set cscopetag
cs add cscope.out

" vim-plug (plugin manager) autoinstall 
if empty(glob('~/.vim/autoload/plug.vim'))
	echo "Empty"
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin section
call plug#begin('~/.vim/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'scrooloose/nerdtree'
	Plug 'tpope/vim-fugitive'
call plug#end()

" Set hotkey for the NERDTree to open and close
map <F2> :NERDTreeToggle<CR>

if filereadable("vimrc")
	source vimrc
endif

function InsertLocalDefinitions()
	let @a=''
	g/\v^[a-zA-Z_\*]+ [a-zA-Z_0-9\(\, \*]*\)$/execute "normal A;\<Esc>\"Ayyx"
	execute "normal " "\<c-o>"
	execute "normal " "\"aP"
endfunction

function ExpandLine(lensize)
	let line = getline('.')
	let tabsize = &tabstop
	"let lensize = strlen(line)
	let sizereq = a:lensize
	if (a:lensize % tabsize)
		let sizereq = a:lensize + (tabsize - a:lensize % tabsize)
	endif
	let tabscount = (sizereq - strlen(line)) / tabsize
	if (((sizereq - strlen(line)) % tabsize) > 0)
		let tabscount = tabscount + 1
	endif 
	for i in range (0,tabscount - 1)
		let line = line . "\t"
	endfor
	let line = line . '|'
	call setline('.', line)
	" let @a=''
	" g/\v^[a-z_\*]+ [a-zA-Z_0-9\(\, \*]*\)$/execute "normal A;\<Esc>\"Ayyx"
	" execute "normal " "\<c-o>"
	" execute "normal " "\"aP"
endfunction

command InsertLocalDefinitions :call InsertLocalDefinitions()

" Clang-format integration
function! FormatOnSave()
  let l:formatdiff = 1
  py3f /usr/share/clang/clang-format-18/clang-format.py
endfunction
autocmd BufWritePre *.h,*.c,*.hpp,*.cc,*.cpp call FormatOnSave()
