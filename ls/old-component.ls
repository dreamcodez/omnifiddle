require! {
  $R: reactivejs
}

if window?
  $ = window.$
else
  require! $:cheerio

# takes a compiled jade template, locals, and an optional mutator
# mutator takes the form ($component, locals)
# attacher takes the form ($component, state) use it to attach .on etc
export define = ({
  template = void
  mutate = (->)
  attach = (->)
  detach = (->)
} = {}) ->
  create = (initial-locals = {}) ->
    # wrap locals into reactive variables
    state = {[k, $R.state v] for k,v of initial-locals}

    get-locals = ->
      {[k, v.val] for k,v of state}

    {
      render: ->
        locals = get-locals!
        out = template(locals)

        # wrap output so that .find can select all nodes in the component, including toplevel one
        # this also makes it so that the toplevel node in the template is rendered correctly
        $c = $ "<div class=\"render-wrapper\">#{out}</div>"

        # dom phase
        mutate $c, locals

        $c.html!

      attach: !($c) ->
        # attach reactivity and events on client
        attach $c, state

      detach: !($c) ->
        # detach reactivity and events on client
        detach $c, state

      state
      get-locals
    }

  {create}
