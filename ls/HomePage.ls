require! Component:yacomponent
require! \./Tinker

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
    template: templates.HomePage
    init: ->
      @local \scripts, scripts
      @children =
        tinker: new Tinker {} \#content @
