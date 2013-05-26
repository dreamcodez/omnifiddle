require! {
  t: \../build/clientjade.js
  reactivejs
  tinker: \./tinker-component.ls
  lodash
}

window.tinker = tinker
window.$R = reactivejs
window.__ = lodash

tc = tinker.create $(document)
tc.start!
