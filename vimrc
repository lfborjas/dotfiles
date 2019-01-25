"from
"http://stackoverflow.com/questions/1562633/setting-vim-whitespace-preferences-by-filetype
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype php setlocal ts=4 sw=4 expandtab autoindent
autocmd Filetype cucumber setlocal ts=2 sw=2 expandtab
set noswapfile
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.md.html set filetype=markdown
autocmd Filetype markdown setlocal textwidth=80 cc=80
