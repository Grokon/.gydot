REM    Copyright 2014 Steve Francia
REM
REM    Installing configs dir
REM

@echo off

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_DIR=%HOME%\.gydot
IF NOT EXIST "%APP_DIR%" (
  call git clone https://github.com/Grokon/.gydot.git "%APP_DIR%"
) ELSE (
	@set ORIGINAL_DIR=%CD%
    echo updating gydot
    chdir /d "%APP_DIR%"
	call git pull
    chdir /d "%ORIGINAL_DIR%"
	call cd "%APP_DIR%"
)

call mklink "%HOME%\.vimrc" "%APP_DIR%\.vim\vimrc"
call mklink "%HOME%\_vimrc" "%APP_DIR%\.vim\vimrc"
call mklink /J "%HOME%\.vim" "%APP_DIR%\.vim"

IF NOT EXIST "%APP_DIR%\.vim\bundle" (
	call mkdir "%APP_DIR%\.vim\bundle"
)

IF NOT EXIST "%HOME%/.vim/bundle/vundle" (
	call git clone https://github.com/gmarik/vundle.git "%HOME%/.vim/bundle/vundle"
) ELSE (
  call cd "%HOME%/.vim/bundle/vundle"
  call git pull
  call cd %HOME%
)

call "C:\Program Files (x86)\vim\vim74\vim.exe" -u "%APP_DIR%/.vim/.vimrc" +PluginInstall! +PluginClean +qall



@echo on