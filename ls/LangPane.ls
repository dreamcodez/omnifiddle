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
    (...args) ->
      opts = args.0 ||= {}
      locals = opts.locals ||= {}
      locals.input ||= ''
      @r-input = $R.state(locals.input)
      super ...args
    template: templates.LangPane
    on-attach: ->
      component = @
      @$.on \keyup, \textarea.LangPane-input, debounce ->
        new-val = $(@).val!
        component.locals.input = new-val
        component.r-input new-val
    on-detach: ->
      @$.off \keyup, \textarea.LangPane-input
