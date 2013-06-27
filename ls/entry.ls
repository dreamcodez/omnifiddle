require! {
  \./Tinker
  reactivejs
}

window.jade = require \../node_modules/jade/lib/jade

window.$R = reactivejs
window.component = {}
window.component.tinker = new Tinker {-auto-render} \#content
