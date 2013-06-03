require! $R:reactivejs
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
    template: templates.Tinker
    put-head: -> @$preview-head.html it
    put-body: -> @$preview-body.html it
    on-attach: ->
      @$preview-doc =
        @@$ @$.find(\iframe.preview).0.content-window.document
      @$preview-head = @$preview-doc.find \head
      @$preview-body = @$preview-doc.find \body

      # initial preview render
      @$preview-body.html @local(\markup)
    children: ->
      c =
        markup: new LangPane {locals: {flavor: \html, flavors: markup-flavors, input: ~> @locals.markup}} \#markup_pane @
        style: new LangPane {locals: {flavor: \css, flavors: style-flavors, input: ~> @locals.style}} \#style_pane @
        code: new LangPane {locals: {flavor: \js, flavors: code-flavors, input: ~> @locals.code}} \#code_pane @

      $R(~>
        @locals.markup = it # update internal state
        @$preview-body.html(it)
      ).bind-to c.markup.r-input

      $R(~>
        @locals.style = it # update internal state
        #@$preview-body.html(it)
      ).bind-to c.style.r-input

      $R(~>
        @locals.code = it # update internal state
        #@$preview-body.html(it)
      ).bind-to c.code.r-input

      return c

