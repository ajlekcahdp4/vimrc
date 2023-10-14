set tabstop=2
set softtabstop=2
set shiftwidth=2
set noexpandtab
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
let &path.="include,/usr/include/"
syntax on
filetype plugin indent on
set autoindent
set smartindent
set number
set showmatch
set comments=sl:/*,mb:\ *,elx:\ */
set cursorline 
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha


set autoindent expandtab tabstop=2 shiftwidth=2
set hlsearch
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

set rtp+=~/.vim/bundle/Vundle.vim

filetype plugin indent on

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'scrooloose/nerdtree'
" import .env file
Plugin 'tpope/vim-dotenv'
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe', { 'do': './install.py' }


" import .editorconfig file
Plugin 'editorconfig/editorconfig-vim'

" fast motions using f F like behavior
Plugin 'easymotion/vim-easymotion'

" tag outline 'preservim/tagbar'
Plugin 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" hotkey helper
Plugin 'liuchengxu/vim-which-key'

" enable fuzzy finder
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

" find project root
Plugin 'dbakker/vim-projectroot'

" comment/uncomment blocks and selections
Plugin 'preservim/nerdcommenter'

" more informative status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" sonokai full color scheme
Plugin 'sainnhe/sonokai'


call vundle#end()




" whichkey

let g:which_key_map = {}
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }
let g:which_key_map.b = { 'name' : '+buffers' }
let g:which_key_map.c = { 'name' : '+comment' }
let g:which_key_map.f = { 'name' : '+fzf' }
let g:which_key_map.t = { 'name' : '+tabs tags term' }
let g:which_key_map_visual = {}

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" color scheme setup
let g:sonokai_style = 'default'
let g:sonokai_better_performance = 1

let g:airline_theme='sonokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:sonokai_transparent_background = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_spell_foreground = 'colored'

" color scheme with enabled plugins
" colorscheme sonokai

" scheme fine tuning
hi Comment guifg=#707070 ctermfg=darkgray
hi Visual guifg=#333333 guibg=darkgray


" Commands and functions

" change current dir to project root on open
function! <SID>AutoProjectRootCD()
    try
      if &ft != 'help'
        ProjectRootCD
      endif
    catch
      " Silently ignore invalid buffers
    endtry
endfunction
autocmd BufEnter * call <SID>AutoProjectRootCD()

let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py"

function FormatBuffer()
	if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
		let cursor_pos = getpos('.')
		:%!clang-format
		call setpos('.', cursor_pos)
	endif
endfunction
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp, :call FormatBuffer()

