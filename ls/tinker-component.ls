function decorate-handlers $top, handlers
  for h in handlers
    {} <<< h <<< {$el: $top.find h.selector}

!function activate-handlers $top, handlers
  for h in handlers
    $top.on h.type, h.selector, h.on

!function deactivate-handlers $top, handlers
  for h in handlers
    $top.off h.type, h.selector, h.on

export create = ($top) ->
  cl = -> console.log arguments
  handlers =
    * selector: \.markup
      type: \keyup
      on: cl
    * selector: \.style
      type: \keyup
      on: cl
    * selector: \.code
      type: \keyup
      on: cl
    * selector: \.preview
      type: \keyup
      on: cl
    * selector: \.submit
      type: \click
      on: cl

  {
    start: ->
      decorate-handlers $top, handlers
      activate-handlers $top, handlers

    stop: ->
      deactivate-handlers $top, handlers
  }
