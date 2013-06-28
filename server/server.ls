require! {
  connect
  express
  amdefine
  \../ui/HomePage
}

max-age = 0ms

path = \public

!function homepage-handler req, res, next
  res.content-type \html
  res.send (new HomePage).html(false)

export run = (port = 8000) ->
  process.title = \omnifiddle
  express!
    ..use express.static(path, {max-age})
    ..use connect.logger(format: \dev)
    ..get '/' homepage-handler
    ..listen port
