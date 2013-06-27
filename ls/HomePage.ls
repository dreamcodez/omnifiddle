define (require) ->
  require! {
    Component:yacomponent
    \./Tinker
  }

  {templates} = require \../build/clientjade

  scripts =
    * '/js/raf.js'
    * '/js/zepto.js'
    * '/js/history/json2.js'
    * '/js/history/history.adapter.zepto.js'
    * '/js/history/history.html4.js'
    * '/js/history/history.js'
    * '/js/loljs.js'
    * '/js/app.js'

  packages =
    * \lodash
    * \reactivejs

  class HomePage extends Component
    component-name: \HomePage
    template: templates.HomePage
    init: ->
      @local \scripts, scripts unless @local(\scripts)
      @local \packages, packages unless @local(\packages)
      @children =
        tinker: new Tinker {} \#content @
