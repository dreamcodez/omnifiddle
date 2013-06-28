define = window?define or require(\amdefine) module
define (require, exports, module) ~>
  require! {
    Component: yacomponent
    \./Tinker
  }

  {templates} = require \../build/clientjade

  class HomePage extends Component
    template: templates.HomePage
    init: ->
      @children =
        tinker: new Tinker {} \#content @
