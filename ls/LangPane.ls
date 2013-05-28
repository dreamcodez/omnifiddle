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

      @merge-state {input: '', output: ''}

      $R(-> console.log ...arguments).bind-to @r.input

    template: templates.LangPane
    mutate: !($c, state) ->
    attach: ->
      r = @r
      @$top.on \keyup \textarea.input debounce(->
        r.input $(@).val!
      )
    detach: !->
      @$top.off!
