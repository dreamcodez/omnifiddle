require! $R: reactivejs

!function cl
  console.log ...arguments

!function activate-handlers $top, handlers
  for h in handlers
    $top.on h.type, h.selector, h.on

!function deactivate-handlers $top, handlers
  for h in handlers
    $top.off h.type, h.selector, h.on

function new-reactor $top
  debounce = __.debounce _, 250

  r =
    markup: $R.state!
    markup-flavor: $R.state!
    style: $R.state!
    style-flavor: $R.state!
    code: $R.state!
    code-flavor: $R.state!

  handlers =
    * selector: \.markup
      type: \keyup
      on: debounce -> r.markup $(this).val!
    * selector: \.markup-flavor
      type: \change
      on: debounce -> r.markup-flavor $(this).val!
    * selector: \.style
      type: \keyup
      on: debounce -> r.style $(this).val!
    * selector: \.style-flavor
      type: \change
      on: debounce -> r.style-flavor $(this).val!
    * selector: \.code
      type: \keyup
      on: debounce -> r.code $(this).val!
    * selector: \.code-flavor
      type: \change
      on: debounce -> r.code-flavor $(this).val!
    * selector: \.preview
      type: \keyup
      on: cl
    * selector: \.submit
      type: \click
      on: cl

  {
    activate: ->
      activate-handlers $top, handlers

    deactivate: ->
      deactivate-handlers $top, handlers

    r
  }

export create = ($top) ->
  {r, activate, deactivate} = new-reactor $top

  pw = $(\iframe.preview).0.content-window
  $preview = $(pw.document).find(\body)

  {
    start: ->
      $R(cl \markup, _).bind-to r.markup
      $R(cl \style, _).bind-to r.style
      $R(cl \code, _).bind-to r.code

      $R((markup) ->
        $preview.html(markup)
        cl \markup, _
      ).bind-to r.markup

      activate!
    stop: ->
      deactivate!
  }
