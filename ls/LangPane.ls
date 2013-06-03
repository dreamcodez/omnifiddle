require! {
  \./Component.ls
  lodash
  $R: reactivejs
}

function eval-lang flavor, source
  source # stub

debounce = lodash.debounce _, 250

{templates} = require(\../build/clientjade.js)

module.exports =
  class LangPane extends Component
    component-name: \LangPane
    ->
      super ...
      @state.output = $R.state
    template: templates.LangPane
    mutate: ($c) ->
      $c.find(\select.flavor).val @local(\flavor)
    on-attach: ->
      $out = @$.find \textarea.LangPane-output
      $out-tab = @$.find \.tab\.output
      component = @

      #@$.on \change, \select.flavor, ->

      @$.on \keyup, \textarea.LangPane-input, debounce ->
        new-input = $(@).val!
        # this condition guards any reactive binders from receiving
        # non-genuine value changes
        unless new-input is component.local(\input)
          flavor = component.local(\flavor)
          new-output = eval-lang(flavor, new-input)
          component.state.input new-input
          component.state.output new-output

          if flavor in [\html \css \js]
            # source IS output in this case so hide extraneous UI
            $out-tab.hide!
          else
            $out.val new-output
            $out-tab.show!
    on-detach: ->
      @$.off \keyup, \textarea.LangPane-input
