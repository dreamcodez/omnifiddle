require! {
  $R: reactivejs
}

if window?
  $ = window.$
else
  require! $:cheerio

module.exports =
  class @Component
    (state = {}) ->
      @r-state = {[k, $R.state v] for k,v of state}
    template: (-> '')
    mutate: !->
    attach: !->
    detach: !->
    state: -> {[k, v.get!] for k,v of @r-state}
