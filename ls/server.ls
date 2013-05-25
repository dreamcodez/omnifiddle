require! {
  connect
  express
  cj: '../build/clientjade'
}

const t = cj.templates

const max-age = 0ms

const path = \public

const scripts =
  * '/js/raf.js'
  * '/js/zepto.js'
  * '/js/history/json2.js'
  * '/js/history/history.adapter.zepto.js'
  * '/js/history/history.html4.js'
  * '/js/history/history.js'
  * '/js/app.js'

!function homepage-handler req, res, next
  res.content-type \html
  res.send t.index({scripts})

export run = (port = 8000) ->
  process.title = \omnifiddle
  express!
    ..use express.static(path, {max-age})
    ..use connect.logger(format: \dev)
    ..get '/' homepage-handler
    ..listen port
