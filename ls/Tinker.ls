require! $R:reactivejs
require! Component:yacomponent
require! \./LangPane

{templates} = require(\../build/clientjade)

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
    init: ->
      # required state
      @local \markup, '' if @local(\markup) is void
      @local \style, '' if @local(\style) is void
      @local \code, '' if @local(\code) is void

      @children =
        markup: new LangPane {locals: {flavor: \html, flavors: markup-flavors, input: @state.markup}} \#markup_pane @
        style: new LangPane {locals: {flavor: \css, flavors: style-flavors, input: @state.style}} \#style_pane @
        code: new LangPane {locals: {flavor: \js, flavors: code-flavors, input: @state.code}} \#code_pane @

      $R((html) ~>
        if $pb = @$preview-body
          $pb.html html
      ).bind-to @children.markup.state.output
    put-head: -> @$preview-head.html it
    put-body: -> @$preview-body.html it
    on-attach: ->
      @$preview-doc =
        @@$ @$.find(\iframe.preview).0.content-window.document
      @$preview-head = @$preview-doc.find \head
      @$preview-body = @$preview-doc.find \body

      # initial preview render
      @$preview-body.html @local(\markup)
