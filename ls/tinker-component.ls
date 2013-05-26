require! $R: reactivejs

!function cl
  console.log ...arguments

!function activate-handlers $top, handlers
  for h in handlers
    $top.on h.type, h.selector, h.on

!function deactivate-handlers $top, handlers
  for h in handlers
    $top.off h.type, h.selector, h.on

function to-js flavor, code
  switch flavor
  | \javascript => code
  | \lolcode => loljs code
  | otherwise throw new Error "code flavor '#{flavor}' not implemented"

function new-reactor $top
  debounce = __.debounce _, 250

  r =
    markup: $R.state $top.find(\.markup).val!
    markup-flavor: $R.state $top.find(\.markup-flavor).val!
    style: $R.state $top.find(\.style).val!
    style-flavor: $R.state $top.find(\.style-flavor).val!
    code: $R.state $top.find(\.code).val!
    code-flavor: $R.state $top.find(\.code-flavor).val!

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
      $R(cl \style, _).bind-to r.style
      $R(cl \markup-flavor, _).bind-to r.markup-flavor
      $R(cl \style-flavor, _).bind-to r.style-flavor

      $R((markup) ->
        $preview.html(markup)
        cl \markup, _
      ).bind-to r.markup

      $R((flavor, code)->
        console.log \flavor, flavor
        console.log \code, code
        console.log \js, to-js(flavor, code)
      ).bind-to r.code-flavor, r.code

      activate!
    stop: ->
      deactivate!
  }
