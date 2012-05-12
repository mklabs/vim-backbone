" backbone.vim - A Plugin for working with Backbone applications
" Maintainer:   @mklabs
" Version:      0.0.1

if exists("g:loaded_backbone") || v:version < 700 || &cp
  finish
endif
let g:loaded_backbone = 1

" Object.create like prototype-like create

let s:Object = {}
function! s:Object.create(...)
  let F = copy(self)
  if a:0
    let F = extend(self, a:1)
  endif
  return F
endfunction

" backbone app prototype

let s:backbone = {}

let s:backbone.basedir = expand('<sfile>:h:h')
let s:backbone.nodescript = join([s:backbone.basedir, 'bin/complete'], '/')

function! s:backbone.compl(findstart, base)
  let line = getline('.')
  if a:findstart
    let existing = matchstr(line[0:col('.')-1], '\.\w*$')
    return col('.')-1-strlen(existing)
  endif

  if s:has(line, 'model')
    return s:map(self.complete('Model'), a:base)
  endif

  if s:has(line, 'collection')
    return s:map(self.complete('Collection'), a:base)
  endif

  if s:has(line, 'router') || s:has(line, 'controller')
    return s:map(self.complete('Router'), a:base)
  endif

  if s:has(line, 'view') || s:has(line, 'view')
    return s:map(self.complete('View'), a:base)
  endif

  return []
endfunction

function! s:backbone.complete(type)
  let out = system('node ' . self.nodescript . ' ' . a:type)
  return split(out, "\n")
endfunction

function! s:has(line, pat)
  return matchstr(a:line, a:pat) != ''
endfunction

function! s:map(list, prefix)
  return map(copy(a:list), 'a:prefix . v:val')
endfunction

let s:bb = s:Object.create(s:backbone)

" Public API

function! backbone#compl(findstart, base)
  return s:bb.compl(a:findstart, a:base)
endfunction


function! backbone#triggerCompl()
  let line = getline('.')
  let dotend = s:has(line, '\.$')

  if s:has(line, 'model\.\?$') ||
    \ s:has(line, 'collection\.\?$') ||
    \ s:has(line, 'router\.\?$') ||
    \ s:has(line, 'controller\.\?$') ||
    \ s:has(line, 'view\.\?$')

    let prefix = dotend ? '' : '.'
    setlocal completefunc=backbone#compl
    return prefix . "\<C-X>\<C-U>"
  endif

  return ''
endfunction


" XXX add configuration option to prefix mapping with user defined
autocmd FileType javascript inoremap <expr> <buffer> <C-Space> backbone#triggerCompl()

" this.foo

" vim:set sw=2 sts=2:
