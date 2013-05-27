require! {
  t: \../build/clientjade.js
  reactivejs
  \./tinker-component.ls
  \./test-component.ls
  lodash
}

#window.tinker = tinker
window.$R = reactivejs
window.__ = lodash

#tc = tinker-component.create $('#tinker')
#tc.start!

tc = test-component.create!
$tc-container = $('#test')
tc.attach $tc-container
# not needed on clientside since server provided markup
#$tc-container.html tc.render!

