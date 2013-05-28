require! {
  $R: reactivejs
}

if window?
  $ = window.$
else
  require! $:cheerio

module.exports =
  class Component
    (state = {}) ->
      @r-state = {[k, $R.state v] for k,v of state}
    template: (-> '')
    mutate: !->
    attach: !->
    detach: !->
    state: -> {[k, v.get!] for k,v of @r-state}
    render: ->
      state = @state!
      # Render js template
      #   could be anything that takes locals as the first argument
      #   and returns html markup. I use compiled Jade =D
      out = @template state

      # Wrap output in top-level div before creating DOM
      # - allows us to find the topmost node in our template
      # - makes $c.html! return the correct html, including all markup
      $c = $('<div class="render-wrapper">' + out + '</div>')

      # Mutation phase (in DOM)
      #   DOM manipulation can be done here
      @mutate $c, state

      # finally return html markup
      $.html!

