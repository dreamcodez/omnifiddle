require! {
  connect
  express
  cj: '../build/clientjade'
  \./HomePage
}

t = cj.templates

max-age = 0ms

path = \public

!function homepage-handler req, res, next
  res.content-type \html
  res.send (new HomePage).render!

export run = (port = 8000) ->
  process.title = \omnifiddle
  express!
    ..use express.static(path, {max-age})
    ..use connect.logger(format: \dev)
    ..get '/' homepage-handler
    ..listen port
