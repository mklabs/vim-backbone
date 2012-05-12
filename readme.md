
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

**What it does**

---

vim helpfile generated from backbonejs.org (`:h backbone`)

![Backbone helptags](https://raw.github.com/mklabs/vim-backbone/master/examples/backbone-helptags.png)

---

Snipmates snippets. When filetype is set to `javascript`, type
`view<tab>`, `model<tab>` or `router<tab>`

In insert mode, in a file where `filetype=javascript`, typing `view`
followed by `<tab>` will expand to the following snippet:

```js
var MyView = Backbone.View.extend({
  el: '',
  tagName: '',

  events: {

  },

  initialize: function () {

  },

  render: function () {

  }
});
```

Hitting tab again will iterate through snippets placeholders. See `:h
snipMate` and `:h snipMate-placeholders` for more infos.

---

Backbone specific omnicompleter.

`:h new-omni-completion`.

> This could also be called "intellisense", but that is a trademark.

Should auto-complete whenever the text in front of the cursor includes a
`model` (`this.model` triggers the match). Same for collection, router
and view.

It works by inspecting the `Backbone.Model.prototype` object when
completing against a match that triggers model completion. It's not as
accurate as it would be in your devtool but should be pretty close.

Use `CTRL-X CTRL-U` in Insert mode to start the completion, when the
cursor in in front of the following:

    model.
    router.
    controller.
    view.

The plugin also map the `<C-Space>` (Ctrl+space) to trigger the same
omnicompletion.

In insert mode, in a file where `filetype=javascript`, typing `model`or
`model.` followed by either `Ctrl+X Ctrl+U` or `Ctrl+Space` will pop the
following menu:

![Backbone model omnicompleter](https://raw.github.com/mklabs/vim-backbone/master/examples/omnifunc.png)

---

**What it should do**

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
