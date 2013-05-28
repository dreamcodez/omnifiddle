require! {
  connect
  express
  cj: '../build/clientjade'
  \./HelloWorld
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
  * '/js/loljs.js'
  * '/js/app.js'

!function homepage-handler req, res, next
  res.content-type \html
  hw = new HelloWorld {name: \Sancho}
  locals = {scripts, hw: hw}
  res.send t.index(locals)

export run = (port = 8000) ->
  process.title = \omnifiddle
  express!
    ..use express.static(path, {max-age})
    ..use connect.logger(format: \dev)
    ..get '/' homepage-handler
    ..listen port
