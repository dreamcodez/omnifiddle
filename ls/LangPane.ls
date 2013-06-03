require! {
  \./Component.ls
  lodash
  $R: reactivejs
}

debounce = lodash.debounce _, 250

{templates} = require(\../build/clientjade.js)

module.exports =
  class LangPane extends Component
    component-name: \LangPane
    ->
      super ...
      @r-input = $R.state @local(\input)
    template: templates.LangPane
    on-attach: ->
      component = @
      @$.on \keyup, \textarea.LangPane-input, debounce ->
        new-input = $(@).val!
        # this condition guards any reactive binders from receiving
        # non-genuine value changes
        unless new-input is component.local(\input)
          component.r-input new-input
    on-detach: ->
      @$.off \keyup, \textarea.LangPane-input
