require! \./Component.ls

{templates} = require(\../build/clientjade.js)

module.exports =
  class LangPane extends Component
    template: templates.LangPane
    mutate: !($c, state) ->
      $strong = $c.find \strong
      $strong.text "#{$strong.text!}!" # add exclamation point in jquery (contrived I know)
    attach: ->
      @$top.on \click \.tab -> console.log 'say my name say my name, you acting kinda shady aint callin me baby why the sudden change?'
    detach: !->
      @$top.off!
