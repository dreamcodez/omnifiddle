require! {
  $R: reactivejs
}

if window?
  $ = window.$
else
  require! $:cheerio

module.exports =
  class Component
    (state, @selector) ->
      @merge-state state

      @$top = $ @selector

      # auto-attach on client only and only when @$top is defined
      if window? and @$top
        # attach delegated event handlers
        # we do not put the output in @$top yet because
        # we want to yield this functionality to something smarter
        # which can use request-animation frame
        @attach!

    template: (-> '')
    mutate: !-> # override in sub-class as needed
    children: [] # override in sub-class as needed
    attach: !-> # override in sub-class as needed (client only)
    detach: !-> # override in sub-class as needed (client only)
    merge-state: !(state) ->
      @r ||= {}
      for k,v of state
        if existing-r = @r[k]
          existing-r v # set rather than override hash key
        else
          @r[k] = $R.state v
    state: -> {[k, v.get!] for k,v of @r}
    render: ->
      state = @state!
      # Render js template
      #   could be anything that takes locals as the first argument
      #   and returns html markup. I use compiled Jade =D
      template-out = @template state

      # Wrap output in top-level div before creating DOM
      # - allows us to find the topmost node in our template
      # - makes $c.html! return the correct html, including all markup
      $c = $('<div class="render-wrapper">' + template-out + '</div>')

      # Mutation phase (in DOM)
      #   DOM manipulation can be done here
      @mutate $c, state

      for child in @children
        $c.find(child.selector).html child.render!

      # finally store html markup
      # pre-calculate and store s
      @html = $c.html!
    put: !-> # put in @$top (client only)
      @$top.html(@html or @render!)

