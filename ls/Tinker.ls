require! \./Component.ls
require! \./LangPane.ls

{templates} = require(\../build/clientjade.js)

module.exports =
  class Tinker extends Component
    component-name: \Tinker
    template: templates.Tinker

    children: -> [
      new LangPane {locals: {flavors: [[\HTML \html]]}} \#markup_pane @
      new LangPane {locals: {flavors: [[\CSS \css]]}} \#style_pane @
      new LangPane {locals: {flavors: [[\JavaScript \javascript]]}} \#code_pane @
    ]

