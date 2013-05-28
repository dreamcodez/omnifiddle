require! {
  connect
  express
  cj: '../build/clientjade'
  \./LangPane
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

  component =
    markup: new LangPane {flavors: [[\CSS \css]]}
    style: new LangPane {flavors: [[\CSS \css]]}
    code: new LangPane {flavors: [[\CSS \css]]}

  state = {[name, c.state!] for name,c of component}

  locals = {scripts, component, state}

  res.send t.index(locals)

export run = (port = 8000) ->
  process.title = \omnifiddle
  express!
    ..use express.static(path, {max-age})
    ..use connect.logger(format: \dev)
    ..get '/' homepage-handler
    ..listen port
