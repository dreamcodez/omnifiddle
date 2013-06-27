require! {
  Component: yacomponent
  jade: \../node_modules/jade/lib/jade
  lodash
  $R: reactivejs
}

function eval-lang flavor, source
  switch flavor
  case \jade
    var out
    # +self ensures we get an actual error if
    # a variable binding does not exist in jade
    jade.render source, {+self}, (err, res) ->
      if err then throw err
      out := res
    out
  default source # stub

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
        new-val = @@$(@).val!
        # this condition guards any reactive binders from receiving
        # non-genuine value changes
        unless new-val is component.local(\input)
          component.state.input new-val

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
