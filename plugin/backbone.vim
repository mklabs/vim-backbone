" backbone.vim - A Plugin for working with Backbone applications
" Maintainer:   @mklabs
" Version:      0.0.1

" if exists("g:loaded_backbone") || v:version < 700 || &cp
"   finish
" endif
" let g:loaded_backbone = 1

" Object.create like prototype-like create


let s:Object = {}
function! s:Object.create(...)
  let F = copy(self)
  if a:0
    let F = extend(self, a:1)
  endif
  return F
endfunction

" utilities

function! s:has(line, pat)
  return matchstr(a:line, a:pat) != ''
endfunction

function! s:map(list, prefix)
  return map(copy(a:list), 'a:prefix . v:val')
endfunction


" backbone app prototype

let s:backbone = {}

let s:backbone.basedir = expand('<sfile>:h:h')

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
  let out = self.exec('complete', [a:type])
  return split(out, "\n")
endfunction

function! s:backbone.generate(args)
  if a:args == ""
    return
  endif

  let parts = split(a:args, ' ')
  if len(parts) < 2
    echo "... Error: Generate commands requires a filename ..."
    return
  endif

  let type = parts[0]
  let thing = parts[1]

  let template = self.template(type, thing)

  if empty(template)
    echo "... Error: Generating tempalte commands for " . type . " for " . thing . "..."
  endif

  " edit the result file, at proper location, depends on type
  " this doesn't write anything, but rather open a new buffer with
  " template content loaded, or edit the existsing file (if any)

  " XXX these subpaths mapping should be configurable
  if type == 'model' || type == 'collectiion'
    let subpath = 'models'
  elseif type == 'view'
    let subpath = 'views'
  elseif type == 'router'
    let subpath = 'routers'
  endif

  " XXX same here, this behaviour should be configurable
  if type == 'collection'
    " pluralize model name for collection
    let thing = thing + 's'
  endif

  " suffix by js
  " XXX coffeescript mode
  let thing = thing . '.js'

  " prior to buffer opening
  " make sure the dir exists, if not create first
  if !isdirectory(subpath)
    call mkdir(subpath, 'p')
  endif

  let subpath = join([subpath, thing], '/')
  exe 'edit' subpath

  " now load up template content
  call append(0, template)
endfunction

function! s:backbone.exec(file, args)
  let script = join([self.basedir, 'bin', a:file], '/')
  return system('node ' . script . ' ' . join(a:args, ' '))
endfunction

function! s:backbone.shell(file, args)
  let script = join([self.basedir, 'bin', a:file], '/')
  exe ':!node ' script join(a:args, ' ')
endfunction

function! s:backbone.template(type, thing)
  call self.shell('template', ['--cwd', getcwd(), a:type, a:thing])
  let file = join([self.basedir, 'bin/template.tmp'], '/')
  return readfile(file)
endfunction


" Public API

" backbone object
let s:bb = s:Object.create(s:backbone)

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

" XXX define commands only from within a backbone project
" still have to figure out what a backbone project is (easy way, a
" package.json or vim/ folder with configuration telling it is)

" XXX autocomplete
command! -nargs=* BGenerate       call s:bb.generate(<q-args>)
command! -nargs=* BCollection     call s:bb.generate('collection ' . <q-args>)
command! -nargs=* BRouter         call s:bb.generate('router '. <q-args>)
command! -nargs=* BModel          call s:bb.generate('model ' . <q-args>)
command! -nargs=* BView           call s:bb.generate('view '. <q-args>)


" vim:set sw=2 sts=2:
