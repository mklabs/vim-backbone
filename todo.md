
---

templates

- files under a model directory are init'd from templates/model
(`*/models/*`)
- files under a collection directory are init'd from templates/collection
(`*/collection/*`)
- files under a router or controller directory are init'd from templates/router
(`*/router/*` || `*/controller/*`)
- files under a view, views or ui directory are init'd from templates/views
(`*/views?/*` || `*/ui/*`)

For every template, if the file's name that is going to be created match
a particular template file, it is used. Otherwise, fallsback to
`<type>/default.js`

Templates loadpath should include and try to load in this order files
from `./vim/templates` (relative to working directory),
`~/.vim/templates/backbone/` and the local `./templates` dir (in this
repo).


---

Backbone specific omnifunc.

*to experiment* Use https://github.com/ariya/esprima to parse out the
the current file, and tries to build a list of completion matches.

---

What it should do:

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
