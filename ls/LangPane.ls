require! {
  \./Component.ls
  lodash
  $R: reactivejs
}

debounce = lodash.debounce _, 250

{templates} = require(\../build/clientjade.js)

module.exports =
  class LangPane extends Component
    ->
      super ...

      @merge-state {input: ''}

      $R(-> console.log ...arguments).bind-to @r.input
      # XXX: todo, create reactive fun out that turns it into output form
      # then create another reactive fun which consumes the output and
      # places it in the output pane
      #
      # and finally yet another reactive fun which binds also to the output
      # and updates the preview pane

    template: templates.LangPane
    mutate: !($c, state) ->
    attach: ->
      r = @r
      @$top.on \keyup \textarea.input debounce(->
        r.input $(@).val!
      )
    detach: !->
      @$top.off!
