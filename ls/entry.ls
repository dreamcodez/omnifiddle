require! {
  t: \../build/clientjade.js
  reactivejs
  lodash
  \./LangPane.ls
}

#window.tinker = tinker
window.$R = reactivejs
window.__ = lodash

#tc = tinker-component.create $('#tinker')
#tc.start!

#tc = test-component.create!
lp = new LangPane window.lp-state, $('#test')
#hw.put!
# not needed on clientside since server provided markup
#$tc-container.html tc.render!

