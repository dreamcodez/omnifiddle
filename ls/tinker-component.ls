
function mk-component $top
  selector =
    markup: \.markup
    style: \.style
    code: \.code
    preview: \.preview
    submit: \.submit

  $$ = [$top.find(s) for s in selector]

  { start: ->
    stop: ->
  }
$R.state
