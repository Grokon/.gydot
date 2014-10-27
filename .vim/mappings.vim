"##############################################################"
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker :
"
" GY Vim Configuration
"
" Grok Yon
"
" This is the personal Vim configuration of Grok Yon.
"
" File: mappings.vim
"
"##############################################################"


" Key Reference Table {

    "<BS>           Backspace
    "<Tab>          Tab
    "<CR>           Enter
    "<Enter>        Enter
    "<Return>       Enter
    "<Esc>          Escape
    "<Space>        Space
    "<Up>           Up arrow
    "<Down>         Down arrow
    "<Left>         Left arrow
    "<Right>        Right arrow
    "<F1> - <F12>   Function keys 1 to 12
    "#1, #2..#9,#0  Function keys F1 to F9, F10
    "<Insert>       Insert
    "<Del>          Delete
    "<Home>         Home
    "<End>          End
    "<PageUp>       page-up
    "<PageDown>     page-down

" }


" Leader
let mapleader = ","
let maplocalleader = '_'



" НАСТРОЙКИ ПЕРЕКЛЮЧЕНИЯ РАСКЛАДОК КЛАВИАТУРЫ
set keymap=russian-jcukenwin 							" настраиваем переключение раскладок клавиатуры по <C-^>
set iminsert=0											" по умолчанию латинская раскладка
set imsearch=0											" по умолчанию поиск латиницей
function! MyKeyMapHighlight()
   if &iminsert == 0 									" при английской раскладке статусная строка текущего окна будет серого цвета
      hi StatusLine ctermfg=Black guifg=Black
   else 												" а при русской - красного.
      hi StatusLine ctermfg=DarkRed guifg=DarkRed
   endif
endfunction
call MyKeyMapHighlight() 								" при старте Vim устанавливать цвет статусной строки
autocmd WinEnter * :call MyKeyMapHighlight() 			" при смене окна обновлять информацию о раскладках
" использовать Ctrl+F для переключения раскладок
cmap <silent> <C-F> <C-^>
imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv




" Easier moving of code blocks
vnoremap < <gv 					" Shift+> keys
vnoremap > >gv 					" Shift+< keys



" CTRL-Z is Undo
noremap <C-z> u
inoremap <C-z> <C-O>u

" CTRL-Y is Redo
noremap <C-y> <C-R>
inoremap <C-y> <C-O><C-R>

" CTRL-A is Select all
noremap <C-a> gggH<C-O>G
inoremap <C-a> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-a> <C-C>gggH<C-O>G
onoremap <C-a> <C-C>gggH<C-O>G
snoremap <C-a> <C-C>gggH<C-O>G
xnoremap <C-a> <C-C>ggVG


" CTRL-S is Quicksave command
noremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>


" CTRL-O is Quickopen file
noremap <C-o> :browse confirm e<CR>
vnoremap <C-o> :browse confirm e<CR>
inoremap <C-o> :browse confirm e<CR>


" CTRL-W is Quicksave as.. file
noremap <C-w> :browse confirm saveas<CR>
vnoremap <C-w> :browse confirm saveas<CR>
inoremap <C-w> :browse confirm saveas<CR>



" Activate autocomplete at <Ctrl+Space>
inoremap <C-space> <C-x><C-o>



" End of mappings.vim