require! \./Component.ls
require! \./LangPane.ls

{templates} = require(\../build/clientjade.js)

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
      new LangPane {locals: {flavors: [[\HTML \html]]}} \#markup_pane @
      new LangPane {locals: {flavors: [[\CSS \css]]}} \#style_pane @
      new LangPane {locals: {flavors: [[\JavaScript \js]]}} \#code_pane @
    ]

