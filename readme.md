
# vim backbone

Collection of Backbone VIM snippets and templates.

## Installation

**Install for pathogen**

```sh
cd ~/.vim/bundle
git clone git://github.com/mklabs/vim-backbone.git
```

## Documentation

*work in progess*

What it does:

* vim helpfile generated from backbonejs.org (`:h backbone`)

* snipmates snippets. When filetype is set to `javascript`, type
  `view<tab>`, `model<tab>` or `router<tab>`

What is should do:

* vim templates on `BufNewFile`. Should this be node-based with mustache
  like templates, and intelligently parse current filepath / app
  structure to know which template it should use (eg. opening a new file
  with something like `*/models/*` or a filename with `model` in it
  should trigger the model template.

* Ease navigation of the Backbone directory structure. eg. easy jumping
  between files, like model to test, view to template, template to
  helper, etc.

* Enhanced syntax highlighting, should this be useful

* Scripts wrapper around the scripts in the script directory of the
  Backbone app. A limited amount of completion should be supported

* Possibly integration and wrappers to build tool

* should have special logic / behaviour if a `spec/` or `test/`
  directory is detected.

* Commands to generate things. a `:Bgenerate model Foo` should create a
  foo controller and edits `app/model/foo.js`, optionally would be nice
  to have the matching test generated `app/test/foo.js` with basic
  assertions.
