require! \./Component

module.exports =
  class HelloWorld extends Component
    template: ({name}={}) -> "<p>Hello, World</p>#{if name then ' <strong>' + name + '</strong>' else ''}"
    attach: !->
    detach: !->
