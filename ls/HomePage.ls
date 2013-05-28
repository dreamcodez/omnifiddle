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
    (state = {}, $top) ->
      state <<< {scripts}
      super state, $top

    template: templates.HomePage

    mutate: !($c, state) ->
      (new LangPane {flavors: [[\HTML \html]]}, $c.find('#markup_pane')).put!
      (new LangPane {flavors: [[\CSS \css]]}, $c.find('#style_pane')).put!
      (new LangPane {flavors: [[\JavaScript \javascript]]}, $c.find('#code_pane')).put!
