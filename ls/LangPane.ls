require! {
  \./Component.ls
  lodash
}

debounce = lodash.debounce _, 250

{templates} = require(\../build/clientjade.js)

module.exports =
  class LangPane extends Component
    ->
      super ...
      @merge-state {input: '', output: ''}

    template: templates.LangPane
    mutate: !($c, state) ->
    attach: ->
      @$top.on \keyup, \textarea.input, debounce ->
        @r.input $(@).val!
    detach: !->
      @$top.off!
