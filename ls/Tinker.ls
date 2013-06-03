require! \./Component.ls
require! \./LangPane.ls

{templates} = require(\../build/clientjade.js)

markup-flavors =
  * [\HTML \html]
  * [\Jade \jade]

style-flavors =
  * [\CSS \css]
  * [\Stylus \styl]

code-flavors =
  * [\JavaScript \js]
  * [\CoffeeScript \coffee]
  * [\LiveScript \ls]
  * [\Roy \roy]
  * [\ClojureScript \clj]
  * [\LOLcode \lol]
  * [\Brainfuck \bf]
  * [\Malbolge \malbolge]

module.exports =
  class Tinker extends Component
    component-name: \Tinker
    (...args) ->
      opts = args.0 ||= {}
      locals = opts.locals ||= {}
      locals.markup ||= ''
      locals.markup-flavor ||= \html
      locals.style ||= ''
      locals.style-flavor ||= \css
      locals.code ||= ''
      locals.code-flavor ||= \js
      super ...args
    template: templates.Tinker
    put-head: -> @$preview-head.html it
    put-body: -> @$preview-body.html it
    on-attach: ->
      @$preview-doc =
        @@$ @$.find(\iframe.preview).0.content-window.document
      @$preview-head = @$preview-doc.find \head
      @$preview-body = @$preview-doc.find \body
    children: -> [
      new LangPane {locals: {flavors: markup-flavors}} \#markup_pane @
      new LangPane {locals: {flavors: style-flavors}} \#style_pane @
      new LangPane {locals: {flavors: code-flavors}} \#code_pane @
    ]

