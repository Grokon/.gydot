"##############################################################"
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker :
"
" GY Vim Configuration
"
" Grok Yon
"
" This is the personal Vim configuration of Grok Yon.
"
" File: plugin.vim
"
"##############################################################"

set nocompatible

" Windows Compatible {
    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
    if has('win32') || has('win64')
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME
    else
        set shell=/bin/sh
    endif
" }

" Setup Bundle Support {

	filetype off                  								" Required by Vundle
	set rtp+=~/.vim/bundle/vundle 								" set the runtime path to include Vundle
	call vundle#begin()											" inicialize

" }

" Plugins (bundles) {

    " Deps {
        Plugin 'gmarik/vundle'									" required! let Vundle manage Vundle
        Plugin 'MarcWeber/vim-addon-mw-utils'
        Plugin 'tomtom/tlib_vim'
        if executable('ag')
            Plugin 'mileszs/ack.vim'
            let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
        elseif executable('ack-grep')
            let g:ackprg="ack-grep -H --nocolor --nogroup --column"
            Plugin 'mileszs/ack.vim'
        elseif executable('ack')
            Plugin 'mileszs/ack.vim'
        endif
    " }

    " list only the plugin groups you will use - указываем - какие плагины необходимо устанавливать.
    if !exists('g:vim_plugins')
        let g:vim_plugins=['general', 'programming', 'python', 'html', 'misc',]
    endif

    " General {
        if count(g:vim_plugins, 'general')
            Plugin 'scrooloose/nerdtree'						" навигация по файловой/директориям
            Plugin 'jistr/vim-nerdtree-tabs'					" NERDTree and tabs together in Vim
            Plugin 'tpope/vim-surround'							" provides mappings to easily delete, change and add such surroundings in pairs
            Plugin 'tpope/vim-repeat'							" need for surround
            Plugin 'kien/ctrlp.vim'								" Fuzzy file, buffer, mru, tag, etc finder.
            Plugin 'tacahiroy/ctrlp-funky'
            Plugin 'bling/vim-airline'							" Lean & mean status/tabline for vim - строка статуса/состояния
            Plugin 'bling/vim-bufferline'						" show the list of buffers in the command bar
            Plugin 'Lokaltog/vim-easymotion'					" EasyMotion — позволяет быстро прыгать по коду, используя визуальную индикацию
            Plugin 'flazz/vim-colorschemes'						" набор цветовых схем
            Plugin 'mbbill/undotree'							" Display your undo history in a graph.
            Plugin 'nathanaelkane/vim-indent-guides'			" visually displaying indent levels in code
            Plugin 'mhinz/vim-signify'							" Show a VCS diff using Vim's sign column
            Plugin 'osyo-manga/vim-over'						" substitute preview
            Plugin 'kana/vim-textobj-user'						" Create your own text objects
            Plugin 'kana/vim-textobj-indent'
            Plugin 'gcmt/wildfire.vim'							" Smart selection of the closest text object
			Plugin 'vim-scripts/sessionman.vim'					" Vim session manager

			Plugin 'mhinz/vim-startify'             			" Nice start screen
        endif
    " }


    " General Programming {
        if count(g:vim_plugins, 'programming')
            Plugin 'scrooloose/syntastic'						" Syntax checking hacks for vim
            Plugin 'tpope/vim-fugitive'							" Git wrapper
            Plugin 'mattn/gist-vim'								" vimscript for creating gists
            Plugin 'mattn/webapi-vim'							" vim interface to Web API
            Plugin 'scrooloose/nerdcommenter'					" Vim plugin for intensely commenting
            Plugin 'tpope/vim-commentary'						" comment stuff out
            Plugin 'godlygeek/tabular'							" text filtering and alignment
            if executable('ctags')
                Plugin 'majutsushi/tagbar'						" Class/module browser навигация по классам/функциям/переменным
            endif

            " Snippets
            Plugin 'garbas/vim-snipmate'						" Snippets manager
            	let g:snips_author = 'Grok Yon'
            Plugin 'honza/vim-snippets'							" snippets repo

        endif
    " }


    " PHP {
        if count(g:vim_plugins, 'php')
            Plugin 'vim/PIV'
            Plugin 'arnaud-lb/vim-php-namespace'
            Plugin 'beyondwords/vim-twig'
        endif
    " }

    " Python {
        if count(g:vim_plugins, 'python')
            Plugin 'klen/python-mode'								" Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box
			Plugin 'mitsuhiko/vim-python-combined'  				" Combined Python 2/3 for Vim
			Plugin 'davidhalter/jedi-vim' 							" Jedi-vim autocomplete plugin автодополнение для Python
            Plugin 'mitsuhiko/vim-jinja'							" Jinja support for vim
            Plugin 'hynek/vim-python-pep8-indent'   				" PEP8 indent
            Plugin 'vim-scripts/pythoncomplete'						" Pythoncomplete omni-completion script shipped with vim 7
        endif
    " }

    " Javascript {
        if count(g:vim_plugins, 'javascript')
            Plugin 'elzr/vim-json'
           	"JSON settings{
           	    nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        		let g:vim_json_syntax_conceal = 0
           	"}
            Plugin 'groenewege/vim-less'
            Plugin 'pangloss/vim-javascript'
            Plugin 'briancollins/vim-jst'
            Plugin 'kchmck/vim-coffee-script'
        endif
    " }

    " Haskell {
        if count(g:vim_plugins, 'haskell')
            Plugin 'travitch/hasksyn'
            Plugin 'dag/vim2hs'
            Plugin 'Twinside/vim-haskellConceal'
            Plugin 'Twinside/vim-haskellFold'
            Plugin 'lukerandall/haskellmode-vim'
            Plugin 'eagletmt/neco-ghc'
            Plugin 'eagletmt/ghcmod-vim'
            Plugin 'Shougo/vimproc'
            Plugin 'adinapoli/cumino'
            Plugin 'bitc/vim-hdevtools'
        endif
    " }

    " HTML {
        if count(g:vim_plugins, 'html')
            Plugin 'amirh/HTML-AutoCloseTag'
            Plugin 'hail2u/vim-css3-syntax'
            Plugin 'gorodinskiy/vim-coloresque'
            Plugin 'tpope/vim-haml'
			Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}			" Sparkup lets you write HTML code faster.
        endif
    " }

    " Ruby {
        if count(g:vim_plugins, 'ruby')
            Plugin 'tpope/vim-rails'
            	let g:rubycomplete_buffer_loading = 1
        endif
    " }

    " Puppet {
        if count(g:vim_plugins, 'puppet')
            Plugin 'rodjek/vim-puppet'
        endif
    " }

    " Go Lang {
        if count(g:vim_plugins, 'go')
            "Plugin 'Blackrush/vim-gocode'
            Plugin 'fatih/vim-go'
        endif
    " }

    " Lua {
        if count(g:vim_plugins, 'lua')
			Plugin 'xolox/vim-lua-ftplugin'						" Lua file type plug-in
			Plugin 'xolox/vim-misc'								" dependensis
        endif
    " }

    " Misc {
        if count(g:vim_plugins, 'misc')
            Plugin 'tpope/vim-markdown'							" Markdown runtime files
            Plugin 'greyblake/vim-preview'						" previewing markup files(markdown,rdoc,textile,html)
            Plugin 'cespare/vim-toml'
            Plugin 'saltstack/salt-vim'
        endif
    " }

