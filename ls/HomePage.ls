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

    children:
      * new LangPane {flavors: [[\HTML \html]]} \#markup_pane
      * new LangPane {flavors: [[\CSS \css]]} \#style_pane
      * new LangPane {flavors: [[\JavaScript \javascript]]} \#code_pane

    template: templates.HomePage

    mutate: !($c, state) ->
      for c in @children
        $c.find(c.selector).html c.html

    attach: !->
      for c in @children
        c.attach!

    detach: !->
      for c in @children
        c.detach!

