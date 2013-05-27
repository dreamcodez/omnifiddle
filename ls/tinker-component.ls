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
    markup: $R.state $top.find(\textarea.markup).val!
    markup-flavor: $R.state {title: $top.find('.select.markup-flavor option:checked').text!, type: $top.find('select.markup-flavor').val!}
    style: $R.state $top.find(\textarea.style).val!
    style-flavor: $R.state {title: $top.find('.select.style-flavor option:checked').text!, type: $top.find('select.style-flavor').val!}
    code: $R.state $top.find(\textarea.code).val!
    code-flavor: $R.state {title: $top.find('.select.code-flavor option:checked').text!, type: $top.find('select.code-flavor').val!}

  handlers =
    * selector: \textarea.markup
      type: \keyup
      on: debounce -> r.markup $(this).val!
    * selector: \select.markup-flavor
      type: \change
      on: debounce -> r.markup-flavor {type: $(this).val!, title: $(this).find('option:checked').text!}
    * selector: \textarea.style
      type: \keyup
      on: debounce -> r.style $(this).val!
    * selector: \select.style-flavor
      type: \change
      on: debounce -> r.style-flavor {type: $(this).val!, title: $(this).find('option:checked').text!}
    * selector: \textarea.code
      type: \keyup
      on: debounce -> r.code $(this).val!
    * selector: \select.code-flavor
      type: \change
      on: debounce -> r.code-flavor {type: $(this).val!, title: $(this).find('option:checked').text!}
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

  # cached selectors
  pw = $(\iframe.preview).0.content-window
  $preview = $(pw.document).find(\body)

  $markup-flavor-label = $top.find '.tab.markup label'
  $style-flavor-label = $top.find '.tab.style label'
  $code-flavor-label = $top.find '.tab.code label'

  {
    start: ->
      $R(-> $markup-flavor-label.text(it.title)).bind-to r.markup-flavor
      $R(-> $style-flavor-label.text(it.title)).bind-to r.style-flavor
      $R(-> $code-flavor-label.text(it.title)).bind-to r.code-flavor

      $R((markup) ->
        $preview.html(markup)
      ).bind-to r.markup

      $R((flavor, code)->
        console.log \flavor, flavor
        console.log \code, code
        console.log \js, to-js(flavor.type, code)
      ).bind-to r.code-flavor, r.code

      activate!
    stop: ->
      deactivate!
  }
