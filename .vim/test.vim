"##############################################################"
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker :
"
" GY Vim Configuration
"
" Grok Yon
"
" This is the personal Vim configuration of Grok Yon.
"
" File: test.vim
"
"##############################################################"



" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'




    set wrap                    " (no)wrap - динамический (не)перенос длинных строк
    set linebreak               " переносить целые слова
    set textwidth=80
    set formatoptions=qrn1j
    set colorcolumn=+1          " mark the ideal max text width





set modelines=0

set visualbell 				     " Use visual bell instead of beeping
set ttyfast



"set relativenumber



set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow				      " new window below for split


set autoread        			  " перечитывать изменённые файлы автоматически
set shiftround
set title				          " показывать имя буфера в заголовке терминала




set confirm                       " использовать диалоги вместо сообщений об ошибках



""    set background=light
""   if filereadable(expand("~/.vim/bundle/vim-colors/colors/solarized.vim"))
""        let g:solarized_termcolors=256
""        let g:solarized_termtrans=1
""        let g:solarized_contrast="normal"
""        let g:solarized_visibility="normal"
""        color solarized                     " Load a colorscheme
""    endif




" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" Save when losing focus
au FocusLost * :silent! wall

" Resize splits when the window is resized
au VimResized * :wincmd =



















		"source project specific config files
		runtime! projects/**/*.vim



 		"Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

        map <S-H> gT
        map <S-L> gt





" Status line setup {{{{

"statusline setup
set statusline =%#identifier#
set statusline+=[%t]    		" tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2				" всегда показывать строку состояния


"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction


"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

