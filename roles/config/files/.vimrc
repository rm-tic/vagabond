" COMMON SETTINGS

syntax on
set number relativenumber

" --------------------------------------------------------------------------------------

" SHORTCUTS

let mapleader="\<space>"

nnoremap <leader>src :source ~/.vimrc<cr>
nnoremap <leader>sh :!bash<cr>
nnoremap <leader>qq :q!<cr>
nnoremap <leader>xx :x<cr>


" --------------------------------------------------------------------------------------

" INDENTATION

" Usage
" -----

" :call UseTabs()
" :call UseSpaces()

" To use it per file extensions, the following syntax can be used (added to .vimrc):
" autocmd Filetype yaml call UseSpaces()
" au! BufWrite,FileWritePre *.module,*.install call UseSpaces()

" Other Form
" autocmd Filetype yaml setlocal ts=2 sw=2 expandtab
" autocmd Filetype tf setlocal ts=2 sw=2 expandtab

" execute pathogen#infect()
" syntax on
" filetype plugin indent on

set tabstop=3     " Size of a hard tabstop (ts).
set shiftwidth=3  " Size of an indentation (sw).
set noexpandtab   " Always uses tabs instead of space characters (noet).
set autoindent    " Copy indent from current line when starting a new line (ai).

function! UseTabs()
  set tabstop=4     " Size of a hard tabstop (ts).
  set shiftwidth=4  " Size of an indentation (sw).
  set noexpandtab   " Always uses tabs instead of space characters (noet).
  set autoindent    " Copy indent from current line when starting a new line (ai).
endfunction

function! UseSpaces()
  set tabstop=2     " Size of a hard tabstop (ts).
  set shiftwidth=2  " Size of an indentation (sw).
  set expandtab     " Always uses spaces instead of tab characters (et).
  set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  set autoindent    " Copy indent from current line when starting a new line.
  set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction

autocmd Filetype yaml call UseSpaces()
autocmd Filetype tf call UseSpaces()
