require! {
  connect
  express
  cj: '../build/clientjade'
}

const t = cj.templates

const max-age = 0ms

const path = \public

const process-title = \omnifiddle

!function homepage-handler req, res, next
  res.content-type \html
  res.send t.index!

export run = (port = 8000) ->
  process.title = process-title
  express!
    ..use express.static(path, {max-age})
    ..use connect.logger(format: \dev)
    ..get '/' homepage-handler
    ..listen port
