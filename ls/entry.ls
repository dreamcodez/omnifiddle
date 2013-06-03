require! {
  \./Tinker.ls
}

window.$R = require \reactivejs
window.component = {}
window.component.tinker = (new Tinker {-auto-render} \#content).attach!
