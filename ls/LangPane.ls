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
        new-input = $(@).val!

        # this condition guards any reactive binders from receiving
        # non-genuine value changes
        unless new-input is component.locals.input
          component.locals.input = new-input
          component.r-input new-input
    on-detach: ->
      @$.off \keyup, \textarea.LangPane-input
