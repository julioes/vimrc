filetype off
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible
set modelines=0

set ts=2 sts=2 sw=2 expandtab

set number

set encoding=utf-8

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

"Include GO support VIM files.
set rtp+=$GOROOT/misc/vim

syntax enable

filetype on
filetype plugin on
filetype indent on

if has('gui_running')
  set background=light
else
  set background=dark
endif
colorscheme solarized

if has("autocmd")

  "Syntax of these languages is fussy over tabs Vs spaces.
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
  autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

  "Treat .rss files as XML.
  autocmd BufNewFile,BufRead *.rss setfiletype xml

  "Format go files after saving
  autocmd BufWritePre *.go :silent Fmt

  "Two space indentation for CoffeeScript
  autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
  "Fold by indentation for CoffeeScript
  autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

endif

nnoremap <F3> :NumbersToggle<CR>

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

