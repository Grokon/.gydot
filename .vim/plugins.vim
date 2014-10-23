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

" Plugins {

	" Git wrapper
	Plugin 'tpope/vim-fugitive'


	" Fast file navigation for VIM
	Plugin 'git://git.wincent.com/command-t.git'


	Plugin 'bling/vim-airline'   	    	" Lean & mean status/tabline for vim - строка статуса/состояния
		" настройки Vim-Airline
		set laststatus=2
		let g:airline_theme='badwolf'
		let g:airline_powerline_fonts = 1
		let g:airline#extensions#tabline#enabled = 1
		let g:airline#extensions#tabline#formatter = 'unique_tail'


	" snipMate
	Plugin 'garbas/vim-snipmate'		" Snippets manager
	Plugin 'MarcWeber/vim-addon-mw-utils'	" dependencies #1
	Plugin 'tomtom/tlib_vim'		" dependencies #2
	Plugin 'honza/vim-snippets'		" snippets repo


	" навигация по файловой/директориям
	Plugin 'scrooloose/nerdtree'
		" nerdtree settings
		let g:NERDTreeMouseMode = 2
		let g:NERDTreeWinSize = 40
		"explorer mappings
		nnoremap <f1> :BufExplorer<cr>
		nnoremap <f2> :NERDTreeToggle<cr>
		nnoremap <f3> :TagbarToggle<cr>
		"source project specific config files
		runtime! projects/**/*.vim

	" NERDTree and tabs together in Vim
	Plugin 'jistr/vim-nerdtree-tabs'


	" репозитории vim/scripts {

		" l9 is a Vim-script library, which provides some utility functions and commands for programming in Vim.
		Plugin 'L9'

		"FuzzyFinder provides convenient ways to quickly reach the buffer/file/command/bookmark/tag you wan
		Plugin 'FuzzyFinder'
	" }



	" Разработка (Development plugins) {

		" Задаем язык программирования
		let gyprog="python"

		" Выбираем плагины в зависимости от текущего языка программирования
		if gyprog == "lua"
			" Lua Plugins
			" Lua file type plug-in
			Plugin 'xolox/vim-lua-ftplugin'
				Plugin 'xolox/vim-misc'

		elseif gyprog == "ruby"
			" Ruby Plugins
			" Ruby on Rails power tools
			Plugin 'tpope/vim-rails.git'

		elseif gyprog == "python"
			" Python plugins
			Plugin 'klen/python-mode'	        	" Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
			Plugin 'davidhalter/jedi-vim' 			" Jedi-vim autocomplete plugin автодополнение для Python
			Plugin 'mitsuhiko/vim-jinja'			" Jinja support for vim
			Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim


		endif


		Plugin 'majutsushi/tagbar'          		" Class/module browser навигация по классам/функциям/переменным
			" TagBar настройки
			map <F4> :TagbarToggle<CR>
			let g:tagbar_autofocus = 0 				" автофокус на Tagbar при открытии


		" Sparkup lets you write HTML code faster.
		Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

		" EasyMotion — позволяет быстро прыгать по коду, используя визуальную индикацию
		Plugin 'Lokaltog/vim-easymotion'

		" Syntax checking hacks for vim
		Plugin 'scrooloose/syntastic'

	" }



	" Colors {

		" Zenburn is a low-contrast color scheme for Vim.
		Plugin 'jnurmine/Zenburn'

		" Solarized Colorscheme for Vim
		Plugin 'altercation/vim-colors-solarized'


		" Set Colorcheme
		"colors zenburn
		colorscheme solarized

	" }







" }

" End of plugins.vim