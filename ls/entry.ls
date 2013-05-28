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
window.component =
  markup-pane: new LangPane window.state.markup, $('#markup_pane')
  style-pane: new LangPane window.state.style, $('#style_pane')
  code-pane: new LangPane window.state.code, $('#code_pane')

#hw.put!
# not needed on clientside since server provided markup
#$tc-container.html tc.render!