" }}}}
































        elseif count(g:vim_plugins, 'youcompleteme')
            Plugin 'Valloric/YouCompleteMe'
            Plugin 'SirVer/ultisnips'
            Plugin 'honza/vim-snippets'
            " youcompleteme settings {
            	et g:acp_enableAtStartup = 0

	            " enable completion from tags
	            let g:ycm_collect_identifiers_from_tags_files = 1

	            " remap Ultisnips for compatibility for YCM
	            let g:UltiSnipsExpandTrigger = '<C-j>'
	            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
	            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

	            " Enable omni completion.
	            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

	            " Haskell post write lint and check with ghcmod
	            " $ `cabal install ghcmod` if missing and ensure
	            " ~/.cabal/bin is in your $PATH.
	            if !executable("ghcmod")
	                autocmd BufWritePost *.hs GhcModCheckAndLintAsync
	            endif

	            " For snippet_complete marker.
	            if !exists("g:spf13_no_conceal")
	                if has('conceal')
	                    set conceallevel=2 concealcursor=i
	                endif
	            endif

	            " Disable the neosnippet preview candidate window
	            " When enabled, there can be too much visual noise
	            " especially when splits are used.
	            set completeopt-=preview
	        "}


        elseif count(g:vim_plugins, 'neocomplcache')
            Plugin 'Shougo/neocomplcache'
            Plugin 'Shougo/neosnippet'
	            " Use honza's snippets.
	            let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

	            " Enable neosnippet snipmate compatibility mode
	            let g:neosnippet#enable_snipmate_compatibility = 1

	            " For snippet_complete marker.
	            if !exists("g:spf13_no_conceal")
	                if has('conceal')
	                    set conceallevel=2 concealcursor=i
	                endif
	            endif

	            " Enable neosnippets when using go
	            let g:go_snippet_engine = "neosnippet"

	            " Disable the neosnippet preview candidate window
	            " When enabled, there can be too much visual noise
	            " especially when splits are used.
	            set completeopt-=preview

            Plugin 'Shougo/neosnippet-snippets'
            Plugin 'honza/vim-snippets'
            " Neocomplcache settings {----------------------------------------------------
	            let g:acp_enableAtStartup = 0
	            let g:neocomplcache_enable_at_startup = 1
	            let g:neocomplcache_enable_camel_case_completion = 1
	            let g:neocomplcache_enable_smart_case = 1
	            let g:neocomplcache_enable_underbar_completion = 1
	            let g:neocomplcache_enable_auto_delimiter = 1
	            let g:neocomplcache_max_list = 15
	            let g:neocomplcache_force_overwrite_completefunc = 1

	            " Define dictionary.
	            let g:neocomplcache_dictionary_filetype_lists = {
	                        \ 'default' : '',
	                        \ 'vimshell' : $HOME.'/.vimshell_hist',
	                        \ 'scheme' : $HOME.'/.gosh_completions'
	                        \ }

	            " Define keyword.
	            if !exists('g:neocomplcache_keyword_patterns')
	                let g:neocomplcache_keyword_patterns = {}
	            endif
	            let g:neocomplcache_keyword_patterns._ = '\h\w*'

	            " Plugin key-mappings {
	                " These two lines conflict with the default digraph mapping of <C-K>
	                imap <C-k> <Plug>(neosnippet_expand_or_jump)
	                smap <C-k> <Plug>(neosnippet_expand_or_jump)
	                if exists('g:spf13_noninvasive_completion')
	                    inoremap <CR> <CR>
	                    " <ESC> takes you out of insert mode
	                    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
	                    " <CR> accepts first, then sends the <CR>
	                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
	                    " <Down> and <Up> cycle like <Tab> and <S-Tab>
	                    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
	                    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
	                    " Jump up and down the list
	                    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
	                    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
	                else
	                    imap <silent><expr><C-k> neosnippet#expandable() ?
	                                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
	                                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
	                    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

	                    inoremap <expr><C-g> neocomplcache#undo_completion()
	                    inoremap <expr><C-l> neocomplcache#complete_common_string()
	                    "inoremap <expr><CR> neocomplcache#complete_common_string()

	                    function! CleverCr()
	                        if pumvisible()
	                            if neosnippet#expandable()
	                                let exp = "\<Plug>(neosnippet_expand)"
	                                return exp . neocomplcache#close_popup()
	                            else
	                                return neocomplcache#close_popup()
	                            endif
	                        else
	                            return "\<CR>"
	                        endif
	                    endfunction

	                    " <CR> close popup and save indent or expand snippet
	                    imap <expr> <CR> CleverCr()

	                    " <CR>: close popup
	                    " <s-CR>: close popup and save indent.
	                    inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
	                    "inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

	                    " <C-h>, <BS>: close popup and delete backword char.
	                    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	                    inoremap <expr><C-y> neocomplcache#close_popup()
	                endif
	                " <TAB>: completion.
	                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
	                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
	            " }

	            " Enable omni completion.
	            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

	            " Enable heavy omni completion.
	            if !exists('g:neocomplcache_omni_patterns')
	                let g:neocomplcache_omni_patterns = {}
	            endif
	            let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	            let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
	            let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	            let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
	            let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
	            let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'


            "}
        elseif count(g:vim_plugins, 'neocomplete')
            Plugin 'Shougo/neocomplete.vim.git'
            Plugin 'Shougo/neosnippet'
            Plugin 'Shougo/neosnippet-snippets'
	            " Use honza's snippets.
	            let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

	            " Enable neosnippet snipmate compatibility mode
	            let g:neosnippet#enable_snipmate_compatibility = 1

	            " For snippet_complete marker.
	            if !exists("g:spf13_no_conceal")
	                if has('conceal')
	                    set conceallevel=2 concealcursor=i
	                endif
	            endif

	            " Enable neosnippets when using go
	            let g:go_snippet_engine = "neosnippet"

	            " Disable the neosnippet preview candidate window
	            " When enabled, there can be too much visual noise
	            " especially when splits are used.
	            set completeopt-=preview
            Plugin 'honza/vim-snippets'
            " Neocomlpete settings {
	            let g:acp_enableAtStartup = 0
	            let g:neocomplete#enable_at_startup = 1
	            let g:neocomplete#enable_smart_case = 1
	            let g:neocomplete#enable_auto_delimiter = 1
	            let g:neocomplete#max_list = 15
	            let g:neocomplete#force_overwrite_completefunc = 1


	            " Define dictionary.
	            let g:neocomplete#sources#dictionary#dictionaries = {
	                        \ 'default' : '',
	                        \ 'vimshell' : $HOME.'/.vimshell_hist',
	                        \ 'scheme' : $HOME.'/.gosh_completions'
	                        \ }

	            " Define keyword.
	            if !exists('g:neocomplete#keyword_patterns')
	                let g:neocomplete#keyword_patterns = {}
	            endif
	            let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	            " Plugin key-mappings {
	                " These two lines conflict with the default digraph mapping of <C-K>
	                if !exists('g:spf13_no_neosnippet_expand')
	                    imap <C-k> <Plug>(neosnippet_expand_or_jump)
	                    smap <C-k> <Plug>(neosnippet_expand_or_jump)
	                endif
	                if exists('g:spf13_noninvasive_completion')
	                    inoremap <CR> <CR>
	                    " <ESC> takes you out of insert mode
	                    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
	                    " <CR> accepts first, then sends the <CR>
	                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
	                    " <Down> and <Up> cycle like <Tab> and <S-Tab>
	                    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
	                    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
	                    " Jump up and down the list
	                    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
	                    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
	                else
	                    " <C-k> Complete Snippet
	                    " <C-k> Jump to next snippet point
	                    imap <silent><expr><C-k> neosnippet#expandable() ?
	                                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
	                                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
	                    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

	                    inoremap <expr><C-g> neocomplete#undo_completion()
	                    inoremap <expr><C-l> neocomplete#complete_common_string()
	                    "inoremap <expr><CR> neocomplete#complete_common_string()

	                    " <CR>: close popup
	                    " <s-CR>: close popup and save indent.
	                    inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()"\<CR>" : "\<CR>"

	                    function! CleverCr()
	                        if pumvisible()
	                            if neosnippet#expandable()
	                                let exp = "\<Plug>(neosnippet_expand)"
	                                return exp . neocomplete#smart_close_popup()
	                            else
	                                return neocomplete#smart_close_popup()
	                            endif
	                        else
	                            return "\<CR>"
	                        endif
	                    endfunction

	                    " <CR> close popup and save indent or expand snippet
	                    imap <expr> <CR> CleverCr()
	                    " <C-h>, <BS>: close popup and delete backword char.
	                    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	                    inoremap <expr><C-y> neocomplete#smart_close_popup()
	                endif
	                " <TAB>: completion.
	                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
	                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

	                " Courtesy of Matteo Cavalleri

	                function! CleverTab()
	                    if pumvisible()
	                        return "\<C-n>"
	                    endif
	                    let substr = strpart(getline('.'), 0, col('.') - 1)
	                    let substr = matchstr(substr, '[^ \t]*$')
	                    if strlen(substr) == 0
	                        " nothing to match on empty string
	                        return "\<Tab>"
	                    else
	                        " existing text matching
	                        if neosnippet#expandable_or_jumpable()
	                            return "\<Plug>(neosnippet_expand_or_jump)"
	                        else
	                            return neocomplete#start_manual_complete()
	                        endif
	                    endif
	                endfunction

	                imap <expr> <Tab> CleverTab()
	            " }

	            " Enable heavy omni completion.
	            if !exists('g:neocomplete#sources#omni#input_patterns')
	                let g:neocomplete#sources#omni#input_patterns = {}
	            endif
	            let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	            let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
	            let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	            let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
	            let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

            "}-----------------------------------------------------------------------





" End of test.vim