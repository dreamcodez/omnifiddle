require! {
  t: \../build/clientjade.js
  reactivejs
  lodash
  \./HelloWorld.ls
}

#window.tinker = tinker
window.$R = reactivejs
window.__ = lodash

#tc = tinker-component.create $('#tinker')
#tc.start!

#tc = test-component.create!
hw = new HelloWorld window.hw-state, $('#test')
console.log hw.html
#hw.put!
# not needed on clientside since server provided markup
#$tc-container.html tc.render!

