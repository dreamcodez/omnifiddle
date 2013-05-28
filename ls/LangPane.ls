require! {
  \./Component.ls
  lodash
}

debounce = lodash.debounce _, 250

{templates} = require(\../build/clientjade.js)

module.exports =
  class LangPane extends Component
    (state, selector) ->
      new-state = {input: '', output: ''} <<< state
      super new-state, selector

    template: templates.LangPane
    mutate: !($c, state) ->
    attach: ->
      @$top.on \keyup 'textarea.input' -> console.log 'say my name say my name, you acting kinda shady aint callin me baby why the sudden change?'
    detach: !->
      @$top.off!
