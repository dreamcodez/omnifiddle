require! \./Component.ls
require! \./Tinker.ls

{templates} = require(\../build/clientjade.js)

scripts =
  * '/js/raf.js'
  * '/js/zepto.js'
  * '/js/history/json2.js'
  * '/js/history/history.adapter.zepto.js'
  * '/js/history/history.html4.js'
  * '/js/history/history.js'
  * '/js/loljs.js'
  * '/js/app.js'

module.exports =
  class HomePage extends Component
    component-name: \HomePage
    (...args) ->
      opts = args.0 ||= {}
      opts.locals  ||= {}
      opts.locals <<< {scripts}
      super ...args

    template: templates.HomePage

    children: -> {
      tinker: new Tinker {} \#content @
    }

