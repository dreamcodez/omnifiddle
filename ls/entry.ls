require! {
  t: \../build/clientjade.js
  reactivejs
  \./tinker-component.ls
  \./test-component.ls
  lodash
}

window.tinker = tinker
window.$R = reactivejs
window.__ = lodash

#tc = tinker-component.create $('#tinker')
#tc.start!

tc = test-component.create!
$(document.body).html tc.render!