" }




" All of your Plugins must be added before the following line
call vundle#end()             " required





" Plugins settings --------------------------------------------------------- {{{

	" General {
        " nerdtree settings{
            if isdirectory(expand("~/.vim/bundle/nerdtree"))
		        let NERDTreeShowBookmarks=1
		        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
		        let NERDTreeChDirMode=0
		        let NERDTreeQuitOnOpen=1
		        let NERDTreeMouseMode=2
		        let NERDTreeShowHidden=1
		        let NERDTreeKeepTreeInNewTab=1
		        let g:nerdtree_tabs_open_on_gui_startup=0
				let g:NERDTreeWinSize = 40
				let g:NERDShutUp=1

				"explorer mappings
				nnoremap <f1> :BufExplorer<cr>
				nnoremap <f2> :NERDTreeToggle<cr>
				map <C-e> <plug>NERDTreeTabsToggle<CR>
	            map <leader>e :NERDTreeFind<CR>
	            nmap <leader>nt :NERDTreeFind<CR>
	        endif
	    " }


        "CTRLP settings {
            if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
	            let g:ctrlp_working_path_mode = 'ra'
	            nnoremap <silent> <D-t> :CtrlP<CR>
	            nnoremap <silent> <D-r> :CtrlPMRU<CR>
	            let g:ctrlp_custom_ignore = {
	                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
	                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            	" On Windows use "dir" as fallback command.
            	if has('win16') || has('win32') || has('win64')
                	let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            	elseif executable('ag')
	                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
	            elseif executable('ack-grep')
	                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
	            elseif executable('ack')
	                let s:ctrlp_fallback = 'ack %s --nocolor -f'
	            else
	                let s:ctrlp_fallback = 'find %s -type f'
	            endif
	            let g:ctrlp_user_command = {
	                \ 'types': {
	                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
	                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
	                \ },
	                \ 'fallback': s:ctrlp_fallback
	            \ }
	        endif
	    "}

        " ctrlp-funky settings {
            if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
            	let g:ctrlp_extensions = ['funky']
                "funky
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            endif
        " }


        " Airline settings{
            if isdirectory(expand("~/.vim/bundle/vim-airline/"))
				let g:airline_theme='zenburn'
				let g:airline_powerline_fonts = 0
				let g:airline#extensions#tabline#enabled = 1
				let g:airline#extensions#tabline#formatter = 'unique_tail'

	            if !exists('g:airline_theme')
	                let g:airline_theme = 'solarized'
	            endif
	            if !exists('g:airline_powerline_fonts')
	                " Use the default set of separators with a few customizations
	                let g:airline_left_sep='›'  " Slightly fancier than '>'
	                let g:airline_right_sep='‹' " Slightly fancier than '<'
	            endif
	        endif
        "}

        " Undotree settings {
            if isdirectory(expand("~/.vim/bundle/undotree/"))
	            nnoremap <Leader>u :UndotreeToggle<CR>
	            " If undotree is opened, it is likely one wants to interact with it.
	            let g:undotree_SetFocusWhenToggle=1
	        endif
        "}

        " vim-indent-guides settings {
            if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
	            let g:indent_guides_start_level = 2
	            let g:indent_guides_guide_size = 1
	            let g:indent_guides_enable_on_vim_startup = 1
	        endif
        "}

        " wildfire settings {
            if isdirectory(expand("~/.vim/bundle/wildfire.vim/"))
			    let g:wildfire_objects = {
			                \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
			                \ "html,xml" : ["at"],
			                \ }
			endif
        " }

		" Sessionman settings{
			if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
				set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
				nmap <leader>sl :SessionList<CR>
	            nmap <leader>ss :SessionSave<CR>
	            nmap <leader>sc :SessionClose<CR>
	        endif
		"}


		" Startify settings {
			if isdirectory(expand("~/.vim/bundle/vim-startify/"))
				let g:startify_change_to_dir = 0
				let g:startify_files_number = 8
				let g:startify_bookmarks = ['~/.vimrc',]
				let g:startify_skiplist = ['vimrc',]
			endif
		" }

    " }




    "Programming {

       	" Syntastic settings {
       		if isdirectory(expand("~/.vim/bundle/syntastic/"))
				let g:syntastic_always_populate_loc_list = 1
				let g:syntastic_auto_loc_list = 1
				let g:syntastic_enable_signs = 1
				let g:syntastic_check_on_wq = 0
				let g:syntastic_aggregate_errors = 1
				noremap <f7> :w<CR>:SyntasticCheck<CR>

				" Better :sign interface symbols
				let g:syntastic_error_symbol = 'X'
				let g:syntastic_style_error_symbol = 'X'
				let g:syntastic_warning_symbol = 'x'
				let g:syntastic_style_warning_symbol = 'x'
			endif
        "}


        " Fugitive settings {
        	if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
	            nnoremap <silent> <leader>gs :Gstatus<CR>
	            nnoremap <silent> <leader>gd :Gdiff<CR>
	            nnoremap <silent> <leader>gc :Gcommit<CR>
	            nnoremap <silent> <leader>gb :Gblame<CR>
	            nnoremap <silent> <leader>gl :Glog<CR>
	            nnoremap <silent> <leader>gp :Git push<CR>
	            nnoremap <silent> <leader>gr :Gread<CR>
	            nnoremap <silent> <leader>gw :Gwrite<CR>
	            nnoremap <silent> <leader>ge :Gedit<CR>
	            " Mnemonic _i_nteractive
	            nnoremap <silent> <leader>gi :Git add -p %<CR>
	            nnoremap <silent> <leader>gg :SignifyToggle<CR>
	        endif
        "}

        " Tabularize {
        	if isdirectory(expand("~/.vim/bundle/tabular"))
	            nmap <Leader>a& :Tabularize /&<CR>
	            vmap <Leader>a& :Tabularize /&<CR>
	            nmap <Leader>a= :Tabularize /=<CR>
	            vmap <Leader>a= :Tabularize /=<CR>
	            nmap <Leader>a=> :Tabularize /=><CR>
	            vmap <Leader>a=> :Tabularize /=><CR>
	            nmap <Leader>a: :Tabularize /:<CR>
	            vmap <Leader>a: :Tabularize /:<CR>
	            nmap <Leader>a:: :Tabularize /:\zs<CR>
	            vmap <Leader>a:: :Tabularize /:\zs<CR>
	            nmap <Leader>a, :Tabularize /,<CR>
	            vmap <Leader>a, :Tabularize /,<CR>
	            nmap <Leader>a,, :Tabularize /,\zs<CR>
	            vmap <Leader>a,, :Tabularize /,\zs<CR>
	            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
	            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
	        endif
        "}

        " Tagbar settings {
	        if isdirectory(expand("~/.vim/bundle/tagbar/"))

	               	set tags=./tags;/,~/.vimtags

	        		"" Make tags placed in .git/tags file available in all levels of a repository
	        		let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
	        		if gitroot != ''
	            		let &tags = &tags . ',' . gitroot . '/.git/tags'
	        		endif
	        		nmap <F8> :TagbarToggle<CR>
					let g:tagbar_autofocus = 0 					" автофокус на Tagbar при открытии

	        endif
	    " }

    " }



    " PHP {

    	" PIV PHP
    	    if isdirectory(expand("~/.vim/bundle/PIV"))
            	let g:DisableAutoPHPFolding = 0
            	let g:PIVAutoClose = 0
            endif
        " }
    " }





	" Python {

		" Python-mode settings {
			if isdirectory(expand("~/.vim/bundle/python-mode"))
				" Python-mode
				" Activate rope
				" Keys:
				" K Show python docs
				" <Ctrl-Space> Rope autocomplete
				" <Ctrl-c>g Rope goto definition
				" <Ctrl-c>d Rope show documentation
				" <Ctrl-c>f Rope find occurrences
				" <Leader>b Set, unset breakpoint (g:pymode_breakpoint enabled)
				" [[ Jump on previous class or function (normal, visual, operator modes)
				" ]] Jump on next class or function (normal, visual, operator modes)
				" [M Jump on previous class or method (normal, visual, operator modes)
				" ]M Jump on next class or method (normal, visual, operator modes)
				let g:pymode_rope = 0

				" Documentation
				let g:pymode_doc = 0
				let g:pymode_doc_key = 'K'
				"Linting
				let g:pymode_lint = 0
				let g:pymode_lint_checker = "pyflakes,pep8"
				let g:pymode_lint_ignore="E501,W601,C0110"
				let g:pymode_lint_write = 0

				" Support virtualenv
				let g:pymode_virtualenv = 1

				" Enable breakpoints plugin
				let g:pymode_breakpoint = 1
				let g:pymode_breakpoint_key = '<leader>b'

				" Syntax highlighting
				let g:pymode_syntax = 1
				let g:pymode_syntax_all = 1
				let g:pymode_syntax_indent_errors = g:pymode_syntax_all
				let g:pymode_syntax_space_errors = g:pymode_syntax_all

				" Don't autofold code
				let g:pymode_folding = 0

				" Get possibility to run Python code
				let g:pymode_run = 0

				" Other options
				let g:pymode_options_colorcolumn = 0
				let g:pymode_lint_checkers = ['pyflakes']
				let g:pymode_trim_whitespaces = 0
				let g:pymode_options = 0
			endif
		" }

		" Jedi-vim {
			if isdirectory(expand("~/.vim/bundle/jedi-vim"))
				let g:jedi#popup_on_dot = 0 	 	" Disable the automatic suggestions
				let g:jedi#popup_select_first = 0	" Disable first select from auto-complete
			endif
		" }

		" Python code check on PEP8 {
			if isdirectory(expand("~/.vim/bundle/vim-python-pep8-indent"))
				autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>
			endif
		" }

	" }



" End of plugins.vim