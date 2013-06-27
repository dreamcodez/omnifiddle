require! {
  \./component
}

{templates} = require \../build/clientjade.js

module.exports = component.define {
  template: templates.test
  mutate: ($c, l) ->
    $c.find('p').text 'hello world'
  attach: ($c, s) ->
    $c.on \click, 'p', ->
      alert('hello world')
  detach: ($c, s) ->
    console.log \detached, $c, s
}
