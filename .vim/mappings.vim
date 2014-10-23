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
let maplocalleader = "\\"



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







" End of mappings.vim