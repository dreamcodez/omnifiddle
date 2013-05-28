require! {
  $R: reactivejs
}

if window?
  $ = window.$
else
  require! $:cheerio

module.exports =
  class Component
    class @NoDollarTopError extends Error
      (fun-name) ->
        @message = "you must pass in @$top to call #{fun-name}"

    # @$top is a zepto/jquery selected div element on the client
    # ... which we will render our output into and attach handlers to
    #
    # it is assumed that whater @$top is selecting.. that it is already
    # in the dom ... not sure if handlers will attach correctly to something
    # that is not in the active dom... MAYBE!?!?!?
    #
    # @$top is kinda intended for client only but it doesn't have to be...
    (state, @$top) ->
      @r-state = {[k, $R.state v] for k,v of state}

      # calculate initial markup
      #
      # DO pre-render the output
      # DON'T put it in the DOM (programmer should do that with .put and raf)
      @render!

      # auto-attach on client only and only when @$top is defined
      if window? and @$top
        # attach delegated event handlers
        # we do not put the output in @$top yet because
        # we want to yield this functionality to something smarter
        # which can use request-animation frame
        @attach!

    template: (-> '')
    mutate: !-> # override in sub-class as needed (client only)
    attach: !-> # override in sub-class as needed (client only)
    detach: !-> # override in sub-class as needed (client only)
    state: -> {[k, v.get!] for k,v of @r-state}
    render: !->
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

      # finally store html markup
      # pre-calculate and store s
      @html = $c.html!
    put: !-> # put in @$top (client only)
      if @$top
        @$top.html @html
      else
        throw new NoDollarTopError \Component.put

