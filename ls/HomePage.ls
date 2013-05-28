require! \./Component.ls
require! \./LangPane.ls

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
    ->
      super ...
      @merge-state {scripts}

    children:
      * new LangPane {flavors: [[\HTML \html]]} \#markup_pane
      * new LangPane {flavors: [[\CSS \css]]} \#style_pane
      * new LangPane {flavors: [[\JavaScript \javascript]]} \#code_pane

    template: templates.HomePage
