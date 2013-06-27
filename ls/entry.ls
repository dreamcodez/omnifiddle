require.config {
  paths:
    zepto: \//cdnjs.cloudflare.com/ajax/libs/zepto/1.0/zepto.min
  map:
    '*': {cheerio: \zepto}
  packages:
    * name: \lodash
      main: \dist/lodash.compat.js
      location: \../packages/lodash
    * name: \reactivejs
      main: \src/reactive.js
      location: \../packages/reactivejs
    * name: \yacomponent
      main: \Component.js
      location: \../packages/yacomponent
    * name: \jade
      main: \jade.js
      location: \../packages/jade
  shim:
    zepto: {exports: \Zepto}
}

define (require) ->
  require! {
    #jade
    lodash
    reactivejs
    yacomponent
    zepto
  }
  # components
  require! {
    Tinker
  }

  window.$ = zepto
  window.$R = reactivejs
  window.__ = lodash
  #window.jade = jade

  window.component = {}
  window.component.tinker = new Tinker {-auto-render} \#content
