require! {
  Component: yacomponent
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
    init: ->
      @state.output = @@$R(eval-lang).bind-to @state.flavor, @state.input
    template: templates.LangPane
    mutate: ($c) ->
      $c.find(\select.flavor).val @local(\flavor)
    on-attach: ->
      @state.output! # render the output on attach

      $out = @$.find \textarea.LangPane-output
      $out-tab = @$.find \.tab\.output
      component = @

      @$.on \change, \select.flavor, ->
        component.local \flavor, component.constructor.$(@).val!

      @$.on \keyup, \textarea.LangPane-input, debounce ->
        # this condition guards any reactive binders from receiving
        # non-genuine value changes
        unless new-input is component.local(\input)
          component.state.input component.constructor.$(@).val!

      @@$R((flavor) ->
        if flavor in [\html \css \js]
          # source IS output in this case so hide extraneous UI
          $out-tab.hide!
        else
          $out-tab.show!
      ).bind-to @state.flavor

      @@$R($out~val).bind-to @state.output
    on-detach: ->
      @$.off \keyup, \textarea.LangPane-input
