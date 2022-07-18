" General settings
set number
set tabstop=2
set shiftwidth=2
set expandtab
set encoding=utf-8

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

function! PackInit() abort
  packadd minpac
  call minpac#init()

  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('junegunn/fzf')
  call minpac#add('tpope/vim-dispatch')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('NLKNguyen/papercolor-theme')
  call minpac#add('fatih/vim-go')
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('preservim/nerdtree')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

" FZF
nnoremap <C-p> :<C-u>FZF<CR>

" Esc to exit from terminal
tnoremap <Esc> <C-\><C-n>

" Colorscheme
colorscheme PaperColor

" Dispatch setup 
autocmd FileType java let b:dispatch = 'javac %'

" vim-test setup
let test#strategy = "dispatch"
let test#java#runner = 'maventest'

" Easy window focus change
nnoremap <M-h> <c-w>h
nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
nnoremap <M-l> <c-w>l
if has('nvim')
  " For terminal mode
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l
  tnoremap <leader><c-r> <c-\><c-n>pa
endif

" Close buffer without closing its window 
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd!<CR>

" Mappings for Go
autocmd FileType go nnoremap <buffer> <leader>gc :GoCallers<CR>
