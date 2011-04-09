call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set ts=2 sts=2 sw=2 expandtab

syntax enable
if has('gui_running')
  set background=light
else
  set background=dark
endif
colorscheme solarized

if has("autocmd")

  filetype on

  "Syntax of these languages is fussy over tabs Vs spaces.
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  "Treat .rss files as XML.
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

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

