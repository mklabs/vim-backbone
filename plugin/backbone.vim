" backbone.vim - A Plugin for working with Backbone applications
" Maintainer:   @mklabs
" Version:      0.1

if exists("g:loaded_backbone") || v:version < 700 || &cp
  finish
endif
let g:loaded_backbone = 1

"
" todo: lot of stuff
"
" - should autodetect backbone application. how.
"
"

" Configure some template files automatically
"
" todo: should be wrapped in a function, then tell
" how to enable this in .vimrc

" let filename=expand('<sfile>:h:h')
" let template=join([filename, 'bin', 'template'], '/')
"
" autocmd! BufNewFile *.js :exe("silent! 0r! ". template ." %:p " . &filetype)


" vim:set sw=2 sts=2:
