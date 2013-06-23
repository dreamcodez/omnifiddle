require! {
  \./Tinker.ls
  reactivejs
}

window.jade = require \../node_modules/jade/lib/jade.js

window.$R = reactivejs
window.component = {}
window.component.tinker = new Tinker {-auto-render} \#content
